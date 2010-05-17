
_mkdir:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	57                   	push   %edi
   7:	56                   	push   %esi
   8:	53                   	push   %ebx
   9:	83 ec 14             	sub    $0x14,%esp
   c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  if(argc < 2){
   f:	83 ff 01             	cmp    $0x1,%edi
  12:	7e 4c                	jle    60 <main+0x60>
    printf(2, "Usage: mkdir files...\n");
    exit();
  14:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  17:	be 01 00 00 00       	mov    $0x1,%esi
  1c:	83 c3 04             	add    $0x4,%ebx
  1f:	90                   	nop
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  20:	8b 03                	mov    (%ebx),%eax
  22:	89 04 24             	mov    %eax,(%esp)
  25:	e8 f6 02 00 00       	call   320 <mkdir>
  2a:	85 c0                	test   %eax,%eax
  2c:	78 12                	js     40 <main+0x40>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  2e:	83 c6 01             	add    $0x1,%esi
  31:	83 c3 04             	add    $0x4,%ebx
  34:	39 f7                	cmp    %esi,%edi
  36:	7f e8                	jg     20 <main+0x20>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  38:	e8 7b 02 00 00       	call   2b8 <exit>
  3d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  40:	8b 03                	mov    (%ebx),%eax
  42:	c7 44 24 04 45 07 00 	movl   $0x745,0x4(%esp)
  49:	00 
  4a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  51:	89 44 24 08          	mov    %eax,0x8(%esp)
  55:	e8 c6 03 00 00       	call   420 <printf>
      break;
    }
  }

  exit();
  5a:	e8 59 02 00 00       	call   2b8 <exit>
  5f:	90                   	nop
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
  60:	c7 44 24 04 2e 07 00 	movl   $0x72e,0x4(%esp)
  67:	00 
  68:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  6f:	e8 ac 03 00 00       	call   420 <printf>
    exit();
  74:	e8 3f 02 00 00       	call   2b8 <exit>
  79:	90                   	nop
  7a:	90                   	nop
  7b:	90                   	nop
  7c:	90                   	nop
  7d:	90                   	nop
  7e:	90                   	nop
  7f:	90                   	nop

00000080 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  80:	55                   	push   %ebp
  81:	31 d2                	xor    %edx,%edx
  83:	89 e5                	mov    %esp,%ebp
  85:	8b 45 08             	mov    0x8(%ebp),%eax
  88:	53                   	push   %ebx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  90:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
  94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 c9                	test   %cl,%cl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	5b                   	pop    %ebx
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	eb 0d                	jmp    b0 <strcmp>
  a3:	90                   	nop
  a4:	90                   	nop
  a5:	90                   	nop
  a6:	90                   	nop
  a7:	90                   	nop
  a8:	90                   	nop
  a9:	90                   	nop
  aa:	90                   	nop
  ab:	90                   	nop
  ac:	90                   	nop
  ad:	90                   	nop
  ae:	90                   	nop
  af:	90                   	nop

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  ba:	0f b6 01             	movzbl (%ecx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 14                	jne    d5 <strcmp+0x25>
  c1:	eb 25                	jmp    e8 <strcmp+0x38>
  c3:	90                   	nop
  c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
  c8:	83 c1 01             	add    $0x1,%ecx
  cb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ce:	0f b6 01             	movzbl (%ecx),%eax
  d1:	84 c0                	test   %al,%al
  d3:	74 13                	je     e8 <strcmp+0x38>
  d5:	0f b6 1a             	movzbl (%edx),%ebx
  d8:	38 d8                	cmp    %bl,%al
  da:	74 ec                	je     c8 <strcmp+0x18>
  dc:	0f b6 db             	movzbl %bl,%ebx
  df:	0f b6 c0             	movzbl %al,%eax
  e2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e8:	0f b6 1a             	movzbl (%edx),%ebx
  eb:	31 c0                	xor    %eax,%eax
  ed:	0f b6 db             	movzbl %bl,%ebx
  f0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
  f2:	5b                   	pop    %ebx
  f3:	5d                   	pop    %ebp
  f4:	c3                   	ret    
  f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strlen>:

uint
strlen(char *s)
{
 100:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 101:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 103:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 105:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 107:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 10a:	80 39 00             	cmpb   $0x0,(%ecx)
 10d:	74 0c                	je     11b <strlen+0x1b>
 10f:	90                   	nop
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
 11d:	8d 76 00             	lea    0x0(%esi),%esi

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 10             	mov    0x10(%ebp),%ecx
 126:	53                   	push   %ebx
 127:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 12a:	85 c9                	test   %ecx,%ecx
 12c:	74 14                	je     142 <memset+0x22>
 12e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 132:	31 d2                	xor    %edx,%edx
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 138:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 13b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 13e:	39 ca                	cmp    %ecx,%edx
 140:	75 f6                	jne    138 <memset+0x18>
    *d++ = c;
  return dst;
}
 142:	5b                   	pop    %ebx
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    
 145:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 11                	jne    172 <strchr+0x22>
 161:	eb 15                	jmp    178 <strchr+0x28>
 163:	90                   	nop
 164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 168:	83 c0 01             	add    $0x1,%eax
 16b:	0f b6 10             	movzbl (%eax),%edx
 16e:	84 d2                	test   %dl,%dl
 170:	74 06                	je     178 <strchr+0x28>
    if(*s == c)
 172:	38 ca                	cmp    %cl,%dl
 174:	75 f2                	jne    168 <strchr+0x18>
      return (char*) s;
  return 0;
}
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 178:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 17a:	5d                   	pop    %ebp
 17b:	90                   	nop
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 180:	c3                   	ret    
 181:	eb 0d                	jmp    190 <atoi>
 183:	90                   	nop
 184:	90                   	nop
 185:	90                   	nop
 186:	90                   	nop
 187:	90                   	nop
 188:	90                   	nop
 189:	90                   	nop
 18a:	90                   	nop
 18b:	90                   	nop
 18c:	90                   	nop
 18d:	90                   	nop
 18e:	90                   	nop
 18f:	90                   	nop

