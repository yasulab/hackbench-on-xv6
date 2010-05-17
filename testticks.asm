
_testticks:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
//#include "defs.h"
#include "user.h"

int main(int argc, char *argv[]){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  int i = getticks();
   9:	e8 f2 02 00 00       	call   300 <getticks>
  //asm volatile();

  printf(1, "%d\n", i);
   e:	c7 44 24 04 de 06 00 	movl   $0x6de,0x4(%esp)
  15:	00 
  16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1d:	89 44 24 08          	mov    %eax,0x8(%esp)
  21:	e8 aa 03 00 00       	call   3d0 <printf>
  exit();
  26:	e8 3d 02 00 00       	call   268 <exit>
  2b:	90                   	nop
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop

00000030 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  30:	55                   	push   %ebp
  31:	31 d2                	xor    %edx,%edx
  33:	89 e5                	mov    %esp,%ebp
  35:	8b 45 08             	mov    0x8(%ebp),%eax
  38:	53                   	push   %ebx
  39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 c9                	test   %cl,%cl
  4c:	75 f2                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4e:	5b                   	pop    %ebx
  4f:	5d                   	pop    %ebp
  50:	c3                   	ret    
  51:	eb 0d                	jmp    60 <strcmp>
  53:	90                   	nop
  54:	90                   	nop
  55:	90                   	nop
  56:	90                   	nop
  57:	90                   	nop
  58:	90                   	nop
  59:	90                   	nop
  5a:	90                   	nop
  5b:	90                   	nop
  5c:	90                   	nop
  5d:	90                   	nop
  5e:	90                   	nop
  5f:	90                   	nop

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 4d 08             	mov    0x8(%ebp),%ecx
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  6a:	0f b6 01             	movzbl (%ecx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	75 14                	jne    85 <strcmp+0x25>
  71:	eb 25                	jmp    98 <strcmp+0x38>
  73:	90                   	nop
  74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  78:	83 c1 01             	add    $0x1,%ecx
  7b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  7e:	0f b6 01             	movzbl (%ecx),%eax
  81:	84 c0                	test   %al,%al
  83:	74 13                	je     98 <strcmp+0x38>
  85:	0f b6 1a             	movzbl (%edx),%ebx
  88:	38 d8                	cmp    %bl,%al
  8a:	74 ec                	je     78 <strcmp+0x18>
  8c:	0f b6 db             	movzbl %bl,%ebx
  8f:	0f b6 c0             	movzbl %al,%eax
  92:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  94:	5b                   	pop    %ebx
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    
  97:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  98:	0f b6 1a             	movzbl (%edx),%ebx
  9b:	31 c0                	xor    %eax,%eax
  9d:	0f b6 db             	movzbl %bl,%ebx
  a0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  a2:	5b                   	pop    %ebx
  a3:	5d                   	pop    %ebp
  a4:	c3                   	ret    
  a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strlen>:

uint
strlen(char *s)
{
  b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  b1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  b3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
  b5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ba:	80 39 00             	cmpb   $0x0,(%ecx)
  bd:	74 0c                	je     cb <strlen+0x1b>
  bf:	90                   	nop
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  d6:	53                   	push   %ebx
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
  da:	85 c9                	test   %ecx,%ecx
  dc:	74 14                	je     f2 <memset+0x22>
  de:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
  e2:	31 d2                	xor    %edx,%edx
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
  e8:	88 1c 10             	mov    %bl,(%eax,%edx,1)
  eb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
  ee:	39 ca                	cmp    %ecx,%edx
  f0:	75 f6                	jne    e8 <memset+0x18>
    *d++ = c;
  return dst;
}
  f2:	5b                   	pop    %ebx
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret    
  f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	75 11                	jne    122 <strchr+0x22>
 111:	eb 15                	jmp    128 <strchr+0x28>
 113:	90                   	nop
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 118:	83 c0 01             	add    $0x1,%eax
 11b:	0f b6 10             	movzbl (%eax),%edx
 11e:	84 d2                	test   %dl,%dl
 120:	74 06                	je     128 <strchr+0x28>
    if(*s == c)
 122:	38 ca                	cmp    %cl,%dl
 124:	75 f2                	jne    118 <strchr+0x18>
      return (char*) s;
  return 0;
}
 126:	5d                   	pop    %ebp
 127:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 128:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 12a:	5d                   	pop    %ebp
 12b:	90                   	nop
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	c3                   	ret    
 131:	eb 0d                	jmp    140 <atoi>
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

00000140 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 140:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 141:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 143:	89 e5                	mov    %esp,%ebp
 145:	8b 4d 08             	mov    0x8(%ebp),%ecx
 148:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 149:	0f b6 11             	movzbl (%ecx),%edx
 14c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 14f:	80 fb 09             	cmp    $0x9,%bl
 152:	77 1c                	ja     170 <atoi+0x30>
 154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 158:	0f be d2             	movsbl %dl,%edx
 15b:	83 c1 01             	add    $0x1,%ecx
 15e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 161:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 165:	0f b6 11             	movzbl (%ecx),%edx
 168:	8d 5a d0             	lea    -0x30(%edx),%ebx
 16b:	80 fb 09             	cmp    $0x9,%bl
 16e:	76 e8                	jbe    158 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 170:	5b                   	pop    %ebx
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	56                   	push   %esi
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	53                   	push   %ebx
 188:	8b 5d 10             	mov    0x10(%ebp),%ebx
 18b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 18e:	85 db                	test   %ebx,%ebx
 190:	7e 14                	jle    1a6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 192:	31 d2                	xor    %edx,%edx
 194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 198:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 19c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 19f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1a2:	39 da                	cmp    %ebx,%edx
 1a4:	75 f2                	jne    198 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 1a6:	5b                   	pop    %ebx
 1a7:	5e                   	pop    %esi
 1a8:	5d                   	pop    %ebp
 1a9:	c3                   	ret    
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1b9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1bc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 1bf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1cb:	00 
 1cc:	89 04 24             	mov    %eax,(%esp)
 1cf:	e8 d4 00 00 00       	call   2a8 <open>
  if(fd < 0)
 1d4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1d8:	78 19                	js     1f3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 1c 24             	mov    %ebx,(%esp)
 1e0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1e4:	e8 d7 00 00 00       	call   2c0 <fstat>
  close(fd);
 1e9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 1ec:	89 c6                	mov    %eax,%esi
  close(fd);
 1ee:	e8 9d 00 00 00       	call   290 <close>
  return r;
}
 1f3:	89 f0                	mov    %esi,%eax
 1f5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1f8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1fb:	89 ec                	mov    %ebp,%esp
 1fd:	5d                   	pop    %ebp
 1fe:	c3                   	ret    
 1ff:	90                   	nop

