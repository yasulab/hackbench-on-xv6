3650 // File system implementation.  Four layers:
3651 //   + Blocks: allocator for raw disk blocks.
3652 //   + Files: inode allocator, reading, writing, metadata.
3653 //   + Directories: inode with special contents (list of other inodes!)
3654 //   + Names: paths like /usr/rtm/xv6/fs.c for convenient naming.
3655 //
3656 // Disk layout is: superblock, inodes, block in-use bitmap, data blocks.
3657 //
3658 // This file contains the low-level file system manipulation
3659 // routines.  The (higher-level) system call implementations
3660 // are in sysfile.c.
3661 
3662 #include "types.h"
3663 #include "defs.h"
3664 #include "param.h"
3665 #include "stat.h"
3666 #include "mmu.h"
3667 #include "proc.h"
3668 #include "spinlock.h"
3669 #include "buf.h"
3670 #include "fs.h"
3671 #include "fsvar.h"
3672 #include "dev.h"
3673 
3674 #define min(a, b) ((a) < (b) ? (a) : (b))
3675 static void itrunc(struct inode*);
3676 
3677 // Read the super block.
3678 static void
3679 readsb(int dev, struct superblock *sb)
3680 {
3681   struct buf *bp;
3682 
3683   bp = bread(dev, 1);
3684   memmove(sb, bp->data, sizeof(*sb));
3685   brelse(bp);
3686 }
3687 
3688 // Zero a block.
3689 static void
3690 bzero(int dev, int bno)
3691 {
3692   struct buf *bp;
3693 
3694   bp = bread(dev, bno);
3695   memset(bp->data, 0, BSIZE);
3696   bwrite(bp);
3697   brelse(bp);
3698 }
3699 
3700 // Blocks.
3701 
3702 // Allocate a disk block.
3703 static uint
3704 balloc(uint dev)
3705 {
3706   int b, bi, m;
3707   struct buf *bp;
3708   struct superblock sb;
3709 
3710   bp = 0;
3711   readsb(dev, &sb);
3712   for(b = 0; b < sb.size; b += BPB){
3713     bp = bread(dev, BBLOCK(b, sb.ninodes));
3714     for(bi = 0; bi < BPB; bi++){
3715       m = 1 << (bi % 8);
3716       if((bp->data[bi/8] & m) == 0){  // Is block free?
3717         bp->data[bi/8] |= m;  // Mark block in use on disk.
3718         bwrite(bp);
3719         brelse(bp);
3720         return b + bi;
3721       }
3722     }
3723     brelse(bp);
3724   }
3725   panic("balloc: out of blocks");
3726 }
3727 
3728 // Free a disk block.
3729 static void
3730 bfree(int dev, uint b)
3731 {
3732   struct buf *bp;
3733   struct superblock sb;
3734   int bi, m;
3735 
3736   bzero(dev, b);
3737 
3738   readsb(dev, &sb);
3739   bp = bread(dev, BBLOCK(b, sb.ninodes));
3740   bi = b % BPB;
3741   m = 1 << (bi % 8);
3742   if((bp->data[bi/8] & m) == 0)
3743     panic("freeing free block");
3744   bp->data[bi/8] &= ~m;  // Mark block free on disk.
3745   bwrite(bp);
3746   brelse(bp);
3747 }
3748 
3749 
3750 // Inodes.
3751 //
3752 // An inode is a single, unnamed file in the file system.
3753 // The inode disk structure holds metadata (the type, device numbers,
3754 // and data size) along with a list of blocks where the associated
3755 // data can be found.
3756 //
3757 // The inodes are laid out sequentially on disk immediately after
3758 // the superblock.  The kernel keeps a cache of the in-use
3759 // on-disk structures to provide a place for synchronizing access
3760 // to inodes shared between multiple processes.
3761 //
3762 // ip->ref counts the number of pointer references to this cached
3763 // inode; references are typically kept in struct file and in cp->cwd.
3764 // When ip->ref falls to zero, the inode is no longer cached.
3765 // It is an error to use an inode without holding a reference to it.
3766 //
3767 // Processes are only allowed to read and write inode
3768 // metadata and contents when holding the inode's lock,
3769 // represented by the I_BUSY flag in the in-memory copy.
3770 // Because inode locks are held during disk accesses,
3771 // they are implemented using a flag rather than with
3772 // spin locks.  Callers are responsible for locking
3773 // inodes before passing them to routines in this file; leaving
3774 // this responsibility with the caller makes it possible for them
3775 // to create arbitrarily-sized atomic operations.
3776 //
3777 // To give maximum control over locking to the callers,
3778 // the routines in this file that return inode pointers
3779 // return pointers to *unlocked* inodes.  It is the callers'
3780 // responsibility to lock them before using them.  A non-zero
3781 // ip->ref keeps these unlocked inodes in the cache.
3782 
3783 struct {
3784   struct spinlock lock;
3785   struct inode inode[NINODE];
3786 } icache;
3787 
3788 void
3789 iinit(void)
3790 {
3791   initlock(&icache.lock, "icache.lock");
3792 }
3793 
3794 
3795 
3796 
3797 
3798 
3799 
3800 // Find the inode with number inum on device dev
3801 // and return the in-memory copy.
3802 static struct inode*
3803 iget(uint dev, uint inum)
3804 {
3805   struct inode *ip, *empty;
3806 
3807   acquire(&icache.lock);
3808 
3809   // Try for cached inode.
3810   empty = 0;
3811   for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
3812     if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
3813       ip->ref++;
3814       release(&icache.lock);
3815       return ip;
3816     }
3817     if(empty == 0 && ip->ref == 0)    // Remember empty slot.
3818       empty = ip;
3819   }
3820 
3821   // Allocate fresh inode.
3822   if(empty == 0)
3823     panic("iget: no inodes");
3824 
3825   ip = empty;
3826   ip->dev = dev;
3827   ip->inum = inum;
3828   ip->ref = 1;
3829   ip->flags = 0;
3830   release(&icache.lock);
3831 
3832   return ip;
3833 }
3834 
3835 // Increment reference count for ip.
3836 // Returns ip to enable ip = idup(ip1) idiom.
3837 struct inode*
3838 idup(struct inode *ip)
3839 {
3840   acquire(&icache.lock);
3841   ip->ref++;
3842   release(&icache.lock);
3843   return ip;
3844 }
3845 
3846 
3847 
3848 
3849 
3850 // Lock the given inode.
3851 void
3852 ilock(struct inode *ip)
3853 {
3854   struct buf *bp;
3855   struct dinode *dip;
3856 
3857   if(ip == 0 || ip->ref < 1)
3858     panic("ilock");
3859 
3860   acquire(&icache.lock);
3861   while(ip->flags & I_BUSY)
3862     sleep(ip, &icache.lock);
3863   ip->flags |= I_BUSY;
3864   release(&icache.lock);
3865 
3866   if(!(ip->flags & I_VALID)){
3867     bp = bread(ip->dev, IBLOCK(ip->inum));
3868     dip = (struct dinode*)bp->data + ip->inum%IPB;
3869     ip->type = dip->type;
3870     ip->major = dip->major;
3871     ip->minor = dip->minor;
3872     ip->nlink = dip->nlink;
3873     ip->size = dip->size;
3874     memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
3875     brelse(bp);
3876     ip->flags |= I_VALID;
3877     if(ip->type == 0)
3878       panic("ilock: no type");
3879   }
3880 }
3881 
3882 // Unlock the given inode.
3883 void
3884 iunlock(struct inode *ip)
3885 {
3886   if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
3887     panic("iunlock");
3888 
3889   acquire(&icache.lock);
3890   ip->flags &= ~I_BUSY;
3891   wakeup(ip);
3892   release(&icache.lock);
3893 }
3894 
3895 
3896 
3897 
3898 
3899 
3900 // Caller holds reference to unlocked ip.  Drop reference.
3901 void
3902 iput(struct inode *ip)
3903 {
3904   acquire(&icache.lock);
3905   if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
3906     // inode is no longer used: truncate and free inode.
3907     if(ip->flags & I_BUSY)
3908       panic("iput busy");
3909     ip->flags |= I_BUSY;
3910     release(&icache.lock);
3911     itrunc(ip);
3912     ip->type = 0;
3913     iupdate(ip);
3914     acquire(&icache.lock);
3915     ip->flags &= ~I_BUSY;
3916     wakeup(ip);
3917   }
3918   ip->ref--;
3919   release(&icache.lock);
3920 }
3921 
3922 // Common idiom: unlock, then put.
3923 void
3924 iunlockput(struct inode *ip)
3925 {
3926   iunlock(ip);
3927   iput(ip);
3928 }
3929 
3930 // Allocate a new inode with the given type on device dev.
3931 struct inode*
3932 ialloc(uint dev, short type)
3933 {
3934   int inum;
3935   struct buf *bp;
3936   struct dinode *dip;
3937   struct superblock sb;
3938 
3939   readsb(dev, &sb);
3940   for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
3941     bp = bread(dev, IBLOCK(inum));
3942     dip = (struct dinode*)bp->data + inum%IPB;
3943     if(dip->type == 0){  // a free inode
3944       memset(dip, 0, sizeof(*dip));
3945       dip->type = type;
3946       bwrite(bp);   // mark it allocated on the disk
3947       brelse(bp);
3948       return iget(dev, inum);
3949     }
3950     brelse(bp);
3951   }
3952   panic("ialloc: no inodes");
3953 }
3954 
3955 // Copy inode, which has changed, from memory to disk.
3956 void
3957 iupdate(struct inode *ip)
3958 {
3959   struct buf *bp;
3960   struct dinode *dip;
3961 
3962   bp = bread(ip->dev, IBLOCK(ip->inum));
3963   dip = (struct dinode*)bp->data + ip->inum%IPB;
3964   dip->type = ip->type;
3965   dip->major = ip->major;
3966   dip->minor = ip->minor;
3967   dip->nlink = ip->nlink;
3968   dip->size = ip->size;
3969   memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
3970   bwrite(bp);
3971   brelse(bp);
3972 }
3973 
3974 // Inode contents
3975 //
3976 // The contents (data) associated with each inode is stored
3977 // in a sequence of blocks on the disk.  The first NDIRECT blocks
3978 // are listed in ip->addrs[].  The next NINDIRECT blocks are
3979 // listed in the block ip->addrs[INDIRECT].
3980 
3981 // Return the disk block address of the nth block in inode ip.
3982 // If there is no such block, alloc controls whether one is allocated.
3983 static uint
3984 bmap(struct inode *ip, uint bn, int alloc)
3985 {
3986   uint addr, *a;
3987   struct buf *bp;
3988 
3989   if(bn < NDIRECT){
3990     if((addr = ip->addrs[bn]) == 0){
3991       if(!alloc)
3992         return -1;
3993       ip->addrs[bn] = addr = balloc(ip->dev);
3994     }
3995     return addr;
3996   }
3997   bn -= NDIRECT;
3998 
3999 
4000   if(bn < NINDIRECT){
4001     // Load indirect block, allocating if necessary.
4002     if((addr = ip->addrs[INDIRECT]) == 0){
4003       if(!alloc)
4004         return -1;
4005       ip->addrs[INDIRECT] = addr = balloc(ip->dev);
4006     }
4007     bp = bread(ip->dev, addr);
4008     a = (uint*)bp->data;
4009 
4010     if((addr = a[bn]) == 0){
4011       if(!alloc){
4012         brelse(bp);
4013         return -1;
4014       }
4015       a[bn] = addr = balloc(ip->dev);
4016       bwrite(bp);
4017     }
4018     brelse(bp);
4019     return addr;
4020   }
4021 
4022   panic("bmap: out of range");
4023 }
4024 
4025 // Truncate inode (discard contents).
4026 static void
4027 itrunc(struct inode *ip)
4028 {
4029   int i, j;
4030   struct buf *bp;
4031   uint *a;
4032 
4033   for(i = 0; i < NDIRECT; i++){
4034     if(ip->addrs[i]){
4035       bfree(ip->dev, ip->addrs[i]);
4036       ip->addrs[i] = 0;
4037     }
4038   }
4039 
4040   if(ip->addrs[INDIRECT]){
4041     bp = bread(ip->dev, ip->addrs[INDIRECT]);
4042     a = (uint*)bp->data;
4043     for(j = 0; j < NINDIRECT; j++){
4044       if(a[j])
4045         bfree(ip->dev, a[j]);
4046     }
4047     brelse(bp);
4048     ip->addrs[INDIRECT] = 0;
4049   }
4050   ip->size = 0;
4051   iupdate(ip);
4052 }
4053 
4054 // Copy stat information from inode.
4055 void
4056 stati(struct inode *ip, struct stat *st)
4057 {
4058   st->dev = ip->dev;
4059   st->ino = ip->inum;
4060   st->type = ip->type;
4061   st->nlink = ip->nlink;
4062   st->size = ip->size;
4063 }
4064 
4065 // Read data from inode.
4066 int
4067 readi(struct inode *ip, char *dst, uint off, uint n)
4068 {
4069   uint tot, m;
4070   struct buf *bp;
4071 
4072   if(ip->type == T_DEV){
4073     if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
4074       return -1;
4075     return devsw[ip->major].read(ip, dst, n);
4076   }
4077 
4078   if(off > ip->size || off + n < off)
4079     return -1;
4080   if(off + n > ip->size)
4081     n = ip->size - off;
4082 
4083   for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
4084     bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
4085     m = min(n - tot, BSIZE - off%BSIZE);
4086     memmove(dst, bp->data + off%BSIZE, m);
4087     brelse(bp);
4088   }
4089   return n;
4090 }
4091 
4092 
4093 
4094 
4095 
4096 
4097 
4098 
4099 
4100 // Write data to inode.
4101 int
4102 writei(struct inode *ip, char *src, uint off, uint n)
4103 {
4104   uint tot, m;
4105   struct buf *bp;
4106 
4107   if(ip->type == T_DEV){
4108     if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
4109       return -1;
4110     return devsw[ip->major].write(ip, src, n);
4111   }
4112 
4113   if(off + n < off)
4114     return -1;
4115   if(off + n > MAXFILE*BSIZE)
4116     n = MAXFILE*BSIZE - off;
4117 
4118   for(tot=0; tot<n; tot+=m, off+=m, src+=m){
4119     bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
4120     m = min(n - tot, BSIZE - off%BSIZE);
4121     memmove(bp->data + off%BSIZE, src, m);
4122     bwrite(bp);
4123     brelse(bp);
4124   }
4125 
4126   if(n > 0 && off > ip->size){
4127     ip->size = off;
4128     iupdate(ip);
4129   }
4130   return n;
4131 }
4132 
4133 // Directories
4134 
4135 int
4136 namecmp(const char *s, const char *t)
4137 {
4138   return strncmp(s, t, DIRSIZ);
4139 }
4140 
4141 
4142 
4143 
4144 
4145 
4146 
4147 
4148 
4149 
4150 // Look for a directory entry in a directory.
4151 // If found, set *poff to byte offset of entry.
4152 // Caller must have already locked dp.
4153 struct inode*
4154 dirlookup(struct inode *dp, char *name, uint *poff)
4155 {
4156   uint off, inum;
4157   struct buf *bp;
4158   struct dirent *de;
4159 
4160   if(dp->type != T_DIR)
4161     panic("dirlookup not DIR");
4162 
4163   for(off = 0; off < dp->size; off += BSIZE){
4164     bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
4165     for(de = (struct dirent*)bp->data;
4166         de < (struct dirent*)(bp->data + BSIZE);
4167         de++){
4168       if(de->inum == 0)
4169         continue;
4170       if(namecmp(name, de->name) == 0){
4171         // entry matches path element
4172         if(poff)
4173           *poff = off + (uchar*)de - bp->data;
4174         inum = de->inum;
4175         brelse(bp);
4176         return iget(dp->dev, inum);
4177       }
4178     }
4179     brelse(bp);
4180   }
4181   return 0;
4182 }
4183 
4184 // Write a new directory entry (name, ino) into the directory dp.
4185 int
4186 dirlink(struct inode *dp, char *name, uint ino)
4187 {
4188   int off;
4189   struct dirent de;
4190   struct inode *ip;
4191 
4192   // Check that name is not present.
4193   if((ip = dirlookup(dp, name, 0)) != 0){
4194     iput(ip);
4195     return -1;
4196   }
4197 
4198 
4199 
4200   // Look for an empty dirent.
4201   for(off = 0; off < dp->size; off += sizeof(de)){
4202     if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
4203       panic("dirlink read");
4204     if(de.inum == 0)
4205       break;
4206   }
4207 
4208   strncpy(de.name, name, DIRSIZ);
4209   de.inum = ino;
4210   if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
4211     panic("dirlink");
4212 
4213   return 0;
4214 }
4215 
4216 // Paths
4217 
4218 // Copy the next path element from path into name.
4219 // Return a pointer to the element following the copied one.
4220 // The returned path has no leading slashes,
4221 // so the caller can check *path=='\0' to see if the name is the last one.
4222 // If no name to remove, return 0.
4223 //
4224 // Examples:
4225 //   skipelem("a/bb/c", name) = "bb/c", setting name = "a"
4226 //   skipelem("///a//bb", name) = "bb", setting name = "a"
4227 //   skipelem("", name) = skipelem("////", name) = 0
4228 //
4229 static char*
4230 skipelem(char *path, char *name)
4231 {
4232   char *s;
4233   int len;
4234 
4235   while(*path == '/')
4236     path++;
4237   if(*path == 0)
4238     return 0;
4239   s = path;
4240   while(*path != '/' && *path != 0)
4241     path++;
4242   len = path - s;
4243   if(len >= DIRSIZ)
4244     memmove(name, s, DIRSIZ);
4245   else {
4246     memmove(name, s, len);
4247     name[len] = 0;
4248   }
4249   while(*path == '/')
4250     path++;
4251   return path;
4252 }
4253 
4254 // Look up and return the inode for a path name.
4255 // If parent != 0, return the inode for the parent and copy the final
4256 // path element into name, which must have room for DIRSIZ bytes.
4257 static struct inode*
4258 _namei(char *path, int parent, char *name)
4259 {
4260   struct inode *ip, *next;
4261 
4262   if(*path == '/')
4263     ip = iget(ROOTDEV, 1);
4264   else
4265     ip = idup(cp->cwd);
4266 
4267   while((path = skipelem(path, name)) != 0){
4268     ilock(ip);
4269     if(ip->type != T_DIR){
4270       iunlockput(ip);
4271       return 0;
4272     }
4273     if(parent && *path == '\0'){
4274       // Stop one level early.
4275       iunlock(ip);
4276       return ip;
4277     }
4278     if((next = dirlookup(ip, name, 0)) == 0){
4279       iunlockput(ip);
4280       return 0;
4281     }
4282     iunlockput(ip);
4283     ip = next;
4284   }
4285   if(parent){
4286     iput(ip);
4287     return 0;
4288   }
4289   return ip;
4290 }
4291 
4292 struct inode*
4293 namei(char *path)
4294 {
4295   char name[DIRSIZ];
4296   return _namei(path, 0, name);
4297 }
4298 
4299 
4300 struct inode*
4301 nameiparent(char *path, char *name)
4302 {
4303   return _namei(path, 1, name);
4304 }
4305 
4306 
4307 
4308 
4309 
4310 
4311 
4312 
4313 
4314 
4315 
4316 
4317 
4318 
4319 
4320 
4321 
4322 
4323 
4324 
4325 
4326 
4327 
4328 
4329 
4330 
4331 
4332 
4333 
4334 
4335 
4336 
4337 
4338 
4339 
4340 
4341 
4342 
4343 
4344 
4345 
4346 
4347 
4348 
4349 
