
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:
#include "stat.h"
#include "user.h"

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
   7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   a:	89 1c 24             	mov    %ebx,(%esp)
   d:	e8 7e 01 00 00       	call   190 <strlen>
  12:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  16:	89 44 24 08          	mov    %eax,0x8(%esp)
  1a:	8b 45 08             	mov    0x8(%ebp),%eax
  1d:	89 04 24             	mov    %eax,(%esp)
  20:	e8 43 03 00 00       	call   368 <write>
}
  25:	83 c4 14             	add    $0x14,%esp
  28:	5b                   	pop    %ebx
  29:	5d                   	pop    %ebp
  2a:	c3                   	ret    
  2b:	90                   	nop
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000030 <forktest>:

void
forktest(void)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
  34:	31 db                	xor    %ebx,%ebx
  write(fd, s, strlen(s));
}

void
forktest(void)
{
  36:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
  39:	c7 44 24 04 e8 03 00 	movl   $0x3e8,0x4(%esp)
  40:	00 
  41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  48:	e8 b3 ff ff ff       	call   0 <printf>
  4d:	eb 13                	jmp    62 <forktest+0x32>
  4f:	90                   	nop

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
  50:	74 72                	je     c4 <forktest+0x94>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
  52:	83 c3 01             	add    $0x1,%ebx
  55:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  5b:	90                   	nop
  5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  60:	74 4e                	je     b0 <forktest+0x80>
  62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pid = fork();
  68:	e8 d3 02 00 00       	call   340 <fork>
    if(pid < 0)
  6d:	83 f8 00             	cmp    $0x0,%eax
  70:	7d de                	jge    50 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
  72:	85 db                	test   %ebx,%ebx
  74:	74 11                	je     87 <forktest+0x57>
  76:	66 90                	xchg   %ax,%ax
    if(wait() < 0){
  78:	e8 d3 02 00 00       	call   350 <wait>
  7d:	85 c0                	test   %eax,%eax
  7f:	90                   	nop
  80:	78 47                	js     c9 <forktest+0x99>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
  82:	83 eb 01             	sub    $0x1,%ebx
  85:	75 f1                	jne    78 <forktest+0x48>
  87:	90                   	nop
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
  88:	e8 c3 02 00 00       	call   350 <wait>
  8d:	83 f8 ff             	cmp    $0xffffffff,%eax
  90:	75 50                	jne    e2 <forktest+0xb2>
    printf(1, "wait got too many\n");
    exit();
  }
  
  printf(1, "fork test OK\n");
  92:	c7 44 24 04 1a 04 00 	movl   $0x41a,0x4(%esp)
  99:	00 
  9a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a1:	e8 5a ff ff ff       	call   0 <printf>
}
  a6:	83 c4 14             	add    $0x14,%esp
  a9:	5b                   	pop    %ebx
  aa:	5d                   	pop    %ebp
  ab:	c3                   	ret    
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
  b0:	c7 44 24 04 28 04 00 	movl   $0x428,0x4(%esp)
  b7:	00 
  b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  bf:	e8 3c ff ff ff       	call   0 <printf>
    exit();
  c4:	e8 7f 02 00 00       	call   348 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
  c9:	c7 44 24 04 f3 03 00 	movl   $0x3f3,0x4(%esp)
  d0:	00 
  d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d8:	e8 23 ff ff ff       	call   0 <printf>
      exit();
  dd:	e8 66 02 00 00       	call   348 <exit>
    }
  }
  
  if(wait() != -1){
    printf(1, "wait got too many\n");
  e2:	c7 44 24 04 07 04 00 	movl   $0x407,0x4(%esp)
  e9:	00 
  ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f1:	e8 0a ff ff ff       	call   0 <printf>
    exit();
  f6:	e8 4d 02 00 00       	call   348 <exit>
  fb:	90                   	nop
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000100 <main>:
  printf(1, "fork test OK\n");
}

int
main(void)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
 106:	e8 25 ff ff ff       	call   30 <forktest>
  exit();
 10b:	e8 38 02 00 00       	call   348 <exit>

