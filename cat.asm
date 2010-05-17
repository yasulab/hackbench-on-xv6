
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
   7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   a:	eb 1c                	jmp    28 <cat+0x28>
   c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    write(1, buf, n);
  10:	89 44 24 08          	mov    %eax,0x8(%esp)
  14:	c7 44 24 04 20 08 00 	movl   $0x820,0x4(%esp)
  1b:	00 
  1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  23:	e8 40 03 00 00       	call   368 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  28:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2f:	00 
  30:	c7 44 24 04 20 08 00 	movl   $0x820,0x4(%esp)
  37:	00 
  38:	89 1c 24             	mov    %ebx,(%esp)
  3b:	e8 20 03 00 00       	call   360 <read>
  40:	83 f8 00             	cmp    $0x0,%eax
  43:	7f cb                	jg     10 <cat+0x10>
    write(1, buf, n);
  if(n < 0){
  45:	75 0a                	jne    51 <cat+0x51>
    printf(1, "cat: read error\n");
    exit();
  }
}
  47:	83 c4 14             	add    $0x14,%esp
  4a:	5b                   	pop    %ebx
  4b:	5d                   	pop    %ebp
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  50:	c3                   	ret    
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
    write(1, buf, n);
  if(n < 0){
    printf(1, "cat: read error\n");
  51:	c7 44 24 04 be 07 00 	movl   $0x7be,0x4(%esp)
  58:	00 
  59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  60:	e8 4b 04 00 00       	call   4b0 <printf>
    exit();
  65:	e8 de 02 00 00       	call   348 <exit>
  6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000070 <main>:
  }
}

