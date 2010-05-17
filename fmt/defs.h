0200 struct buf;
0201 struct context;
0202 struct file;
0203 struct inode;
0204 struct pipe;
0205 struct proc;
0206 struct spinlock;
0207 struct stat;
0208 
0209 // bio.c
0210 void            binit(void);
0211 struct buf*     bread(uint, uint);
0212 void            brelse(struct buf*);
0213 void            bwrite(struct buf*);
0214 
0215 // console.c
0216 void            console_init(void);
0217 void            cprintf(char*, ...);
0218 void            console_intr(int(*)(void));
0219 void            panic(char*) __attribute__((noreturn));
0220 
0221 // exec.c
0222 int             exec(char*, char**);
0223 
0224 // file.c
0225 struct file*    filealloc(void);
0226 void            fileclose(struct file*);
0227 struct file*    filedup(struct file*);
0228 void            fileinit(void);
0229 int             fileread(struct file*, char*, int n);
0230 int             filestat(struct file*, struct stat*);
0231 int             filewrite(struct file*, char*, int n);
0232 
0233 // fs.c
0234 int             dirlink(struct inode*, char*, uint);
0235 struct inode*   dirlookup(struct inode*, char*, uint*);
0236 struct inode*   ialloc(uint, short);
0237 struct inode*   idup(struct inode*);
0238 void            iinit(void);
0239 void            ilock(struct inode*);
0240 void            iput(struct inode*);
0241 void            iunlock(struct inode*);
0242 void            iunlockput(struct inode*);
0243 void            iupdate(struct inode*);
0244 int             namecmp(const char*, const char*);
0245 struct inode*   namei(char*);
0246 struct inode*   nameiparent(char*, char*);
0247 int             readi(struct inode*, char*, uint, uint);
0248 void            stati(struct inode*, struct stat*);
0249 int             writei(struct inode*, char*, uint, uint);
0250 // ide.c
0251 void            ide_init(void);
0252 void            ide_intr(void);
0253 void            ide_rw(struct buf *);
0254 
0255 // ioapic.c
0256 void            ioapic_enable(int irq, int cpu);
0257 extern uchar    ioapic_id;
0258 void            ioapic_init(void);
0259 
0260 // kalloc.c
0261 char*           kalloc(int);
0262 void            kfree(char*, int);
0263 void            kinit(void);
0264 
0265 // kbd.c
0266 void            kbd_intr(void);
0267 
0268 // lapic.c
0269 int             cpu(void);
0270 extern volatile uint*    lapic;
0271 void            lapic_eoi(void);
0272 void            lapic_init(int);
0273 void            lapic_startap(uchar, uint);
0274 
0275 // mp.c
0276 extern int      ismp;
0277 int             mp_bcpu(void);
0278 void            mp_init(void);
0279 void            mp_startthem(void);
0280 
0281 // picirq.c
0282 void            pic_enable(int);
0283 void            pic_init(void);
0284 
0285 // pipe.c
0286 int             pipealloc(struct file**, struct file**);
0287 void            pipeclose(struct pipe*, int);
0288 int             piperead(struct pipe*, char*, int);
0289 int             pipewrite(struct pipe*, char*, int);
0290 
0291 // proc.c
0292 struct proc*    copyproc(struct proc*);
0293 struct proc*    curproc(void);
0294 void            exit(void);
0295 int             growproc(int);
0296 int             kill(int);
0297 void            pinit(void);
0298 void            procdump(void);
0299 void            scheduler(void) __attribute__((noreturn));
0300 void            setupsegs(struct proc*);
0301 void            sleep(void*, struct spinlock*);
0302 void            userinit(void);
0303 int             wait(void);
0304 void            wakeup(void*);
0305 void            yield(void);
0306 
0307 // swtch.S
0308 void            swtch(struct context*, struct context*);
0309 
0310 // spinlock.c
0311 void            acquire(struct spinlock*);
0312 void            getcallerpcs(void*, uint*);
0313 int             holding(struct spinlock*);
0314 void            initlock(struct spinlock*, char*);
0315 void            release(struct spinlock*);
0316 void            pushcli();
0317 void            popcli();
0318 
0319 // string.c
0320 int             memcmp(const void*, const void*, uint);
0321 void*           memmove(void*, const void*, uint);
0322 void*           memset(void*, int, uint);
0323 char*           safestrcpy(char*, const char*, int);
0324 int             strlen(const char*);
0325 int             strncmp(const char*, const char*, uint);
0326 char*           strncpy(char*, const char*, int);
0327 
0328 // syscall.c
0329 int             argint(int, int*);
0330 int             argptr(int, char**, int);
0331 int             argstr(int, char**);
0332 int             fetchint(struct proc*, uint, int*);
0333 int             fetchstr(struct proc*, uint, char**);
0334 void            syscall(void);
0335 
0336 // timer.c
0337 void            timer_init(void);
0338 
0339 // trap.c
0340 void            idtinit(void);
0341 extern int      ticks;
0342 void            tvinit(void);
0343 extern struct spinlock tickslock;
0344 
0345 // number of elements in fixed-size array
0346 #define NELEM(x) (sizeof(x)/sizeof((x)[0]))
0347 
0348 
0349 