00000190 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 190:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 191:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 193:	89 e5                	mov    %esp,%ebp
 195:	8b 4d 08             	mov    0x8(%ebp),%ecx
 198:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 199:	0f b6 11             	movzbl (%ecx),%edx
 19c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 19f:	80 fb 09             	cmp    $0x9,%bl
 1a2:	77 1c                	ja     1c0 <atoi+0x30>
 1a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 1a8:	0f be d2             	movsbl %dl,%edx
 1ab:	83 c1 01             	add    $0x1,%ecx
 1ae:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1b1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1b5:	0f b6 11             	movzbl (%ecx),%edx
 1b8:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1bb:	80 fb 09             	cmp    $0x9,%bl
 1be:	76 e8                	jbe    1a8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1c0:	5b                   	pop    %ebx
 1c1:	5d                   	pop    %ebp
 1c2:	c3                   	ret    
 1c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	56                   	push   %esi
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
 1d7:	53                   	push   %ebx
 1d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 1db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1de:	85 db                	test   %ebx,%ebx
 1e0:	7e 14                	jle    1f6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 1e2:	31 d2                	xor    %edx,%edx
 1e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 1e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 1ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1ef:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f2:	39 da                	cmp    %ebx,%edx
 1f4:	75 f2                	jne    1e8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 1f6:	5b                   	pop    %ebx
 1f7:	5e                   	pop    %esi
 1f8:	5d                   	pop    %ebp
 1f9:	c3                   	ret    
 1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000200 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 206:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 209:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 20c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 20f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 214:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 21b:	00 
 21c:	89 04 24             	mov    %eax,(%esp)
 21f:	e8 d4 00 00 00       	call   2f8 <open>
  if(fd < 0)
 224:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 228:	78 19                	js     243 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 22a:	8b 45 0c             	mov    0xc(%ebp),%eax
 22d:	89 1c 24             	mov    %ebx,(%esp)
 230:	89 44 24 04          	mov    %eax,0x4(%esp)
 234:	e8 d7 00 00 00       	call   310 <fstat>
  close(fd);
 239:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 23c:	89 c6                	mov    %eax,%esi
  close(fd);
 23e:	e8 9d 00 00 00       	call   2e0 <close>
  return r;
}
 243:	89 f0                	mov    %esi,%eax
 245:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 248:	8b 75 fc             	mov    -0x4(%ebp),%esi
 24b:	89 ec                	mov    %ebp,%esp
 24d:	5d                   	pop    %ebp
 24e:	c3                   	ret    
 24f:	90                   	nop