00000200 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	31 f6                	xor    %esi,%esi
 207:	53                   	push   %ebx
 208:	83 ec 2c             	sub    $0x2c,%esp
 20b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20e:	eb 06                	jmp    216 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 210:	3c 0a                	cmp    $0xa,%al
 212:	74 39                	je     24d <gets+0x4d>
 214:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 216:	8d 5e 01             	lea    0x1(%esi),%ebx
 219:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 21c:	7d 31                	jge    24f <gets+0x4f>
    cc = read(0, &c, 1);
 21e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 221:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 228:	00 
 229:	89 44 24 04          	mov    %eax,0x4(%esp)
 22d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 234:	e8 47 00 00 00       	call   280 <read>
    if(cc < 1)
 239:	85 c0                	test   %eax,%eax
 23b:	7e 12                	jle    24f <gets+0x4f>
      break;
    buf[i++] = c;
 23d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 241:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 245:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 249:	3c 0d                	cmp    $0xd,%al
 24b:	75 c3                	jne    210 <gets+0x10>
 24d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 24f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 253:	89 f8                	mov    %edi,%eax
 255:	83 c4 2c             	add    $0x2c,%esp
 258:	5b                   	pop    %ebx
 259:	5e                   	pop    %esi
 25a:	5f                   	pop    %edi
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	90                   	nop
 25e:	90                   	nop
 25f:	90                   	nop

