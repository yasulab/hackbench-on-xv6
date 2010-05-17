
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
  14:	c7 44 24 04 40 08 00 	movl   $0x840,0x4(%esp)
  1b:	00 
  1c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  23:	e8 50 03 00 00       	call   378 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  28:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  2f:	00 
  30:	c7 44 24 04 40 08 00 	movl   $0x840,0x4(%esp)
  37:	00 
  38:	89 1c 24             	mov    %ebx,(%esp)
  3b:	e8 30 03 00 00       	call   370 <read>
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
  65:	e8 ee 02 00 00       	call   358 <exit>
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
  printf(0, "hoge\n\n");
  7f:	c7 44 24 04 cf 07 00 	movl   $0x7cf,0x4(%esp)
  86:	00 
  87:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8e:	e8 1d 04 00 00       	call   4b0 <printf>

  if(argc <= 1){
  93:	83 ff 01             	cmp    $0x1,%edi
  96:	7e 70                	jle    108 <main+0x98>
    cat(0);
    exit();
  98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  9b:	be 01 00 00 00       	mov    $0x1,%esi
  a0:	83 c3 04             	add    $0x4,%ebx
  a3:	90                   	nop
  a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  a8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  af:	00 
  b0:	8b 03                	mov    (%ebx),%eax
  b2:	89 04 24             	mov    %eax,(%esp)
  b5:	e8 de 02 00 00       	call   398 <open>
  ba:	85 c0                	test   %eax,%eax
  bc:	78 2a                	js     e8 <main+0x78>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  be:	89 04 24             	mov    %eax,(%esp)
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  c1:	83 c6 01             	add    $0x1,%esi
  c4:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  c7:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  cb:	e8 30 ff ff ff       	call   0 <cat>
    close(fd);
  d0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  d4:	89 04 24             	mov    %eax,(%esp)
  d7:	e8 a4 02 00 00       	call   380 <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  dc:	39 f7                	cmp    %esi,%edi
  de:	7f c8                	jg     a8 <main+0x38>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  e0:	e8 73 02 00 00       	call   358 <exit>
  e5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  e8:	8b 03                	mov    (%ebx),%eax
  ea:	c7 44 24 04 d6 07 00 	movl   $0x7d6,0x4(%esp)
  f1:	00 
  f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f9:	89 44 24 08          	mov    %eax,0x8(%esp)
  fd:	e8 ae 03 00 00       	call   4b0 <printf>
      exit();
 102:	e8 51 02 00 00       	call   358 <exit>
 107:	90                   	nop
{
  int fd, i;
  printf(0, "hoge\n\n");

  if(argc <= 1){
    cat(0);
 108:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 10f:	e8 ec fe ff ff       	call   0 <cat>
    exit();
 114:	e8 3f 02 00 00       	call   358 <exit>
 119:	90                   	nop
 11a:	90                   	nop
 11b:	90                   	nop
 11c:	90                   	nop
 11d:	90                   	nop
 11e:	90                   	nop
 11f:	90                   	nop

00000120 <strcpy>:
 120:	55                   	push   %ebp
 121:	31 d2                	xor    %edx,%edx
 123:	89 e5                	mov    %esp,%ebp
 125:	8b 45 08             	mov    0x8(%ebp),%eax
 128:	53                   	push   %ebx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 134:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 137:	83 c2 01             	add    $0x1,%edx
 13a:	84 c9                	test   %cl,%cl
 13c:	75 f2                	jne    130 <strcpy+0x10>
 13e:	5b                   	pop    %ebx
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	eb 0d                	jmp    150 <strcmp>
 143:	90                   	nop
 144:	90                   	nop
 145:	90                   	nop
 146:	90                   	nop
 147:	90                   	nop
 148:	90                   	nop
 149:	90                   	nop
 14a:	90                   	nop
 14b:	90                   	nop
 14c:	90                   	nop
 14d:	90                   	nop
 14e:	90                   	nop
 14f:	90                   	nop

00000150 <strcmp>:
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 4d 08             	mov    0x8(%ebp),%ecx
 157:	8b 55 0c             	mov    0xc(%ebp),%edx
 15a:	0f b6 01             	movzbl (%ecx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 14                	jne    175 <strcmp+0x25>
 161:	eb 25                	jmp    188 <strcmp+0x38>
 163:	90                   	nop
 164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 168:	83 c1 01             	add    $0x1,%ecx
 16b:	83 c2 01             	add    $0x1,%edx
 16e:	0f b6 01             	movzbl (%ecx),%eax
 171:	84 c0                	test   %al,%al
 173:	74 13                	je     188 <strcmp+0x38>
 175:	0f b6 1a             	movzbl (%edx),%ebx
 178:	38 d8                	cmp    %bl,%al
 17a:	74 ec                	je     168 <strcmp+0x18>
 17c:	0f b6 db             	movzbl %bl,%ebx
 17f:	0f b6 c0             	movzbl %al,%eax
 182:	29 d8                	sub    %ebx,%eax
 184:	5b                   	pop    %ebx
 185:	5d                   	pop    %ebp
 186:	c3                   	ret    
 187:	90                   	nop
 188:	0f b6 1a             	movzbl (%edx),%ebx
 18b:	31 c0                	xor    %eax,%eax
 18d:	0f b6 db             	movzbl %bl,%ebx
 190:	29 d8                	sub    %ebx,%eax
 192:	5b                   	pop    %ebx
 193:	5d                   	pop    %ebp
 194:	c3                   	ret    
 195:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001a0 <strlen>:
 1a0:	55                   	push   %ebp
 1a1:	31 d2                	xor    %edx,%edx
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	31 c0                	xor    %eax,%eax
 1a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1aa:	80 39 00             	cmpb   $0x0,(%ecx)
 1ad:	74 0c                	je     1bb <strlen+0x1b>
 1af:	90                   	nop
 1b0:	83 c2 01             	add    $0x1,%edx
 1b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1b7:	89 d0                	mov    %edx,%eax
 1b9:	75 f5                	jne    1b0 <strlen+0x10>
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret    
 1bd:	8d 76 00             	lea    0x0(%esi),%esi

000001c0 <memset>:
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1c6:	53                   	push   %ebx
 1c7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ca:	85 c9                	test   %ecx,%ecx
 1cc:	74 14                	je     1e2 <memset+0x22>
 1ce:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 1d2:	31 d2                	xor    %edx,%edx
 1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d8:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 1db:	83 c2 01             	add    $0x1,%edx
 1de:	39 ca                	cmp    %ecx,%edx
 1e0:	75 f6                	jne    1d8 <memset+0x18>
 1e2:	5b                   	pop    %ebx
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <strchr>:
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 11                	jne    212 <strchr+0x22>
 201:	eb 15                	jmp    218 <strchr+0x28>
 203:	90                   	nop
 204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 208:	83 c0 01             	add    $0x1,%eax
 20b:	0f b6 10             	movzbl (%eax),%edx
 20e:	84 d2                	test   %dl,%dl
 210:	74 06                	je     218 <strchr+0x28>
 212:	38 ca                	cmp    %cl,%dl
 214:	75 f2                	jne    208 <strchr+0x18>
 216:	5d                   	pop    %ebp
 217:	c3                   	ret    
 218:	31 c0                	xor    %eax,%eax
 21a:	5d                   	pop    %ebp
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 220:	c3                   	ret    
 221:	eb 0d                	jmp    230 <atoi>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <atoi>:
 230:	55                   	push   %ebp
 231:	31 c0                	xor    %eax,%eax
 233:	89 e5                	mov    %esp,%ebp
 235:	8b 4d 08             	mov    0x8(%ebp),%ecx
 238:	53                   	push   %ebx
 239:	0f b6 11             	movzbl (%ecx),%edx
 23c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 23f:	80 fb 09             	cmp    $0x9,%bl
 242:	77 1c                	ja     260 <atoi+0x30>
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 248:	0f be d2             	movsbl %dl,%edx
 24b:	83 c1 01             	add    $0x1,%ecx
 24e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 251:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 255:	0f b6 11             	movzbl (%ecx),%edx
 258:	8d 5a d0             	lea    -0x30(%edx),%ebx
 25b:	80 fb 09             	cmp    $0x9,%bl
 25e:	76 e8                	jbe    248 <atoi+0x18>
 260:	5b                   	pop    %ebx
 261:	5d                   	pop    %ebp
 262:	c3                   	ret    
 263:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <memmove>:
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	56                   	push   %esi
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	53                   	push   %ebx
 278:	8b 5d 10             	mov    0x10(%ebp),%ebx
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
 27e:	85 db                	test   %ebx,%ebx
 280:	7e 14                	jle    296 <memmove+0x26>
 282:	31 d2                	xor    %edx,%edx
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 288:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 28c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28f:	83 c2 01             	add    $0x1,%edx
 292:	39 da                	cmp    %ebx,%edx
 294:	75 f2                	jne    288 <memmove+0x18>
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002a0 <stat>:
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	83 ec 18             	sub    $0x18,%esp
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
 2a9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
 2af:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2bb:	00 
 2bc:	89 04 24             	mov    %eax,(%esp)
 2bf:	e8 d4 00 00 00       	call   398 <open>
 2c4:	85 c0                	test   %eax,%eax
 2c6:	89 c3                	mov    %eax,%ebx
 2c8:	78 19                	js     2e3 <stat+0x43>
 2ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cd:	89 1c 24             	mov    %ebx,(%esp)
 2d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d4:	e8 d7 00 00 00       	call   3b0 <fstat>
 2d9:	89 1c 24             	mov    %ebx,(%esp)
 2dc:	89 c6                	mov    %eax,%esi
 2de:	e8 9d 00 00 00       	call   380 <close>
 2e3:	89 f0                	mov    %esi,%eax
 2e5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2e8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2eb:	89 ec                	mov    %ebp,%esp
 2ed:	5d                   	pop    %ebp
 2ee:	c3                   	ret    
 2ef:	90                   	nop

000002f0 <gets>:
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	56                   	push   %esi
 2f5:	31 f6                	xor    %esi,%esi
 2f7:	53                   	push   %ebx
 2f8:	83 ec 2c             	sub    $0x2c,%esp
 2fb:	8b 7d 08             	mov    0x8(%ebp),%edi
 2fe:	eb 06                	jmp    306 <gets+0x16>
 300:	3c 0a                	cmp    $0xa,%al
 302:	74 39                	je     33d <gets+0x4d>
 304:	89 de                	mov    %ebx,%esi
 306:	8d 5e 01             	lea    0x1(%esi),%ebx
 309:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 30c:	7d 31                	jge    33f <gets+0x4f>
 30e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 311:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 318:	00 
 319:	89 44 24 04          	mov    %eax,0x4(%esp)
 31d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 324:	e8 47 00 00 00       	call   370 <read>
 329:	85 c0                	test   %eax,%eax
 32b:	7e 12                	jle    33f <gets+0x4f>
 32d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 331:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
 335:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 339:	3c 0d                	cmp    $0xd,%al
 33b:	75 c3                	jne    300 <gets+0x10>
 33d:	89 de                	mov    %ebx,%esi
 33f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
 343:	89 f8                	mov    %edi,%eax
 345:	83 c4 2c             	add    $0x2c,%esp
 348:	5b                   	pop    %ebx
 349:	5e                   	pop    %esi
 34a:	5f                   	pop    %edi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	90                   	nop
 34e:	90                   	nop
 34f:	90                   	nop

00000350 <fork>:
 350:	b8 01 00 00 00       	mov    $0x1,%eax
 355:	cd 30                	int    $0x30
 357:	c3                   	ret    

00000358 <exit>:
 358:	b8 02 00 00 00       	mov    $0x2,%eax
 35d:	cd 30                	int    $0x30
 35f:	c3                   	ret    

00000360 <wait>:
 360:	b8 03 00 00 00       	mov    $0x3,%eax
 365:	cd 30                	int    $0x30
 367:	c3                   	ret    

00000368 <pipe>:
 368:	b8 04 00 00 00       	mov    $0x4,%eax
 36d:	cd 30                	int    $0x30
 36f:	c3                   	ret    

00000370 <read>:
 370:	b8 06 00 00 00       	mov    $0x6,%eax
 375:	cd 30                	int    $0x30
 377:	c3                   	ret    

00000378 <write>:
 378:	b8 05 00 00 00       	mov    $0x5,%eax
 37d:	cd 30                	int    $0x30
 37f:	c3                   	ret    

00000380 <close>:
 380:	b8 07 00 00 00       	mov    $0x7,%eax
 385:	cd 30                	int    $0x30
 387:	c3                   	ret    

00000388 <kill>:
 388:	b8 08 00 00 00       	mov    $0x8,%eax
 38d:	cd 30                	int    $0x30
 38f:	c3                   	ret    

00000390 <exec>:
 390:	b8 09 00 00 00       	mov    $0x9,%eax
 395:	cd 30                	int    $0x30
 397:	c3                   	ret    

00000398 <open>:
 398:	b8 0a 00 00 00       	mov    $0xa,%eax
 39d:	cd 30                	int    $0x30
 39f:	c3                   	ret    

000003a0 <mknod>:
 3a0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a5:	cd 30                	int    $0x30
 3a7:	c3                   	ret    

000003a8 <unlink>:
 3a8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ad:	cd 30                	int    $0x30
 3af:	c3                   	ret    

000003b0 <fstat>:
 3b0:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b5:	cd 30                	int    $0x30
 3b7:	c3                   	ret    

000003b8 <link>:
 3b8:	b8 0e 00 00 00       	mov    $0xe,%eax
 3bd:	cd 30                	int    $0x30
 3bf:	c3                   	ret    

000003c0 <mkdir>:
 3c0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3c5:	cd 30                	int    $0x30
 3c7:	c3                   	ret    

000003c8 <chdir>:
 3c8:	b8 10 00 00 00       	mov    $0x10,%eax
 3cd:	cd 30                	int    $0x30
 3cf:	c3                   	ret    

000003d0 <dup>:
 3d0:	b8 11 00 00 00       	mov    $0x11,%eax
 3d5:	cd 30                	int    $0x30
 3d7:	c3                   	ret    

000003d8 <getpid>:
 3d8:	b8 12 00 00 00       	mov    $0x12,%eax
 3dd:	cd 30                	int    $0x30
 3df:	c3                   	ret    

000003e0 <sbrk>:
 3e0:	b8 13 00 00 00       	mov    $0x13,%eax
 3e5:	cd 30                	int    $0x30
 3e7:	c3                   	ret    

000003e8 <sleep>:
 3e8:	b8 14 00 00 00       	mov    $0x14,%eax
 3ed:	cd 30                	int    $0x30
 3ef:	c3                   	ret    

000003f0 <putc>:
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	83 ec 28             	sub    $0x28,%esp
 3f6:	88 55 f4             	mov    %dl,-0xc(%ebp)
 3f9:	8d 55 f4             	lea    -0xc(%ebp),%edx
 3fc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 403:	00 
 404:	89 54 24 04          	mov    %edx,0x4(%esp)
 408:	89 04 24             	mov    %eax,(%esp)
 40b:	e8 68 ff ff ff       	call   378 <write>
 410:	c9                   	leave  
 411:	c3                   	ret    
 412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000420 <printint>:
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	89 c7                	mov    %eax,%edi
 426:	56                   	push   %esi
 427:	89 ce                	mov    %ecx,%esi
 429:	53                   	push   %ebx
 42a:	83 ec 2c             	sub    $0x2c,%esp
 42d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 430:	85 c9                	test   %ecx,%ecx
 432:	74 04                	je     438 <printint+0x18>
 434:	85 d2                	test   %edx,%edx
 436:	78 5d                	js     495 <printint+0x75>
 438:	89 d0                	mov    %edx,%eax
 43a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 441:	31 c9                	xor    %ecx,%ecx
 443:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 446:	66 90                	xchg   %ax,%ax
 448:	31 d2                	xor    %edx,%edx
 44a:	f7 f6                	div    %esi
 44c:	0f b6 92 f2 07 00 00 	movzbl 0x7f2(%edx),%edx
 453:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 456:	83 c1 01             	add    $0x1,%ecx
 459:	85 c0                	test   %eax,%eax
 45b:	75 eb                	jne    448 <printint+0x28>
 45d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 460:	85 c0                	test   %eax,%eax
 462:	74 08                	je     46c <printint+0x4c>
 464:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 469:	83 c1 01             	add    $0x1,%ecx
 46c:	8d 71 ff             	lea    -0x1(%ecx),%esi
 46f:	01 f3                	add    %esi,%ebx
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 478:	0f be 13             	movsbl (%ebx),%edx
 47b:	89 f8                	mov    %edi,%eax
 47d:	83 ee 01             	sub    $0x1,%esi
 480:	83 eb 01             	sub    $0x1,%ebx
 483:	e8 68 ff ff ff       	call   3f0 <putc>
 488:	83 fe ff             	cmp    $0xffffffff,%esi
 48b:	75 eb                	jne    478 <printint+0x58>
 48d:	83 c4 2c             	add    $0x2c,%esp
 490:	5b                   	pop    %ebx
 491:	5e                   	pop    %esi
 492:	5f                   	pop    %edi
 493:	5d                   	pop    %ebp
 494:	c3                   	ret    
 495:	89 d0                	mov    %edx,%eax
 497:	f7 d8                	neg    %eax
 499:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 4a0:	eb 9f                	jmp    441 <printint+0x21>
 4a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <printf>:
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 2c             	sub    $0x2c,%esp
 4b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4bc:	8b 7d 08             	mov    0x8(%ebp),%edi
 4bf:	0f b6 08             	movzbl (%eax),%ecx
 4c2:	84 c9                	test   %cl,%cl
 4c4:	0f 84 96 00 00 00    	je     560 <printf+0xb0>
 4ca:	8d 55 10             	lea    0x10(%ebp),%edx
 4cd:	31 f6                	xor    %esi,%esi
 4cf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 4d2:	31 db                	xor    %ebx,%ebx
 4d4:	eb 1a                	jmp    4f0 <printf+0x40>
 4d6:	66 90                	xchg   %ax,%ax
 4d8:	83 f9 25             	cmp    $0x25,%ecx
 4db:	0f 85 87 00 00 00    	jne    568 <printf+0xb8>
 4e1:	66 be 25 00          	mov    $0x25,%si
 4e5:	83 c3 01             	add    $0x1,%ebx
 4e8:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 4ec:	84 c9                	test   %cl,%cl
 4ee:	74 70                	je     560 <printf+0xb0>
 4f0:	85 f6                	test   %esi,%esi
 4f2:	0f b6 c9             	movzbl %cl,%ecx
 4f5:	74 e1                	je     4d8 <printf+0x28>
 4f7:	83 fe 25             	cmp    $0x25,%esi
 4fa:	75 e9                	jne    4e5 <printf+0x35>
 4fc:	83 f9 64             	cmp    $0x64,%ecx
 4ff:	90                   	nop
 500:	0f 84 fa 00 00 00    	je     600 <printf+0x150>
 506:	83 f9 70             	cmp    $0x70,%ecx
 509:	74 75                	je     580 <printf+0xd0>
 50b:	83 f9 78             	cmp    $0x78,%ecx
 50e:	66 90                	xchg   %ax,%ax
 510:	74 6e                	je     580 <printf+0xd0>
 512:	83 f9 73             	cmp    $0x73,%ecx
 515:	0f 84 8d 00 00 00    	je     5a8 <printf+0xf8>
 51b:	83 f9 63             	cmp    $0x63,%ecx
 51e:	66 90                	xchg   %ax,%ax
 520:	0f 84 fe 00 00 00    	je     624 <printf+0x174>
 526:	83 f9 25             	cmp    $0x25,%ecx
 529:	0f 84 b9 00 00 00    	je     5e8 <printf+0x138>
 52f:	ba 25 00 00 00       	mov    $0x25,%edx
 534:	89 f8                	mov    %edi,%eax
 536:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 539:	83 c3 01             	add    $0x1,%ebx
 53c:	31 f6                	xor    %esi,%esi
 53e:	e8 ad fe ff ff       	call   3f0 <putc>
 543:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 546:	89 f8                	mov    %edi,%eax
 548:	0f be d1             	movsbl %cl,%edx
 54b:	e8 a0 fe ff ff       	call   3f0 <putc>
 550:	8b 45 0c             	mov    0xc(%ebp),%eax
 553:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 557:	84 c9                	test   %cl,%cl
 559:	75 95                	jne    4f0 <printf+0x40>
 55b:	90                   	nop
 55c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 560:	83 c4 2c             	add    $0x2c,%esp
 563:	5b                   	pop    %ebx
 564:	5e                   	pop    %esi
 565:	5f                   	pop    %edi
 566:	5d                   	pop    %ebp
 567:	c3                   	ret    
 568:	89 f8                	mov    %edi,%eax
 56a:	0f be d1             	movsbl %cl,%edx
 56d:	e8 7e fe ff ff       	call   3f0 <putc>
 572:	8b 45 0c             	mov    0xc(%ebp),%eax
 575:	e9 6b ff ff ff       	jmp    4e5 <printf+0x35>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 580:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 583:	b9 10 00 00 00       	mov    $0x10,%ecx
 588:	31 f6                	xor    %esi,%esi
 58a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 591:	8b 10                	mov    (%eax),%edx
 593:	89 f8                	mov    %edi,%eax
 595:	e8 86 fe ff ff       	call   420 <printint>
 59a:	8b 45 0c             	mov    0xc(%ebp),%eax
 59d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 5a1:	e9 3f ff ff ff       	jmp    4e5 <printf+0x35>
 5a6:	66 90                	xchg   %ax,%ax
 5a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 5ab:	8b 32                	mov    (%edx),%esi
 5ad:	83 c2 04             	add    $0x4,%edx
 5b0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 5b3:	85 f6                	test   %esi,%esi
 5b5:	0f 84 84 00 00 00    	je     63f <printf+0x18f>
 5bb:	0f b6 16             	movzbl (%esi),%edx
 5be:	84 d2                	test   %dl,%dl
 5c0:	74 1d                	je     5df <printf+0x12f>
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5c8:	0f be d2             	movsbl %dl,%edx
 5cb:	83 c6 01             	add    $0x1,%esi
 5ce:	89 f8                	mov    %edi,%eax
 5d0:	e8 1b fe ff ff       	call   3f0 <putc>
 5d5:	0f b6 16             	movzbl (%esi),%edx
 5d8:	84 d2                	test   %dl,%dl
 5da:	75 ec                	jne    5c8 <printf+0x118>
 5dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 5df:	31 f6                	xor    %esi,%esi
 5e1:	e9 ff fe ff ff       	jmp    4e5 <printf+0x35>
 5e6:	66 90                	xchg   %ax,%ax
 5e8:	89 f8                	mov    %edi,%eax
 5ea:	ba 25 00 00 00       	mov    $0x25,%edx
 5ef:	e8 fc fd ff ff       	call   3f0 <putc>
 5f4:	31 f6                	xor    %esi,%esi
 5f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f9:	e9 e7 fe ff ff       	jmp    4e5 <printf+0x35>
 5fe:	66 90                	xchg   %ax,%ax
 600:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 603:	b1 0a                	mov    $0xa,%cl
 605:	66 31 f6             	xor    %si,%si
 608:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 60f:	8b 10                	mov    (%eax),%edx
 611:	89 f8                	mov    %edi,%eax
 613:	e8 08 fe ff ff       	call   420 <printint>
 618:	8b 45 0c             	mov    0xc(%ebp),%eax
 61b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 61f:	e9 c1 fe ff ff       	jmp    4e5 <printf+0x35>
 624:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 627:	31 f6                	xor    %esi,%esi
 629:	0f be 10             	movsbl (%eax),%edx
 62c:	89 f8                	mov    %edi,%eax
 62e:	e8 bd fd ff ff       	call   3f0 <putc>
 633:	8b 45 0c             	mov    0xc(%ebp),%eax
 636:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 63a:	e9 a6 fe ff ff       	jmp    4e5 <printf+0x35>
 63f:	be eb 07 00 00       	mov    $0x7eb,%esi
 644:	e9 72 ff ff ff       	jmp    5bb <printf+0x10b>
 649:	90                   	nop
 64a:	90                   	nop
 64b:	90                   	nop
 64c:	90                   	nop
 64d:	90                   	nop
 64e:	90                   	nop
 64f:	90                   	nop

00000650 <free>:
 650:	55                   	push   %ebp
 651:	a1 28 08 00 00       	mov    0x828,%eax
 656:	89 e5                	mov    %esp,%ebp
 658:	57                   	push   %edi
 659:	56                   	push   %esi
 65a:	53                   	push   %ebx
 65b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 65e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 661:	39 c8                	cmp    %ecx,%eax
 663:	73 1d                	jae    682 <free+0x32>
 665:	8d 76 00             	lea    0x0(%esi),%esi
 668:	8b 10                	mov    (%eax),%edx
 66a:	39 d1                	cmp    %edx,%ecx
 66c:	72 1a                	jb     688 <free+0x38>
 66e:	39 d0                	cmp    %edx,%eax
 670:	72 08                	jb     67a <free+0x2a>
 672:	39 c8                	cmp    %ecx,%eax
 674:	72 12                	jb     688 <free+0x38>
 676:	39 d1                	cmp    %edx,%ecx
 678:	72 0e                	jb     688 <free+0x38>
 67a:	89 d0                	mov    %edx,%eax
 67c:	39 c8                	cmp    %ecx,%eax
 67e:	66 90                	xchg   %ax,%ax
 680:	72 e6                	jb     668 <free+0x18>
 682:	8b 10                	mov    (%eax),%edx
 684:	eb e8                	jmp    66e <free+0x1e>
 686:	66 90                	xchg   %ax,%ax
 688:	8b 71 04             	mov    0x4(%ecx),%esi
 68b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 68e:	39 d7                	cmp    %edx,%edi
 690:	74 19                	je     6ab <free+0x5b>
 692:	89 53 f8             	mov    %edx,-0x8(%ebx)
 695:	8b 50 04             	mov    0x4(%eax),%edx
 698:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 69b:	39 ce                	cmp    %ecx,%esi
 69d:	74 21                	je     6c0 <free+0x70>
 69f:	89 08                	mov    %ecx,(%eax)
 6a1:	a3 28 08 00 00       	mov    %eax,0x828
 6a6:	5b                   	pop    %ebx
 6a7:	5e                   	pop    %esi
 6a8:	5f                   	pop    %edi
 6a9:	5d                   	pop    %ebp
 6aa:	c3                   	ret    
 6ab:	03 72 04             	add    0x4(%edx),%esi
 6ae:	8b 12                	mov    (%edx),%edx
 6b0:	89 71 04             	mov    %esi,0x4(%ecx)
 6b3:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6b6:	8b 50 04             	mov    0x4(%eax),%edx
 6b9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6bc:	39 ce                	cmp    %ecx,%esi
 6be:	75 df                	jne    69f <free+0x4f>
 6c0:	03 51 04             	add    0x4(%ecx),%edx
 6c3:	89 50 04             	mov    %edx,0x4(%eax)
 6c6:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6c9:	89 10                	mov    %edx,(%eax)
 6cb:	a3 28 08 00 00       	mov    %eax,0x828
 6d0:	5b                   	pop    %ebx
 6d1:	5e                   	pop    %esi
 6d2:	5f                   	pop    %edi
 6d3:	5d                   	pop    %ebp
 6d4:	c3                   	ret    
 6d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006e0 <malloc>:
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 1c             	sub    $0x1c,%esp
 6e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6ec:	8b 0d 28 08 00 00    	mov    0x828,%ecx
 6f2:	83 c3 07             	add    $0x7,%ebx
 6f5:	c1 eb 03             	shr    $0x3,%ebx
 6f8:	83 c3 01             	add    $0x1,%ebx
 6fb:	85 c9                	test   %ecx,%ecx
 6fd:	0f 84 93 00 00 00    	je     796 <malloc+0xb6>
 703:	8b 01                	mov    (%ecx),%eax
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	39 d3                	cmp    %edx,%ebx
 70a:	76 1f                	jbe    72b <malloc+0x4b>
 70c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 713:	90                   	nop
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 718:	3b 05 28 08 00 00    	cmp    0x828,%eax
 71e:	74 30                	je     750 <malloc+0x70>
 720:	89 c1                	mov    %eax,%ecx
 722:	8b 01                	mov    (%ecx),%eax
 724:	8b 50 04             	mov    0x4(%eax),%edx
 727:	39 d3                	cmp    %edx,%ebx
 729:	77 ed                	ja     718 <malloc+0x38>
 72b:	39 d3                	cmp    %edx,%ebx
 72d:	74 61                	je     790 <malloc+0xb0>
 72f:	29 da                	sub    %ebx,%edx
 731:	89 50 04             	mov    %edx,0x4(%eax)
 734:	8d 04 d0             	lea    (%eax,%edx,8),%eax
 737:	89 58 04             	mov    %ebx,0x4(%eax)
 73a:	89 0d 28 08 00 00    	mov    %ecx,0x828
 740:	83 c0 08             	add    $0x8,%eax
 743:	83 c4 1c             	add    $0x1c,%esp
 746:	5b                   	pop    %ebx
 747:	5e                   	pop    %esi
 748:	5f                   	pop    %edi
 749:	5d                   	pop    %ebp
 74a:	c3                   	ret    
 74b:	90                   	nop
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 750:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 756:	b8 00 80 00 00       	mov    $0x8000,%eax
 75b:	bf 00 10 00 00       	mov    $0x1000,%edi
 760:	76 04                	jbe    766 <malloc+0x86>
 762:	89 f0                	mov    %esi,%eax
 764:	89 df                	mov    %ebx,%edi
 766:	89 04 24             	mov    %eax,(%esp)
 769:	e8 72 fc ff ff       	call   3e0 <sbrk>
 76e:	83 f8 ff             	cmp    $0xffffffff,%eax
 771:	74 18                	je     78b <malloc+0xab>
 773:	89 78 04             	mov    %edi,0x4(%eax)
 776:	83 c0 08             	add    $0x8,%eax
 779:	89 04 24             	mov    %eax,(%esp)
 77c:	e8 cf fe ff ff       	call   650 <free>
 781:	8b 0d 28 08 00 00    	mov    0x828,%ecx
 787:	85 c9                	test   %ecx,%ecx
 789:	75 97                	jne    722 <malloc+0x42>
 78b:	31 c0                	xor    %eax,%eax
 78d:	eb b4                	jmp    743 <malloc+0x63>
 78f:	90                   	nop
 790:	8b 10                	mov    (%eax),%edx
 792:	89 11                	mov    %edx,(%ecx)
 794:	eb a4                	jmp    73a <malloc+0x5a>
 796:	c7 05 28 08 00 00 20 	movl   $0x820,0x828
 79d:	08 00 00 
 7a0:	b9 20 08 00 00       	mov    $0x820,%ecx
 7a5:	c7 05 20 08 00 00 20 	movl   $0x820,0x820
 7ac:	08 00 00 
 7af:	c7 05 24 08 00 00 00 	movl   $0x0,0x824
 7b6:	00 00 00 
 7b9:	e9 45 ff ff ff       	jmp    703 <malloc+0x23>
