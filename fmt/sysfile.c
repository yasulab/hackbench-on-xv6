4500 #include "types.h"
4501 #include "defs.h"
4502 #include "param.h"
4503 #include "stat.h"
4504 #include "mmu.h"
4505 #include "proc.h"
4506 #include "fs.h"
4507 #include "fsvar.h"
4508 #include "file.h"
4509 #include "fcntl.h"
4510 
4511 // Fetch the nth word-sized system call argument as a file descriptor
4512 // and return both the descriptor and the corresponding struct file.
4513 static int
4514 argfd(int n, int *pfd, struct file **pf)
4515 {
4516   int fd;
4517   struct file *f;
4518 
4519   if(argint(n, &fd) < 0)
4520     return -1;
4521   if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
4522     return -1;
4523   if(pfd)
4524     *pfd = fd;
4525   if(pf)
4526     *pf = f;
4527   return 0;
4528 }
4529 
4530 // Allocate a file descriptor for the given file.
4531 // Takes over file reference from caller on success.
4532 static int
4533 fdalloc(struct file *f)
4534 {
4535   int fd;
4536 
4537   for(fd = 0; fd < NOFILE; fd++){
4538     if(cp->ofile[fd] == 0){
4539       cp->ofile[fd] = f;
4540       return fd;
4541     }
4542   }
4543   return -1;
4544 }
4545 
4546 
4547 
4548 
4549 
4550 int
4551 sys_read(void)
4552 {
4553   struct file *f;
4554   int n;
4555   char *p;
4556 
4557   if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
4558     return -1;
4559   return fileread(f, p, n);
4560 }
4561 
4562 int
4563 sys_write(void)
4564 {
4565   struct file *f;
4566   int n;
4567   char *p;
4568 
4569   if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
4570     return -1;
4571   return filewrite(f, p, n);
4572 }
4573 
4574 int
4575 sys_dup(void)
4576 {
4577   struct file *f;
4578   int fd;
4579 
4580   if(argfd(0, 0, &f) < 0)
4581     return -1;
4582   if((fd=fdalloc(f)) < 0)
4583     return -1;
4584   filedup(f);
4585   return fd;
4586 }
4587 
4588 int
4589 sys_close(void)
4590 {
4591   int fd;
4592   struct file *f;
4593 
4594   if(argfd(0, &fd, &f) < 0)
4595     return -1;
4596   cp->ofile[fd] = 0;
4597   fileclose(f);
4598   return 0;
4599 }
4600 int
4601 sys_fstat(void)
4602 {
4603   struct file *f;
4604   struct stat *st;
4605 
4606   if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
4607     return -1;
4608   return filestat(f, st);
4609 }
4610 
4611 // Create the path new as a link to the same inode as old.
4612 int
4613 sys_link(void)
4614 {
4615   char name[DIRSIZ], *new, *old;
4616   struct inode *dp, *ip;
4617 
4618   if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
4619     return -1;
4620   if((ip = namei(old)) == 0)
4621     return -1;
4622   ilock(ip);
4623   if(ip->type == T_DIR){
4624     iunlockput(ip);
4625     return -1;
4626   }
4627   ip->nlink++;
4628   iupdate(ip);
4629   iunlock(ip);
4630 
4631   if((dp = nameiparent(new, name)) == 0)
4632     goto  bad;
4633   ilock(dp);
4634   if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
4635     goto bad;
4636   iunlockput(dp);
4637   iput(ip);
4638   return 0;
4639 
4640 bad:
4641   if(dp)
4642     iunlockput(dp);
4643   ilock(ip);
4644   ip->nlink--;
4645   iupdate(ip);
4646   iunlockput(ip);
4647   return -1;
4648 }
4649 
4650 // Is the directory dp empty except for "." and ".." ?
4651 static int
4652 isdirempty(struct inode *dp)
4653 {
4654   int off;
4655   struct dirent de;
4656 
4657   for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
4658     if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
4659       panic("isdirempty: readi");
4660     if(de.inum != 0)
4661       return 0;
4662   }
4663   return 1;
4664 }
4665 
4666 int
4667 sys_unlink(void)
4668 {
4669   struct inode *ip, *dp;
4670   struct dirent de;
4671   char name[DIRSIZ], *path;
4672   uint off;
4673 
4674   if(argstr(0, &path) < 0)
4675     return -1;
4676   if((dp = nameiparent(path, name)) == 0)
4677     return -1;
4678   ilock(dp);
4679 
4680   // Cannot unlink "." or "..".
4681   if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
4682     iunlockput(dp);
4683     return -1;
4684   }
4685 
4686   if((ip = dirlookup(dp, name, &off)) == 0){
4687     iunlockput(dp);
4688     return -1;
4689   }
4690   ilock(ip);
4691 
4692   if(ip->nlink < 1)
4693     panic("unlink: nlink < 1");
4694   if(ip->type == T_DIR && !isdirempty(ip)){
4695     iunlockput(ip);
4696     iunlockput(dp);
4697     return -1;
4698   }
4699 
4700   memset(&de, 0, sizeof(de));
4701   if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
4702     panic("unlink: writei");
4703   iunlockput(dp);
4704 
4705   ip->nlink--;
4706   iupdate(ip);
4707   iunlockput(ip);
4708   return 0;
4709 }
4710 
4711 static struct inode*
4712 create(char *path, int canexist, short type, short major, short minor)
4713 {
4714   uint off;
4715   struct inode *ip, *dp;
4716   char name[DIRSIZ];
4717 
4718   if((dp = nameiparent(path, name)) == 0)
4719     return 0;
4720   ilock(dp);
4721 
4722   if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
4723     iunlockput(dp);
4724     ilock(ip);
4725     if(ip->type != type || ip->major != major || ip->minor != minor){
4726       iunlockput(ip);
4727       return 0;
4728     }
4729     return ip;
4730   }
4731 
4732   if((ip = ialloc(dp->dev, type)) == 0){
4733     iunlockput(dp);
4734     return 0;
4735   }
4736   ilock(ip);
4737   ip->major = major;
4738   ip->minor = minor;
4739   ip->nlink = 1;
4740   iupdate(ip);
4741 
4742   if(dirlink(dp, name, ip->inum) < 0){
4743     ip->nlink = 0;
4744     iunlockput(ip);
4745     iunlockput(dp);
4746     return 0;
4747   }
4748 
4749 
4750   if(type == T_DIR){  // Create . and .. entries.
4751     dp->nlink++;  // for ".."
4752     iupdate(dp);
4753     // No ip->nlink++ for ".": avoid cyclic ref count.
4754     if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
4755       panic("create dots");
4756   }
4757   iunlockput(dp);
4758   return ip;
4759 }
4760 
4761 int
4762 sys_open(void)
4763 {
4764   char *path;
4765   int fd, omode;
4766   struct file *f;
4767   struct inode *ip;
4768 
4769   if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
4770     return -1;
4771 
4772   if(omode & O_CREATE){
4773     if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
4774       return -1;
4775   } else {
4776     if((ip = namei(path)) == 0)
4777       return -1;
4778     ilock(ip);
4779     if(ip->type == T_DIR && (omode & (O_RDWR|O_WRONLY))){
4780       iunlockput(ip);
4781       return -1;
4782     }
4783   }
4784 
4785   if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
4786     if(f)
4787       fileclose(f);
4788     iunlockput(ip);
4789     return -1;
4790   }
4791   iunlock(ip);
4792 
4793   f->type = FD_INODE;
4794   f->ip = ip;
4795   f->off = 0;
4796   f->readable = !(omode & O_WRONLY);
4797   f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
4798 
4799 
4800   return fd;
4801 }
4802 
4803 int
4804 sys_mknod(void)
4805 {
4806   struct inode *ip;
4807   char *path;
4808   int len;
4809   int major, minor;
4810 
4811   if((len=argstr(0, &path)) < 0 ||
4812      argint(1, &major) < 0 ||
4813      argint(2, &minor) < 0 ||
4814      (ip = create(path, 0, T_DEV, major, minor)) == 0)
4815     return -1;
4816   iunlockput(ip);
4817   return 0;
4818 }
4819 
4820 int
4821 sys_mkdir(void)
4822 {
4823   char *path;
4824   struct inode *ip;
4825 
4826   if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
4827     return -1;
4828   iunlockput(ip);
4829   return 0;
4830 }
4831 
4832 int
4833 sys_chdir(void)
4834 {
4835   char *path;
4836   struct inode *ip;
4837 
4838   if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
4839     return -1;
4840   ilock(ip);
4841   if(ip->type != T_DIR){
4842     iunlockput(ip);
4843     return -1;
4844   }
4845   iunlock(ip);
4846   iput(cp->cwd);
4847   cp->cwd = ip;
4848   return 0;
4849 }
4850 int
4851 sys_exec(void)
4852 {
4853   char *path, *argv[20];
4854   int i;
4855   uint uargv, uarg;
4856 
4857   if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
4858     return -1;
4859   memset(argv, 0, sizeof(argv));
4860   for(i=0;; i++){
4861     if(i >= NELEM(argv))
4862       return -1;
4863     if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
4864       return -1;
4865     if(uarg == 0){
4866       argv[i] = 0;
4867       break;
4868     }
4869     if(fetchstr(cp, uarg, &argv[i]) < 0)
4870       return -1;
4871   }
4872   return exec(path, argv);
4873 }
4874 
4875 int
4876 sys_pipe(void)
4877 {
4878   int *fd;
4879   struct file *rf, *wf;
4880   int fd0, fd1;
4881 
4882   if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
4883     return -1;
4884   if(pipealloc(&rf, &wf) < 0)
4885     return -1;
4886   fd0 = -1;
4887   if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
4888     if(fd0 >= 0)
4889       cp->ofile[fd0] = 0;
4890     fileclose(rf);
4891     fileclose(wf);
4892     return -1;
4893   }
4894   fd[0] = fd0;
4895   fd[1] = fd1;
4896   return 0;
4897 }
4898 
4899 
