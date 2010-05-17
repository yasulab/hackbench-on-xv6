5200 #include "types.h"
5201 
5202 void*
5203 memset(void *dst, int c, uint n)
5204 {
5205   char *d;
5206 
5207   d = (char*)dst;
5208   while(n-- > 0)
5209     *d++ = c;
5210 
5211   return dst;
5212 }
5213 
5214 int
5215 memcmp(const void *v1, const void *v2, uint n)
5216 {
5217   const uchar *s1, *s2;
5218 
5219   s1 = v1;
5220   s2 = v2;
5221   while(n-- > 0){
5222     if(*s1 != *s2)
5223       return *s1 - *s2;
5224     s1++, s2++;
5225   }
5226 
5227   return 0;
5228 }
5229 
5230 void*
5231 memmove(void *dst, const void *src, uint n)
5232 {
5233   const char *s;
5234   char *d;
5235 
5236   s = src;
5237   d = dst;
5238   if(s < d && s + n > d){
5239     s += n;
5240     d += n;
5241     while(n-- > 0)
5242       *--d = *--s;
5243   } else
5244     while(n-- > 0)
5245       *d++ = *s++;
5246 
5247   return dst;
5248 }
5249 
5250 int
5251 strncmp(const char *p, const char *q, uint n)
5252 {
5253   while(n > 0 && *p && *p == *q)
5254     n--, p++, q++;
5255   if(n == 0)
5256     return 0;
5257   return (uchar)*p - (uchar)*q;
5258 }
5259 
5260 char*
5261 strncpy(char *s, const char *t, int n)
5262 {
5263   char *os;
5264 
5265   os = s;
5266   while(n-- > 0 && (*s++ = *t++) != 0)
5267     ;
5268   while(n-- > 0)
5269     *s++ = 0;
5270   return os;
5271 }
5272 
5273 // Like strncpy but guaranteed to NUL-terminate.
5274 char*
5275 safestrcpy(char *s, const char *t, int n)
5276 {
5277   char *os;
5278 
5279   os = s;
5280   if(n <= 0)
5281     return os;
5282   while(--n > 0 && (*s++ = *t++) != 0)
5283     ;
5284   *s = 0;
5285   return os;
5286 }
5287 
5288 int
5289 strlen(const char *s)
5290 {
5291   int n;
5292 
5293   for(n = 0; s[n]; n++)
5294     ;
5295   return n;
5296 }
5297 
5298 
5299 