00000260 <fork>:
 260:	b8 01 00 00 00       	mov    $0x1,%eax
 265:	cd 30                	int    $0x30
 267:	c3                   	ret    

00000268 <exit>:
 268:	b8 02 00 00 00       	mov    $0x2,%eax
 26d:	cd 30                	int    $0x30
 26f:	c3                   	ret    

00000270 <wait>:
 270:	b8 03 00 00 00       	mov    $0x3,%eax
 275:	cd 30                	int    $0x30
 277:	c3                   	ret    

00000278 <pipe>:
 278:	b8 04 00 00 00       	mov    $0x4,%eax
 27d:	cd 30                	int    $0x30
 27f:	c3                   	ret    

00000280 <read>:
 280:	b8 06 00 00 00       	mov    $0x6,%eax
 285:	cd 30                	int    $0x30
 287:	c3                   	ret    

00000288 <write>:
 288:	b8 05 00 00 00       	mov    $0x5,%eax
 28d:	cd 30                	int    $0x30
 28f:	c3                   	ret    

00000290 <close>:
 290:	b8 07 00 00 00       	mov    $0x7,%eax
 295:	cd 30                	int    $0x30
 297:	c3                   	ret    

00000298 <kill>:
 298:	b8 08 00 00 00       	mov    $0x8,%eax
 29d:	cd 30                	int    $0x30
 29f:	c3                   	ret    

000002a0 <exec>:
 2a0:	b8 09 00 00 00       	mov    $0x9,%eax
 2a5:	cd 30                	int    $0x30
 2a7:	c3                   	ret    

000002a8 <open>:
 2a8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ad:	cd 30                	int    $0x30
 2af:	c3                   	ret    

000002b0 <mknod>:
 2b0:	b8 0b 00 00 00       	mov    $0xb,%eax
 2b5:	cd 30                	int    $0x30
 2b7:	c3                   	ret    

000002b8 <unlink>:
 2b8:	b8 0c 00 00 00       	mov    $0xc,%eax
 2bd:	cd 30                	int    $0x30
 2bf:	c3                   	ret    

000002c0 <fstat>:
 2c0:	b8 0d 00 00 00       	mov    $0xd,%eax
 2c5:	cd 30                	int    $0x30
 2c7:	c3                   	ret    

000002c8 <link>:
 2c8:	b8 0e 00 00 00       	mov    $0xe,%eax
 2cd:	cd 30                	int    $0x30
 2cf:	c3                   	ret    

000002d0 <mkdir>:
 2d0:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d5:	cd 30                	int    $0x30
 2d7:	c3                   	ret    

000002d8 <chdir>:
 2d8:	b8 10 00 00 00       	mov    $0x10,%eax
 2dd:	cd 30                	int    $0x30
 2df:	c3                   	ret    

000002e0 <dup>:
 2e0:	b8 11 00 00 00       	mov    $0x11,%eax
 2e5:	cd 30                	int    $0x30
 2e7:	c3                   	ret    

000002e8 <getpid>:
 2e8:	b8 12 00 00 00       	mov    $0x12,%eax
 2ed:	cd 30                	int    $0x30
 2ef:	c3                   	ret    

000002f0 <sbrk>:
 2f0:	b8 13 00 00 00       	mov    $0x13,%eax
 2f5:	cd 30                	int    $0x30
 2f7:	c3                   	ret    

000002f8 <sleep>:
 2f8:	b8 14 00 00 00       	mov    $0x14,%eax
 2fd:	cd 30                	int    $0x30
 2ff:	c3                   	ret    

