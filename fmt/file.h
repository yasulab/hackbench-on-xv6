3100 struct file {
3101   enum { FD_CLOSED, FD_NONE, FD_PIPE, FD_INODE } type;
3102   int ref; // reference count
3103   char readable;
3104   char writable;
3105   struct pipe *pipe;
3106   struct inode *ip;
3107   uint off;
3108 };
3109 
3110 
3111 
3112 
3113 
3114 
3115 
3116 
3117 
3118 
3119 
3120 
3121 
3122 
3123 
3124 
3125 
3126 
3127 
3128 
3129 
3130 
3131 
3132 
3133 
3134 
3135 
3136 
3137 
3138 
3139 
3140 
3141 
3142 
3143 
3144 
3145 
3146 
3147 
3148 
3149 
