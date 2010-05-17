2900 struct buf {
2901   int flags;
2902   uint dev;
2903   uint sector;
2904   struct buf *prev; // LRU cache list
2905   struct buf *next;
2906   struct buf *qnext; // disk queue
2907   uchar data[512];
2908 };
2909 #define B_BUSY  0x1  // buffer is locked by some process
2910 #define B_VALID 0x2  // buffer has been read from disk
2911 #define B_DIRTY 0x4  // buffer needs to be written to disk
2912 
2913 
2914 
2915 
2916 
2917 
2918 
2919 
2920 
2921 
2922 
2923 
2924 
2925 
2926 
2927 
2928 
2929 
2930 
2931 
2932 
2933 
2934 
2935 
2936 
2937 
2938 
2939 
2940 
2941 
2942 
2943 
2944 
2945 
2946 
2947 
2948 
2949 