00000250 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
 255:	31 f6                	xor    %esi,%esi
 257:	53                   	push   %ebx
 258:	83 ec 2c             	sub    $0x2c,%esp
 25b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25e:	eb 06                	jmp    266 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 260:	3c 0a                	cmp    $0xa,%al
 262:	74 39                	je     29d <gets+0x4d>
 264:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 266:	8d 5e 01             	lea    0x1(%esi),%ebx
 269:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 26c:	7d 31                	jge    29f <gets+0x4f>
    cc = read(0, &c, 1);
 26e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 271:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 278:	00 
 279:	89 44 24 04          	mov    %eax,0x4(%esp)
 27d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 284:	e8 47 00 00 00       	call   2d0 <read>
    if(cc < 1)
 289:	85 c0                	test   %eax,%eax
 28b:	7e 12                	jle    29f <gets+0x4f>
      break;
    buf[i++] = c;
 28d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 291:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 295:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 299:	3c 0d                	cmp    $0xd,%al
 29b:	75 c3                	jne    260 <gets+0x10>
 29d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 29f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 2a3:	89 f8                	mov    %edi,%eax
 2a5:	83 c4 2c             	add    $0x2c,%esp
 2a8:	5b                   	pop    %ebx
 2a9:	5e                   	pop    %esi
 2aa:	5f                   	pop    %edi
 2ab:	5d                   	pop    %ebp
 2ac:	c3                   	ret    
 2ad:	90                   	nop
 2ae:	90                   	nop
 2af:	90                   	nop

000002b0 <fork>:
 2b0:	b8 01 00 00 00       	mov    $0x1,%eax
 2b5:	cd 30                	int    $0x30
 2b7:	c3                   	ret    

000002b8 <exit>:
 2b8:	b8 02 00 00 00       	mov    $0x2,%eax
 2bd:	cd 30                	int    $0x30
 2bf:	c3                   	ret    

000002c0 <wait>:
 2c0:	b8 03 00 00 00       	mov    $0x3,%eax
 2c5:	cd 30                	int    $0x30
 2c7:	c3                   	ret    

000002c8 <pipe>:
 2c8:	b8 04 00 00 00       	mov    $0x4,%eax
 2cd:	cd 30                	int    $0x30
 2cf:	c3                   	ret    

000002d0 <read>:
 2d0:	b8 06 00 00 00       	mov    $0x6,%eax
 2d5:	cd 30                	int    $0x30
 2d7:	c3                   	ret    

000002d8 <write>:
 2d8:	b8 05 00 00 00       	mov    $0x5,%eax
 2dd:	cd 30                	int    $0x30
 2df:	c3                   	ret    

000002e0 <close>:
 2e0:	b8 07 00 00 00       	mov    $0x7,%eax
 2e5:	cd 30                	int    $0x30
 2e7:	c3                   	ret    

000002e8 <kill>:
 2e8:	b8 08 00 00 00       	mov    $0x8,%eax
 2ed:	cd 30                	int    $0x30
 2ef:	c3                   	ret    

000002f0 <exec>:
 2f0:	b8 09 00 00 00       	mov    $0x9,%eax
 2f5:	cd 30                	int    $0x30
 2f7:	c3                   	ret    

000002f8 <open>:
 2f8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2fd:	cd 30                	int    $0x30
 2ff:	c3                   	ret    

00000300 <mknod>:
 300:	b8 0b 00 00 00       	mov    $0xb,%eax
 305:	cd 30                	int    $0x30
 307:	c3                   	ret    

00000308 <unlink>:
 308:	b8 0c 00 00 00       	mov    $0xc,%eax
 30d:	cd 30                	int    $0x30
 30f:	c3                   	ret    

00000310 <fstat>:
 310:	b8 0d 00 00 00       	mov    $0xd,%eax
 315:	cd 30                	int    $0x30
 317:	c3                   	ret    

