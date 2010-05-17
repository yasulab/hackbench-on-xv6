3150 // On-disk file system format.
3151 // Both the kernel and user programs use this header file.
3152 
3153 // Block 0 is unused.
3154 // Block 1 is super block.
3155 // Inodes start at block 2.
3156 
3157 #define BSIZE 512  // block size
3158 
3159 // File system super block
3160 struct superblock {
3161   uint size;         // Size of file system image (blocks)
3162   uint nblocks;      // Number of data blocks
3163   uint ninodes;      // Number of inodes.
3164 };
3165 
3166 #define NADDRS (NDIRECT+1)
3167 #define NDIRECT 12
3168 #define INDIRECT 12
3169 #define NINDIRECT (BSIZE / sizeof(uint))
3170 #define MAXFILE (NDIRECT  + NINDIRECT)
3171 
3172 // On-disk inode structure
3173 struct dinode {
3174   short type;           // File type
3175   short major;          // Major device number (T_DEV only)
3176   short minor;          // Minor device number (T_DEV only)
3177   short nlink;          // Number of links to inode in file system
3178   uint size;            // Size of file (bytes)
3179   uint addrs[NADDRS];   // Data block addresses
3180 };
3181 
3182 #define T_DIR  1   // Directory
3183 #define T_FILE 2   // File
3184 #define T_DEV  3   // Special device
3185 
3186 // Inodes per block.
3187 #define IPB           (BSIZE / sizeof(struct dinode))
3188 
3189 // Block containing inode i
3190 #define IBLOCK(i)     ((i) / IPB + 2)
3191 
3192 // Bitmap bits per block
3193 #define BPB           (BSIZE*8)
3194 
3195 // Block containing bit for block b
3196 #define BBLOCK(b, ninodes) (b/BPB + (ninodes)/IPB + 3)
3197 
3198 // Directory is a file containing a sequence of dirent structures.
3199 #define DIRSIZ 14
3200 struct dirent {
3201   ushort inum;
3202   char name[DIRSIZ];
3203 };
3204 
3205 
3206 
3207 
3208 
3209 
3210 
3211 
3212 
3213 
3214 
3215 
3216 
3217 
3218 
3219 
3220 
3221 
3222 
3223 
3224 
3225 
3226 
3227 
3228 
3229 
3230 
3231 
3232 
3233 
3234 
3235 
3236 
3237 
3238 
3239 
3240 
3241 
3242 
3243 
3244 
3245 
3246 
3247 
3248 
3249 