00000110 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 110:	55                   	push   %ebp
 111:	31 d2                	xor    %edx,%edx
 113:	89 e5                	mov    %esp,%ebp
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	53                   	push   %ebx
 119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 120:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 124:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 127:	83 c2 01             	add    $0x1,%edx
 12a:	84 c9                	test   %cl,%cl
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	5b                   	pop    %ebx
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    
 131:	eb 0d                	jmp    140 <strcmp>
 133:	90                   	nop
 134:	90                   	nop
 135:	90                   	nop
 136:	90                   	nop
 137:	90                   	nop
 138:	90                   	nop
 139:	90                   	nop
 13a:	90                   	nop
 13b:	90                   	nop
 13c:	90                   	nop
 13d:	90                   	nop
 13e:	90                   	nop
 13f:	90                   	nop

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 4d 08             	mov    0x8(%ebp),%ecx
 147:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 14a:	0f b6 01             	movzbl (%ecx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	75 14                	jne    165 <strcmp+0x25>
 151:	eb 25                	jmp    178 <strcmp+0x38>
 153:	90                   	nop
 154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 158:	83 c1 01             	add    $0x1,%ecx
 15b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 15e:	0f b6 01             	movzbl (%ecx),%eax
 161:	84 c0                	test   %al,%al
 163:	74 13                	je     178 <strcmp+0x38>
 165:	0f b6 1a             	movzbl (%edx),%ebx
 168:	38 d8                	cmp    %bl,%al
 16a:	74 ec                	je     158 <strcmp+0x18>
 16c:	0f b6 db             	movzbl %bl,%ebx
 16f:	0f b6 c0             	movzbl %al,%eax
 172:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 174:	5b                   	pop    %ebx
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
 177:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 178:	0f b6 1a             	movzbl (%edx),%ebx
 17b:	31 c0                	xor    %eax,%eax
 17d:	0f b6 db             	movzbl %bl,%ebx
 180:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 182:	5b                   	pop    %ebx
 183:	5d                   	pop    %ebp
 184:	c3                   	ret    
 185:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <strlen>:

uint
strlen(char *s)
{
 190:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 191:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 193:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 195:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 197:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 19a:	80 39 00             	cmpb   $0x0,(%ecx)
 19d:	74 0c                	je     1ab <strlen+0x1b>
 19f:	90                   	nop
 1a0:	83 c2 01             	add    $0x1,%edx
 1a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1a7:	89 d0                	mov    %edx,%eax
 1a9:	75 f5                	jne    1a0 <strlen+0x10>
    ;
  return n;
}
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1b6:	53                   	push   %ebx
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 1ba:	85 c9                	test   %ecx,%ecx
 1bc:	74 14                	je     1d2 <memset+0x22>
 1be:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 1c2:	31 d2                	xor    %edx,%edx
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 1c8:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 1cb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 1ce:	39 ca                	cmp    %ecx,%edx
 1d0:	75 f6                	jne    1c8 <memset+0x18>
    *d++ = c;
  return dst;
}
 1d2:	5b                   	pop    %ebx
 1d3:	5d                   	pop    %ebp
 1d4:	c3                   	ret    
 1d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <strchr>:

char*
strchr(const char *s, char c)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ea:	0f b6 10             	movzbl (%eax),%edx
 1ed:	84 d2                	test   %dl,%dl
 1ef:	75 11                	jne    202 <strchr+0x22>
 1f1:	eb 15                	jmp    208 <strchr+0x28>
 1f3:	90                   	nop
 1f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f8:	83 c0 01             	add    $0x1,%eax
 1fb:	0f b6 10             	movzbl (%eax),%edx
 1fe:	84 d2                	test   %dl,%dl
 200:	74 06                	je     208 <strchr+0x28>
    if(*s == c)
 202:	38 ca                	cmp    %cl,%dl
 204:	75 f2                	jne    1f8 <strchr+0x18>
      return (char*) s;
  return 0;
}
 206:	5d                   	pop    %ebp
 207:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 208:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 20a:	5d                   	pop    %ebp
 20b:	90                   	nop
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 210:	c3                   	ret    
 211:	eb 0d                	jmp    220 <atoi>
 213:	90                   	nop
 214:	90                   	nop
 215:	90                   	nop
 216:	90                   	nop
 217:	90                   	nop
 218:	90                   	nop
 219:	90                   	nop
 21a:	90                   	nop
 21b:	90                   	nop
 21c:	90                   	nop
 21d:	90                   	nop
 21e:	90                   	nop
 21f:	90                   	nop