00000318 <link>:
 318:	b8 0e 00 00 00       	mov    $0xe,%eax
 31d:	cd 30                	int    $0x30
 31f:	c3                   	ret    

00000320 <mkdir>:
 320:	b8 0f 00 00 00       	mov    $0xf,%eax
 325:	cd 30                	int    $0x30
 327:	c3                   	ret    

00000328 <chdir>:
 328:	b8 10 00 00 00       	mov    $0x10,%eax
 32d:	cd 30                	int    $0x30
 32f:	c3                   	ret    

00000330 <dup>:
 330:	b8 11 00 00 00       	mov    $0x11,%eax
 335:	cd 30                	int    $0x30
 337:	c3                   	ret    

00000338 <getpid>:
 338:	b8 12 00 00 00       	mov    $0x12,%eax
 33d:	cd 30                	int    $0x30
 33f:	c3                   	ret    

00000340 <sbrk>:
 340:	b8 13 00 00 00       	mov    $0x13,%eax
 345:	cd 30                	int    $0x30
 347:	c3                   	ret    

00000348 <sleep>:
 348:	b8 14 00 00 00       	mov    $0x14,%eax
 34d:	cd 30                	int    $0x30
 34f:	c3                   	ret    

00000350 <getticks>:
 350:	b8 15 00 00 00       	mov    $0x15,%eax
 355:	cd 30                	int    $0x30
 357:	c3                   	ret    
 358:	90                   	nop
 359:	90                   	nop
 35a:	90                   	nop
 35b:	90                   	nop
 35c:	90                   	nop
 35d:	90                   	nop
 35e:	90                   	nop
 35f:	90                   	nop