int
main(int argc, char *argv[])
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	83 e4 f0             	and    $0xfffffff0,%esp
  76:	57                   	push   %edi
  77:	56                   	push   %esi
  78:	53                   	push   %ebx
  79:	83 ec 24             	sub    $0x24,%esp
  7c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int fd, i;

  if(argc <= 1){
  7f:	83 ff 01             	cmp    $0x1,%edi
  82:	7e 6c                	jle    f0 <main+0x80>
    cat(0);
    exit();
  84:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  87:	be 01 00 00 00       	mov    $0x1,%esi
  8c:	83 c3 04             	add    $0x4,%ebx
  8f:	90                   	nop
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  90:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  97:	00 
  98:	8b 03                	mov    (%ebx),%eax
  9a:	89 04 24             	mov    %eax,(%esp)
  9d:	e8 e6 02 00 00       	call   388 <open>
  a2:	85 c0                	test   %eax,%eax
  a4:	78 2a                	js     d0 <main+0x60>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  a6:	89 04 24             	mov    %eax,(%esp)
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  a9:	83 c6 01             	add    $0x1,%esi
  ac:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  af:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  b3:	e8 48 ff ff ff       	call   0 <cat>
    close(fd);
  b8:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  bc:	89 04 24             	mov    %eax,(%esp)
  bf:	e8 ac 02 00 00       	call   370 <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  c4:	39 f7                	cmp    %esi,%edi
  c6:	7f c8                	jg     90 <main+0x20>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  c8:	e8 7b 02 00 00       	call   348 <exit>
  cd:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  d0:	8b 03                	mov    (%ebx),%eax
  d2:	c7 44 24 04 cf 07 00 	movl   $0x7cf,0x4(%esp)
  d9:	00 
  da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e1:	89 44 24 08          	mov    %eax,0x8(%esp)
  e5:	e8 c6 03 00 00       	call   4b0 <printf>
      exit();
  ea:	e8 59 02 00 00       	call   348 <exit>
  ef:	90                   	nop
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  f7:	e8 04 ff ff ff       	call   0 <cat>
    exit();
  fc:	e8 47 02 00 00       	call   348 <exit>
 101:	90                   	nop
 102:	90                   	nop
 103:	90                   	nop
 104:	90                   	nop
 105:	90                   	nop
 106:	90                   	nop
 107:	90                   	nop
 108:	90                   	nop
 109:	90                   	nop
 10a:	90                   	nop
 10b:	90                   	nop
 10c:	90                   	nop
 10d:	90                   	nop
 10e:	90                   	nop
 10f:	90                   	nop

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
 3e8:	90                   	nop
 3e9:	90                   	nop
 3ea:	90                   	nop
 3eb:	90                   	nop
 3ec:	90                   	nop
 3ed:	90                   	nop
 3ee:	90                   	nop
 3ef:	90                   	nop

000003f0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	83 ec 28             	sub    $0x28,%esp
 3f6:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 3f9:	8d 55 f4             	lea    -0xc(%ebp),%edx
 3fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 403:	00 
 404:	89 54 24 04          	mov    %edx,0x4(%esp)
 408:	89 04 24             	mov    %eax,(%esp)
 40b:	e8 58 ff ff ff       	call   368 <write>
}
 410:	c9                   	leave  
 411:	c3                   	ret    
 412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	89 c7                	mov    %eax,%edi
 426:	56                   	push   %esi
 427:	89 ce                	mov    %ecx,%esi
 429:	53                   	push   %ebx
 42a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 430:	85 c9                	test   %ecx,%ecx
 432:	74 04                	je     438 <printint+0x18>
 434:	85 d2                	test   %edx,%edx
 436:	78 5d                	js     495 <printint+0x75>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 438:	89 d0                	mov    %edx,%eax
 43a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 441:	31 c9                	xor    %ecx,%ecx
 443:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 446:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 448:	31 d2                	xor    %edx,%edx
 44a:	f7 f6                	div    %esi
 44c:	0f b6 92 eb 07 00 00 	movzbl 0x7eb(%edx),%edx
 453:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 456:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 459:	85 c0                	test   %eax,%eax
 45b:	75 eb                	jne    448 <printint+0x28>
  if(neg)
 45d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 460:	85 c0                	test   %eax,%eax
 462:	74 08                	je     46c <printint+0x4c>
    buf[i++] = '-';
 464:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 469:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 46c:	8d 71 ff             	lea    -0x1(%ecx),%esi
 46f:	01 f3                	add    %esi,%ebx
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 478:	0f be 13             	movsbl (%ebx),%edx
 47b:	89 f8                	mov    %edi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 47d:	83 ee 01             	sub    $0x1,%esi
 480:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
 483:	e8 68 ff ff ff       	call   3f0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 488:	83 fe ff             	cmp    $0xffffffff,%esi
 48b:	75 eb                	jne    478 <printint+0x58>
    putc(fd, buf[i]);
}
 48d:	83 c4 2c             	add    $0x2c,%esp
 490:	5b                   	pop    %ebx
 491:	5e                   	pop    %esi
 492:	5f                   	pop    %edi
 493:	5d                   	pop    %ebp
 494:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 495:	89 d0                	mov    %edx,%eax
 497:	f7 d8                	neg    %eax
 499:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 4a0:	eb 9f                	jmp    441 <printint+0x21>
 4a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4b9:	8b 45 0c             	mov    0xc(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4bf:	0f b6 08             	movzbl (%eax),%ecx
 4c2:	84 c9                	test   %cl,%cl
 4c4:	0f 84 96 00 00 00    	je     560 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4ca:	8d 55 10             	lea    0x10(%ebp),%edx
 4cd:	31 f6                	xor    %esi,%esi
 4cf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 4d2:	31 db                	xor    %ebx,%ebx
 4d4:	eb 1a                	jmp    4f0 <printf+0x40>
 4d6:	66 90                	xchg   %ax,%ax
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4d8:	83 f9 25             	cmp    $0x25,%ecx
 4db:	0f 85 87 00 00 00    	jne    568 <printf+0xb8>
 4e1:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e5:	83 c3 01             	add    $0x1,%ebx
 4e8:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 4ec:	84 c9                	test   %cl,%cl
 4ee:	74 70                	je     560 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 4f0:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4f2:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 4f5:	74 e1                	je     4d8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4f7:	83 fe 25             	cmp    $0x25,%esi
 4fa:	75 e9                	jne    4e5 <printf+0x35>
      if(c == 'd'){
 4fc:	83 f9 64             	cmp    $0x64,%ecx
 4ff:	90                   	nop
 500:	0f 84 fa 00 00 00    	je     600 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 506:	83 f9 70             	cmp    $0x70,%ecx
 509:	74 75                	je     580 <printf+0xd0>
 50b:	83 f9 78             	cmp    $0x78,%ecx
 50e:	66 90                	xchg   %ax,%ax
 510:	74 6e                	je     580 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 512:	83 f9 73             	cmp    $0x73,%ecx
 515:	0f 84 8d 00 00 00    	je     5a8 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 51b:	83 f9 63             	cmp    $0x63,%ecx
 51e:	66 90                	xchg   %ax,%ax
 520:	0f 84 fe 00 00 00    	je     624 <printf+0x174>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 526:	83 f9 25             	cmp    $0x25,%ecx
 529:	0f 84 b9 00 00 00    	je     5e8 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 52f:	ba 25 00 00 00       	mov    $0x25,%edx
 534:	89 f8                	mov    %edi,%eax
 536:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 539:	83 c3 01             	add    $0x1,%ebx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 53c:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 53e:	e8 ad fe ff ff       	call   3f0 <putc>
        putc(fd, c);
 543:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 546:	89 f8                	mov    %edi,%eax
 548:	0f be d1             	movsbl %cl,%edx
 54b:	e8 a0 fe ff ff       	call   3f0 <putc>
 550:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 553:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 557:	84 c9                	test   %cl,%cl
 559:	75 95                	jne    4f0 <printf+0x40>
 55b:	90                   	nop
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 560:	83 c4 2c             	add    $0x2c,%esp
 563:	5b                   	pop    %ebx
 564:	5e                   	pop    %esi
 565:	5f                   	pop    %edi
 566:	5d                   	pop    %ebp
 567:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 568:	89 f8                	mov    %edi,%eax
 56a:	0f be d1             	movsbl %cl,%edx
 56d:	e8 7e fe ff ff       	call   3f0 <putc>
 572:	8b 45 0c             	mov    0xc(%ebp),%eax
 575:	e9 6b ff ff ff       	jmp    4e5 <printf+0x35>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 583:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 588:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 58a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 591:	8b 10                	mov    (%eax),%edx
 593:	89 f8                	mov    %edi,%eax
 595:	e8 86 fe ff ff       	call   420 <printint>
 59a:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 59d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 5a1:	e9 3f ff ff ff       	jmp    4e5 <printf+0x35>
 5a6:	66 90                	xchg   %ax,%ax
      } else if(c == 's'){
        s = (char*)*ap;
 5a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 5ab:	8b 32                	mov    (%edx),%esi
        ap++;
 5ad:	83 c2 04             	add    $0x4,%edx
 5b0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        if(s == 0)
 5b3:	85 f6                	test   %esi,%esi
 5b5:	0f 84 84 00 00 00    	je     63f <printf+0x18f>
          s = "(null)";
        while(*s != 0){
 5bb:	0f b6 16             	movzbl (%esi),%edx
 5be:	84 d2                	test   %dl,%dl
 5c0:	74 1d                	je     5df <printf+0x12f>
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 5c8:	0f be d2             	movsbl %dl,%edx
          s++;
 5cb:	83 c6 01             	add    $0x1,%esi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 5ce:	89 f8                	mov    %edi,%eax
 5d0:	e8 1b fe ff ff       	call   3f0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5d5:	0f b6 16             	movzbl (%esi),%edx
 5d8:	84 d2                	test   %dl,%dl
 5da:	75 ec                	jne    5c8 <printf+0x118>
 5dc:	8b 45 0c             	mov    0xc(%ebp),%eax
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5df:	31 f6                	xor    %esi,%esi
 5e1:	e9 ff fe ff ff       	jmp    4e5 <printf+0x35>
 5e6:	66 90                	xchg   %ax,%ax
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 5e8:	89 f8                	mov    %edi,%eax
 5ea:	ba 25 00 00 00       	mov    $0x25,%edx
 5ef:	e8 fc fd ff ff       	call   3f0 <putc>
 5f4:	31 f6                	xor    %esi,%esi
 5f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f9:	e9 e7 fe ff ff       	jmp    4e5 <printf+0x35>
 5fe:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 600:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 603:	b1 0a                	mov    $0xa,%cl
        ap++;
 605:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 608:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 60f:	8b 10                	mov    (%eax),%edx
 611:	89 f8                	mov    %edi,%eax
 613:	e8 08 fe ff ff       	call   420 <printint>
 618:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 61b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 61f:	e9 c1 fe ff ff       	jmp    4e5 <printf+0x35>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 624:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        ap++;
 627:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 629:	0f be 10             	movsbl (%eax),%edx
 62c:	89 f8                	mov    %edi,%eax
 62e:	e8 bd fd ff ff       	call   3f0 <putc>
 633:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 636:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 63a:	e9 a6 fe ff ff       	jmp    4e5 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 63f:	be e4 07 00 00       	mov    $0x7e4,%esi
 644:	e9 72 ff ff ff       	jmp    5bb <printf+0x10b>
 649:	90                   	nop
 64a:	90                   	nop
 64b:	90                   	nop
 64c:	90                   	nop
 64d:	90                   	nop
 64e:	90                   	nop
 64f:	90                   	nop

00000650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 650:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	a1 08 08 00 00       	mov    0x808,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 656:	89 e5                	mov    %esp,%ebp
 658:	57                   	push   %edi
 659:	56                   	push   %esi
 65a:	53                   	push   %ebx
 65b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 65e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	39 c8                	cmp    %ecx,%eax
 663:	73 1d                	jae    682 <free+0x32>
 665:	8d 76 00             	lea    0x0(%esi),%esi
 668:	8b 10                	mov    (%eax),%edx
 66a:	39 d1                	cmp    %edx,%ecx
 66c:	72 1a                	jb     688 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66e:	39 d0                	cmp    %edx,%eax
 670:	72 08                	jb     67a <free+0x2a>
 672:	39 c8                	cmp    %ecx,%eax
 674:	72 12                	jb     688 <free+0x38>
 676:	39 d1                	cmp    %edx,%ecx
 678:	72 0e                	jb     688 <free+0x38>
 67a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67c:	39 c8                	cmp    %ecx,%eax
 67e:	66 90                	xchg   %ax,%ax
 680:	72 e6                	jb     668 <free+0x18>
 682:	8b 10                	mov    (%eax),%edx
 684:	eb e8                	jmp    66e <free+0x1e>
 686:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 688:	8b 71 04             	mov    0x4(%ecx),%esi
 68b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 68e:	39 d7                	cmp    %edx,%edi
 690:	74 19                	je     6ab <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 692:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 695:	8b 50 04             	mov    0x4(%eax),%edx
 698:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 69b:	39 ce                	cmp    %ecx,%esi
 69d:	74 21                	je     6c0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 69f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6a1:	a3 08 08 00 00       	mov    %eax,0x808
}
 6a6:	5b                   	pop    %ebx
 6a7:	5e                   	pop    %esi
 6a8:	5f                   	pop    %edi
 6a9:	5d                   	pop    %ebp
 6aa:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6ab:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 6ae:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6b0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6b6:	8b 50 04             	mov    0x4(%eax),%edx
 6b9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6bc:	39 ce                	cmp    %ecx,%esi
 6be:	75 df                	jne    69f <free+0x4f>
    p->s.size += bp->s.size;
 6c0:	03 51 04             	add    0x4(%ecx),%edx
 6c3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c6:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6c9:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 6cb:	a3 08 08 00 00       	mov    %eax,0x808
}
 6d0:	5b                   	pop    %ebx
 6d1:	5e                   	pop    %esi
 6d2:	5f                   	pop    %edi
 6d3:	5d                   	pop    %ebp
 6d4:	c3                   	ret    
 6d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 6ec:	8b 0d 08 08 00 00    	mov    0x808,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	83 c3 07             	add    $0x7,%ebx
 6f5:	c1 eb 03             	shr    $0x3,%ebx
 6f8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 6fb:	85 c9                	test   %ecx,%ecx
 6fd:	0f 84 93 00 00 00    	je     796 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 703:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	39 d3                	cmp    %edx,%ebx
 70a:	76 1f                	jbe    72b <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 70c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 713:	90                   	nop
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 718:	3b 05 08 08 00 00    	cmp    0x808,%eax
 71e:	74 30                	je     750 <malloc+0x70>
 720:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 722:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 724:	8b 50 04             	mov    0x4(%eax),%edx
 727:	39 d3                	cmp    %edx,%ebx
 729:	77 ed                	ja     718 <malloc+0x38>
      if(p->s.size == nunits)
 72b:	39 d3                	cmp    %edx,%ebx
 72d:	74 61                	je     790 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 72f:	29 da                	sub    %ebx,%edx
 731:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 734:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 737:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 73a:	89 0d 08 08 00 00    	mov    %ecx,0x808
      return (void*) (p + 1);
 740:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 743:	83 c4 1c             	add    $0x1c,%esp
 746:	5b                   	pop    %ebx
 747:	5e                   	pop    %esi
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    
 74b:	90                   	nop
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 750:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 756:	b8 00 80 00 00       	mov    $0x8000,%eax
 75b:	bf 00 10 00 00       	mov    $0x1000,%edi
 760:	76 04                	jbe    766 <malloc+0x86>
 762:	89 f0                	mov    %esi,%eax
 764:	89 df                	mov    %ebx,%edi
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 766:	89 04 24             	mov    %eax,(%esp)
 769:	e8 62 fc ff ff       	call   3d0 <sbrk>
  if(p == (char*) -1)
 76e:	83 f8 ff             	cmp    $0xffffffff,%eax
 771:	74 18                	je     78b <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 773:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 776:	83 c0 08             	add    $0x8,%eax
 779:	89 04 24             	mov    %eax,(%esp)
 77c:	e8 cf fe ff ff       	call   650 <free>
  return freep;
 781:	8b 0d 08 08 00 00    	mov    0x808,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 787:	85 c9                	test   %ecx,%ecx
 789:	75 97                	jne    722 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 78b:	31 c0                	xor    %eax,%eax
 78d:	eb b4                	jmp    743 <malloc+0x63>
 78f:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 790:	8b 10                	mov    (%eax),%edx
 792:	89 11                	mov    %edx,(%ecx)
 794:	eb a4                	jmp    73a <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 796:	c7 05 08 08 00 00 00 	movl   $0x800,0x808
 79d:	08 00 00 
    base.s.size = 0;
 7a0:	b9 00 08 00 00       	mov    $0x800,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7a5:	c7 05 00 08 00 00 00 	movl   $0x800,0x800
 7ac:	08 00 00 
    base.s.size = 0;
 7af:	c7 05 04 08 00 00 00 	movl   $0x0,0x804
 7b6:	00 00 00 
 7b9:	e9 45 ff ff ff       	jmp    703 <malloc+0x23>
