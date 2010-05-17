3250 // in-core file system types
3251 
3252 struct inode {
3253   uint dev;           // Device number
3254   uint inum;          // Inode number
3255   int ref;            // Reference count
3256   int flags;          // I_BUSY, I_VALID
3257 
3258   short type;         // copy of disk inode
3259   short major;
3260   short minor;
3261   short nlink;
3262   uint size;
3263   uint addrs[NADDRS];
3264 };
3265 
3266 #define I_BUSY 0x1
3267 #define I_VALID 0x2
3268 
3269 
3270 
3271 
3272 
3273 
3274 
3275 
3276 
3277 
3278 
3279 
3280 
3281 
3282 
3283 
3284 
3285 
3286 
3287 
3288 
3289 
3290 
3291 
3292 
3293 
3294 
3295 
3296 
3297 
3298 
3299 