00000360 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	83 ec 28             	sub    $0x28,%esp
 366:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 369:	8d 55 f4             	lea    -0xc(%ebp),%edx
 36c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 373:	00 
 374:	89 54 24 04          	mov    %edx,0x4(%esp)
 378:	89 04 24             	mov    %eax,(%esp)
 37b:	e8 58 ff ff ff       	call   2d8 <write>
}
 380:	c9                   	leave  
 381:	c3                   	ret    
 382:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	89 c7                	mov    %eax,%edi
 396:	56                   	push   %esi
 397:	89 ce                	mov    %ecx,%esi
 399:	53                   	push   %ebx
 39a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 39d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a0:	85 c9                	test   %ecx,%ecx
 3a2:	74 04                	je     3a8 <printint+0x18>
 3a4:	85 d2                	test   %edx,%edx
 3a6:	78 5d                	js     405 <printint+0x75>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3a8:	89 d0                	mov    %edx,%eax
 3aa:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 3b1:	31 c9                	xor    %ecx,%ecx
 3b3:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 3b6:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3b8:	31 d2                	xor    %edx,%edx
 3ba:	f7 f6                	div    %esi
 3bc:	0f b6 92 68 07 00 00 	movzbl 0x768(%edx),%edx
 3c3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 3c6:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 3c9:	85 c0                	test   %eax,%eax
 3cb:	75 eb                	jne    3b8 <printint+0x28>
  if(neg)
 3cd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3d0:	85 c0                	test   %eax,%eax
 3d2:	74 08                	je     3dc <printint+0x4c>
    buf[i++] = '-';
 3d4:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 3d9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 3dc:	8d 71 ff             	lea    -0x1(%ecx),%esi
 3df:	01 f3                	add    %esi,%ebx
 3e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 3e8:	0f be 13             	movsbl (%ebx),%edx
 3eb:	89 f8                	mov    %edi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3ed:	83 ee 01             	sub    $0x1,%esi
 3f0:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
 3f3:	e8 68 ff ff ff       	call   360 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3f8:	83 fe ff             	cmp    $0xffffffff,%esi
 3fb:	75 eb                	jne    3e8 <printint+0x58>
    putc(fd, buf[i]);
}
 3fd:	83 c4 2c             	add    $0x2c,%esp
 400:	5b                   	pop    %ebx
 401:	5e                   	pop    %esi
 402:	5f                   	pop    %edi
 403:	5d                   	pop    %ebp
 404:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 405:	89 d0                	mov    %edx,%eax
 407:	f7 d8                	neg    %eax
 409:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 410:	eb 9f                	jmp    3b1 <printint+0x21>
 412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 429:	8b 45 0c             	mov    0xc(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 42c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42f:	0f b6 08             	movzbl (%eax),%ecx
 432:	84 c9                	test   %cl,%cl
 434:	0f 84 96 00 00 00    	je     4d0 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 43a:	8d 55 10             	lea    0x10(%ebp),%edx
 43d:	31 f6                	xor    %esi,%esi
 43f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 442:	31 db                	xor    %ebx,%ebx
 444:	eb 1a                	jmp    460 <printf+0x40>
 446:	66 90                	xchg   %ax,%ax
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 448:	83 f9 25             	cmp    $0x25,%ecx
 44b:	0f 85 87 00 00 00    	jne    4d8 <printf+0xb8>
 451:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 455:	83 c3 01             	add    $0x1,%ebx
 458:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 45c:	84 c9                	test   %cl,%cl
 45e:	74 70                	je     4d0 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 460:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 462:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 465:	74 e1                	je     448 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 467:	83 fe 25             	cmp    $0x25,%esi
 46a:	75 e9                	jne    455 <printf+0x35>
      if(c == 'd'){
 46c:	83 f9 64             	cmp    $0x64,%ecx
 46f:	90                   	nop
 470:	0f 84 fa 00 00 00    	je     570 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 476:	83 f9 70             	cmp    $0x70,%ecx
 479:	74 75                	je     4f0 <printf+0xd0>
 47b:	83 f9 78             	cmp    $0x78,%ecx
 47e:	66 90                	xchg   %ax,%ax
 480:	74 6e                	je     4f0 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 482:	83 f9 73             	cmp    $0x73,%ecx
 485:	0f 84 8d 00 00 00    	je     518 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48b:	83 f9 63             	cmp    $0x63,%ecx
 48e:	66 90                	xchg   %ax,%ax
 490:	0f 84 fe 00 00 00    	je     594 <printf+0x174>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 496:	83 f9 25             	cmp    $0x25,%ecx
 499:	0f 84 b9 00 00 00    	je     558 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 49f:	ba 25 00 00 00       	mov    $0x25,%edx
 4a4:	89 f8                	mov    %edi,%eax
 4a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a9:	83 c3 01             	add    $0x1,%ebx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4ac:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4ae:	e8 ad fe ff ff       	call   360 <putc>
        putc(fd, c);
 4b3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 4b6:	89 f8                	mov    %edi,%eax
 4b8:	0f be d1             	movsbl %cl,%edx
 4bb:	e8 a0 fe ff ff       	call   360 <putc>
 4c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c3:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 4c7:	84 c9                	test   %cl,%cl
 4c9:	75 95                	jne    460 <printf+0x40>
 4cb:	90                   	nop
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4d0:	83 c4 2c             	add    $0x2c,%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5f                   	pop    %edi
 4d6:	5d                   	pop    %ebp
 4d7:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4d8:	89 f8                	mov    %edi,%eax
 4da:	0f be d1             	movsbl %cl,%edx
 4dd:	e8 7e fe ff ff       	call   360 <putc>
 4e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e5:	e9 6b ff ff ff       	jmp    455 <printf+0x35>
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 4f8:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 501:	8b 10                	mov    (%eax),%edx
 503:	89 f8                	mov    %edi,%eax
 505:	e8 86 fe ff ff       	call   390 <printint>
 50a:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 50d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 511:	e9 3f ff ff ff       	jmp    455 <printf+0x35>
 516:	66 90                	xchg   %ax,%ax
      } else if(c == 's'){
        s = (char*)*ap;
 518:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 51b:	8b 32                	mov    (%edx),%esi
        ap++;
 51d:	83 c2 04             	add    $0x4,%edx
 520:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        if(s == 0)
 523:	85 f6                	test   %esi,%esi
 525:	0f 84 84 00 00 00    	je     5af <printf+0x18f>
          s = "(null)";
        while(*s != 0){
 52b:	0f b6 16             	movzbl (%esi),%edx
 52e:	84 d2                	test   %dl,%dl
 530:	74 1d                	je     54f <printf+0x12f>
 532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 538:	0f be d2             	movsbl %dl,%edx
          s++;
 53b:	83 c6 01             	add    $0x1,%esi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 53e:	89 f8                	mov    %edi,%eax
 540:	e8 1b fe ff ff       	call   360 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 545:	0f b6 16             	movzbl (%esi),%edx
 548:	84 d2                	test   %dl,%dl
 54a:	75 ec                	jne    538 <printf+0x118>
 54c:	8b 45 0c             	mov    0xc(%ebp),%eax
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 54f:	31 f6                	xor    %esi,%esi
 551:	e9 ff fe ff ff       	jmp    455 <printf+0x35>
 556:	66 90                	xchg   %ax,%ax
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 558:	89 f8                	mov    %edi,%eax
 55a:	ba 25 00 00 00       	mov    $0x25,%edx
 55f:	e8 fc fd ff ff       	call   360 <putc>
 564:	31 f6                	xor    %esi,%esi
 566:	8b 45 0c             	mov    0xc(%ebp),%eax
 569:	e9 e7 fe ff ff       	jmp    455 <printf+0x35>
 56e:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 570:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 573:	b1 0a                	mov    $0xa,%cl
        ap++;
 575:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 578:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 57f:	8b 10                	mov    (%eax),%edx
 581:	89 f8                	mov    %edi,%eax
 583:	e8 08 fe ff ff       	call   390 <printint>
 588:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 58b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 58f:	e9 c1 fe ff ff       	jmp    455 <printf+0x35>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 594:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        ap++;
 597:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 599:	0f be 10             	movsbl (%eax),%edx
 59c:	89 f8                	mov    %edi,%eax
 59e:	e8 bd fd ff ff       	call   360 <putc>
 5a3:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 5a6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 5aa:	e9 a6 fe ff ff       	jmp    455 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 5af:	be 61 07 00 00       	mov    $0x761,%esi
 5b4:	e9 72 ff ff ff       	jmp    52b <printf+0x10b>
 5b9:	90                   	nop
 5ba:	90                   	nop
 5bb:	90                   	nop
 5bc:	90                   	nop
 5bd:	90                   	nop
 5be:	90                   	nop
 5bf:	90                   	nop

000005c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c1:	a1 84 07 00 00       	mov    0x784,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c6:	89 e5                	mov    %esp,%ebp
 5c8:	57                   	push   %edi
 5c9:	56                   	push   %esi
 5ca:	53                   	push   %ebx
 5cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 5ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d1:	39 c8                	cmp    %ecx,%eax
 5d3:	73 1d                	jae    5f2 <free+0x32>
 5d5:	8d 76 00             	lea    0x0(%esi),%esi
 5d8:	8b 10                	mov    (%eax),%edx
 5da:	39 d1                	cmp    %edx,%ecx
 5dc:	72 1a                	jb     5f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5de:	39 d0                	cmp    %edx,%eax
 5e0:	72 08                	jb     5ea <free+0x2a>
 5e2:	39 c8                	cmp    %ecx,%eax
 5e4:	72 12                	jb     5f8 <free+0x38>
 5e6:	39 d1                	cmp    %edx,%ecx
 5e8:	72 0e                	jb     5f8 <free+0x38>
 5ea:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ec:	39 c8                	cmp    %ecx,%eax
 5ee:	66 90                	xchg   %ax,%ax
 5f0:	72 e6                	jb     5d8 <free+0x18>
 5f2:	8b 10                	mov    (%eax),%edx
 5f4:	eb e8                	jmp    5de <free+0x1e>
 5f6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f8:	8b 71 04             	mov    0x4(%ecx),%esi
 5fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5fe:	39 d7                	cmp    %edx,%edi
 600:	74 19                	je     61b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 602:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 605:	8b 50 04             	mov    0x4(%eax),%edx
 608:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 60b:	39 ce                	cmp    %ecx,%esi
 60d:	74 21                	je     630 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 60f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 611:	a3 84 07 00 00       	mov    %eax,0x784
}
 616:	5b                   	pop    %ebx
 617:	5e                   	pop    %esi
 618:	5f                   	pop    %edi
 619:	5d                   	pop    %ebp
 61a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 61b:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 61e:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 620:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 623:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 626:	8b 50 04             	mov    0x4(%eax),%edx
 629:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 62c:	39 ce                	cmp    %ecx,%esi
 62e:	75 df                	jne    60f <free+0x4f>
    p->s.size += bp->s.size;
 630:	03 51 04             	add    0x4(%ecx),%edx
 633:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 636:	8b 53 f8             	mov    -0x8(%ebx),%edx
 639:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 63b:	a3 84 07 00 00       	mov    %eax,0x784
}
 640:	5b                   	pop    %ebx
 641:	5e                   	pop    %esi
 642:	5f                   	pop    %edi
 643:	5d                   	pop    %ebp
 644:	c3                   	ret    
 645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
 656:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 659:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 65c:	8b 0d 84 07 00 00    	mov    0x784,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 662:	83 c3 07             	add    $0x7,%ebx
 665:	c1 eb 03             	shr    $0x3,%ebx
 668:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 66b:	85 c9                	test   %ecx,%ecx
 66d:	0f 84 93 00 00 00    	je     706 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 673:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 675:	8b 50 04             	mov    0x4(%eax),%edx
 678:	39 d3                	cmp    %edx,%ebx
 67a:	76 1f                	jbe    69b <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 67c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 683:	90                   	nop
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 688:	3b 05 84 07 00 00    	cmp    0x784,%eax
 68e:	74 30                	je     6c0 <malloc+0x70>
 690:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 692:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 694:	8b 50 04             	mov    0x4(%eax),%edx
 697:	39 d3                	cmp    %edx,%ebx
 699:	77 ed                	ja     688 <malloc+0x38>
      if(p->s.size == nunits)
 69b:	39 d3                	cmp    %edx,%ebx
 69d:	74 61                	je     700 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 69f:	29 da                	sub    %ebx,%edx
 6a1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 6a4:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 6a7:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6aa:	89 0d 84 07 00 00    	mov    %ecx,0x784
      return (void*) (p + 1);
 6b0:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6b3:	83 c4 1c             	add    $0x1c,%esp
 6b6:	5b                   	pop    %ebx
 6b7:	5e                   	pop    %esi
 6b8:	5f                   	pop    %edi
 6b9:	5d                   	pop    %ebp
 6ba:	c3                   	ret    
 6bb:	90                   	nop
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 6c0:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 6c6:	b8 00 80 00 00       	mov    $0x8000,%eax
 6cb:	bf 00 10 00 00       	mov    $0x1000,%edi
 6d0:	76 04                	jbe    6d6 <malloc+0x86>
 6d2:	89 f0                	mov    %esi,%eax
 6d4:	89 df                	mov    %ebx,%edi
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 6d6:	89 04 24             	mov    %eax,(%esp)
 6d9:	e8 62 fc ff ff       	call   340 <sbrk>
  if(p == (char*) -1)
 6de:	83 f8 ff             	cmp    $0xffffffff,%eax
 6e1:	74 18                	je     6fb <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6e3:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6e6:	83 c0 08             	add    $0x8,%eax
 6e9:	89 04 24             	mov    %eax,(%esp)
 6ec:	e8 cf fe ff ff       	call   5c0 <free>
  return freep;
 6f1:	8b 0d 84 07 00 00    	mov    0x784,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6f7:	85 c9                	test   %ecx,%ecx
 6f9:	75 97                	jne    692 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6fb:	31 c0                	xor    %eax,%eax
 6fd:	eb b4                	jmp    6b3 <malloc+0x63>
 6ff:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 700:	8b 10                	mov    (%eax),%edx
 702:	89 11                	mov    %edx,(%ecx)
 704:	eb a4                	jmp    6aa <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 706:	c7 05 84 07 00 00 7c 	movl   $0x77c,0x784
 70d:	07 00 00 
    base.s.size = 0;
 710:	b9 7c 07 00 00       	mov    $0x77c,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 715:	c7 05 7c 07 00 00 7c 	movl   $0x77c,0x77c
 71c:	07 00 00 
    base.s.size = 0;
 71f:	c7 05 80 07 00 00 00 	movl   $0x0,0x780
 726:	00 00 00 
 729:	e9 45 ff ff ff       	jmp    673 <malloc+0x23>