00000220 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 220:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 221:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 223:	89 e5                	mov    %esp,%ebp
 225:	8b 4d 08             	mov    0x8(%ebp),%ecx
 228:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 229:	0f b6 11             	movzbl (%ecx),%edx
 22c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 22f:	80 fb 09             	cmp    $0x9,%bl
 232:	77 1c                	ja     250 <atoi+0x30>
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 238:	0f be d2             	movsbl %dl,%edx
 23b:	83 c1 01             	add    $0x1,%ecx
 23e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 241:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 245:	0f b6 11             	movzbl (%ecx),%edx
 248:	8d 5a d0             	lea    -0x30(%edx),%ebx
 24b:	80 fb 09             	cmp    $0x9,%bl
 24e:	76 e8                	jbe    238 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 250:	5b                   	pop    %ebx
 251:	5d                   	pop    %ebp
 252:	c3                   	ret    
 253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	53                   	push   %ebx
 268:	8b 5d 10             	mov    0x10(%ebp),%ebx
 26b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26e:	85 db                	test   %ebx,%ebx
 270:	7e 14                	jle    286 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 272:	31 d2                	xor    %edx,%edx
 274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 278:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 27c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 27f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 282:	39 da                	cmp    %ebx,%edx
 284:	75 f2                	jne    278 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 286:	5b                   	pop    %ebx
 287:	5e                   	pop    %esi
 288:	5d                   	pop    %ebp
 289:	c3                   	ret    
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 296:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 299:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 29c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 29f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2ab:	00 
 2ac:	89 04 24             	mov    %eax,(%esp)
 2af:	e8 d4 00 00 00       	call   388 <open>
  if(fd < 0)
 2b4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2b8:	78 19                	js     2d3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 2ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bd:	89 1c 24             	mov    %ebx,(%esp)
 2c0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c4:	e8 d7 00 00 00       	call   3a0 <fstat>
  close(fd);
 2c9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2cc:	89 c6                	mov    %eax,%esi
  close(fd);
 2ce:	e8 9d 00 00 00       	call   370 <close>
  return r;
}
 2d3:	89 f0                	mov    %esi,%eax
 2d5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2d8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2db:	89 ec                	mov    %ebp,%esp
 2dd:	5d                   	pop    %ebp
 2de:	c3                   	ret    
 2df:	90                   	nop

000002e0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	56                   	push   %esi
 2e5:	31 f6                	xor    %esi,%esi
 2e7:	53                   	push   %ebx
 2e8:	83 ec 2c             	sub    $0x2c,%esp
 2eb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ee:	eb 06                	jmp    2f6 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2f0:	3c 0a                	cmp    $0xa,%al
 2f2:	74 39                	je     32d <gets+0x4d>
 2f4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f6:	8d 5e 01             	lea    0x1(%esi),%ebx
 2f9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2fc:	7d 31                	jge    32f <gets+0x4f>
    cc = read(0, &c, 1);
 2fe:	8d 45 e7             	lea    -0x19(%ebp),%eax
 301:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 308:	00 
 309:	89 44 24 04          	mov    %eax,0x4(%esp)
 30d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 314:	e8 47 00 00 00       	call   360 <read>
    if(cc < 1)
 319:	85 c0                	test   %eax,%eax
 31b:	7e 12                	jle    32f <gets+0x4f>
      break;
    buf[i++] = c;
 31d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 321:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 325:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 329:	3c 0d                	cmp    $0xd,%al
 32b:	75 c3                	jne    2f0 <gets+0x10>
 32d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 32f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 333:	89 f8                	mov    %edi,%eax
 335:	83 c4 2c             	add    $0x2c,%esp
 338:	5b                   	pop    %ebx
 339:	5e                   	pop    %esi
 33a:	5f                   	pop    %edi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret    
 33d:	90                   	nop
 33e:	90                   	nop
 33f:	90                   	nop