00000300 <getticks>:
 300:	b8 15 00 00 00       	mov    $0x15,%eax
 305:	cd 30                	int    $0x30
 307:	c3                   	ret    
 308:	90                   	nop
 309:	90                   	nop
 30a:	90                   	nop
 30b:	90                   	nop
 30c:	90                   	nop
 30d:	90                   	nop
 30e:	90                   	nop
 30f:	90                   	nop

00000310 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 ec 28             	sub    $0x28,%esp
 316:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 319:	8d 55 f4             	lea    -0xc(%ebp),%edx
 31c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 323:	00 
 324:	89 54 24 04          	mov    %edx,0x4(%esp)
 328:	89 04 24             	mov    %eax,(%esp)
 32b:	e8 58 ff ff ff       	call   288 <write>
}
 330:	c9                   	leave  
 331:	c3                   	ret    
 332:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	89 c7                	mov    %eax,%edi
 346:	56                   	push   %esi
 347:	89 ce                	mov    %ecx,%esi
 349:	53                   	push   %ebx
 34a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 350:	85 c9                	test   %ecx,%ecx
 352:	74 04                	je     358 <printint+0x18>
 354:	85 d2                	test   %edx,%edx
 356:	78 5d                	js     3b5 <printint+0x75>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 358:	89 d0                	mov    %edx,%eax
 35a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 361:	31 c9                	xor    %ecx,%ecx
 363:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 366:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 368:	31 d2                	xor    %edx,%edx
 36a:	f7 f6                	div    %esi
 36c:	0f b6 92 e9 06 00 00 	movzbl 0x6e9(%edx),%edx
 373:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 376:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 379:	85 c0                	test   %eax,%eax
 37b:	75 eb                	jne    368 <printint+0x28>
  if(neg)
 37d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 380:	85 c0                	test   %eax,%eax
 382:	74 08                	je     38c <printint+0x4c>
    buf[i++] = '-';
 384:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 389:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 38c:	8d 71 ff             	lea    -0x1(%ecx),%esi
 38f:	01 f3                	add    %esi,%ebx
 391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 398:	0f be 13             	movsbl (%ebx),%edx
 39b:	89 f8                	mov    %edi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 39d:	83 ee 01             	sub    $0x1,%esi
 3a0:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
 3a3:	e8 68 ff ff ff       	call   310 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3a8:	83 fe ff             	cmp    $0xffffffff,%esi
 3ab:	75 eb                	jne    398 <printint+0x58>
    putc(fd, buf[i]);
}
 3ad:	83 c4 2c             	add    $0x2c,%esp
 3b0:	5b                   	pop    %ebx
 3b1:	5e                   	pop    %esi
 3b2:	5f                   	pop    %edi
 3b3:	5d                   	pop    %ebp
 3b4:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3b5:	89 d0                	mov    %edx,%eax
 3b7:	f7 d8                	neg    %eax
 3b9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 3c0:	eb 9f                	jmp    361 <printint+0x21>
 3c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3d9:	8b 45 0c             	mov    0xc(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3dc:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3df:	0f b6 08             	movzbl (%eax),%ecx
 3e2:	84 c9                	test   %cl,%cl
 3e4:	0f 84 96 00 00 00    	je     480 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3ea:	8d 55 10             	lea    0x10(%ebp),%edx
 3ed:	31 f6                	xor    %esi,%esi
 3ef:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 3f2:	31 db                	xor    %ebx,%ebx
 3f4:	eb 1a                	jmp    410 <printf+0x40>
 3f6:	66 90                	xchg   %ax,%ax
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f8:	83 f9 25             	cmp    $0x25,%ecx
 3fb:	0f 85 87 00 00 00    	jne    488 <printf+0xb8>
 401:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 405:	83 c3 01             	add    $0x1,%ebx
 408:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 40c:	84 c9                	test   %cl,%cl
 40e:	74 70                	je     480 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 410:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 412:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 415:	74 e1                	je     3f8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 417:	83 fe 25             	cmp    $0x25,%esi
 41a:	75 e9                	jne    405 <printf+0x35>
      if(c == 'd'){
 41c:	83 f9 64             	cmp    $0x64,%ecx
 41f:	90                   	nop
 420:	0f 84 fa 00 00 00    	je     520 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 426:	83 f9 70             	cmp    $0x70,%ecx
 429:	74 75                	je     4a0 <printf+0xd0>
 42b:	83 f9 78             	cmp    $0x78,%ecx
 42e:	66 90                	xchg   %ax,%ax
 430:	74 6e                	je     4a0 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 432:	83 f9 73             	cmp    $0x73,%ecx
 435:	0f 84 8d 00 00 00    	je     4c8 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 43b:	83 f9 63             	cmp    $0x63,%ecx
 43e:	66 90                	xchg   %ax,%ax
 440:	0f 84 fe 00 00 00    	je     544 <printf+0x174>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 446:	83 f9 25             	cmp    $0x25,%ecx
 449:	0f 84 b9 00 00 00    	je     508 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 44f:	ba 25 00 00 00       	mov    $0x25,%edx
 454:	89 f8                	mov    %edi,%eax
 456:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 459:	83 c3 01             	add    $0x1,%ebx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 45c:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 45e:	e8 ad fe ff ff       	call   310 <putc>
        putc(fd, c);
 463:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 466:	89 f8                	mov    %edi,%eax
 468:	0f be d1             	movsbl %cl,%edx
 46b:	e8 a0 fe ff ff       	call   310 <putc>
 470:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 473:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 477:	84 c9                	test   %cl,%cl
 479:	75 95                	jne    410 <printf+0x40>
 47b:	90                   	nop
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 480:	83 c4 2c             	add    $0x2c,%esp
 483:	5b                   	pop    %ebx
 484:	5e                   	pop    %esi
 485:	5f                   	pop    %edi
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 488:	89 f8                	mov    %edi,%eax
 48a:	0f be d1             	movsbl %cl,%edx
 48d:	e8 7e fe ff ff       	call   310 <putc>
 492:	8b 45 0c             	mov    0xc(%ebp),%eax
 495:	e9 6b ff ff ff       	jmp    405 <printf+0x35>
 49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4a3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 4a8:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4b1:	8b 10                	mov    (%eax),%edx
 4b3:	89 f8                	mov    %edi,%eax
 4b5:	e8 86 fe ff ff       	call   340 <printint>
 4ba:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 4bd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 4c1:	e9 3f ff ff ff       	jmp    405 <printf+0x35>
 4c6:	66 90                	xchg   %ax,%ax
      } else if(c == 's'){
        s = (char*)*ap;
 4c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 4cb:	8b 32                	mov    (%edx),%esi
        ap++;
 4cd:	83 c2 04             	add    $0x4,%edx
 4d0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        if(s == 0)
 4d3:	85 f6                	test   %esi,%esi
 4d5:	0f 84 84 00 00 00    	je     55f <printf+0x18f>
          s = "(null)";
        while(*s != 0){
 4db:	0f b6 16             	movzbl (%esi),%edx
 4de:	84 d2                	test   %dl,%dl
 4e0:	74 1d                	je     4ff <printf+0x12f>
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 4e8:	0f be d2             	movsbl %dl,%edx
          s++;
 4eb:	83 c6 01             	add    $0x1,%esi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 4ee:	89 f8                	mov    %edi,%eax
 4f0:	e8 1b fe ff ff       	call   310 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4f5:	0f b6 16             	movzbl (%esi),%edx
 4f8:	84 d2                	test   %dl,%dl
 4fa:	75 ec                	jne    4e8 <printf+0x118>
 4fc:	8b 45 0c             	mov    0xc(%ebp),%eax
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4ff:	31 f6                	xor    %esi,%esi
 501:	e9 ff fe ff ff       	jmp    405 <printf+0x35>
 506:	66 90                	xchg   %ax,%ax
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 508:	89 f8                	mov    %edi,%eax
 50a:	ba 25 00 00 00       	mov    $0x25,%edx
 50f:	e8 fc fd ff ff       	call   310 <putc>
 514:	31 f6                	xor    %esi,%esi
 516:	8b 45 0c             	mov    0xc(%ebp),%eax
 519:	e9 e7 fe ff ff       	jmp    405 <printf+0x35>
 51e:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 520:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 523:	b1 0a                	mov    $0xa,%cl
        ap++;
 525:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 528:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 52f:	8b 10                	mov    (%eax),%edx
 531:	89 f8                	mov    %edi,%eax
 533:	e8 08 fe ff ff       	call   340 <printint>
 538:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 53b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 53f:	e9 c1 fe ff ff       	jmp    405 <printf+0x35>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 544:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        ap++;
 547:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 549:	0f be 10             	movsbl (%eax),%edx
 54c:	89 f8                	mov    %edi,%eax
 54e:	e8 bd fd ff ff       	call   310 <putc>
 553:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 556:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 55a:	e9 a6 fe ff ff       	jmp    405 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 55f:	be e2 06 00 00       	mov    $0x6e2,%esi
 564:	e9 72 ff ff ff       	jmp    4db <printf+0x10b>
 569:	90                   	nop
 56a:	90                   	nop
 56b:	90                   	nop
 56c:	90                   	nop
 56d:	90                   	nop
 56e:	90                   	nop
 56f:	90                   	nop

00000570 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 570:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 571:	a1 04 07 00 00       	mov    0x704,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 576:	89 e5                	mov    %esp,%ebp
 578:	57                   	push   %edi
 579:	56                   	push   %esi
 57a:	53                   	push   %ebx
 57b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 57e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 581:	39 c8                	cmp    %ecx,%eax
 583:	73 1d                	jae    5a2 <free+0x32>
 585:	8d 76 00             	lea    0x0(%esi),%esi
 588:	8b 10                	mov    (%eax),%edx
 58a:	39 d1                	cmp    %edx,%ecx
 58c:	72 1a                	jb     5a8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 58e:	39 d0                	cmp    %edx,%eax
 590:	72 08                	jb     59a <free+0x2a>
 592:	39 c8                	cmp    %ecx,%eax
 594:	72 12                	jb     5a8 <free+0x38>
 596:	39 d1                	cmp    %edx,%ecx
 598:	72 0e                	jb     5a8 <free+0x38>
 59a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 59c:	39 c8                	cmp    %ecx,%eax
 59e:	66 90                	xchg   %ax,%ax
 5a0:	72 e6                	jb     588 <free+0x18>
 5a2:	8b 10                	mov    (%eax),%edx
 5a4:	eb e8                	jmp    58e <free+0x1e>
 5a6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5a8:	8b 71 04             	mov    0x4(%ecx),%esi
 5ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5ae:	39 d7                	cmp    %edx,%edi
 5b0:	74 19                	je     5cb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5b2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5b5:	8b 50 04             	mov    0x4(%eax),%edx
 5b8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5bb:	39 ce                	cmp    %ecx,%esi
 5bd:	74 21                	je     5e0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5bf:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5c1:	a3 04 07 00 00       	mov    %eax,0x704
}
 5c6:	5b                   	pop    %ebx
 5c7:	5e                   	pop    %esi
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5cb:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 5ce:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5d0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5d3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5d6:	8b 50 04             	mov    0x4(%eax),%edx
 5d9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5dc:	39 ce                	cmp    %ecx,%esi
 5de:	75 df                	jne    5bf <free+0x4f>
    p->s.size += bp->s.size;
 5e0:	03 51 04             	add    0x4(%ecx),%edx
 5e3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5e6:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5e9:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5eb:	a3 04 07 00 00       	mov    %eax,0x704
}
 5f0:	5b                   	pop    %ebx
 5f1:	5e                   	pop    %esi
 5f2:	5f                   	pop    %edi
 5f3:	5d                   	pop    %ebp
 5f4:	c3                   	ret    
 5f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000600 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 609:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 60c:	8b 0d 04 07 00 00    	mov    0x704,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 612:	83 c3 07             	add    $0x7,%ebx
 615:	c1 eb 03             	shr    $0x3,%ebx
 618:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 61b:	85 c9                	test   %ecx,%ecx
 61d:	0f 84 93 00 00 00    	je     6b6 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 623:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 625:	8b 50 04             	mov    0x4(%eax),%edx
 628:	39 d3                	cmp    %edx,%ebx
 62a:	76 1f                	jbe    64b <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 62c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 633:	90                   	nop
 634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 638:	3b 05 04 07 00 00    	cmp    0x704,%eax
 63e:	74 30                	je     670 <malloc+0x70>
 640:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 642:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 644:	8b 50 04             	mov    0x4(%eax),%edx
 647:	39 d3                	cmp    %edx,%ebx
 649:	77 ed                	ja     638 <malloc+0x38>
      if(p->s.size == nunits)
 64b:	39 d3                	cmp    %edx,%ebx
 64d:	74 61                	je     6b0 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 64f:	29 da                	sub    %ebx,%edx
 651:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 654:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 657:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 65a:	89 0d 04 07 00 00    	mov    %ecx,0x704
      return (void*) (p + 1);
 660:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 663:	83 c4 1c             	add    $0x1c,%esp
 666:	5b                   	pop    %ebx
 667:	5e                   	pop    %esi
 668:	5f                   	pop    %edi
 669:	5d                   	pop    %ebp
 66a:	c3                   	ret    
 66b:	90                   	nop
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 670:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 676:	b8 00 80 00 00       	mov    $0x8000,%eax
 67b:	bf 00 10 00 00       	mov    $0x1000,%edi
 680:	76 04                	jbe    686 <malloc+0x86>
 682:	89 f0                	mov    %esi,%eax
 684:	89 df                	mov    %ebx,%edi
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 686:	89 04 24             	mov    %eax,(%esp)
 689:	e8 62 fc ff ff       	call   2f0 <sbrk>
  if(p == (char*) -1)
 68e:	83 f8 ff             	cmp    $0xffffffff,%eax
 691:	74 18                	je     6ab <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 693:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 696:	83 c0 08             	add    $0x8,%eax
 699:	89 04 24             	mov    %eax,(%esp)
 69c:	e8 cf fe ff ff       	call   570 <free>
  return freep;
 6a1:	8b 0d 04 07 00 00    	mov    0x704,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6a7:	85 c9                	test   %ecx,%ecx
 6a9:	75 97                	jne    642 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6ab:	31 c0                	xor    %eax,%eax
 6ad:	eb b4                	jmp    663 <malloc+0x63>
 6af:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6b0:	8b 10                	mov    (%eax),%edx
 6b2:	89 11                	mov    %edx,(%ecx)
 6b4:	eb a4                	jmp    65a <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6b6:	c7 05 04 07 00 00 fc 	movl   $0x6fc,0x704
 6bd:	06 00 00 
    base.s.size = 0;
 6c0:	b9 fc 06 00 00       	mov    $0x6fc,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6c5:	c7 05 fc 06 00 00 fc 	movl   $0x6fc,0x6fc
 6cc:	06 00 00 
    base.s.size = 0;
 6cf:	c7 05 00 07 00 00 00 	movl   $0x0,0x700
 6d6:	00 00 00 
 6d9:	e9 45 ff ff ff       	jmp    623 <malloc+0x23>