00000340 <fork>:
 340:	b8 01 00 00 00       	mov    $0x1,%eax
 345:	cd 30                	int    $0x30
 347:	c3                   	ret    

00000348 <exit>:
 348:	b8 02 00 00 00       	mov    $0x2,%eax
 34d:	cd 30                	int    $0x30
 34f:	c3                   	ret    

00000350 <wait>:
 350:	b8 03 00 00 00       	mov    $0x3,%eax
 355:	cd 30                	int    $0x30
 357:	c3                   	ret    

00000358 <pipe>:
 358:	b8 04 00 00 00       	mov    $0x4,%eax
 35d:	cd 30                	int    $0x30
 35f:	c3                   	ret    

00000360 <read>:
 360:	b8 06 00 00 00       	mov    $0x6,%eax
 365:	cd 30                	int    $0x30
 367:	c3                   	ret    

00000368 <write>:
 368:	b8 05 00 00 00       	mov    $0x5,%eax
 36d:	cd 30                	int    $0x30
 36f:	c3                   	ret    

00000370 <close>:
 370:	b8 07 00 00 00       	mov    $0x7,%eax
 375:	cd 30                	int    $0x30
 377:	c3                   	ret    

00000378 <kill>:
 378:	b8 08 00 00 00       	mov    $0x8,%eax
 37d:	cd 30                	int    $0x30
 37f:	c3                   	ret    

00000380 <exec>:
 380:	b8 09 00 00 00       	mov    $0x9,%eax
 385:	cd 30                	int    $0x30
 387:	c3                   	ret    

00000388 <open>:
 388:	b8 0a 00 00 00       	mov    $0xa,%eax
 38d:	cd 30                	int    $0x30
 38f:	c3                   	ret    

00000390 <mknod>:
 390:	b8 0b 00 00 00       	mov    $0xb,%eax
 395:	cd 30                	int    $0x30
 397:	c3                   	ret    

00000398 <unlink>:
 398:	b8 0c 00 00 00       	mov    $0xc,%eax
 39d:	cd 30                	int    $0x30
 39f:	c3                   	ret    

000003a0 <fstat>:
 3a0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a5:	cd 30                	int    $0x30
 3a7:	c3                   	ret    

000003a8 <link>:
 3a8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ad:	cd 30                	int    $0x30
 3af:	c3                   	ret    

000003b0 <mkdir>:
 3b0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b5:	cd 30                	int    $0x30
 3b7:	c3                   	ret    

000003b8 <chdir>:
 3b8:	b8 10 00 00 00       	mov    $0x10,%eax
 3bd:	cd 30                	int    $0x30
 3bf:	c3                   	ret    

000003c0 <dup>:
 3c0:	b8 11 00 00 00       	mov    $0x11,%eax
 3c5:	cd 30                	int    $0x30
 3c7:	c3                   	ret    

000003c8 <getpid>:
 3c8:	b8 12 00 00 00       	mov    $0x12,%eax
 3cd:	cd 30                	int    $0x30
 3cf:	c3                   	ret    

000003d0 <sbrk>:
 3d0:	b8 13 00 00 00       	mov    $0x13,%eax
 3d5:	cd 30                	int    $0x30
 3d7:	c3                   	ret    

000003d8 <sleep>:
 3d8:	b8 14 00 00 00       	mov    $0x14,%eax
 3dd:	cd 30                	int    $0x30
 3df:	c3                   	ret    

000003e0 <getticks>:
 3e0:	b8 15 00 00 00       	mov    $0x15,%eax
 3e5:	cd 30                	int    $0x30
 3e7:	c3                   	ret    
