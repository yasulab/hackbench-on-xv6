
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
       6:	a1 08 44 00 00       	mov    0x4408,%eax
       b:	c7 44 24 04 90 31 00 	movl   $0x3190,0x4(%esp)
      12:	00 
      13:	89 04 24             	mov    %eax,(%esp)
      16:	e8 65 2e 00 00       	call   2e80 <printf>
  fd = open("echo", 0);
      1b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      22:	00 
      23:	c7 04 24 9b 31 00 00 	movl   $0x319b,(%esp)
      2a:	e8 29 2d 00 00       	call   2d58 <open>
  if(fd < 0){
      2f:	85 c0                	test   %eax,%eax
      31:	78 37                	js     6a <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
      33:	89 04 24             	mov    %eax,(%esp)
      36:	e8 05 2d 00 00       	call   2d40 <close>
  fd = open("doesnotexist", 0);
      3b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      42:	00 
      43:	c7 04 24 b3 31 00 00 	movl   $0x31b3,(%esp)
      4a:	e8 09 2d 00 00       	call   2d58 <open>
  if(fd >= 0){
      4f:	85 c0                	test   %eax,%eax
      51:	79 31                	jns    84 <opentest+0x84>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
      53:	a1 08 44 00 00       	mov    0x4408,%eax
      58:	c7 44 24 04 de 31 00 	movl   $0x31de,0x4(%esp)
      5f:	00 
      60:	89 04 24             	mov    %eax,(%esp)
      63:	e8 18 2e 00 00       	call   2e80 <printf>
}
      68:	c9                   	leave  
      69:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
      6a:	a1 08 44 00 00       	mov    0x4408,%eax
      6f:	c7 44 24 04 a0 31 00 	movl   $0x31a0,0x4(%esp)
      76:	00 
      77:	89 04 24             	mov    %eax,(%esp)
      7a:	e8 01 2e 00 00       	call   2e80 <printf>
    exit();
      7f:	e8 94 2c 00 00       	call   2d18 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
      84:	a1 08 44 00 00       	mov    0x4408,%eax
      89:	c7 44 24 04 c0 31 00 	movl   $0x31c0,0x4(%esp)
      90:	00 
      91:	89 04 24             	mov    %eax,(%esp)
      94:	e8 e7 2d 00 00       	call   2e80 <printf>
    exit();
      99:	e8 7a 2c 00 00       	call   2d18 <exit>
      9e:	66 90                	xchg   %ax,%ax

000000a0 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
      a0:	55                   	push   %ebp
      a1:	89 e5                	mov    %esp,%ebp
      a3:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");
      a4:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
      a6:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
      a9:	c7 44 24 04 ec 31 00 	movl   $0x31ec,0x4(%esp)
      b0:	00 
      b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      b8:	e8 c3 2d 00 00       	call   2e80 <printf>
      bd:	eb 13                	jmp    d2 <forktest+0x32>
      bf:	90                   	nop

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
      c0:	74 72                	je     134 <forktest+0x94>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
      c2:	83 c3 01             	add    $0x1,%ebx
      c5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
      cb:	90                   	nop
      cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      d0:	74 4e                	je     120 <forktest+0x80>
      d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pid = fork();
      d8:	e8 33 2c 00 00       	call   2d10 <fork>
    if(pid < 0)
      dd:	83 f8 00             	cmp    $0x0,%eax
      e0:	7d de                	jge    c0 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
      e2:	85 db                	test   %ebx,%ebx
      e4:	74 11                	je     f7 <forktest+0x57>
      e6:	66 90                	xchg   %ax,%ax
    if(wait() < 0){
      e8:	e8 33 2c 00 00       	call   2d20 <wait>
      ed:	85 c0                	test   %eax,%eax
      ef:	90                   	nop
      f0:	78 47                	js     139 <forktest+0x99>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
      f2:	83 eb 01             	sub    $0x1,%ebx
      f5:	75 f1                	jne    e8 <forktest+0x48>
      f7:	90                   	nop
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
      f8:	e8 23 2c 00 00       	call   2d20 <wait>
      fd:	83 f8 ff             	cmp    $0xffffffff,%eax
     100:	75 50                	jne    152 <forktest+0xb2>
    printf(1, "wait got too many\n");
    exit();
  }
  
  printf(1, "fork test OK\n");
     102:	c7 44 24 04 1e 32 00 	movl   $0x321e,0x4(%esp)
     109:	00 
     10a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     111:	e8 6a 2d 00 00       	call   2e80 <printf>
}
     116:	83 c4 14             	add    $0x14,%esp
     119:	5b                   	pop    %ebx
     11a:	5d                   	pop    %ebp
     11b:	c3                   	ret    
     11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
     120:	c7 44 24 04 78 3e 00 	movl   $0x3e78,0x4(%esp)
     127:	00 
     128:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     12f:	e8 4c 2d 00 00       	call   2e80 <printf>
    exit();
     134:	e8 df 2b 00 00       	call   2d18 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
     139:	c7 44 24 04 f7 31 00 	movl   $0x31f7,0x4(%esp)
     140:	00 
     141:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     148:	e8 33 2d 00 00       	call   2e80 <printf>
      exit();
     14d:	e8 c6 2b 00 00       	call   2d18 <exit>
    }
  }
  
  if(wait() != -1){
    printf(1, "wait got too many\n");
     152:	c7 44 24 04 0b 32 00 	movl   $0x320b,0x4(%esp)
     159:	00 
     15a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     161:	e8 1a 2d 00 00       	call   2e80 <printf>
    exit();
     166:	e8 ad 2b 00 00       	call   2d18 <exit>
     16b:	90                   	nop
     16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	56                   	push   %esi
     174:	31 f6                	xor    %esi,%esi
     176:	53                   	push   %ebx
     177:	83 ec 10             	sub    $0x10,%esp
     17a:	eb 17                	jmp    193 <exitwait+0x23>
     17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     180:	74 79                	je     1fb <exitwait+0x8b>
      if(wait() != pid){
     182:	e8 99 2b 00 00       	call   2d20 <wait>
     187:	39 c3                	cmp    %eax,%ebx
     189:	75 35                	jne    1c0 <exitwait+0x50>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     18b:	83 c6 01             	add    $0x1,%esi
     18e:	83 fe 64             	cmp    $0x64,%esi
     191:	74 4d                	je     1e0 <exitwait+0x70>
    pid = fork();
     193:	e8 78 2b 00 00       	call   2d10 <fork>
    if(pid < 0){
     198:	83 f8 00             	cmp    $0x0,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
     19b:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     19d:	7d e1                	jge    180 <exitwait+0x10>
      printf(1, "fork failed\n");
     19f:	c7 44 24 04 2c 32 00 	movl   $0x322c,0x4(%esp)
     1a6:	00 
     1a7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1ae:	e8 cd 2c 00 00       	call   2e80 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     1b3:	83 c4 10             	add    $0x10,%esp
     1b6:	5b                   	pop    %ebx
     1b7:	5e                   	pop    %esi
     1b8:	5d                   	pop    %ebp
     1b9:	c3                   	ret    
     1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     1c0:	c7 44 24 04 39 32 00 	movl   $0x3239,0x4(%esp)
     1c7:	00 
     1c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1cf:	e8 ac 2c 00 00       	call   2e80 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     1d4:	83 c4 10             	add    $0x10,%esp
     1d7:	5b                   	pop    %ebx
     1d8:	5e                   	pop    %esi
     1d9:	5d                   	pop    %ebp
     1da:	c3                   	ret    
     1db:	90                   	nop
     1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     1e0:	c7 44 24 04 49 32 00 	movl   $0x3249,0x4(%esp)
     1e7:	00 
     1e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     1ef:	e8 8c 2c 00 00       	call   2e80 <printf>
}
     1f4:	83 c4 10             	add    $0x10,%esp
     1f7:	5b                   	pop    %ebx
     1f8:	5e                   	pop    %esi
     1f9:	5d                   	pop    %ebp
     1fa:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     1fb:	e8 18 2b 00 00       	call   2d18 <exit>

00000200 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
     206:	c7 44 24 04 56 32 00 	movl   $0x3256,0x4(%esp)
     20d:	00 
     20e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     215:	e8 66 2c 00 00       	call   2e80 <printf>

  if(mkdir("12345678901234") != 0){
     21a:	c7 04 24 91 32 00 00 	movl   $0x3291,(%esp)
     221:	e8 5a 2b 00 00       	call   2d80 <mkdir>
     226:	85 c0                	test   %eax,%eax
     228:	0f 85 92 00 00 00    	jne    2c0 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
     22e:	c7 04 24 9c 3e 00 00 	movl   $0x3e9c,(%esp)
     235:	e8 46 2b 00 00       	call   2d80 <mkdir>
     23a:	85 c0                	test   %eax,%eax
     23c:	0f 85 fb 00 00 00    	jne    33d <fourteen+0x13d>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
     242:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     249:	00 
     24a:	c7 04 24 ec 3e 00 00 	movl   $0x3eec,(%esp)
     251:	e8 02 2b 00 00       	call   2d58 <open>
  if(fd < 0){
     256:	85 c0                	test   %eax,%eax
     258:	0f 88 c6 00 00 00    	js     324 <fourteen+0x124>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
     25e:	89 04 24             	mov    %eax,(%esp)
     261:	e8 da 2a 00 00       	call   2d40 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
     266:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     26d:	00 
     26e:	c7 04 24 5c 3f 00 00 	movl   $0x3f5c,(%esp)
     275:	e8 de 2a 00 00       	call   2d58 <open>
  if(fd < 0){
     27a:	85 c0                	test   %eax,%eax
     27c:	0f 88 89 00 00 00    	js     30b <fourteen+0x10b>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
     282:	89 04 24             	mov    %eax,(%esp)
     285:	e8 b6 2a 00 00       	call   2d40 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
     28a:	c7 04 24 82 32 00 00 	movl   $0x3282,(%esp)
     291:	e8 ea 2a 00 00       	call   2d80 <mkdir>
     296:	85 c0                	test   %eax,%eax
     298:	74 58                	je     2f2 <fourteen+0xf2>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
     29a:	c7 04 24 f8 3f 00 00 	movl   $0x3ff8,(%esp)
     2a1:	e8 da 2a 00 00       	call   2d80 <mkdir>
     2a6:	85 c0                	test   %eax,%eax
     2a8:	74 2f                	je     2d9 <fourteen+0xd9>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
     2aa:	c7 44 24 04 a0 32 00 	movl   $0x32a0,0x4(%esp)
     2b1:	00 
     2b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2b9:	e8 c2 2b 00 00       	call   2e80 <printf>
}
     2be:	c9                   	leave  
     2bf:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
     2c0:	c7 44 24 04 65 32 00 	movl   $0x3265,0x4(%esp)
     2c7:	00 
     2c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2cf:	e8 ac 2b 00 00       	call   2e80 <printf>
    exit();
     2d4:	e8 3f 2a 00 00       	call   2d18 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
     2d9:	c7 44 24 04 18 40 00 	movl   $0x4018,0x4(%esp)
     2e0:	00 
     2e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2e8:	e8 93 2b 00 00       	call   2e80 <printf>
    exit();
     2ed:	e8 26 2a 00 00       	call   2d18 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
     2f2:	c7 44 24 04 c8 3f 00 	movl   $0x3fc8,0x4(%esp)
     2f9:	00 
     2fa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     301:	e8 7a 2b 00 00       	call   2e80 <printf>
    exit();
     306:	e8 0d 2a 00 00       	call   2d18 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
     30b:	c7 44 24 04 8c 3f 00 	movl   $0x3f8c,0x4(%esp)
     312:	00 
     313:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     31a:	e8 61 2b 00 00       	call   2e80 <printf>
    exit();
     31f:	e8 f4 29 00 00       	call   2d18 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
     324:	c7 44 24 04 1c 3f 00 	movl   $0x3f1c,0x4(%esp)
     32b:	00 
     32c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     333:	e8 48 2b 00 00       	call   2e80 <printf>
    exit();
     338:	e8 db 29 00 00       	call   2d18 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
     33d:	c7 44 24 04 bc 3e 00 	movl   $0x3ebc,0x4(%esp)
     344:	00 
     345:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     34c:	e8 2f 2b 00 00       	call   2e80 <printf>
    exit();
     351:	e8 c2 29 00 00       	call   2d18 <exit>
     356:	8d 76 00             	lea    0x0(%esi),%esi
     359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
     364:	31 db                	xor    %ebx,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
     366:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
     369:	c7 44 24 04 ad 32 00 	movl   $0x32ad,0x4(%esp)
     370:	00 
     371:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     378:	e8 03 2b 00 00       	call   2e80 <printf>
     37d:	8d 76 00             	lea    0x0(%esi),%esi

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
     380:	c7 04 24 be 32 00 00 	movl   $0x32be,(%esp)
     387:	e8 f4 29 00 00       	call   2d80 <mkdir>
     38c:	85 c0                	test   %eax,%eax
     38e:	0f 85 b2 00 00 00    	jne    446 <iref+0xe6>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
     394:	c7 04 24 be 32 00 00 	movl   $0x32be,(%esp)
     39b:	e8 e8 29 00 00       	call   2d88 <chdir>
     3a0:	85 c0                	test   %eax,%eax
     3a2:	0f 85 b7 00 00 00    	jne    45f <iref+0xff>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
     3a8:	c7 04 24 6f 3d 00 00 	movl   $0x3d6f,(%esp)
     3af:	e8 cc 29 00 00       	call   2d80 <mkdir>
    link("README", "");
     3b4:	c7 44 24 04 6f 3d 00 	movl   $0x3d6f,0x4(%esp)
     3bb:	00 
     3bc:	c7 04 24 ec 32 00 00 	movl   $0x32ec,(%esp)
     3c3:	e8 b0 29 00 00       	call   2d78 <link>
    fd = open("", O_CREATE);
     3c8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     3cf:	00 
     3d0:	c7 04 24 6f 3d 00 00 	movl   $0x3d6f,(%esp)
     3d7:	e8 7c 29 00 00       	call   2d58 <open>
    if(fd >= 0)
     3dc:	85 c0                	test   %eax,%eax
     3de:	78 08                	js     3e8 <iref+0x88>
      close(fd);
     3e0:	89 04 24             	mov    %eax,(%esp)
     3e3:	e8 58 29 00 00       	call   2d40 <close>
    fd = open("xx", O_CREATE);
     3e8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     3ef:	00 
     3f0:	c7 04 24 5e 38 00 00 	movl   $0x385e,(%esp)
     3f7:	e8 5c 29 00 00       	call   2d58 <open>
    if(fd >= 0)
     3fc:	85 c0                	test   %eax,%eax
     3fe:	78 08                	js     408 <iref+0xa8>
      close(fd);
     400:	89 04 24             	mov    %eax,(%esp)
     403:	e8 38 29 00 00       	call   2d40 <close>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
     408:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
    fd = open("xx", O_CREATE);
    if(fd >= 0)
      close(fd);
    unlink("xx");
     40b:	c7 04 24 5e 38 00 00 	movl   $0x385e,(%esp)
     412:	e8 51 29 00 00       	call   2d68 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
     417:	83 fb 33             	cmp    $0x33,%ebx
     41a:	0f 85 60 ff ff ff    	jne    380 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
     420:	c7 04 24 f3 32 00 00 	movl   $0x32f3,(%esp)
     427:	e8 5c 29 00 00       	call   2d88 <chdir>
  printf(1, "empty file name OK\n");
     42c:	c7 44 24 04 f5 32 00 	movl   $0x32f5,0x4(%esp)
     433:	00 
     434:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     43b:	e8 40 2a 00 00       	call   2e80 <printf>
}
     440:	83 c4 14             	add    $0x14,%esp
     443:	5b                   	pop    %ebx
     444:	5d                   	pop    %ebp
     445:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
     446:	c7 44 24 04 c4 32 00 	movl   $0x32c4,0x4(%esp)
     44d:	00 
     44e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     455:	e8 26 2a 00 00       	call   2e80 <printf>
      exit();
     45a:	e8 b9 28 00 00       	call   2d18 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
     45f:	c7 44 24 04 d8 32 00 	movl   $0x32d8,0x4(%esp)
     466:	00 
     467:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     46e:	e8 0d 2a 00 00       	call   2e80 <printf>
      exit();
     473:	e8 a0 28 00 00       	call   2d18 <exit>
     478:	90                   	nop
     479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000480 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
     486:	c7 44 24 04 09 33 00 	movl   $0x3309,0x4(%esp)
     48d:	00 
     48e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     495:	e8 e6 29 00 00       	call   2e80 <printf>
  if(mkdir("dots") != 0){
     49a:	c7 04 24 15 33 00 00 	movl   $0x3315,(%esp)
     4a1:	e8 da 28 00 00       	call   2d80 <mkdir>
     4a6:	85 c0                	test   %eax,%eax
     4a8:	0f 85 9a 00 00 00    	jne    548 <rmdot+0xc8>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
     4ae:	c7 04 24 15 33 00 00 	movl   $0x3315,(%esp)
     4b5:	e8 ce 28 00 00       	call   2d88 <chdir>
     4ba:	85 c0                	test   %eax,%eax
     4bc:	0f 85 35 01 00 00    	jne    5f7 <rmdot+0x177>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
     4c2:	c7 04 24 7c 37 00 00 	movl   $0x377c,(%esp)
     4c9:	e8 9a 28 00 00       	call   2d68 <unlink>
     4ce:	85 c0                	test   %eax,%eax
     4d0:	0f 84 08 01 00 00    	je     5de <rmdot+0x15e>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
     4d6:	c7 04 24 7b 37 00 00 	movl   $0x377b,(%esp)
     4dd:	e8 86 28 00 00       	call   2d68 <unlink>
     4e2:	85 c0                	test   %eax,%eax
     4e4:	0f 84 db 00 00 00    	je     5c5 <rmdot+0x145>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
     4ea:	c7 04 24 f3 32 00 00 	movl   $0x32f3,(%esp)
     4f1:	e8 92 28 00 00       	call   2d88 <chdir>
     4f6:	85 c0                	test   %eax,%eax
     4f8:	0f 85 ae 00 00 00    	jne    5ac <rmdot+0x12c>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
     4fe:	c7 04 24 6d 33 00 00 	movl   $0x336d,(%esp)
     505:	e8 5e 28 00 00       	call   2d68 <unlink>
     50a:	85 c0                	test   %eax,%eax
     50c:	0f 84 81 00 00 00    	je     593 <rmdot+0x113>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
     512:	c7 04 24 8b 33 00 00 	movl   $0x338b,(%esp)
     519:	e8 4a 28 00 00       	call   2d68 <unlink>
     51e:	85 c0                	test   %eax,%eax
     520:	74 58                	je     57a <rmdot+0xfa>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
     522:	c7 04 24 15 33 00 00 	movl   $0x3315,(%esp)
     529:	e8 3a 28 00 00       	call   2d68 <unlink>
     52e:	85 c0                	test   %eax,%eax
     530:	75 2f                	jne    561 <rmdot+0xe1>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
     532:	c7 44 24 04 c0 33 00 	movl   $0x33c0,0x4(%esp)
     539:	00 
     53a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     541:	e8 3a 29 00 00       	call   2e80 <printf>
}
     546:	c9                   	leave  
     547:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
     548:	c7 44 24 04 1a 33 00 	movl   $0x331a,0x4(%esp)
     54f:	00 
     550:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     557:	e8 24 29 00 00       	call   2e80 <printf>
    exit();
     55c:	e8 b7 27 00 00       	call   2d18 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
     561:	c7 44 24 04 ab 33 00 	movl   $0x33ab,0x4(%esp)
     568:	00 
     569:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     570:	e8 0b 29 00 00       	call   2e80 <printf>
    exit();
     575:	e8 9e 27 00 00       	call   2d18 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
     57a:	c7 44 24 04 93 33 00 	movl   $0x3393,0x4(%esp)
     581:	00 
     582:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     589:	e8 f2 28 00 00       	call   2e80 <printf>
    exit();
     58e:	e8 85 27 00 00       	call   2d18 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
     593:	c7 44 24 04 74 33 00 	movl   $0x3374,0x4(%esp)
     59a:	00 
     59b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5a2:	e8 d9 28 00 00       	call   2e80 <printf>
    exit();
     5a7:	e8 6c 27 00 00       	call   2d18 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
     5ac:	c7 44 24 04 5d 33 00 	movl   $0x335d,0x4(%esp)
     5b3:	00 
     5b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5bb:	e8 c0 28 00 00       	call   2e80 <printf>
    exit();
     5c0:	e8 53 27 00 00       	call   2d18 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
     5c5:	c7 44 24 04 4e 33 00 	movl   $0x334e,0x4(%esp)
     5cc:	00 
     5cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5d4:	e8 a7 28 00 00       	call   2e80 <printf>
    exit();
     5d9:	e8 3a 27 00 00       	call   2d18 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
     5de:	c7 44 24 04 40 33 00 	movl   $0x3340,0x4(%esp)
     5e5:	00 
     5e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     5ed:	e8 8e 28 00 00       	call   2e80 <printf>
    exit();
     5f2:	e8 21 27 00 00       	call   2d18 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
     5f7:	c7 44 24 04 2d 33 00 	movl   $0x332d,0x4(%esp)
     5fe:	00 
     5ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     606:	e8 75 28 00 00       	call   2e80 <printf>
    exit();
     60b:	e8 08 27 00 00       	call   2d18 <exit>

00000610 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	56                   	push   %esi
     614:	53                   	push   %ebx
     615:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
     618:	c7 44 24 04 ca 33 00 	movl   $0x33ca,0x4(%esp)
     61f:	00 
     620:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     627:	e8 54 28 00 00       	call   2e80 <printf>
  unlink("bd");
     62c:	c7 04 24 d7 33 00 00 	movl   $0x33d7,(%esp)
     633:	e8 30 27 00 00       	call   2d68 <unlink>

  fd = open("bd", O_CREATE);
     638:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     63f:	00 
     640:	c7 04 24 d7 33 00 00 	movl   $0x33d7,(%esp)
     647:	e8 0c 27 00 00       	call   2d58 <open>
  if(fd < 0){
     64c:	85 c0                	test   %eax,%eax
     64e:	0f 88 e6 00 00 00    	js     73a <bigdir+0x12a>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
     654:	89 04 24             	mov    %eax,(%esp)
     657:	31 db                	xor    %ebx,%ebx
     659:	e8 e2 26 00 00       	call   2d40 <close>
     65e:	8d 75 ee             	lea    -0x12(%ebp),%esi
     661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
     668:	89 d8                	mov    %ebx,%eax
     66a:	c1 f8 06             	sar    $0x6,%eax
     66d:	83 c0 30             	add    $0x30,%eax
     670:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
     673:	89 d8                	mov    %ebx,%eax
     675:	83 e0 3f             	and    $0x3f,%eax
     678:	83 c0 30             	add    $0x30,%eax
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
     67b:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
     67f:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
     682:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
     686:	89 74 24 04          	mov    %esi,0x4(%esp)
     68a:	c7 04 24 d7 33 00 00 	movl   $0x33d7,(%esp)
     691:	e8 e2 26 00 00       	call   2d78 <link>
     696:	85 c0                	test   %eax,%eax
     698:	75 6e                	jne    708 <bigdir+0xf8>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
     69a:	83 c3 01             	add    $0x1,%ebx
     69d:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
     6a3:	75 c3                	jne    668 <bigdir+0x58>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
     6a5:	c7 04 24 d7 33 00 00 	movl   $0x33d7,(%esp)
     6ac:	66 31 db             	xor    %bx,%bx
     6af:	e8 b4 26 00 00       	call   2d68 <unlink>
     6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
     6b8:	89 d8                	mov    %ebx,%eax
     6ba:	c1 f8 06             	sar    $0x6,%eax
     6bd:	83 c0 30             	add    $0x30,%eax
     6c0:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
     6c3:	89 d8                	mov    %ebx,%eax
     6c5:	83 e0 3f             	and    $0x3f,%eax
     6c8:	83 c0 30             	add    $0x30,%eax
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
     6cb:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
     6cf:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
     6d2:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
     6d6:	89 34 24             	mov    %esi,(%esp)
     6d9:	e8 8a 26 00 00       	call   2d68 <unlink>
     6de:	85 c0                	test   %eax,%eax
     6e0:	75 3f                	jne    721 <bigdir+0x111>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
     6e2:	83 c3 01             	add    $0x1,%ebx
     6e5:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
     6eb:	75 cb                	jne    6b8 <bigdir+0xa8>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
     6ed:	c7 44 24 04 19 34 00 	movl   $0x3419,0x4(%esp)
     6f4:	00 
     6f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     6fc:	e8 7f 27 00 00       	call   2e80 <printf>
}
     701:	83 c4 20             	add    $0x20,%esp
     704:	5b                   	pop    %ebx
     705:	5e                   	pop    %esi
     706:	5d                   	pop    %ebp
     707:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
     708:	c7 44 24 04 f0 33 00 	movl   $0x33f0,0x4(%esp)
     70f:	00 
     710:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     717:	e8 64 27 00 00       	call   2e80 <printf>
      exit();
     71c:	e8 f7 25 00 00       	call   2d18 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
     721:	c7 44 24 04 04 34 00 	movl   $0x3404,0x4(%esp)
     728:	00 
     729:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     730:	e8 4b 27 00 00       	call   2e80 <printf>
      exit();
     735:	e8 de 25 00 00       	call   2d18 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
     73a:	c7 44 24 04 da 33 00 	movl   $0x33da,0x4(%esp)
     741:	00 
     742:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     749:	e8 32 27 00 00       	call   2e80 <printf>
    exit();
     74e:	e8 c5 25 00 00       	call   2d18 <exit>
     753:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000760 <createdelete>:
}

// two processes create and delete different files in same directory
void
createdelete(void)
{
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	57                   	push   %edi
     764:	56                   	push   %esi
     765:	53                   	push   %ebx
     766:	83 ec 4c             	sub    $0x4c,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
     769:	c7 44 24 04 24 34 00 	movl   $0x3424,0x4(%esp)
     770:	00 
     771:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     778:	e8 03 27 00 00       	call   2e80 <printf>
  pid = fork();
     77d:	e8 8e 25 00 00       	call   2d10 <fork>
  if(pid < 0){
     782:	85 c0                	test   %eax,%eax
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
     784:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  if(pid < 0){
     787:	0f 88 0d 02 00 00    	js     99a <createdelete+0x23a>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
     78d:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
  name[2] = '\0';
     791:	bf 01 00 00 00       	mov    $0x1,%edi
     796:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
     79a:	8d 75 c8             	lea    -0x38(%ebp),%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
     79d:	19 c0                	sbb    %eax,%eax
  name[2] = '\0';
     79f:	31 db                	xor    %ebx,%ebx
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
     7a1:	83 e0 f3             	and    $0xfffffff3,%eax
     7a4:	83 c0 70             	add    $0x70,%eax
     7a7:	88 45 c8             	mov    %al,-0x38(%ebp)
     7aa:	eb 0f                	jmp    7bb <createdelete+0x5b>
     7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  name[2] = '\0';
  for(i = 0; i < N; i++){
     7b0:	83 ff 13             	cmp    $0x13,%edi
     7b3:	7f 6b                	jg     820 <createdelete+0xc0>
    printf(1, "fork failed\n");
    exit();
  }

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
     7b5:	83 c3 01             	add    $0x1,%ebx
     7b8:	83 c7 01             	add    $0x1,%edi
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
     7bb:	8d 43 30             	lea    0x30(%ebx),%eax
     7be:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
     7c1:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     7c8:	00 
     7c9:	89 34 24             	mov    %esi,(%esp)
     7cc:	e8 87 25 00 00       	call   2d58 <open>
    if(fd < 0){
     7d1:	85 c0                	test   %eax,%eax
     7d3:	0f 88 6e 01 00 00    	js     947 <createdelete+0x1e7>
      printf(1, "create failed\n");
      exit();
    }
    close(fd);
     7d9:	89 04 24             	mov    %eax,(%esp)
     7dc:	e8 5f 25 00 00       	call   2d40 <close>
    if(i > 0 && (i % 2 ) == 0){
     7e1:	85 db                	test   %ebx,%ebx
     7e3:	74 d0                	je     7b5 <createdelete+0x55>
     7e5:	f6 c3 01             	test   $0x1,%bl
     7e8:	75 c6                	jne    7b0 <createdelete+0x50>
      name[1] = '0' + (i / 2);
     7ea:	89 d8                	mov    %ebx,%eax
     7ec:	d1 f8                	sar    %eax
     7ee:	83 c0 30             	add    $0x30,%eax
     7f1:	88 45 c9             	mov    %al,-0x37(%ebp)
      if(unlink(name) < 0){
     7f4:	89 34 24             	mov    %esi,(%esp)
     7f7:	e8 6c 25 00 00       	call   2d68 <unlink>
     7fc:	85 c0                	test   %eax,%eax
     7fe:	79 b0                	jns    7b0 <createdelete+0x50>
        printf(1, "unlink failed\n");
     800:	c7 44 24 04 37 34 00 	movl   $0x3437,0x4(%esp)
     807:	00 
     808:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     80f:	e8 6c 26 00 00       	call   2e80 <printf>
        exit();
     814:	e8 ff 24 00 00       	call   2d18 <exit>
     819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      }
    }
  }

  if(pid==0)
     820:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     823:	85 c0                	test   %eax,%eax
     825:	0f 84 6a 01 00 00    	je     995 <createdelete+0x235>
    exit();
  else
    wait();
     82b:	e8 f0 24 00 00       	call   2d20 <wait>
     830:	31 db                	xor    %ebx,%ebx
     832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(i = 0; i < N; i++){
    name[0] = 'p';
     838:	8d 7b 30             	lea    0x30(%ebx),%edi
    name[1] = '0' + i;
     83b:	89 f8                	mov    %edi,%eax
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    name[0] = 'p';
     83d:	c6 45 c8 70          	movb   $0x70,-0x38(%ebp)
    name[1] = '0' + i;
     841:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, 0);
     844:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     84b:	00 
     84c:	89 34 24             	mov    %esi,(%esp)
     84f:	e8 04 25 00 00       	call   2d58 <open>
    if((i == 0 || i >= N/2) && fd < 0){
     854:	83 fb 09             	cmp    $0x9,%ebx
     857:	0f 9f c1             	setg   %cl
     85a:	85 db                	test   %ebx,%ebx
     85c:	0f 94 c2             	sete   %dl
     85f:	08 d1                	or     %dl,%cl
     861:	88 4d c3             	mov    %cl,-0x3d(%ebp)
     864:	74 08                	je     86e <createdelete+0x10e>
     866:	85 c0                	test   %eax,%eax
     868:	0f 88 0f 01 00 00    	js     97d <createdelete+0x21d>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
     86e:	8d 53 ff             	lea    -0x1(%ebx),%edx
     871:	83 fa 08             	cmp    $0x8,%edx
     874:	89 c2                	mov    %eax,%edx
     876:	f7 d2                	not    %edx
     878:	0f 96 45 c4          	setbe  -0x3c(%ebp)
     87c:	c1 ea 1f             	shr    $0x1f,%edx
     87f:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
     883:	74 23                	je     8a8 <createdelete+0x148>
     885:	84 d2                	test   %dl,%dl
     887:	74 2b                	je     8b4 <createdelete+0x154>
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
      printf(1, "oops createdelete %s did exist\n", name);
     889:	89 74 24 08          	mov    %esi,0x8(%esp)
     88d:	c7 44 24 04 70 40 00 	movl   $0x4070,0x4(%esp)
     894:	00 
     895:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     89c:	e8 df 25 00 00       	call   2e80 <printf>
      exit();
     8a1:	e8 72 24 00 00       	call   2d18 <exit>
     8a6:	66 90                	xchg   %ax,%ax
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
      printf(1, "oops createdelete %s did exist\n", name);
      exit();
    }
    if(fd >= 0)
     8a8:	84 d2                	test   %dl,%dl
     8aa:	74 08                	je     8b4 <createdelete+0x154>
      close(fd);
     8ac:	89 04 24             	mov    %eax,(%esp)
     8af:	e8 8c 24 00 00       	call   2d40 <close>

    name[0] = 'c';
    name[1] = '0' + i;
     8b4:	89 f8                	mov    %edi,%eax
      exit();
    }
    if(fd >= 0)
      close(fd);

    name[0] = 'c';
     8b6:	c6 45 c8 63          	movb   $0x63,-0x38(%ebp)
    name[1] = '0' + i;
     8ba:	88 45 c9             	mov    %al,-0x37(%ebp)
    fd = open(name, 0);
     8bd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     8c4:	00 
     8c5:	89 34 24             	mov    %esi,(%esp)
     8c8:	e8 8b 24 00 00       	call   2d58 <open>
    if((i == 0 || i >= N/2) && fd < 0){
     8cd:	80 7d c3 00          	cmpb   $0x0,-0x3d(%ebp)
     8d1:	74 08                	je     8db <createdelete+0x17b>
     8d3:	85 c0                	test   %eax,%eax
     8d5:	0f 88 85 00 00 00    	js     960 <createdelete+0x200>
      printf(1, "oops createdelete %s didn't exist\n", name);
      exit();
    } else if((i >= 1 && i < N/2) && fd >= 0){
     8db:	85 c0                	test   %eax,%eax
     8dd:	8d 76 00             	lea    0x0(%esi),%esi
     8e0:	78 13                	js     8f5 <createdelete+0x195>
     8e2:	80 7d c4 00          	cmpb   $0x0,-0x3c(%ebp)
     8e6:	75 a1                	jne    889 <createdelete+0x129>
      printf(1, "oops createdelete %s did exist\n", name);
      exit();
    }
    if(fd >= 0)
      close(fd);
     8e8:	89 04 24             	mov    %eax,(%esp)
     8eb:	90                   	nop
     8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8f0:	e8 4b 24 00 00       	call   2d40 <close>
  if(pid==0)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
     8f5:	83 c3 01             	add    $0x1,%ebx
     8f8:	83 fb 14             	cmp    $0x14,%ebx
     8fb:	0f 85 37 ff ff ff    	jne    838 <createdelete+0xd8>
     901:	bb 30 00 00 00       	mov    $0x30,%ebx
     906:	66 90                	xchg   %ax,%ax
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
     908:	88 5d c9             	mov    %bl,-0x37(%ebp)
    unlink(name);
    name[0] = 'c';
    unlink(name);
     90b:	83 c3 01             	add    $0x1,%ebx
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    name[0] = 'p';
     90e:	c6 45 c8 70          	movb   $0x70,-0x38(%ebp)
    name[1] = '0' + i;
    unlink(name);
     912:	89 34 24             	mov    %esi,(%esp)
     915:	e8 4e 24 00 00       	call   2d68 <unlink>
    name[0] = 'c';
     91a:	c6 45 c8 63          	movb   $0x63,-0x38(%ebp)
    unlink(name);
     91e:	89 34 24             	mov    %esi,(%esp)
     921:	e8 42 24 00 00       	call   2d68 <unlink>
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
     926:	80 fb 44             	cmp    $0x44,%bl
     929:	75 dd                	jne    908 <createdelete+0x1a8>
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf(1, "createdelete ok\n");
     92b:	c7 44 24 04 46 34 00 	movl   $0x3446,0x4(%esp)
     932:	00 
     933:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     93a:	e8 41 25 00 00       	call   2e80 <printf>
}
     93f:	83 c4 4c             	add    $0x4c,%esp
     942:	5b                   	pop    %ebx
     943:	5e                   	pop    %esi
     944:	5f                   	pop    %edi
     945:	5d                   	pop    %ebp
     946:	c3                   	ret    
  name[2] = '\0';
  for(i = 0; i < N; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "create failed\n");
     947:	c7 44 24 04 e1 33 00 	movl   $0x33e1,0x4(%esp)
     94e:	00 
     94f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     956:	e8 25 25 00 00       	call   2e80 <printf>
      exit();
     95b:	e8 b8 23 00 00       	call   2d18 <exit>

    name[0] = 'c';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
     960:	89 74 24 08          	mov    %esi,0x8(%esp)
     964:	c7 44 24 04 4c 40 00 	movl   $0x404c,0x4(%esp)
     96b:	00 
     96c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     973:	e8 08 25 00 00       	call   2e80 <printf>
      exit();
     978:	e8 9b 23 00 00       	call   2d18 <exit>
  for(i = 0; i < N; i++){
    name[0] = 'p';
    name[1] = '0' + i;
    fd = open(name, 0);
    if((i == 0 || i >= N/2) && fd < 0){
      printf(1, "oops createdelete %s didn't exist\n", name);
     97d:	89 74 24 08          	mov    %esi,0x8(%esp)
     981:	c7 44 24 04 4c 40 00 	movl   $0x404c,0x4(%esp)
     988:	00 
     989:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     990:	e8 eb 24 00 00       	call   2e80 <printf>
      exit();
     995:	e8 7e 23 00 00       	call   2d18 <exit>
  char name[32];

  printf(1, "createdelete test\n");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
     99a:	c7 44 24 04 2c 32 00 	movl   $0x322c,0x4(%esp)
     9a1:	00 
     9a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     9a9:	e8 d2 24 00 00       	call   2e80 <printf>
    exit();
     9ae:	e8 65 23 00 00       	call   2d18 <exit>
     9b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009c0 <dirtest>:
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
}

void dirtest(void)
{
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
     9c6:	a1 08 44 00 00       	mov    0x4408,%eax
     9cb:	c7 44 24 04 57 34 00 	movl   $0x3457,0x4(%esp)
     9d2:	00 
     9d3:	89 04 24             	mov    %eax,(%esp)
     9d6:	e8 a5 24 00 00       	call   2e80 <printf>

  if(mkdir("dir0") < 0) {
     9db:	c7 04 24 63 34 00 00 	movl   $0x3463,(%esp)
     9e2:	e8 99 23 00 00       	call   2d80 <mkdir>
     9e7:	85 c0                	test   %eax,%eax
     9e9:	78 4b                	js     a36 <dirtest+0x76>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
     9eb:	c7 04 24 63 34 00 00 	movl   $0x3463,(%esp)
     9f2:	e8 91 23 00 00       	call   2d88 <chdir>
     9f7:	85 c0                	test   %eax,%eax
     9f9:	0f 88 85 00 00 00    	js     a84 <dirtest+0xc4>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
     9ff:	c7 04 24 7b 37 00 00 	movl   $0x377b,(%esp)
     a06:	e8 7d 23 00 00       	call   2d88 <chdir>
     a0b:	85 c0                	test   %eax,%eax
     a0d:	78 5b                	js     a6a <dirtest+0xaa>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
     a0f:	c7 04 24 63 34 00 00 	movl   $0x3463,(%esp)
     a16:	e8 4d 23 00 00       	call   2d68 <unlink>
     a1b:	85 c0                	test   %eax,%eax
     a1d:	78 31                	js     a50 <dirtest+0x90>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test\n");
     a1f:	a1 08 44 00 00       	mov    0x4408,%eax
     a24:	c7 44 24 04 57 34 00 	movl   $0x3457,0x4(%esp)
     a2b:	00 
     a2c:	89 04 24             	mov    %eax,(%esp)
     a2f:	e8 4c 24 00 00       	call   2e80 <printf>
}
     a34:	c9                   	leave  
     a35:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0) {
    printf(stdout, "mkdir failed\n");
     a36:	a1 08 44 00 00       	mov    0x4408,%eax
     a3b:	c7 44 24 04 68 34 00 	movl   $0x3468,0x4(%esp)
     a42:	00 
     a43:	89 04 24             	mov    %eax,(%esp)
     a46:	e8 35 24 00 00       	call   2e80 <printf>
    exit();
     a4b:	e8 c8 22 00 00       	call   2d18 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0) {
    printf(stdout, "unlink dir0 failed\n");
     a50:	a1 08 44 00 00       	mov    0x4408,%eax
     a55:	c7 44 24 04 9a 34 00 	movl   $0x349a,0x4(%esp)
     a5c:	00 
     a5d:	89 04 24             	mov    %eax,(%esp)
     a60:	e8 1b 24 00 00       	call   2e80 <printf>
    exit();
     a65:	e8 ae 22 00 00       	call   2d18 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0) {
    printf(stdout, "chdir .. failed\n");
     a6a:	a1 08 44 00 00       	mov    0x4408,%eax
     a6f:	c7 44 24 04 89 34 00 	movl   $0x3489,0x4(%esp)
     a76:	00 
     a77:	89 04 24             	mov    %eax,(%esp)
     a7a:	e8 01 24 00 00       	call   2e80 <printf>
    exit();
     a7f:	e8 94 22 00 00       	call   2d18 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0) {
    printf(stdout, "chdir dir0 failed\n");
     a84:	a1 08 44 00 00       	mov    0x4408,%eax
     a89:	c7 44 24 04 76 34 00 	movl   $0x3476,0x4(%esp)
     a90:	00 
     a91:	89 04 24             	mov    %eax,(%esp)
     a94:	e8 e7 23 00 00       	call   2e80 <printf>
    exit();
     a99:	e8 7a 22 00 00       	call   2d18 <exit>
     a9e:	66 90                	xchg   %ax,%ax

00000aa0 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
     aa4:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     aa9:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     aac:	a1 08 44 00 00       	mov    0x4408,%eax
     ab1:	c7 44 24 04 90 40 00 	movl   $0x4090,0x4(%esp)
     ab8:	00 
     ab9:	89 04 24             	mov    %eax,(%esp)
     abc:	e8 bf 23 00 00       	call   2e80 <printf>

  name[0] = 'a';
     ac1:	c6 05 40 4c 00 00 61 	movb   $0x61,0x4c40
  name[2] = '\0';
     ac8:	c6 05 42 4c 00 00 00 	movb   $0x0,0x4c42
     acf:	90                   	nop
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
     ad0:	88 1d 41 4c 00 00    	mov    %bl,0x4c41
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
     ad6:	83 c3 01             	add    $0x1,%ebx

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
     ad9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     ae0:	00 
     ae1:	c7 04 24 40 4c 00 00 	movl   $0x4c40,(%esp)
     ae8:	e8 6b 22 00 00       	call   2d58 <open>
    close(fd);
     aed:	89 04 24             	mov    %eax,(%esp)
     af0:	e8 4b 22 00 00       	call   2d40 <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
     af5:	80 fb 64             	cmp    $0x64,%bl
     af8:	75 d6                	jne    ad0 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     afa:	c6 05 40 4c 00 00 61 	movb   $0x61,0x4c40
  name[2] = '\0';
     b01:	bb 30 00 00 00       	mov    $0x30,%ebx
     b06:	c6 05 42 4c 00 00 00 	movb   $0x0,0x4c42
     b0d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++) {
    name[1] = '0' + i;
     b10:	88 1d 41 4c 00 00    	mov    %bl,0x4c41
    unlink(name);
     b16:	83 c3 01             	add    $0x1,%ebx
     b19:	c7 04 24 40 4c 00 00 	movl   $0x4c40,(%esp)
     b20:	e8 43 22 00 00       	call   2d68 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++) {
     b25:	80 fb 64             	cmp    $0x64,%bl
     b28:	75 e6                	jne    b10 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     b2a:	a1 08 44 00 00       	mov    0x4408,%eax
     b2f:	c7 44 24 04 b8 40 00 	movl   $0x40b8,0x4(%esp)
     b36:	00 
     b37:	89 04 24             	mov    %eax,(%esp)
     b3a:	e8 41 23 00 00       	call   2e80 <printf>
}
     b3f:	83 c4 14             	add    $0x14,%esp
     b42:	5b                   	pop    %ebx
     b43:	5d                   	pop    %ebp
     b44:	c3                   	ret    
     b45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b50 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	53                   	push   %ebx
     b54:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
     b57:	c7 44 24 04 ae 34 00 	movl   $0x34ae,0x4(%esp)
     b5e:	00 
     b5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b66:	e8 15 23 00 00       	call   2e80 <printf>

  fd = open("dirfile", O_CREATE);
     b6b:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     b72:	00 
     b73:	c7 04 24 bb 34 00 00 	movl   $0x34bb,(%esp)
     b7a:	e8 d9 21 00 00       	call   2d58 <open>
  if(fd < 0){
     b7f:	85 c0                	test   %eax,%eax
     b81:	0f 88 4e 01 00 00    	js     cd5 <dirfile+0x185>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
     b87:	89 04 24             	mov    %eax,(%esp)
     b8a:	e8 b1 21 00 00       	call   2d40 <close>
  if(chdir("dirfile") == 0){
     b8f:	c7 04 24 bb 34 00 00 	movl   $0x34bb,(%esp)
     b96:	e8 ed 21 00 00       	call   2d88 <chdir>
     b9b:	85 c0                	test   %eax,%eax
     b9d:	0f 84 19 01 00 00    	je     cbc <dirfile+0x16c>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
     ba3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     baa:	00 
     bab:	c7 04 24 f4 34 00 00 	movl   $0x34f4,(%esp)
     bb2:	e8 a1 21 00 00       	call   2d58 <open>
  if(fd >= 0){
     bb7:	85 c0                	test   %eax,%eax
     bb9:	0f 89 e4 00 00 00    	jns    ca3 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
     bbf:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
     bc6:	00 
     bc7:	c7 04 24 f4 34 00 00 	movl   $0x34f4,(%esp)
     bce:	e8 85 21 00 00       	call   2d58 <open>
  if(fd >= 0){
     bd3:	85 c0                	test   %eax,%eax
     bd5:	0f 89 c8 00 00 00    	jns    ca3 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
     bdb:	c7 04 24 f4 34 00 00 	movl   $0x34f4,(%esp)
     be2:	e8 99 21 00 00       	call   2d80 <mkdir>
     be7:	85 c0                	test   %eax,%eax
     be9:	0f 84 7c 01 00 00    	je     d6b <dirfile+0x21b>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
     bef:	c7 04 24 f4 34 00 00 	movl   $0x34f4,(%esp)
     bf6:	e8 6d 21 00 00       	call   2d68 <unlink>
     bfb:	85 c0                	test   %eax,%eax
     bfd:	0f 84 4f 01 00 00    	je     d52 <dirfile+0x202>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
     c03:	c7 44 24 04 f4 34 00 	movl   $0x34f4,0x4(%esp)
     c0a:	00 
     c0b:	c7 04 24 ec 32 00 00 	movl   $0x32ec,(%esp)
     c12:	e8 61 21 00 00       	call   2d78 <link>
     c17:	85 c0                	test   %eax,%eax
     c19:	0f 84 1a 01 00 00    	je     d39 <dirfile+0x1e9>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
     c1f:	c7 04 24 bb 34 00 00 	movl   $0x34bb,(%esp)
     c26:	e8 3d 21 00 00       	call   2d68 <unlink>
     c2b:	85 c0                	test   %eax,%eax
     c2d:	0f 85 ed 00 00 00    	jne    d20 <dirfile+0x1d0>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
     c33:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     c3a:	00 
     c3b:	c7 04 24 7c 37 00 00 	movl   $0x377c,(%esp)
     c42:	e8 11 21 00 00       	call   2d58 <open>
  if(fd >= 0){
     c47:	85 c0                	test   %eax,%eax
     c49:	0f 89 b8 00 00 00    	jns    d07 <dirfile+0x1b7>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
     c4f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     c56:	00 
     c57:	c7 04 24 7c 37 00 00 	movl   $0x377c,(%esp)
     c5e:	e8 f5 20 00 00       	call   2d58 <open>
  if(write(fd, "x", 1) > 0){
     c63:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     c6a:	00 
     c6b:	c7 44 24 04 5f 38 00 	movl   $0x385f,0x4(%esp)
     c72:	00 
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
     c73:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
     c75:	89 04 24             	mov    %eax,(%esp)
     c78:	e8 bb 20 00 00       	call   2d38 <write>
     c7d:	85 c0                	test   %eax,%eax
     c7f:	7f 6d                	jg     cee <dirfile+0x19e>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
     c81:	89 1c 24             	mov    %ebx,(%esp)
     c84:	e8 b7 20 00 00       	call   2d40 <close>

  printf(1, "dir vs file OK\n");
     c89:	c7 44 24 04 84 35 00 	movl   $0x3584,0x4(%esp)
     c90:	00 
     c91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c98:	e8 e3 21 00 00       	call   2e80 <printf>
}
     c9d:	83 c4 14             	add    $0x14,%esp
     ca0:	5b                   	pop    %ebx
     ca1:	5d                   	pop    %ebp
     ca2:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
     ca3:	c7 44 24 04 ff 34 00 	movl   $0x34ff,0x4(%esp)
     caa:	00 
     cab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cb2:	e8 c9 21 00 00       	call   2e80 <printf>
    exit();
     cb7:	e8 5c 20 00 00       	call   2d18 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
     cbc:	c7 44 24 04 da 34 00 	movl   $0x34da,0x4(%esp)
     cc3:	00 
     cc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ccb:	e8 b0 21 00 00       	call   2e80 <printf>
    exit();
     cd0:	e8 43 20 00 00       	call   2d18 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
     cd5:	c7 44 24 04 c3 34 00 	movl   $0x34c3,0x4(%esp)
     cdc:	00 
     cdd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ce4:	e8 97 21 00 00       	call   2e80 <printf>
    exit();
     ce9:	e8 2a 20 00 00       	call   2d18 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
     cee:	c7 44 24 04 70 35 00 	movl   $0x3570,0x4(%esp)
     cf5:	00 
     cf6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cfd:	e8 7e 21 00 00       	call   2e80 <printf>
    exit();
     d02:	e8 11 20 00 00       	call   2d18 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
     d07:	c7 44 24 04 00 41 00 	movl   $0x4100,0x4(%esp)
     d0e:	00 
     d0f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d16:	e8 65 21 00 00       	call   2e80 <printf>
    exit();
     d1b:	e8 f8 1f 00 00       	call   2d18 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
     d20:	c7 44 24 04 58 35 00 	movl   $0x3558,0x4(%esp)
     d27:	00 
     d28:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d2f:	e8 4c 21 00 00       	call   2e80 <printf>
    exit();
     d34:	e8 df 1f 00 00       	call   2d18 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
     d39:	c7 44 24 04 e0 40 00 	movl   $0x40e0,0x4(%esp)
     d40:	00 
     d41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d48:	e8 33 21 00 00       	call   2e80 <printf>
    exit();
     d4d:	e8 c6 1f 00 00       	call   2d18 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
     d52:	c7 44 24 04 3a 35 00 	movl   $0x353a,0x4(%esp)
     d59:	00 
     d5a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d61:	e8 1a 21 00 00       	call   2e80 <printf>
    exit();
     d66:	e8 ad 1f 00 00       	call   2d18 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
     d6b:	c7 44 24 04 1d 35 00 	movl   $0x351d,0x4(%esp)
     d72:	00 
     d73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d7a:	e8 01 21 00 00       	call   2e80 <printf>
    exit();
     d7f:	e8 94 1f 00 00       	call   2d18 <exit>
     d84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000d90 <bigfile>:
  printf(1, "subdir ok\n");
}

void
bigfile(void)
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	57                   	push   %edi
     d94:	56                   	push   %esi
     d95:	53                   	push   %ebx
     d96:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
     d99:	c7 44 24 04 94 35 00 	movl   $0x3594,0x4(%esp)
     da0:	00 
     da1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     da8:	e8 d3 20 00 00       	call   2e80 <printf>

  unlink("bigfile");
     dad:	c7 04 24 b0 35 00 00 	movl   $0x35b0,(%esp)
     db4:	e8 af 1f 00 00       	call   2d68 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
     db9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     dc0:	00 
     dc1:	c7 04 24 b0 35 00 00 	movl   $0x35b0,(%esp)
     dc8:	e8 8b 1f 00 00       	call   2d58 <open>
  if(fd < 0){
     dcd:	85 c0                	test   %eax,%eax
  int fd, i, total, cc;

  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
     dcf:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     dd1:	0f 88 7f 01 00 00    	js     f56 <bigfile+0x1c6>
    printf(1, "cannot create bigfile");
    exit();
     dd7:	31 db                	xor    %ebx,%ebx
     dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
     de0:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
     de7:	00 
     de8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     dec:	c7 04 24 40 44 00 00 	movl   $0x4440,(%esp)
     df3:	e8 88 1d 00 00       	call   2b80 <memset>
    if(write(fd, buf, 600) != 600){
     df8:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
     dff:	00 
     e00:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     e07:	00 
     e08:	89 34 24             	mov    %esi,(%esp)
     e0b:	e8 28 1f 00 00       	call   2d38 <write>
     e10:	3d 58 02 00 00       	cmp    $0x258,%eax
     e15:	0f 85 09 01 00 00    	jne    f24 <bigfile+0x194>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
     e1b:	83 c3 01             	add    $0x1,%ebx
     e1e:	83 fb 14             	cmp    $0x14,%ebx
     e21:	75 bd                	jne    de0 <bigfile+0x50>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
     e23:	89 34 24             	mov    %esi,(%esp)
     e26:	e8 15 1f 00 00       	call   2d40 <close>

  fd = open("bigfile", 0);
     e2b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     e32:	00 
     e33:	c7 04 24 b0 35 00 00 	movl   $0x35b0,(%esp)
     e3a:	e8 19 1f 00 00       	call   2d58 <open>
  if(fd < 0){
     e3f:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
     e41:	89 c7                	mov    %eax,%edi
  if(fd < 0){
     e43:	0f 88 f4 00 00 00    	js     f3d <bigfile+0x1ad>
    printf(1, "cannot open bigfile\n");
    exit();
     e49:	31 f6                	xor    %esi,%esi
     e4b:	31 db                	xor    %ebx,%ebx
     e4d:	eb 2f                	jmp    e7e <bigfile+0xee>
     e4f:	90                   	nop
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
     e50:	3d 2c 01 00 00       	cmp    $0x12c,%eax
     e55:	0f 85 97 00 00 00    	jne    ef2 <bigfile+0x162>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
     e5b:	0f be 05 40 44 00 00 	movsbl 0x4440,%eax
     e62:	89 da                	mov    %ebx,%edx
     e64:	d1 fa                	sar    %edx
     e66:	39 d0                	cmp    %edx,%eax
     e68:	75 6f                	jne    ed9 <bigfile+0x149>
     e6a:	0f be 15 6b 45 00 00 	movsbl 0x456b,%edx
     e71:	39 d0                	cmp    %edx,%eax
     e73:	75 64                	jne    ed9 <bigfile+0x149>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
     e75:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
     e7b:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
     e7e:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
     e85:	00 
     e86:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
     e8d:	00 
     e8e:	89 3c 24             	mov    %edi,(%esp)
     e91:	e8 9a 1e 00 00       	call   2d30 <read>
    if(cc < 0){
     e96:	83 f8 00             	cmp    $0x0,%eax
     e99:	7c 70                	jl     f0b <bigfile+0x17b>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
     e9b:	75 b3                	jne    e50 <bigfile+0xc0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
     e9d:	89 3c 24             	mov    %edi,(%esp)
     ea0:	e8 9b 1e 00 00       	call   2d40 <close>
  if(total != 20*600){
     ea5:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
     eab:	0f 85 be 00 00 00    	jne    f6f <bigfile+0x1df>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
     eb1:	c7 04 24 b0 35 00 00 	movl   $0x35b0,(%esp)
     eb8:	e8 ab 1e 00 00       	call   2d68 <unlink>

  printf(1, "bigfile test ok\n");
     ebd:	c7 44 24 04 3f 36 00 	movl   $0x363f,0x4(%esp)
     ec4:	00 
     ec5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ecc:	e8 af 1f 00 00       	call   2e80 <printf>
}
     ed1:	83 c4 1c             	add    $0x1c,%esp
     ed4:	5b                   	pop    %ebx
     ed5:	5e                   	pop    %esi
     ed6:	5f                   	pop    %edi
     ed7:	5d                   	pop    %ebp
     ed8:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
     ed9:	c7 44 24 04 0c 36 00 	movl   $0x360c,0x4(%esp)
     ee0:	00 
     ee1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ee8:	e8 93 1f 00 00       	call   2e80 <printf>
      exit();
     eed:	e8 26 1e 00 00       	call   2d18 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
     ef2:	c7 44 24 04 f8 35 00 	movl   $0x35f8,0x4(%esp)
     ef9:	00 
     efa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f01:	e8 7a 1f 00 00       	call   2e80 <printf>
      exit();
     f06:	e8 0d 1e 00 00       	call   2d18 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
     f0b:	c7 44 24 04 e3 35 00 	movl   $0x35e3,0x4(%esp)
     f12:	00 
     f13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f1a:	e8 61 1f 00 00       	call   2e80 <printf>
      exit();
     f1f:	e8 f4 1d 00 00       	call   2d18 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
     f24:	c7 44 24 04 b8 35 00 	movl   $0x35b8,0x4(%esp)
     f2b:	00 
     f2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f33:	e8 48 1f 00 00       	call   2e80 <printf>
      exit();
     f38:	e8 db 1d 00 00       	call   2d18 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
     f3d:	c7 44 24 04 ce 35 00 	movl   $0x35ce,0x4(%esp)
     f44:	00 
     f45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f4c:	e8 2f 1f 00 00       	call   2e80 <printf>
    exit();
     f51:	e8 c2 1d 00 00       	call   2d18 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
     f56:	c7 44 24 04 a2 35 00 	movl   $0x35a2,0x4(%esp)
     f5d:	00 
     f5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f65:	e8 16 1f 00 00       	call   2e80 <printf>
    exit();
     f6a:	e8 a9 1d 00 00       	call   2d18 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
     f6f:	c7 44 24 04 25 36 00 	movl   $0x3625,0x4(%esp)
     f76:	00 
     f77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f7e:	e8 fd 1e 00 00       	call   2e80 <printf>
    exit();
     f83:	e8 90 1d 00 00       	call   2d18 <exit>
     f88:	90                   	nop
     f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f90 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
     f90:	55                   	push   %ebp
     f91:	89 e5                	mov    %esp,%ebp
     f93:	53                   	push   %ebx
     f94:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
     f97:	c7 44 24 04 50 36 00 	movl   $0x3650,0x4(%esp)
     f9e:	00 
     f9f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fa6:	e8 d5 1e 00 00       	call   2e80 <printf>

  unlink("ff");
     fab:	c7 04 24 d9 36 00 00 	movl   $0x36d9,(%esp)
     fb2:	e8 b1 1d 00 00       	call   2d68 <unlink>
  if(mkdir("dd") != 0){
     fb7:	c7 04 24 76 37 00 00 	movl   $0x3776,(%esp)
     fbe:	e8 bd 1d 00 00       	call   2d80 <mkdir>
     fc3:	85 c0                	test   %eax,%eax
     fc5:	0f 85 07 06 00 00    	jne    15d2 <subdir+0x642>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
     fcb:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     fd2:	00 
     fd3:	c7 04 24 af 36 00 00 	movl   $0x36af,(%esp)
     fda:	e8 79 1d 00 00       	call   2d58 <open>
  if(fd < 0){
     fdf:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
     fe1:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     fe3:	0f 88 d0 05 00 00    	js     15b9 <subdir+0x629>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
     fe9:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
     ff0:	00 
     ff1:	c7 44 24 04 d9 36 00 	movl   $0x36d9,0x4(%esp)
     ff8:	00 
     ff9:	89 04 24             	mov    %eax,(%esp)
     ffc:	e8 37 1d 00 00       	call   2d38 <write>
  close(fd);
    1001:	89 1c 24             	mov    %ebx,(%esp)
    1004:	e8 37 1d 00 00       	call   2d40 <close>
  
  if(unlink("dd") >= 0){
    1009:	c7 04 24 76 37 00 00 	movl   $0x3776,(%esp)
    1010:	e8 53 1d 00 00       	call   2d68 <unlink>
    1015:	85 c0                	test   %eax,%eax
    1017:	0f 89 83 05 00 00    	jns    15a0 <subdir+0x610>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    101d:	c7 04 24 8a 36 00 00 	movl   $0x368a,(%esp)
    1024:	e8 57 1d 00 00       	call   2d80 <mkdir>
    1029:	85 c0                	test   %eax,%eax
    102b:	0f 85 56 05 00 00    	jne    1587 <subdir+0x5f7>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1031:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1038:	00 
    1039:	c7 04 24 ac 36 00 00 	movl   $0x36ac,(%esp)
    1040:	e8 13 1d 00 00       	call   2d58 <open>
  if(fd < 0){
    1045:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1047:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1049:	0f 88 25 04 00 00    	js     1474 <subdir+0x4e4>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    104f:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1056:	00 
    1057:	c7 44 24 04 cd 36 00 	movl   $0x36cd,0x4(%esp)
    105e:	00 
    105f:	89 04 24             	mov    %eax,(%esp)
    1062:	e8 d1 1c 00 00       	call   2d38 <write>
  close(fd);
    1067:	89 1c 24             	mov    %ebx,(%esp)
    106a:	e8 d1 1c 00 00       	call   2d40 <close>

  fd = open("dd/dd/../ff", 0);
    106f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1076:	00 
    1077:	c7 04 24 d0 36 00 00 	movl   $0x36d0,(%esp)
    107e:	e8 d5 1c 00 00       	call   2d58 <open>
  if(fd < 0){
    1083:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    1085:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1087:	0f 88 ce 03 00 00    	js     145b <subdir+0x4cb>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    108d:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1094:	00 
    1095:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    109c:	00 
    109d:	89 04 24             	mov    %eax,(%esp)
    10a0:	e8 8b 1c 00 00       	call   2d30 <read>
  if(cc != 2 || buf[0] != 'f'){
    10a5:	83 f8 02             	cmp    $0x2,%eax
    10a8:	0f 85 fe 02 00 00    	jne    13ac <subdir+0x41c>
    10ae:	80 3d 40 44 00 00 66 	cmpb   $0x66,0x4440
    10b5:	0f 85 f1 02 00 00    	jne    13ac <subdir+0x41c>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    10bb:	89 1c 24             	mov    %ebx,(%esp)
    10be:	e8 7d 1c 00 00       	call   2d40 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    10c3:	c7 44 24 04 10 37 00 	movl   $0x3710,0x4(%esp)
    10ca:	00 
    10cb:	c7 04 24 ac 36 00 00 	movl   $0x36ac,(%esp)
    10d2:	e8 a1 1c 00 00       	call   2d78 <link>
    10d7:	85 c0                	test   %eax,%eax
    10d9:	0f 85 c7 03 00 00    	jne    14a6 <subdir+0x516>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    10df:	c7 04 24 ac 36 00 00 	movl   $0x36ac,(%esp)
    10e6:	e8 7d 1c 00 00       	call   2d68 <unlink>
    10eb:	85 c0                	test   %eax,%eax
    10ed:	0f 85 eb 02 00 00    	jne    13de <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    10f3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10fa:	00 
    10fb:	c7 04 24 ac 36 00 00 	movl   $0x36ac,(%esp)
    1102:	e8 51 1c 00 00       	call   2d58 <open>
    1107:	85 c0                	test   %eax,%eax
    1109:	0f 89 5f 04 00 00    	jns    156e <subdir+0x5de>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    110f:	c7 04 24 76 37 00 00 	movl   $0x3776,(%esp)
    1116:	e8 6d 1c 00 00       	call   2d88 <chdir>
    111b:	85 c0                	test   %eax,%eax
    111d:	0f 85 32 04 00 00    	jne    1555 <subdir+0x5c5>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1123:	c7 04 24 44 37 00 00 	movl   $0x3744,(%esp)
    112a:	e8 59 1c 00 00       	call   2d88 <chdir>
    112f:	85 c0                	test   %eax,%eax
    1131:	0f 85 8e 02 00 00    	jne    13c5 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1137:	c7 04 24 6a 37 00 00 	movl   $0x376a,(%esp)
    113e:	e8 45 1c 00 00       	call   2d88 <chdir>
    1143:	85 c0                	test   %eax,%eax
    1145:	0f 85 7a 02 00 00    	jne    13c5 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    114b:	c7 04 24 79 37 00 00 	movl   $0x3779,(%esp)
    1152:	e8 31 1c 00 00       	call   2d88 <chdir>
    1157:	85 c0                	test   %eax,%eax
    1159:	0f 85 2e 03 00 00    	jne    148d <subdir+0x4fd>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    115f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1166:	00 
    1167:	c7 04 24 10 37 00 00 	movl   $0x3710,(%esp)
    116e:	e8 e5 1b 00 00       	call   2d58 <open>
  if(fd < 0){
    1173:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1175:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1177:	0f 88 81 05 00 00    	js     16fe <subdir+0x76e>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    117d:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1184:	00 
    1185:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    118c:	00 
    118d:	89 04 24             	mov    %eax,(%esp)
    1190:	e8 9b 1b 00 00       	call   2d30 <read>
    1195:	83 f8 02             	cmp    $0x2,%eax
    1198:	0f 85 47 05 00 00    	jne    16e5 <subdir+0x755>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    119e:	89 1c 24             	mov    %ebx,(%esp)
    11a1:	e8 9a 1b 00 00       	call   2d40 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    11a6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11ad:	00 
    11ae:	c7 04 24 ac 36 00 00 	movl   $0x36ac,(%esp)
    11b5:	e8 9e 1b 00 00       	call   2d58 <open>
    11ba:	85 c0                	test   %eax,%eax
    11bc:	0f 89 4e 02 00 00    	jns    1410 <subdir+0x480>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    11c2:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    11c9:	00 
    11ca:	c7 04 24 c4 37 00 00 	movl   $0x37c4,(%esp)
    11d1:	e8 82 1b 00 00       	call   2d58 <open>
    11d6:	85 c0                	test   %eax,%eax
    11d8:	0f 89 19 02 00 00    	jns    13f7 <subdir+0x467>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    11de:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    11e5:	00 
    11e6:	c7 04 24 e9 37 00 00 	movl   $0x37e9,(%esp)
    11ed:	e8 66 1b 00 00       	call   2d58 <open>
    11f2:	85 c0                	test   %eax,%eax
    11f4:	0f 89 42 03 00 00    	jns    153c <subdir+0x5ac>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    11fa:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1201:	00 
    1202:	c7 04 24 76 37 00 00 	movl   $0x3776,(%esp)
    1209:	e8 4a 1b 00 00       	call   2d58 <open>
    120e:	85 c0                	test   %eax,%eax
    1210:	0f 89 0d 03 00 00    	jns    1523 <subdir+0x593>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1216:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    121d:	00 
    121e:	c7 04 24 76 37 00 00 	movl   $0x3776,(%esp)
    1225:	e8 2e 1b 00 00       	call   2d58 <open>
    122a:	85 c0                	test   %eax,%eax
    122c:	0f 89 d8 02 00 00    	jns    150a <subdir+0x57a>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    1232:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1239:	00 
    123a:	c7 04 24 76 37 00 00 	movl   $0x3776,(%esp)
    1241:	e8 12 1b 00 00       	call   2d58 <open>
    1246:	85 c0                	test   %eax,%eax
    1248:	0f 89 a3 02 00 00    	jns    14f1 <subdir+0x561>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    124e:	c7 44 24 04 58 38 00 	movl   $0x3858,0x4(%esp)
    1255:	00 
    1256:	c7 04 24 c4 37 00 00 	movl   $0x37c4,(%esp)
    125d:	e8 16 1b 00 00       	call   2d78 <link>
    1262:	85 c0                	test   %eax,%eax
    1264:	0f 84 6e 02 00 00    	je     14d8 <subdir+0x548>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    126a:	c7 44 24 04 58 38 00 	movl   $0x3858,0x4(%esp)
    1271:	00 
    1272:	c7 04 24 e9 37 00 00 	movl   $0x37e9,(%esp)
    1279:	e8 fa 1a 00 00       	call   2d78 <link>
    127e:	85 c0                	test   %eax,%eax
    1280:	0f 84 39 02 00 00    	je     14bf <subdir+0x52f>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1286:	c7 44 24 04 10 37 00 	movl   $0x3710,0x4(%esp)
    128d:	00 
    128e:	c7 04 24 af 36 00 00 	movl   $0x36af,(%esp)
    1295:	e8 de 1a 00 00       	call   2d78 <link>
    129a:	85 c0                	test   %eax,%eax
    129c:	0f 84 a0 01 00 00    	je     1442 <subdir+0x4b2>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    12a2:	c7 04 24 c4 37 00 00 	movl   $0x37c4,(%esp)
    12a9:	e8 d2 1a 00 00       	call   2d80 <mkdir>
    12ae:	85 c0                	test   %eax,%eax
    12b0:	0f 84 73 01 00 00    	je     1429 <subdir+0x499>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    12b6:	c7 04 24 e9 37 00 00 	movl   $0x37e9,(%esp)
    12bd:	e8 be 1a 00 00       	call   2d80 <mkdir>
    12c2:	85 c0                	test   %eax,%eax
    12c4:	0f 84 02 04 00 00    	je     16cc <subdir+0x73c>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    12ca:	c7 04 24 10 37 00 00 	movl   $0x3710,(%esp)
    12d1:	e8 aa 1a 00 00       	call   2d80 <mkdir>
    12d6:	85 c0                	test   %eax,%eax
    12d8:	0f 84 d5 03 00 00    	je     16b3 <subdir+0x723>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    12de:	c7 04 24 e9 37 00 00 	movl   $0x37e9,(%esp)
    12e5:	e8 7e 1a 00 00       	call   2d68 <unlink>
    12ea:	85 c0                	test   %eax,%eax
    12ec:	0f 84 a8 03 00 00    	je     169a <subdir+0x70a>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    12f2:	c7 04 24 c4 37 00 00 	movl   $0x37c4,(%esp)
    12f9:	e8 6a 1a 00 00       	call   2d68 <unlink>
    12fe:	85 c0                	test   %eax,%eax
    1300:	0f 84 7b 03 00 00    	je     1681 <subdir+0x6f1>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    1306:	c7 04 24 af 36 00 00 	movl   $0x36af,(%esp)
    130d:	e8 76 1a 00 00       	call   2d88 <chdir>
    1312:	85 c0                	test   %eax,%eax
    1314:	0f 84 4e 03 00 00    	je     1668 <subdir+0x6d8>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    131a:	c7 04 24 5b 38 00 00 	movl   $0x385b,(%esp)
    1321:	e8 62 1a 00 00       	call   2d88 <chdir>
    1326:	85 c0                	test   %eax,%eax
    1328:	0f 84 21 03 00 00    	je     164f <subdir+0x6bf>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    132e:	c7 04 24 10 37 00 00 	movl   $0x3710,(%esp)
    1335:	e8 2e 1a 00 00       	call   2d68 <unlink>
    133a:	85 c0                	test   %eax,%eax
    133c:	0f 85 9c 00 00 00    	jne    13de <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    1342:	c7 04 24 af 36 00 00 	movl   $0x36af,(%esp)
    1349:	e8 1a 1a 00 00       	call   2d68 <unlink>
    134e:	85 c0                	test   %eax,%eax
    1350:	0f 85 e0 02 00 00    	jne    1636 <subdir+0x6a6>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    1356:	c7 04 24 76 37 00 00 	movl   $0x3776,(%esp)
    135d:	e8 06 1a 00 00       	call   2d68 <unlink>
    1362:	85 c0                	test   %eax,%eax
    1364:	0f 84 b3 02 00 00    	je     161d <subdir+0x68d>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    136a:	c7 04 24 8b 36 00 00 	movl   $0x368b,(%esp)
    1371:	e8 f2 19 00 00       	call   2d68 <unlink>
    1376:	85 c0                	test   %eax,%eax
    1378:	0f 88 86 02 00 00    	js     1604 <subdir+0x674>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    137e:	c7 04 24 76 37 00 00 	movl   $0x3776,(%esp)
    1385:	e8 de 19 00 00       	call   2d68 <unlink>
    138a:	85 c0                	test   %eax,%eax
    138c:	0f 88 59 02 00 00    	js     15eb <subdir+0x65b>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    1392:	c7 44 24 04 58 39 00 	movl   $0x3958,0x4(%esp)
    1399:	00 
    139a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a1:	e8 da 1a 00 00       	call   2e80 <printf>
}
    13a6:	83 c4 14             	add    $0x14,%esp
    13a9:	5b                   	pop    %ebx
    13aa:	5d                   	pop    %ebp
    13ab:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    13ac:	c7 44 24 04 f5 36 00 	movl   $0x36f5,0x4(%esp)
    13b3:	00 
    13b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13bb:	e8 c0 1a 00 00       	call   2e80 <printf>
    exit();
    13c0:	e8 53 19 00 00       	call   2d18 <exit>
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    13c5:	c7 44 24 04 50 37 00 	movl   $0x3750,0x4(%esp)
    13cc:	00 
    13cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13d4:	e8 a7 1a 00 00       	call   2e80 <printf>
    exit();
    13d9:	e8 3a 19 00 00       	call   2d18 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    13de:	c7 44 24 04 1b 37 00 	movl   $0x371b,0x4(%esp)
    13e5:	00 
    13e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13ed:	e8 8e 1a 00 00       	call   2e80 <printf>
    exit();
    13f2:	e8 21 19 00 00       	call   2d18 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    13f7:	c7 44 24 04 cd 37 00 	movl   $0x37cd,0x4(%esp)
    13fe:	00 
    13ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1406:	e8 75 1a 00 00       	call   2e80 <printf>
    exit();
    140b:	e8 08 19 00 00       	call   2d18 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    1410:	c7 44 24 04 90 41 00 	movl   $0x4190,0x4(%esp)
    1417:	00 
    1418:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    141f:	e8 5c 1a 00 00       	call   2e80 <printf>
    exit();
    1424:	e8 ef 18 00 00       	call   2d18 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    1429:	c7 44 24 04 61 38 00 	movl   $0x3861,0x4(%esp)
    1430:	00 
    1431:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1438:	e8 43 1a 00 00       	call   2e80 <printf>
    exit();
    143d:	e8 d6 18 00 00       	call   2d18 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    1442:	c7 44 24 04 00 42 00 	movl   $0x4200,0x4(%esp)
    1449:	00 
    144a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1451:	e8 2a 1a 00 00       	call   2e80 <printf>
    exit();
    1456:	e8 bd 18 00 00       	call   2d18 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    145b:	c7 44 24 04 dc 36 00 	movl   $0x36dc,0x4(%esp)
    1462:	00 
    1463:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    146a:	e8 11 1a 00 00       	call   2e80 <printf>
    exit();
    146f:	e8 a4 18 00 00       	call   2d18 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    1474:	c7 44 24 04 b5 36 00 	movl   $0x36b5,0x4(%esp)
    147b:	00 
    147c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1483:	e8 f8 19 00 00       	call   2e80 <printf>
    exit();
    1488:	e8 8b 18 00 00       	call   2d18 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    148d:	c7 44 24 04 7e 37 00 	movl   $0x377e,0x4(%esp)
    1494:	00 
    1495:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    149c:	e8 df 19 00 00       	call   2e80 <printf>
    exit();
    14a1:	e8 72 18 00 00       	call   2d18 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    14a6:	c7 44 24 04 48 41 00 	movl   $0x4148,0x4(%esp)
    14ad:	00 
    14ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14b5:	e8 c6 19 00 00       	call   2e80 <printf>
    exit();
    14ba:	e8 59 18 00 00       	call   2d18 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    14bf:	c7 44 24 04 dc 41 00 	movl   $0x41dc,0x4(%esp)
    14c6:	00 
    14c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ce:	e8 ad 19 00 00       	call   2e80 <printf>
    exit();
    14d3:	e8 40 18 00 00       	call   2d18 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    14d8:	c7 44 24 04 b8 41 00 	movl   $0x41b8,0x4(%esp)
    14df:	00 
    14e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14e7:	e8 94 19 00 00       	call   2e80 <printf>
    exit();
    14ec:	e8 27 18 00 00       	call   2d18 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    14f1:	c7 44 24 04 3d 38 00 	movl   $0x383d,0x4(%esp)
    14f8:	00 
    14f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1500:	e8 7b 19 00 00       	call   2e80 <printf>
    exit();
    1505:	e8 0e 18 00 00       	call   2d18 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    150a:	c7 44 24 04 24 38 00 	movl   $0x3824,0x4(%esp)
    1511:	00 
    1512:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1519:	e8 62 19 00 00       	call   2e80 <printf>
    exit();
    151e:	e8 f5 17 00 00       	call   2d18 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    1523:	c7 44 24 04 0e 38 00 	movl   $0x380e,0x4(%esp)
    152a:	00 
    152b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1532:	e8 49 19 00 00       	call   2e80 <printf>
    exit();
    1537:	e8 dc 17 00 00       	call   2d18 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    153c:	c7 44 24 04 f2 37 00 	movl   $0x37f2,0x4(%esp)
    1543:	00 
    1544:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    154b:	e8 30 19 00 00       	call   2e80 <printf>
    exit();
    1550:	e8 c3 17 00 00       	call   2d18 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    1555:	c7 44 24 04 33 37 00 	movl   $0x3733,0x4(%esp)
    155c:	00 
    155d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1564:	e8 17 19 00 00       	call   2e80 <printf>
    exit();
    1569:	e8 aa 17 00 00       	call   2d18 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    156e:	c7 44 24 04 6c 41 00 	movl   $0x416c,0x4(%esp)
    1575:	00 
    1576:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    157d:	e8 fe 18 00 00       	call   2e80 <printf>
    exit();
    1582:	e8 91 17 00 00       	call   2d18 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    1587:	c7 44 24 04 91 36 00 	movl   $0x3691,0x4(%esp)
    158e:	00 
    158f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1596:	e8 e5 18 00 00       	call   2e80 <printf>
    exit();
    159b:	e8 78 17 00 00       	call   2d18 <exit>
  }
  write(fd, "ff", 2);
  close(fd);
  
  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    15a0:	c7 44 24 04 20 41 00 	movl   $0x4120,0x4(%esp)
    15a7:	00 
    15a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15af:	e8 cc 18 00 00       	call   2e80 <printf>
    exit();
    15b4:	e8 5f 17 00 00       	call   2d18 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    15b9:	c7 44 24 04 75 36 00 	movl   $0x3675,0x4(%esp)
    15c0:	00 
    15c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15c8:	e8 b3 18 00 00       	call   2e80 <printf>
    exit();
    15cd:	e8 46 17 00 00       	call   2d18 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    15d2:	c7 44 24 04 5d 36 00 	movl   $0x365d,0x4(%esp)
    15d9:	00 
    15da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15e1:	e8 9a 18 00 00       	call   2e80 <printf>
    exit();
    15e6:	e8 2d 17 00 00       	call   2d18 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    15eb:	c7 44 24 04 46 39 00 	movl   $0x3946,0x4(%esp)
    15f2:	00 
    15f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15fa:	e8 81 18 00 00       	call   2e80 <printf>
    exit();
    15ff:	e8 14 17 00 00       	call   2d18 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    1604:	c7 44 24 04 31 39 00 	movl   $0x3931,0x4(%esp)
    160b:	00 
    160c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1613:	e8 68 18 00 00       	call   2e80 <printf>
    exit();
    1618:	e8 fb 16 00 00       	call   2d18 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    161d:	c7 44 24 04 24 42 00 	movl   $0x4224,0x4(%esp)
    1624:	00 
    1625:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    162c:	e8 4f 18 00 00       	call   2e80 <printf>
    exit();
    1631:	e8 e2 16 00 00       	call   2d18 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    1636:	c7 44 24 04 1c 39 00 	movl   $0x391c,0x4(%esp)
    163d:	00 
    163e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1645:	e8 36 18 00 00       	call   2e80 <printf>
    exit();
    164a:	e8 c9 16 00 00       	call   2d18 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    164f:	c7 44 24 04 04 39 00 	movl   $0x3904,0x4(%esp)
    1656:	00 
    1657:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    165e:	e8 1d 18 00 00       	call   2e80 <printf>
    exit();
    1663:	e8 b0 16 00 00       	call   2d18 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    1668:	c7 44 24 04 ec 38 00 	movl   $0x38ec,0x4(%esp)
    166f:	00 
    1670:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1677:	e8 04 18 00 00       	call   2e80 <printf>
    exit();
    167c:	e8 97 16 00 00       	call   2d18 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    1681:	c7 44 24 04 d0 38 00 	movl   $0x38d0,0x4(%esp)
    1688:	00 
    1689:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1690:	e8 eb 17 00 00       	call   2e80 <printf>
    exit();
    1695:	e8 7e 16 00 00       	call   2d18 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    169a:	c7 44 24 04 b4 38 00 	movl   $0x38b4,0x4(%esp)
    16a1:	00 
    16a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16a9:	e8 d2 17 00 00       	call   2e80 <printf>
    exit();
    16ae:	e8 65 16 00 00       	call   2d18 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    16b3:	c7 44 24 04 97 38 00 	movl   $0x3897,0x4(%esp)
    16ba:	00 
    16bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16c2:	e8 b9 17 00 00       	call   2e80 <printf>
    exit();
    16c7:	e8 4c 16 00 00       	call   2d18 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    16cc:	c7 44 24 04 7c 38 00 	movl   $0x387c,0x4(%esp)
    16d3:	00 
    16d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16db:	e8 a0 17 00 00       	call   2e80 <printf>
    exit();
    16e0:	e8 33 16 00 00       	call   2d18 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    16e5:	c7 44 24 04 a9 37 00 	movl   $0x37a9,0x4(%esp)
    16ec:	00 
    16ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16f4:	e8 87 17 00 00       	call   2e80 <printf>
    exit();
    16f9:	e8 1a 16 00 00       	call   2d18 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    16fe:	c7 44 24 04 91 37 00 	movl   $0x3791,0x4(%esp)
    1705:	00 
    1706:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    170d:	e8 6e 17 00 00       	call   2e80 <printf>
    exit();
    1712:	e8 01 16 00 00       	call   2d18 <exit>
    1717:	89 f6                	mov    %esi,%esi
    1719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001720 <concreate>:
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    1720:	55                   	push   %ebp
    1721:	89 e5                	mov    %esp,%ebp
    1723:	57                   	push   %edi
    1724:	56                   	push   %esi
    1725:	53                   	push   %ebx
    char name[14];
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
    1726:	31 db                	xor    %ebx,%ebx
}

// test concurrent create and unlink of the same file
void
concreate(void)
{
    1728:	83 ec 6c             	sub    $0x6c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    172b:	c7 44 24 04 63 39 00 	movl   $0x3963,0x4(%esp)
    1732:	00 
    1733:	8d 7d e5             	lea    -0x1b(%ebp),%edi
    1736:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    173d:	e8 3e 17 00 00       	call   2e80 <printf>
  file[0] = 'C';
    1742:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    1746:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    174a:	eb 4f                	jmp    179b <concreate+0x7b>
    174c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    1750:	b8 56 55 55 55       	mov    $0x55555556,%eax
    1755:	f7 eb                	imul   %ebx
    1757:	89 d8                	mov    %ebx,%eax
    1759:	c1 f8 1f             	sar    $0x1f,%eax
    175c:	29 c2                	sub    %eax,%edx
    175e:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1761:	89 da                	mov    %ebx,%edx
    1763:	29 c2                	sub    %eax,%edx
    1765:	83 fa 01             	cmp    $0x1,%edx
    1768:	74 7e                	je     17e8 <concreate+0xc8>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    176a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1771:	00 
    1772:	89 3c 24             	mov    %edi,(%esp)
    1775:	e8 de 15 00 00       	call   2d58 <open>
      if(fd < 0){
    177a:	85 c0                	test   %eax,%eax
    177c:	0f 88 db 01 00 00    	js     195d <concreate+0x23d>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    1782:	89 04 24             	mov    %eax,(%esp)
    1785:	e8 b6 15 00 00       	call   2d40 <close>
    }
    if(pid == 0)
    178a:	85 f6                	test   %esi,%esi
    178c:	74 52                	je     17e0 <concreate+0xc0>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    178e:	83 c3 01             	add    $0x1,%ebx
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    1791:	e8 8a 15 00 00       	call   2d20 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1796:	83 fb 28             	cmp    $0x28,%ebx
    1799:	74 6d                	je     1808 <concreate+0xe8>
    file[1] = '0' + i;
    179b:	8d 43 30             	lea    0x30(%ebx),%eax
    179e:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    17a1:	89 3c 24             	mov    %edi,(%esp)
    17a4:	e8 bf 15 00 00       	call   2d68 <unlink>
    pid = fork();
    17a9:	e8 62 15 00 00       	call   2d10 <fork>
    if(pid && (i % 3) == 1){
    17ae:	85 c0                	test   %eax,%eax
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    17b0:	89 c6                	mov    %eax,%esi
    if(pid && (i % 3) == 1){
    17b2:	75 9c                	jne    1750 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    17b4:	b8 67 66 66 66       	mov    $0x66666667,%eax
    17b9:	f7 eb                	imul   %ebx
    17bb:	89 d8                	mov    %ebx,%eax
    17bd:	c1 f8 1f             	sar    $0x1f,%eax
    17c0:	d1 fa                	sar    %edx
    17c2:	29 c2                	sub    %eax,%edx
    17c4:	8d 04 92             	lea    (%edx,%edx,4),%eax
    17c7:	89 da                	mov    %ebx,%edx
    17c9:	29 c2                	sub    %eax,%edx
    17cb:	83 fa 01             	cmp    $0x1,%edx
    17ce:	75 9a                	jne    176a <concreate+0x4a>
      link("C0", file);
    17d0:	89 7c 24 04          	mov    %edi,0x4(%esp)
    17d4:	c7 04 24 73 39 00 00 	movl   $0x3973,(%esp)
    17db:	e8 98 15 00 00       	call   2d78 <link>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
    17e0:	e8 33 15 00 00       	call   2d18 <exit>
    17e5:	8d 76 00             	lea    0x0(%esi),%esi
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    17e8:	83 c3 01             	add    $0x1,%ebx
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    17eb:	89 7c 24 04          	mov    %edi,0x4(%esp)
    17ef:	c7 04 24 73 39 00 00 	movl   $0x3973,(%esp)
    17f6:	e8 7d 15 00 00       	call   2d78 <link>
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    17fb:	e8 20 15 00 00       	call   2d20 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1800:	83 fb 28             	cmp    $0x28,%ebx
    1803:	75 96                	jne    179b <concreate+0x7b>
    1805:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1808:	8d 45 ac             	lea    -0x54(%ebp),%eax
    180b:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    1812:	00 
    1813:	8d 75 d4             	lea    -0x2c(%ebp),%esi
    1816:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    181d:	00 
    181e:	89 04 24             	mov    %eax,(%esp)
    1821:	e8 5a 13 00 00       	call   2b80 <memset>
  fd = open(".", 0);
    1826:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    182d:	00 
    182e:	c7 04 24 7c 37 00 00 	movl   $0x377c,(%esp)
    1835:	e8 1e 15 00 00       	call   2d58 <open>
    183a:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    1841:	89 c3                	mov    %eax,%ebx
    1843:	90                   	nop
    1844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1848:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    184f:	00 
    1850:	89 74 24 04          	mov    %esi,0x4(%esp)
    1854:	89 1c 24             	mov    %ebx,(%esp)
    1857:	e8 d4 14 00 00       	call   2d30 <read>
    185c:	85 c0                	test   %eax,%eax
    185e:	7e 40                	jle    18a0 <concreate+0x180>
    if(de.inum == 0)
    1860:	66 83 7d d4 00       	cmpw   $0x0,-0x2c(%ebp)
    1865:	74 e1                	je     1848 <concreate+0x128>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1867:	80 7d d6 43          	cmpb   $0x43,-0x2a(%ebp)
    186b:	90                   	nop
    186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1870:	75 d6                	jne    1848 <concreate+0x128>
    1872:	80 7d d8 00          	cmpb   $0x0,-0x28(%ebp)
    1876:	75 d0                	jne    1848 <concreate+0x128>
      i = de.name[1] - '0';
    1878:	0f be 45 d7          	movsbl -0x29(%ebp),%eax
    187c:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    187f:	83 f8 27             	cmp    $0x27,%eax
    1882:	0f 87 f2 00 00 00    	ja     197a <concreate+0x25a>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    1888:	80 7c 05 ac 00       	cmpb   $0x0,-0x54(%ebp,%eax,1)
    188d:	0f 85 20 01 00 00    	jne    19b3 <concreate+0x293>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    1893:	c6 44 05 ac 01       	movb   $0x1,-0x54(%ebp,%eax,1)
      n++;
    1898:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    189c:	eb aa                	jmp    1848 <concreate+0x128>
    189e:	66 90                	xchg   %ax,%ax
    }
  }
  close(fd);
    18a0:	89 1c 24             	mov    %ebx,(%esp)
    18a3:	e8 98 14 00 00       	call   2d40 <close>

  if(n != 40){
    18a8:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    18ac:	0f 85 e8 00 00 00    	jne    199a <concreate+0x27a>
    printf(1, "concreate not enough files in directory listing\n");
    exit();
    18b2:	31 db                	xor    %ebx,%ebx
    18b4:	eb 24                	jmp    18da <concreate+0x1ba>
    18b6:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    18b8:	85 f6                	test   %esi,%esi
    18ba:	74 4f                	je     190b <concreate+0x1eb>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
      close(fd);
    } else {
      unlink(file);
    18bc:	89 3c 24             	mov    %edi,(%esp)
    18bf:	90                   	nop
    18c0:	e8 a3 14 00 00       	call   2d68 <unlink>
    }
    if(pid == 0)
    18c5:	85 f6                	test   %esi,%esi
    18c7:	0f 84 13 ff ff ff    	je     17e0 <concreate+0xc0>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    18cd:	83 c3 01             	add    $0x1,%ebx
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    18d0:	e8 4b 14 00 00       	call   2d20 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    18d5:	83 fb 28             	cmp    $0x28,%ebx
    18d8:	74 4e                	je     1928 <concreate+0x208>
    file[1] = '0' + i;
    18da:	8d 43 30             	lea    0x30(%ebx),%eax
    18dd:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    18e0:	e8 2b 14 00 00       	call   2d10 <fork>
    if(pid < 0){
    18e5:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    18e7:	89 c6                	mov    %eax,%esi
    if(pid < 0){
    18e9:	78 59                	js     1944 <concreate+0x224>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    18eb:	b8 56 55 55 55       	mov    $0x55555556,%eax
    18f0:	f7 eb                	imul   %ebx
    18f2:	89 d8                	mov    %ebx,%eax
    18f4:	c1 f8 1f             	sar    $0x1f,%eax
    18f7:	29 c2                	sub    %eax,%edx
    18f9:	89 d8                	mov    %ebx,%eax
    18fb:	8d 14 52             	lea    (%edx,%edx,2),%edx
    18fe:	29 d0                	sub    %edx,%eax
    1900:	74 b6                	je     18b8 <concreate+0x198>
    1902:	83 f8 01             	cmp    $0x1,%eax
    1905:	75 b5                	jne    18bc <concreate+0x19c>
    1907:	85 f6                	test   %esi,%esi
    1909:	74 b1                	je     18bc <concreate+0x19c>
       ((i % 3) == 1 && pid != 0)){
      fd = open(file, 0);
    190b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1912:	00 
    1913:	89 3c 24             	mov    %edi,(%esp)
    1916:	e8 3d 14 00 00       	call   2d58 <open>
      close(fd);
    191b:	89 04 24             	mov    %eax,(%esp)
    191e:	e8 1d 14 00 00       	call   2d40 <close>
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1923:	eb a0                	jmp    18c5 <concreate+0x1a5>
    1925:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1928:	c7 44 24 04 c8 39 00 	movl   $0x39c8,0x4(%esp)
    192f:	00 
    1930:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1937:	e8 44 15 00 00       	call   2e80 <printf>
}
    193c:	83 c4 6c             	add    $0x6c,%esp
    193f:	5b                   	pop    %ebx
    1940:	5e                   	pop    %esi
    1941:	5f                   	pop    %edi
    1942:	5d                   	pop    %ebp
    1943:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1944:	c7 44 24 04 2c 32 00 	movl   $0x322c,0x4(%esp)
    194b:	00 
    194c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1953:	e8 28 15 00 00       	call   2e80 <printf>
      exit();
    1958:	e8 bb 13 00 00       	call   2d18 <exit>
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    195d:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1961:	c7 44 24 04 76 39 00 	movl   $0x3976,0x4(%esp)
    1968:	00 
    1969:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1970:	e8 0b 15 00 00       	call   2e80 <printf>
        exit();
    1975:	e8 9e 13 00 00       	call   2d18 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    197a:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    197d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1981:	c7 44 24 04 92 39 00 	movl   $0x3992,0x4(%esp)
    1988:	00 
    1989:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1990:	e8 eb 14 00 00       	call   2e80 <printf>
    1995:	e9 46 fe ff ff       	jmp    17e0 <concreate+0xc0>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    199a:	c7 44 24 04 44 42 00 	movl   $0x4244,0x4(%esp)
    19a1:	00 
    19a2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19a9:	e8 d2 14 00 00       	call   2e80 <printf>
    exit();
    19ae:	e8 65 13 00 00       	call   2d18 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    19b3:	8d 45 d6             	lea    -0x2a(%ebp),%eax
    19b6:	89 44 24 08          	mov    %eax,0x8(%esp)
    19ba:	c7 44 24 04 ab 39 00 	movl   $0x39ab,0x4(%esp)
    19c1:	00 
    19c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19c9:	e8 b2 14 00 00       	call   2e80 <printf>
        exit();
    19ce:	e8 45 13 00 00       	call   2d18 <exit>
    19d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    19d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000019e0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    19e0:	55                   	push   %ebp
    19e1:	89 e5                	mov    %esp,%ebp
    19e3:	53                   	push   %ebx
    19e4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    19e7:	c7 44 24 04 d6 39 00 	movl   $0x39d6,0x4(%esp)
    19ee:	00 
    19ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19f6:	e8 85 14 00 00       	call   2e80 <printf>

  unlink("lf1");
    19fb:	c7 04 24 e0 39 00 00 	movl   $0x39e0,(%esp)
    1a02:	e8 61 13 00 00       	call   2d68 <unlink>
  unlink("lf2");
    1a07:	c7 04 24 e4 39 00 00 	movl   $0x39e4,(%esp)
    1a0e:	e8 55 13 00 00       	call   2d68 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1a13:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1a1a:	00 
    1a1b:	c7 04 24 e0 39 00 00 	movl   $0x39e0,(%esp)
    1a22:	e8 31 13 00 00       	call   2d58 <open>
  if(fd < 0){
    1a27:	85 c0                	test   %eax,%eax
  printf(1, "linktest\n");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
    1a29:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1a2b:	0f 88 26 01 00 00    	js     1b57 <linktest+0x177>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1a31:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1a38:	00 
    1a39:	c7 44 24 04 fb 39 00 	movl   $0x39fb,0x4(%esp)
    1a40:	00 
    1a41:	89 04 24             	mov    %eax,(%esp)
    1a44:	e8 ef 12 00 00       	call   2d38 <write>
    1a49:	83 f8 05             	cmp    $0x5,%eax
    1a4c:	0f 85 cd 01 00 00    	jne    1c1f <linktest+0x23f>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1a52:	89 1c 24             	mov    %ebx,(%esp)
    1a55:	e8 e6 12 00 00       	call   2d40 <close>

  if(link("lf1", "lf2") < 0){
    1a5a:	c7 44 24 04 e4 39 00 	movl   $0x39e4,0x4(%esp)
    1a61:	00 
    1a62:	c7 04 24 e0 39 00 00 	movl   $0x39e0,(%esp)
    1a69:	e8 0a 13 00 00       	call   2d78 <link>
    1a6e:	85 c0                	test   %eax,%eax
    1a70:	0f 88 90 01 00 00    	js     1c06 <linktest+0x226>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    1a76:	c7 04 24 e0 39 00 00 	movl   $0x39e0,(%esp)
    1a7d:	e8 e6 12 00 00       	call   2d68 <unlink>

  if(open("lf1", 0) >= 0){
    1a82:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a89:	00 
    1a8a:	c7 04 24 e0 39 00 00 	movl   $0x39e0,(%esp)
    1a91:	e8 c2 12 00 00       	call   2d58 <open>
    1a96:	85 c0                	test   %eax,%eax
    1a98:	0f 89 4f 01 00 00    	jns    1bed <linktest+0x20d>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1a9e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1aa5:	00 
    1aa6:	c7 04 24 e4 39 00 00 	movl   $0x39e4,(%esp)
    1aad:	e8 a6 12 00 00       	call   2d58 <open>
  if(fd < 0){
    1ab2:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    1ab4:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ab6:	0f 88 18 01 00 00    	js     1bd4 <linktest+0x1f4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1abc:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1ac3:	00 
    1ac4:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    1acb:	00 
    1acc:	89 04 24             	mov    %eax,(%esp)
    1acf:	e8 5c 12 00 00       	call   2d30 <read>
    1ad4:	83 f8 05             	cmp    $0x5,%eax
    1ad7:	0f 85 de 00 00 00    	jne    1bbb <linktest+0x1db>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    1add:	89 1c 24             	mov    %ebx,(%esp)
    1ae0:	e8 5b 12 00 00       	call   2d40 <close>

  if(link("lf2", "lf2") >= 0){
    1ae5:	c7 44 24 04 e4 39 00 	movl   $0x39e4,0x4(%esp)
    1aec:	00 
    1aed:	c7 04 24 e4 39 00 00 	movl   $0x39e4,(%esp)
    1af4:	e8 7f 12 00 00       	call   2d78 <link>
    1af9:	85 c0                	test   %eax,%eax
    1afb:	0f 89 a1 00 00 00    	jns    1ba2 <linktest+0x1c2>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    1b01:	c7 04 24 e4 39 00 00 	movl   $0x39e4,(%esp)
    1b08:	e8 5b 12 00 00       	call   2d68 <unlink>
  if(link("lf2", "lf1") >= 0){
    1b0d:	c7 44 24 04 e0 39 00 	movl   $0x39e0,0x4(%esp)
    1b14:	00 
    1b15:	c7 04 24 e4 39 00 00 	movl   $0x39e4,(%esp)
    1b1c:	e8 57 12 00 00       	call   2d78 <link>
    1b21:	85 c0                	test   %eax,%eax
    1b23:	79 64                	jns    1b89 <linktest+0x1a9>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1b25:	c7 44 24 04 e0 39 00 	movl   $0x39e0,0x4(%esp)
    1b2c:	00 
    1b2d:	c7 04 24 7c 37 00 00 	movl   $0x377c,(%esp)
    1b34:	e8 3f 12 00 00       	call   2d78 <link>
    1b39:	85 c0                	test   %eax,%eax
    1b3b:	79 33                	jns    1b70 <linktest+0x190>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    1b3d:	c7 44 24 04 84 3a 00 	movl   $0x3a84,0x4(%esp)
    1b44:	00 
    1b45:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b4c:	e8 2f 13 00 00       	call   2e80 <printf>
}
    1b51:	83 c4 14             	add    $0x14,%esp
    1b54:	5b                   	pop    %ebx
    1b55:	5d                   	pop    %ebp
    1b56:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1b57:	c7 44 24 04 e8 39 00 	movl   $0x39e8,0x4(%esp)
    1b5e:	00 
    1b5f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b66:	e8 15 13 00 00       	call   2e80 <printf>
    exit();
    1b6b:	e8 a8 11 00 00       	call   2d18 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1b70:	c7 44 24 04 68 3a 00 	movl   $0x3a68,0x4(%esp)
    1b77:	00 
    1b78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b7f:	e8 fc 12 00 00       	call   2e80 <printf>
    exit();
    1b84:	e8 8f 11 00 00       	call   2d18 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    1b89:	c7 44 24 04 a0 42 00 	movl   $0x42a0,0x4(%esp)
    1b90:	00 
    1b91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b98:	e8 e3 12 00 00       	call   2e80 <printf>
    exit();
    1b9d:	e8 76 11 00 00       	call   2d18 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1ba2:	c7 44 24 04 4a 3a 00 	movl   $0x3a4a,0x4(%esp)
    1ba9:	00 
    1baa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bb1:	e8 ca 12 00 00       	call   2e80 <printf>
    exit();
    1bb6:	e8 5d 11 00 00       	call   2d18 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    1bbb:	c7 44 24 04 39 3a 00 	movl   $0x3a39,0x4(%esp)
    1bc2:	00 
    1bc3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bca:	e8 b1 12 00 00       	call   2e80 <printf>
    exit();
    1bcf:	e8 44 11 00 00       	call   2d18 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    1bd4:	c7 44 24 04 28 3a 00 	movl   $0x3a28,0x4(%esp)
    1bdb:	00 
    1bdc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1be3:	e8 98 12 00 00       	call   2e80 <printf>
    exit();
    1be8:	e8 2b 11 00 00       	call   2d18 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    1bed:	c7 44 24 04 78 42 00 	movl   $0x4278,0x4(%esp)
    1bf4:	00 
    1bf5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bfc:	e8 7f 12 00 00       	call   2e80 <printf>
    exit();
    1c01:	e8 12 11 00 00       	call   2d18 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    1c06:	c7 44 24 04 13 3a 00 	movl   $0x3a13,0x4(%esp)
    1c0d:	00 
    1c0e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c15:	e8 66 12 00 00       	call   2e80 <printf>
    exit();
    1c1a:	e8 f9 10 00 00       	call   2d18 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    1c1f:	c7 44 24 04 01 3a 00 	movl   $0x3a01,0x4(%esp)
    1c26:	00 
    1c27:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c2e:	e8 4d 12 00 00       	call   2e80 <printf>
    exit();
    1c33:	e8 e0 10 00 00       	call   2d18 <exit>
    1c38:	90                   	nop
    1c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001c40 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1c40:	55                   	push   %ebp
    1c41:	89 e5                	mov    %esp,%ebp
    1c43:	56                   	push   %esi
    1c44:	53                   	push   %ebx
    1c45:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1c48:	c7 44 24 04 91 3a 00 	movl   $0x3a91,0x4(%esp)
    1c4f:	00 
    1c50:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c57:	e8 24 12 00 00       	call   2e80 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1c5c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1c63:	00 
    1c64:	c7 04 24 a2 3a 00 00 	movl   $0x3aa2,(%esp)
    1c6b:	e8 e8 10 00 00       	call   2d58 <open>
  if(fd < 0){
    1c70:	85 c0                	test   %eax,%eax
unlinkread(void)
{
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1c72:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1c74:	0f 88 fe 00 00 00    	js     1d78 <unlinkread+0x138>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    1c7a:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1c81:	00 
    1c82:	c7 44 24 04 fb 39 00 	movl   $0x39fb,0x4(%esp)
    1c89:	00 
    1c8a:	89 04 24             	mov    %eax,(%esp)
    1c8d:	e8 a6 10 00 00       	call   2d38 <write>
  close(fd);
    1c92:	89 1c 24             	mov    %ebx,(%esp)
    1c95:	e8 a6 10 00 00       	call   2d40 <close>

  fd = open("unlinkread", O_RDWR);
    1c9a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1ca1:	00 
    1ca2:	c7 04 24 a2 3a 00 00 	movl   $0x3aa2,(%esp)
    1ca9:	e8 aa 10 00 00       	call   2d58 <open>
  if(fd < 0){
    1cae:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    1cb0:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1cb2:	0f 88 3d 01 00 00    	js     1df5 <unlinkread+0x1b5>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1cb8:	c7 04 24 a2 3a 00 00 	movl   $0x3aa2,(%esp)
    1cbf:	e8 a4 10 00 00       	call   2d68 <unlink>
    1cc4:	85 c0                	test   %eax,%eax
    1cc6:	0f 85 10 01 00 00    	jne    1ddc <unlinkread+0x19c>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1ccc:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1cd3:	00 
    1cd4:	c7 04 24 a2 3a 00 00 	movl   $0x3aa2,(%esp)
    1cdb:	e8 78 10 00 00       	call   2d58 <open>
  write(fd1, "yyy", 3);
    1ce0:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    1ce7:	00 
    1ce8:	c7 44 24 04 f9 3a 00 	movl   $0x3af9,0x4(%esp)
    1cef:	00 
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1cf0:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1cf2:	89 04 24             	mov    %eax,(%esp)
    1cf5:	e8 3e 10 00 00       	call   2d38 <write>
  close(fd1);
    1cfa:	89 34 24             	mov    %esi,(%esp)
    1cfd:	e8 3e 10 00 00       	call   2d40 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    1d02:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1d09:	00 
    1d0a:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    1d11:	00 
    1d12:	89 1c 24             	mov    %ebx,(%esp)
    1d15:	e8 16 10 00 00       	call   2d30 <read>
    1d1a:	83 f8 05             	cmp    $0x5,%eax
    1d1d:	0f 85 a0 00 00 00    	jne    1dc3 <unlinkread+0x183>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    1d23:	80 3d 40 44 00 00 68 	cmpb   $0x68,0x4440
    1d2a:	75 7e                	jne    1daa <unlinkread+0x16a>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    1d2c:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1d33:	00 
    1d34:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    1d3b:	00 
    1d3c:	89 1c 24             	mov    %ebx,(%esp)
    1d3f:	e8 f4 0f 00 00       	call   2d38 <write>
    1d44:	83 f8 0a             	cmp    $0xa,%eax
    1d47:	75 48                	jne    1d91 <unlinkread+0x151>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    1d49:	89 1c 24             	mov    %ebx,(%esp)
    1d4c:	e8 ef 0f 00 00       	call   2d40 <close>
  unlink("unlinkread");
    1d51:	c7 04 24 a2 3a 00 00 	movl   $0x3aa2,(%esp)
    1d58:	e8 0b 10 00 00       	call   2d68 <unlink>
  printf(1, "unlinkread ok\n");
    1d5d:	c7 44 24 04 44 3b 00 	movl   $0x3b44,0x4(%esp)
    1d64:	00 
    1d65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d6c:	e8 0f 11 00 00       	call   2e80 <printf>
}
    1d71:	83 c4 10             	add    $0x10,%esp
    1d74:	5b                   	pop    %ebx
    1d75:	5e                   	pop    %esi
    1d76:	5d                   	pop    %ebp
    1d77:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1d78:	c7 44 24 04 ad 3a 00 	movl   $0x3aad,0x4(%esp)
    1d7f:	00 
    1d80:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d87:	e8 f4 10 00 00       	call   2e80 <printf>
    exit();
    1d8c:	e8 87 0f 00 00       	call   2d18 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1d91:	c7 44 24 04 2b 3b 00 	movl   $0x3b2b,0x4(%esp)
    1d98:	00 
    1d99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1da0:	e8 db 10 00 00       	call   2e80 <printf>
    exit();
    1da5:	e8 6e 0f 00 00       	call   2d18 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    1daa:	c7 44 24 04 14 3b 00 	movl   $0x3b14,0x4(%esp)
    1db1:	00 
    1db2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1db9:	e8 c2 10 00 00       	call   2e80 <printf>
    exit();
    1dbe:	e8 55 0f 00 00       	call   2d18 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    1dc3:	c7 44 24 04 fd 3a 00 	movl   $0x3afd,0x4(%esp)
    1dca:	00 
    1dcb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dd2:	e8 a9 10 00 00       	call   2e80 <printf>
    exit();
    1dd7:	e8 3c 0f 00 00       	call   2d18 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    1ddc:	c7 44 24 04 df 3a 00 	movl   $0x3adf,0x4(%esp)
    1de3:	00 
    1de4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1deb:	e8 90 10 00 00       	call   2e80 <printf>
    exit();
    1df0:	e8 23 0f 00 00       	call   2d18 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    1df5:	c7 44 24 04 c7 3a 00 	movl   $0x3ac7,0x4(%esp)
    1dfc:	00 
    1dfd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e04:	e8 77 10 00 00       	call   2e80 <printf>
    exit();
    1e09:	e8 0a 0f 00 00       	call   2d18 <exit>
    1e0e:	66 90                	xchg   %ax,%ax

00001e10 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
    1e10:	55                   	push   %ebp
    1e11:	89 e5                	mov    %esp,%ebp
    1e13:	57                   	push   %edi
    1e14:	56                   	push   %esi
    1e15:	53                   	push   %ebx
    1e16:	83 ec 2c             	sub    $0x2c,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
    1e19:	c7 44 24 04 53 3b 00 	movl   $0x3b53,0x4(%esp)
    1e20:	00 
    1e21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e28:	e8 53 10 00 00       	call   2e80 <printf>

  unlink("f1");
    1e2d:	c7 04 24 e1 39 00 00 	movl   $0x39e1,(%esp)
    1e34:	e8 2f 0f 00 00       	call   2d68 <unlink>
  unlink("f2");
    1e39:	c7 04 24 e5 39 00 00 	movl   $0x39e5,(%esp)
    1e40:	e8 23 0f 00 00       	call   2d68 <unlink>

  pid = fork();
    1e45:	e8 c6 0e 00 00       	call   2d10 <fork>
  if(pid < 0){
    1e4a:	83 f8 00             	cmp    $0x0,%eax
  printf(1, "twofiles test\n");

  unlink("f1");
  unlink("f2");

  pid = fork();
    1e4d:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    1e4f:	0f 8c 64 01 00 00    	jl     1fb9 <twofiles+0x1a9>
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
    1e55:	b8 e1 39 00 00       	mov    $0x39e1,%eax
    1e5a:	75 05                	jne    1e61 <twofiles+0x51>
    1e5c:	b8 e5 39 00 00       	mov    $0x39e5,%eax
  fd = open(fname, O_CREATE | O_RDWR);
    1e61:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1e68:	00 
    1e69:	89 04 24             	mov    %eax,(%esp)
    1e6c:	e8 e7 0e 00 00       	call   2d58 <open>
  if(fd < 0){
    1e71:	85 c0                	test   %eax,%eax
    printf(1, "fork failed\n");
    return;
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
    1e73:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    1e75:	0f 88 8e 01 00 00    	js     2009 <twofiles+0x1f9>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
    1e7b:	83 ff 01             	cmp    $0x1,%edi
    1e7e:	19 c0                	sbb    %eax,%eax
    1e80:	31 db                	xor    %ebx,%ebx
    1e82:	83 e0 f3             	and    $0xfffffff3,%eax
    1e85:	83 c0 70             	add    $0x70,%eax
    1e88:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1e8f:	00 
    1e90:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e94:	c7 04 24 40 44 00 00 	movl   $0x4440,(%esp)
    1e9b:	e8 e0 0c 00 00       	call   2b80 <memset>
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
    1ea0:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    1ea7:	00 
    1ea8:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    1eaf:	00 
    1eb0:	89 34 24             	mov    %esi,(%esp)
    1eb3:	e8 80 0e 00 00       	call   2d38 <write>
    1eb8:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1ebd:	0f 85 29 01 00 00    	jne    1fec <twofiles+0x1dc>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    1ec3:	83 c3 01             	add    $0x1,%ebx
    1ec6:	83 fb 0c             	cmp    $0xc,%ebx
    1ec9:	75 d5                	jne    1ea0 <twofiles+0x90>
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
      exit();
    }
  }
  close(fd);
    1ecb:	89 34 24             	mov    %esi,(%esp)
    1ece:	e8 6d 0e 00 00       	call   2d40 <close>
  if(pid)
    1ed3:	85 ff                	test   %edi,%edi
    1ed5:	0f 84 d9 00 00 00    	je     1fb4 <twofiles+0x1a4>
    wait();
    1edb:	e8 40 0e 00 00       	call   2d20 <wait>
    1ee0:	30 db                	xor    %bl,%bl
    1ee2:	b8 e5 39 00 00       	mov    $0x39e5,%eax
  else
    exit();

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    1ee7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1eee:	00 
    1eef:	31 f6                	xor    %esi,%esi
    1ef1:	89 04 24             	mov    %eax,(%esp)
    1ef4:	e8 5f 0e 00 00       	call   2d58 <open>
    1ef9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1f00:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f03:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    1f0a:	00 
    1f0b:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    1f12:	00 
    1f13:	89 04 24             	mov    %eax,(%esp)
    1f16:	e8 15 0e 00 00       	call   2d30 <read>
    1f1b:	85 c0                	test   %eax,%eax
    1f1d:	7e 2a                	jle    1f49 <twofiles+0x139>
    1f1f:	31 c9                	xor    %ecx,%ecx
    1f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
    1f28:	83 fb 01             	cmp    $0x1,%ebx
    1f2b:	0f be b9 40 44 00 00 	movsbl 0x4440(%ecx),%edi
    1f32:	19 d2                	sbb    %edx,%edx
    1f34:	83 e2 f3             	and    $0xfffffff3,%edx
    1f37:	83 c2 70             	add    $0x70,%edx
    1f3a:	39 d7                	cmp    %edx,%edi
    1f3c:	75 62                	jne    1fa0 <twofiles+0x190>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    1f3e:	83 c1 01             	add    $0x1,%ecx
    1f41:	39 c8                	cmp    %ecx,%eax
    1f43:	7f e3                	jg     1f28 <twofiles+0x118>
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    1f45:	01 c6                	add    %eax,%esi
    1f47:	eb b7                	jmp    1f00 <twofiles+0xf0>
    }
    close(fd);
    1f49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1f4c:	89 04 24             	mov    %eax,(%esp)
    1f4f:	e8 ec 0d 00 00       	call   2d40 <close>
    if(total != 12*500){
    1f54:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
    1f5a:	75 73                	jne    1fcf <twofiles+0x1bf>
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
    1f5c:	83 fb 01             	cmp    $0x1,%ebx
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
      exit();
    1f5f:	b8 e1 39 00 00       	mov    $0x39e1,%eax
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
    1f64:	75 30                	jne    1f96 <twofiles+0x186>
      printf(1, "wrong length %d\n", total);
      exit();
    }
  }

  unlink("f1");
    1f66:	89 04 24             	mov    %eax,(%esp)
    1f69:	e8 fa 0d 00 00       	call   2d68 <unlink>
  unlink("f2");
    1f6e:	c7 04 24 e5 39 00 00 	movl   $0x39e5,(%esp)
    1f75:	e8 ee 0d 00 00       	call   2d68 <unlink>

  printf(1, "twofiles ok\n");
    1f7a:	c7 44 24 04 90 3b 00 	movl   $0x3b90,0x4(%esp)
    1f81:	00 
    1f82:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f89:	e8 f2 0e 00 00       	call   2e80 <printf>
}
    1f8e:	83 c4 2c             	add    $0x2c,%esp
    1f91:	5b                   	pop    %ebx
    1f92:	5e                   	pop    %esi
    1f93:	5f                   	pop    %edi
    1f94:	5d                   	pop    %ebp
    1f95:	c3                   	ret    
  }
  close(fd);
  if(pid)
    wait();
  else
    exit();
    1f96:	bb 01 00 00 00       	mov    $0x1,%ebx
    1f9b:	e9 47 ff ff ff       	jmp    1ee7 <twofiles+0xd7>
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
    1fa0:	c7 44 24 04 73 3b 00 	movl   $0x3b73,0x4(%esp)
    1fa7:	00 
    1fa8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1faf:	e8 cc 0e 00 00       	call   2e80 <printf>
          exit();
    1fb4:	e8 5f 0d 00 00       	call   2d18 <exit>
  unlink("f1");
  unlink("f2");

  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    1fb9:	c7 44 24 04 2c 32 00 	movl   $0x322c,0x4(%esp)
    1fc0:	00 
    1fc1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fc8:	e8 b3 0e 00 00       	call   2e80 <printf>
    return;
    1fcd:	eb bf                	jmp    1f8e <twofiles+0x17e>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    1fcf:	89 74 24 08          	mov    %esi,0x8(%esp)
    1fd3:	c7 44 24 04 7f 3b 00 	movl   $0x3b7f,0x4(%esp)
    1fda:	00 
    1fdb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fe2:	e8 99 0e 00 00       	call   2e80 <printf>
      exit();
    1fe7:	e8 2c 0d 00 00       	call   2d18 <exit>
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
    1fec:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ff0:	c7 44 24 04 62 3b 00 	movl   $0x3b62,0x4(%esp)
    1ff7:	00 
    1ff8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1fff:	e8 7c 0e 00 00       	call   2e80 <printf>
      exit();
    2004:	e8 0f 0d 00 00       	call   2d18 <exit>
  }

  fname = pid ? "f1" : "f2";
  fd = open(fname, O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create failed\n");
    2009:	c7 44 24 04 e1 33 00 	movl   $0x33e1,0x4(%esp)
    2010:	00 
    2011:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2018:	e8 63 0e 00 00       	call   2e80 <printf>
    exit();
    201d:	e8 f6 0c 00 00       	call   2d18 <exit>
    2022:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002030 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    2030:	55                   	push   %ebp
    2031:	89 e5                	mov    %esp,%ebp
    2033:	57                   	push   %edi
    2034:	56                   	push   %esi
    2035:	53                   	push   %ebx
    2036:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
    2039:	c7 04 24 9d 3b 00 00 	movl   $0x3b9d,(%esp)
    2040:	e8 23 0d 00 00       	call   2d68 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2045:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    204c:	00 
    204d:	c7 04 24 9d 3b 00 00 	movl   $0x3b9d,(%esp)
    2054:	e8 ff 0c 00 00       	call   2d58 <open>
  if(fd < 0){
    2059:	85 c0                	test   %eax,%eax
{
  int fd, pid, i, n, nc, np;
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
    205b:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    205d:	0f 88 55 01 00 00    	js     21b8 <sharedfd+0x188>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    2063:	e8 a8 0c 00 00       	call   2d10 <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2068:	8d 75 de             	lea    -0x22(%ebp),%esi
    206b:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
    206e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2071:	19 c0                	sbb    %eax,%eax
    2073:	31 db                	xor    %ebx,%ebx
    2075:	83 e0 f3             	and    $0xfffffff3,%eax
    2078:	83 c0 70             	add    $0x70,%eax
    207b:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2082:	00 
    2083:	89 44 24 04          	mov    %eax,0x4(%esp)
    2087:	89 34 24             	mov    %esi,(%esp)
    208a:	e8 f1 0a 00 00       	call   2b80 <memset>
    208f:	eb 12                	jmp    20a3 <sharedfd+0x73>
    2091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 1000; i++){
    2098:	83 c3 01             	add    $0x1,%ebx
    209b:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    20a1:	74 2d                	je     20d0 <sharedfd+0xa0>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    20a3:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    20aa:	00 
    20ab:	89 74 24 04          	mov    %esi,0x4(%esp)
    20af:	89 3c 24             	mov    %edi,(%esp)
    20b2:	e8 81 0c 00 00       	call   2d38 <write>
    20b7:	83 f8 0a             	cmp    $0xa,%eax
    20ba:	74 dc                	je     2098 <sharedfd+0x68>
      printf(1, "fstests: write sharedfd failed\n");
    20bc:	c7 44 24 04 f0 42 00 	movl   $0x42f0,0x4(%esp)
    20c3:	00 
    20c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    20cb:	e8 b0 0d 00 00       	call   2e80 <printf>
      break;
    }
  }
  if(pid == 0)
    20d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    20d3:	85 d2                	test   %edx,%edx
    20d5:	0f 84 0f 01 00 00    	je     21ea <sharedfd+0x1ba>
    exit();
  else
    wait();
    20db:	e8 40 0c 00 00       	call   2d20 <wait>
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    20e0:	31 db                	xor    %ebx,%ebx
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
    20e2:	89 3c 24             	mov    %edi,(%esp)
  fd = open("sharedfd", 0);
  if(fd < 0){
    20e5:	31 ff                	xor    %edi,%edi
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
    20e7:	e8 54 0c 00 00       	call   2d40 <close>
  fd = open("sharedfd", 0);
    20ec:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    20f3:	00 
    20f4:	c7 04 24 9d 3b 00 00 	movl   $0x3b9d,(%esp)
    20fb:	e8 58 0c 00 00       	call   2d58 <open>
  if(fd < 0){
    2100:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
    2102:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
    2105:	0f 88 c9 00 00 00    	js     21d4 <sharedfd+0x1a4>
    210b:	90                   	nop
    210c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2110:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2117:	00 
    2118:	89 74 24 04          	mov    %esi,0x4(%esp)
    211c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    211f:	89 04 24             	mov    %eax,(%esp)
    2122:	e8 09 0c 00 00       	call   2d30 <read>
    2127:	85 c0                	test   %eax,%eax
    2129:	7e 26                	jle    2151 <sharedfd+0x121>
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
    212b:	31 c0                	xor    %eax,%eax
    212d:	eb 14                	jmp    2143 <sharedfd+0x113>
    212f:	90                   	nop
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    2130:	80 fa 70             	cmp    $0x70,%dl
    2133:	0f 94 c2             	sete   %dl
    2136:	0f b6 d2             	movzbl %dl,%edx
    2139:	01 d3                	add    %edx,%ebx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    213b:	83 c0 01             	add    $0x1,%eax
    213e:	83 f8 0a             	cmp    $0xa,%eax
    2141:	74 cd                	je     2110 <sharedfd+0xe0>
      if(buf[i] == 'c')
    2143:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
    2147:	80 fa 63             	cmp    $0x63,%dl
    214a:	75 e4                	jne    2130 <sharedfd+0x100>
        nc++;
    214c:	83 c7 01             	add    $0x1,%edi
    214f:	eb ea                	jmp    213b <sharedfd+0x10b>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    2151:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2154:	89 04 24             	mov    %eax,(%esp)
    2157:	e8 e4 0b 00 00       	call   2d40 <close>
  unlink("sharedfd");
    215c:	c7 04 24 9d 3b 00 00 	movl   $0x3b9d,(%esp)
    2163:	e8 00 0c 00 00       	call   2d68 <unlink>
  if(nc == 10000 && np == 10000)
    2168:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    216e:	74 24                	je     2194 <sharedfd+0x164>
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
    2170:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    2174:	89 7c 24 08          	mov    %edi,0x8(%esp)
    2178:	c7 44 24 04 b3 3b 00 	movl   $0x3bb3,0x4(%esp)
    217f:	00 
    2180:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2187:	e8 f4 0c 00 00       	call   2e80 <printf>
}
    218c:	83 c4 3c             	add    $0x3c,%esp
    218f:	5b                   	pop    %ebx
    2190:	5e                   	pop    %esi
    2191:	5f                   	pop    %edi
    2192:	5d                   	pop    %ebp
    2193:	c3                   	ret    
        np++;
    }
  }
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    2194:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
    219a:	75 d4                	jne    2170 <sharedfd+0x140>
    printf(1, "sharedfd ok\n");
    219c:	c7 44 24 04 a6 3b 00 	movl   $0x3ba6,0x4(%esp)
    21a3:	00 
    21a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21ab:	e8 d0 0c 00 00       	call   2e80 <printf>
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    21b0:	83 c4 3c             	add    $0x3c,%esp
    21b3:	5b                   	pop    %ebx
    21b4:	5e                   	pop    %esi
    21b5:	5f                   	pop    %edi
    21b6:	5d                   	pop    %ebp
    21b7:	c3                   	ret    
  char buf[10];

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    21b8:	c7 44 24 04 c4 42 00 	movl   $0x42c4,0x4(%esp)
    21bf:	00 
    21c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21c7:	e8 b4 0c 00 00       	call   2e80 <printf>
  unlink("sharedfd");
  if(nc == 10000 && np == 10000)
    printf(1, "sharedfd ok\n");
  else
    printf(1, "sharedfd oops %d %d\n", nc, np);
}
    21cc:	83 c4 3c             	add    $0x3c,%esp
    21cf:	5b                   	pop    %ebx
    21d0:	5e                   	pop    %esi
    21d1:	5f                   	pop    %edi
    21d2:	5d                   	pop    %ebp
    21d3:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    21d4:	c7 44 24 04 10 43 00 	movl   $0x4310,0x4(%esp)
    21db:	00 
    21dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21e3:	e8 98 0c 00 00       	call   2e80 <printf>
    return;
    21e8:	eb a2                	jmp    218c <sharedfd+0x15c>
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
    exit();
    21ea:	e8 29 0b 00 00       	call   2d18 <exit>
    21ef:	90                   	nop

000021f0 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
    21f0:	55                   	push   %ebp
    21f1:	89 e5                	mov    %esp,%ebp
    21f3:	56                   	push   %esi
    21f4:	53                   	push   %ebx
    21f5:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
    21f8:	a1 08 44 00 00       	mov    0x4408,%eax
    21fd:	c7 44 24 04 c8 3b 00 	movl   $0x3bc8,0x4(%esp)
    2204:	00 
    2205:	89 04 24             	mov    %eax,(%esp)
    2208:	e8 73 0c 00 00       	call   2e80 <printf>

  fd = open("big", O_CREATE|O_RDWR);
    220d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2214:	00 
    2215:	c7 04 24 42 3c 00 00 	movl   $0x3c42,(%esp)
    221c:	e8 37 0b 00 00       	call   2d58 <open>
  if(fd < 0){
    2221:	85 c0                	test   %eax,%eax
{
  int i, fd, n;

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
    2223:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2225:	0f 88 7a 01 00 00    	js     23a5 <writetest1+0x1b5>
    printf(stdout, "error: creat big failed!\n");
    exit();
    222b:	31 db                	xor    %ebx,%ebx
    222d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  for(i = 0; i < MAXFILE; i++) {
    ((int*) buf)[0] = i;
    2230:	89 1d 40 44 00 00    	mov    %ebx,0x4440
    if(write(fd, buf, 512) != 512) {
    2236:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    223d:	00 
    223e:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    2245:	00 
    2246:	89 34 24             	mov    %esi,(%esp)
    2249:	e8 ea 0a 00 00       	call   2d38 <write>
    224e:	3d 00 02 00 00       	cmp    $0x200,%eax
    2253:	0f 85 b2 00 00 00    	jne    230b <writetest1+0x11b>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++) {
    2259:	83 c3 01             	add    $0x1,%ebx
    225c:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
    2262:	75 cc                	jne    2230 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
    2264:	89 34 24             	mov    %esi,(%esp)
    2267:	e8 d4 0a 00 00       	call   2d40 <close>

  fd = open("big", O_RDONLY);
    226c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2273:	00 
    2274:	c7 04 24 42 3c 00 00 	movl   $0x3c42,(%esp)
    227b:	e8 d8 0a 00 00       	call   2d58 <open>
  if(fd < 0){
    2280:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
    2282:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2284:	0f 88 01 01 00 00    	js     238b <writetest1+0x19b>
    printf(stdout, "error: open big failed!\n");
    exit();
    228a:	31 db                	xor    %ebx,%ebx
    228c:	eb 1d                	jmp    22ab <writetest1+0xbb>
    228e:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
    2290:	3d 00 02 00 00       	cmp    $0x200,%eax
    2295:	0f 85 b0 00 00 00    	jne    234b <writetest1+0x15b>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
    229b:	a1 40 44 00 00       	mov    0x4440,%eax
    22a0:	39 d8                	cmp    %ebx,%eax
    22a2:	0f 85 81 00 00 00    	jne    2329 <writetest1+0x139>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
    22a8:	83 c3 01             	add    $0x1,%ebx
    exit();
  }

  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    22ab:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    22b2:	00 
    22b3:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    22ba:	00 
    22bb:	89 34 24             	mov    %esi,(%esp)
    22be:	e8 6d 0a 00 00       	call   2d30 <read>
    if(i == 0) {
    22c3:	85 c0                	test   %eax,%eax
    22c5:	75 c9                	jne    2290 <writetest1+0xa0>
      if(n == MAXFILE - 1) {
    22c7:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
    22cd:	0f 84 96 00 00 00    	je     2369 <writetest1+0x179>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
    22d3:	89 34 24             	mov    %esi,(%esp)
    22d6:	e8 65 0a 00 00       	call   2d40 <close>
  if(unlink("big") < 0) {
    22db:	c7 04 24 42 3c 00 00 	movl   $0x3c42,(%esp)
    22e2:	e8 81 0a 00 00       	call   2d68 <unlink>
    22e7:	85 c0                	test   %eax,%eax
    22e9:	0f 88 d0 00 00 00    	js     23bf <writetest1+0x1cf>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
    22ef:	a1 08 44 00 00       	mov    0x4408,%eax
    22f4:	c7 44 24 04 69 3c 00 	movl   $0x3c69,0x4(%esp)
    22fb:	00 
    22fc:	89 04 24             	mov    %eax,(%esp)
    22ff:	e8 7c 0b 00 00       	call   2e80 <printf>
}
    2304:	83 c4 10             	add    $0x10,%esp
    2307:	5b                   	pop    %ebx
    2308:	5e                   	pop    %esi
    2309:	5d                   	pop    %ebp
    230a:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++) {
    ((int*) buf)[0] = i;
    if(write(fd, buf, 512) != 512) {
      printf(stdout, "error: write big file failed\n", i);
    230b:	a1 08 44 00 00       	mov    0x4408,%eax
    2310:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2314:	c7 44 24 04 f2 3b 00 	movl   $0x3bf2,0x4(%esp)
    231b:	00 
    231c:	89 04 24             	mov    %eax,(%esp)
    231f:	e8 5c 0b 00 00       	call   2e80 <printf>
      exit();
    2324:	e8 ef 09 00 00       	call   2d18 <exit>
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n) {
      printf(stdout, "read content of block %d is %d\n",
    2329:	89 44 24 0c          	mov    %eax,0xc(%esp)
    232d:	a1 08 44 00 00       	mov    0x4408,%eax
    2332:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2336:	c7 44 24 04 3c 43 00 	movl   $0x433c,0x4(%esp)
    233d:	00 
    233e:	89 04 24             	mov    %eax,(%esp)
    2341:	e8 3a 0b 00 00       	call   2e80 <printf>
             n, ((int*)buf)[0]);
      exit();
    2346:	e8 cd 09 00 00       	call   2d18 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512) {
      printf(stdout, "read failed %d\n", i);
    234b:	89 44 24 08          	mov    %eax,0x8(%esp)
    234f:	a1 08 44 00 00       	mov    0x4408,%eax
    2354:	c7 44 24 04 46 3c 00 	movl   $0x3c46,0x4(%esp)
    235b:	00 
    235c:	89 04 24             	mov    %eax,(%esp)
    235f:	e8 1c 0b 00 00       	call   2e80 <printf>
      exit();
    2364:	e8 af 09 00 00       	call   2d18 <exit>
  n = 0;
  for(;;) {
    i = read(fd, buf, 512);
    if(i == 0) {
      if(n == MAXFILE - 1) {
        printf(stdout, "read only %d blocks from big", n);
    2369:	a1 08 44 00 00       	mov    0x4408,%eax
    236e:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
    2375:	00 
    2376:	c7 44 24 04 29 3c 00 	movl   $0x3c29,0x4(%esp)
    237d:	00 
    237e:	89 04 24             	mov    %eax,(%esp)
    2381:	e8 fa 0a 00 00       	call   2e80 <printf>
        exit();
    2386:	e8 8d 09 00 00       	call   2d18 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
    238b:	a1 08 44 00 00       	mov    0x4408,%eax
    2390:	c7 44 24 04 10 3c 00 	movl   $0x3c10,0x4(%esp)
    2397:	00 
    2398:	89 04 24             	mov    %eax,(%esp)
    239b:	e8 e0 0a 00 00       	call   2e80 <printf>
    exit();
    23a0:	e8 73 09 00 00       	call   2d18 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    23a5:	a1 08 44 00 00       	mov    0x4408,%eax
    23aa:	c7 44 24 04 d8 3b 00 	movl   $0x3bd8,0x4(%esp)
    23b1:	00 
    23b2:	89 04 24             	mov    %eax,(%esp)
    23b5:	e8 c6 0a 00 00       	call   2e80 <printf>
    exit();
    23ba:	e8 59 09 00 00       	call   2d18 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0) {
    printf(stdout, "unlink big failed\n");
    23bf:	a1 08 44 00 00       	mov    0x4408,%eax
    23c4:	c7 44 24 04 56 3c 00 	movl   $0x3c56,0x4(%esp)
    23cb:	00 
    23cc:	89 04 24             	mov    %eax,(%esp)
    23cf:	e8 ac 0a 00 00       	call   2e80 <printf>
    exit();
    23d4:	e8 3f 09 00 00       	call   2d18 <exit>
    23d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000023e0 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
    23e0:	55                   	push   %ebp
    23e1:	89 e5                	mov    %esp,%ebp
    23e3:	56                   	push   %esi
    23e4:	53                   	push   %ebx
    23e5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
    23e8:	a1 08 44 00 00       	mov    0x4408,%eax
    23ed:	c7 44 24 04 77 3c 00 	movl   $0x3c77,0x4(%esp)
    23f4:	00 
    23f5:	89 04 24             	mov    %eax,(%esp)
    23f8:	e8 83 0a 00 00       	call   2e80 <printf>
  fd = open("small", O_CREATE|O_RDWR);
    23fd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2404:	00 
    2405:	c7 04 24 88 3c 00 00 	movl   $0x3c88,(%esp)
    240c:	e8 47 09 00 00       	call   2d58 <open>
  if(fd >= 0){
    2411:	85 c0                	test   %eax,%eax
{
  int fd;
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
    2413:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
    2415:	0f 88 b1 01 00 00    	js     25cc <writetest+0x1ec>
    printf(stdout, "creat small succeeded; ok\n");
    241b:	a1 08 44 00 00       	mov    0x4408,%eax
    2420:	31 db                	xor    %ebx,%ebx
    2422:	c7 44 24 04 8e 3c 00 	movl   $0x3c8e,0x4(%esp)
    2429:	00 
    242a:	89 04 24             	mov    %eax,(%esp)
    242d:	e8 4e 0a 00 00       	call   2e80 <printf>
    2432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
    2438:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    243f:	00 
    2440:	c7 44 24 04 c5 3c 00 	movl   $0x3cc5,0x4(%esp)
    2447:	00 
    2448:	89 34 24             	mov    %esi,(%esp)
    244b:	e8 e8 08 00 00       	call   2d38 <write>
    2450:	83 f8 0a             	cmp    $0xa,%eax
    2453:	0f 85 e9 00 00 00    	jne    2542 <writetest+0x162>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
    2459:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    2460:	00 
    2461:	c7 44 24 04 d0 3c 00 	movl   $0x3cd0,0x4(%esp)
    2468:	00 
    2469:	89 34 24             	mov    %esi,(%esp)
    246c:	e8 c7 08 00 00       	call   2d38 <write>
    2471:	83 f8 0a             	cmp    $0xa,%eax
    2474:	0f 85 e6 00 00 00    	jne    2560 <writetest+0x180>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    247a:	83 c3 01             	add    $0x1,%ebx
    247d:	83 fb 64             	cmp    $0x64,%ebx
    2480:	75 b6                	jne    2438 <writetest+0x58>
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
    2482:	a1 08 44 00 00       	mov    0x4408,%eax
    2487:	c7 44 24 04 db 3c 00 	movl   $0x3cdb,0x4(%esp)
    248e:	00 
    248f:	89 04 24             	mov    %eax,(%esp)
    2492:	e8 e9 09 00 00       	call   2e80 <printf>
  close(fd);
    2497:	89 34 24             	mov    %esi,(%esp)
    249a:	e8 a1 08 00 00       	call   2d40 <close>
  fd = open("small", O_RDONLY);
    249f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    24a6:	00 
    24a7:	c7 04 24 88 3c 00 00 	movl   $0x3c88,(%esp)
    24ae:	e8 a5 08 00 00       	call   2d58 <open>
  if(fd >= 0){
    24b3:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
    24b5:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
    24b7:	0f 88 c1 00 00 00    	js     257e <writetest+0x19e>
    printf(stdout, "open small succeeded ok\n");
    24bd:	a1 08 44 00 00       	mov    0x4408,%eax
    24c2:	c7 44 24 04 e6 3c 00 	movl   $0x3ce6,0x4(%esp)
    24c9:	00 
    24ca:	89 04 24             	mov    %eax,(%esp)
    24cd:	e8 ae 09 00 00       	call   2e80 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
    24d2:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
    24d9:	00 
    24da:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    24e1:	00 
    24e2:	89 1c 24             	mov    %ebx,(%esp)
    24e5:	e8 46 08 00 00       	call   2d30 <read>
  if(i == 2000) {
    24ea:	3d d0 07 00 00       	cmp    $0x7d0,%eax
    24ef:	0f 85 a3 00 00 00    	jne    2598 <writetest+0x1b8>
    printf(stdout, "read succeeded ok\n");
    24f5:	a1 08 44 00 00       	mov    0x4408,%eax
    24fa:	c7 44 24 04 1a 3d 00 	movl   $0x3d1a,0x4(%esp)
    2501:	00 
    2502:	89 04 24             	mov    %eax,(%esp)
    2505:	e8 76 09 00 00       	call   2e80 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
    250a:	89 1c 24             	mov    %ebx,(%esp)
    250d:	e8 2e 08 00 00       	call   2d40 <close>

  if(unlink("small") < 0) {
    2512:	c7 04 24 88 3c 00 00 	movl   $0x3c88,(%esp)
    2519:	e8 4a 08 00 00       	call   2d68 <unlink>
    251e:	85 c0                	test   %eax,%eax
    2520:	0f 88 8c 00 00 00    	js     25b2 <writetest+0x1d2>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
    2526:	a1 08 44 00 00       	mov    0x4408,%eax
    252b:	c7 44 24 04 42 3d 00 	movl   $0x3d42,0x4(%esp)
    2532:	00 
    2533:	89 04 24             	mov    %eax,(%esp)
    2536:	e8 45 09 00 00       	call   2e80 <printf>
}
    253b:	83 c4 10             	add    $0x10,%esp
    253e:	5b                   	pop    %ebx
    253f:	5e                   	pop    %esi
    2540:	5d                   	pop    %ebp
    2541:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++) {
    if(write(fd, "aaaaaaaaaa", 10) != 10) {
      printf(stdout, "error: write aa %d new file failed\n", i);
    2542:	a1 08 44 00 00       	mov    0x4408,%eax
    2547:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    254b:	c7 44 24 04 5c 43 00 	movl   $0x435c,0x4(%esp)
    2552:	00 
    2553:	89 04 24             	mov    %eax,(%esp)
    2556:	e8 25 09 00 00       	call   2e80 <printf>
      exit();
    255b:	e8 b8 07 00 00       	call   2d18 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10) {
      printf(stdout, "error: write bb %d new file failed\n", i);
    2560:	a1 08 44 00 00       	mov    0x4408,%eax
    2565:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2569:	c7 44 24 04 80 43 00 	movl   $0x4380,0x4(%esp)
    2570:	00 
    2571:	89 04 24             	mov    %eax,(%esp)
    2574:	e8 07 09 00 00       	call   2e80 <printf>
      exit();
    2579:	e8 9a 07 00 00       	call   2d18 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
    257e:	a1 08 44 00 00       	mov    0x4408,%eax
    2583:	c7 44 24 04 ff 3c 00 	movl   $0x3cff,0x4(%esp)
    258a:	00 
    258b:	89 04 24             	mov    %eax,(%esp)
    258e:	e8 ed 08 00 00       	call   2e80 <printf>
    exit();
    2593:	e8 80 07 00 00       	call   2d18 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000) {
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
    2598:	a1 08 44 00 00       	mov    0x4408,%eax
    259d:	c7 44 24 04 ba 3a 00 	movl   $0x3aba,0x4(%esp)
    25a4:	00 
    25a5:	89 04 24             	mov    %eax,(%esp)
    25a8:	e8 d3 08 00 00       	call   2e80 <printf>
    exit();
    25ad:	e8 66 07 00 00       	call   2d18 <exit>
  }
  close(fd);

  if(unlink("small") < 0) {
    printf(stdout, "unlink small failed\n");
    25b2:	a1 08 44 00 00       	mov    0x4408,%eax
    25b7:	c7 44 24 04 2d 3d 00 	movl   $0x3d2d,0x4(%esp)
    25be:	00 
    25bf:	89 04 24             	mov    %eax,(%esp)
    25c2:	e8 b9 08 00 00       	call   2e80 <printf>
    exit();
    25c7:	e8 4c 07 00 00       	call   2d18 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    25cc:	a1 08 44 00 00       	mov    0x4408,%eax
    25d1:	c7 44 24 04 a9 3c 00 	movl   $0x3ca9,0x4(%esp)
    25d8:	00 
    25d9:	89 04 24             	mov    %eax,(%esp)
    25dc:	e8 9f 08 00 00       	call   2e80 <printf>
    exit();
    25e1:	e8 32 07 00 00       	call   2d18 <exit>
    25e6:	8d 76 00             	lea    0x0(%esi),%esi
    25e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000025f0 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    25f0:	55                   	push   %ebp
    25f1:	89 e5                	mov    %esp,%ebp
    25f3:	56                   	push   %esi
    25f4:	53                   	push   %ebx
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    25f5:	31 db                	xor    %ebx,%ebx
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
    25f7:	83 ec 10             	sub    $0x10,%esp
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    25fa:	e8 11 07 00 00       	call   2d10 <fork>
    25ff:	85 c0                	test   %eax,%eax
    2601:	74 09                	je     260c <mem+0x1c>
    2603:	eb 5c                	jmp    2661 <mem+0x71>
    2605:	8d 76 00             	lea    0x0(%esi),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
    2608:	89 18                	mov    %ebx,(%eax)
    260a:	89 c3                	mov    %eax,%ebx
  void *m1, *m2;
  int pid;

  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
    260c:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
    2613:	e8 98 0a 00 00       	call   30b0 <malloc>
    2618:	85 c0                	test   %eax,%eax
    261a:	75 ec                	jne    2608 <mem+0x18>
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
    261c:	85 db                	test   %ebx,%ebx
    261e:	74 10                	je     2630 <mem+0x40>
      m2 = *(char**)m1;
    2620:	8b 33                	mov    (%ebx),%esi
      free(m1);
    2622:	89 1c 24             	mov    %ebx,(%esp)
    2625:	e8 f6 09 00 00       	call   3020 <free>
    262a:	89 f3                	mov    %esi,%ebx
    m1 = 0;
    while((m2 = malloc(10001)) != 0) {
      *(char**) m2 = m1;
      m1 = m2;
    }
    while(m1) {
    262c:	85 db                	test   %ebx,%ebx
    262e:	75 f0                	jne    2620 <mem+0x30>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    2630:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
    2637:	e8 74 0a 00 00       	call   30b0 <malloc>
    if(m1 == 0) {
    263c:	85 c0                	test   %eax,%eax
    263e:	74 30                	je     2670 <mem+0x80>
      printf(1, "couldn't allocate mem?!!\n");
      exit();
    }
    free(m1);
    2640:	89 04 24             	mov    %eax,(%esp)
    2643:	e8 d8 09 00 00       	call   3020 <free>
    printf(1, "mem ok\n");
    2648:	c7 44 24 04 70 3d 00 	movl   $0x3d70,0x4(%esp)
    264f:	00 
    2650:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2657:	e8 24 08 00 00       	call   2e80 <printf>
    exit();
    265c:	e8 b7 06 00 00       	call   2d18 <exit>
  } else {
    wait();
  }
}
    2661:	83 c4 10             	add    $0x10,%esp
    2664:	5b                   	pop    %ebx
    2665:	5e                   	pop    %esi
    2666:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
    2667:	e9 b4 06 00 00       	jmp    2d20 <wait>
    266c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0) {
      printf(1, "couldn't allocate mem?!!\n");
    2670:	c7 44 24 04 56 3d 00 	movl   $0x3d56,0x4(%esp)
    2677:	00 
    2678:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    267f:	e8 fc 07 00 00       	call   2e80 <printf>
      exit();
    2684:	e8 8f 06 00 00       	call   2d18 <exit>
    2689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00002690 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
    2690:	55                   	push   %ebp
    2691:	89 e5                	mov    %esp,%ebp
    2693:	57                   	push   %edi
    2694:	56                   	push   %esi
    2695:	53                   	push   %ebx
    2696:	83 ec 2c             	sub    $0x2c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    2699:	8d 45 e0             	lea    -0x20(%ebp),%eax
    269c:	89 04 24             	mov    %eax,(%esp)
    269f:	e8 84 06 00 00       	call   2d28 <pipe>
    26a4:	85 c0                	test   %eax,%eax
    26a6:	0f 85 53 01 00 00    	jne    27ff <pipe1+0x16f>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
    26ac:	e8 5f 06 00 00       	call   2d10 <fork>
  seq = 0;
  if(pid == 0){
    26b1:	83 f8 00             	cmp    $0x0,%eax
    26b4:	0f 84 87 00 00 00    	je     2741 <pipe1+0xb1>
    26ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
    26c0:	0f 8e 52 01 00 00    	jle    2818 <pipe1+0x188>
    close(fds[1]);
    26c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    26c9:	31 ff                	xor    %edi,%edi
    26cb:	be 01 00 00 00       	mov    $0x1,%esi
    26d0:	31 db                	xor    %ebx,%ebx
    26d2:	89 04 24             	mov    %eax,(%esp)
    26d5:	e8 66 06 00 00       	call   2d40 <close>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
    26da:	8b 45 e0             	mov    -0x20(%ebp),%eax
    26dd:	89 74 24 08          	mov    %esi,0x8(%esp)
    26e1:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    26e8:	00 
    26e9:	89 04 24             	mov    %eax,(%esp)
    26ec:	e8 3f 06 00 00       	call   2d30 <read>
    26f1:	85 c0                	test   %eax,%eax
    26f3:	0f 8e a4 00 00 00    	jle    279d <pipe1+0x10d>
    26f9:	31 d2                	xor    %edx,%edx
    26fb:	90                   	nop
    26fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    2700:	38 9a 40 44 00 00    	cmp    %bl,0x4440(%edx)
    2706:	75 1d                	jne    2725 <pipe1+0x95>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
    2708:	83 c2 01             	add    $0x1,%edx
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    270b:	83 c3 01             	add    $0x1,%ebx
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
    270e:	39 d0                	cmp    %edx,%eax
    2710:	7f ee                	jg     2700 <pipe1+0x70>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
    2712:	01 f6                	add    %esi,%esi
      if(cc > sizeof(buf))
    2714:	81 fe 00 08 00 00    	cmp    $0x800,%esi
    271a:	76 05                	jbe    2721 <pipe1+0x91>
    271c:	be 00 08 00 00       	mov    $0x800,%esi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
    2721:	01 c7                	add    %eax,%edi
    2723:	eb b5                	jmp    26da <pipe1+0x4a>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
    2725:	c7 44 24 04 95 3d 00 	movl   $0x3d95,0x4(%esp)
    272c:	00 
    272d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2734:	e8 47 07 00 00       	call   2e80 <printf>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
    2739:	83 c4 2c             	add    $0x2c,%esp
    273c:	5b                   	pop    %ebx
    273d:	5e                   	pop    %esi
    273e:	5f                   	pop    %edi
    273f:	5d                   	pop    %ebp
    2740:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    2741:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2744:	31 db                	xor    %ebx,%ebx
    2746:	89 04 24             	mov    %eax,(%esp)
    2749:	e8 f2 05 00 00       	call   2d40 <close>
    for(n = 0; n < 5; n++){
    274e:	31 c0                	xor    %eax,%eax
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
    2750:	8d 14 18             	lea    (%eax,%ebx,1),%edx
    2753:	88 90 40 44 00 00    	mov    %dl,0x4440(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
    2759:	83 c0 01             	add    $0x1,%eax
    275c:	3d 09 04 00 00       	cmp    $0x409,%eax
    2761:	75 ed                	jne    2750 <pipe1+0xc0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
    2763:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
    2766:	81 c3 09 04 00 00    	add    $0x409,%ebx
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
    276c:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
    2773:	00 
    2774:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    277b:	00 
    277c:	89 04 24             	mov    %eax,(%esp)
    277f:	e8 b4 05 00 00       	call   2d38 <write>
    2784:	3d 09 04 00 00       	cmp    $0x409,%eax
    2789:	75 5b                	jne    27e6 <pipe1+0x156>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
    278b:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
    2791:	75 bb                	jne    274e <pipe1+0xbe>
    2793:	90                   	nop
    2794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
    exit();
    2798:	e8 7b 05 00 00       	call   2d18 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033)
    279d:	81 ff 2d 14 00 00    	cmp    $0x142d,%edi
    27a3:	74 18                	je     27bd <pipe1+0x12d>
      printf(1, "pipe1 oops 3 total %d\n", total);
    27a5:	89 7c 24 08          	mov    %edi,0x8(%esp)
    27a9:	c7 44 24 04 a3 3d 00 	movl   $0x3da3,0x4(%esp)
    27b0:	00 
    27b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27b8:	e8 c3 06 00 00       	call   2e80 <printf>
    close(fds[0]);
    27bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    27c0:	89 04 24             	mov    %eax,(%esp)
    27c3:	e8 78 05 00 00       	call   2d40 <close>
    wait();
    27c8:	e8 53 05 00 00       	call   2d20 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
    27cd:	c7 44 24 04 ba 3d 00 	movl   $0x3dba,0x4(%esp)
    27d4:	00 
    27d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27dc:	e8 9f 06 00 00       	call   2e80 <printf>
    27e1:	e9 53 ff ff ff       	jmp    2739 <pipe1+0xa9>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
    27e6:	c7 44 24 04 87 3d 00 	movl   $0x3d87,0x4(%esp)
    27ed:	00 
    27ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27f5:	e8 86 06 00 00       	call   2e80 <printf>
        exit();
    27fa:	e8 19 05 00 00       	call   2d18 <exit>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    27ff:	c7 44 24 04 78 3d 00 	movl   $0x3d78,0x4(%esp)
    2806:	00 
    2807:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    280e:	e8 6d 06 00 00       	call   2e80 <printf>
    exit();
    2813:	e8 00 05 00 00       	call   2d18 <exit>
    if(total != 5 * 1033)
      printf(1, "pipe1 oops 3 total %d\n", total);
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
    2818:	c7 44 24 04 c4 3d 00 	movl   $0x3dc4,0x4(%esp)
    281f:	00 
    2820:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2827:	e8 54 06 00 00       	call   2e80 <printf>
    282c:	e9 62 ff ff ff       	jmp    2793 <pipe1+0x103>
    2831:	eb 0d                	jmp    2840 <preempt>
    2833:	90                   	nop
    2834:	90                   	nop
    2835:	90                   	nop
    2836:	90                   	nop
    2837:	90                   	nop
    2838:	90                   	nop
    2839:	90                   	nop
    283a:	90                   	nop
    283b:	90                   	nop
    283c:	90                   	nop
    283d:	90                   	nop
    283e:	90                   	nop
    283f:	90                   	nop

00002840 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
    2840:	55                   	push   %ebp
    2841:	89 e5                	mov    %esp,%ebp
    2843:	57                   	push   %edi
    2844:	56                   	push   %esi
    2845:	53                   	push   %ebx
    2846:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
    2849:	c7 44 24 04 d3 3d 00 	movl   $0x3dd3,0x4(%esp)
    2850:	00 
    2851:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2858:	e8 23 06 00 00       	call   2e80 <printf>
  pid1 = fork();
    285d:	e8 ae 04 00 00       	call   2d10 <fork>
  if(pid1 == 0)
    2862:	85 c0                	test   %eax,%eax
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
  pid1 = fork();
    2864:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
    2866:	75 02                	jne    286a <preempt+0x2a>
    2868:	eb fe                	jmp    2868 <preempt+0x28>
    286a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
      ;

  pid2 = fork();
    2870:	e8 9b 04 00 00       	call   2d10 <fork>
  if(pid2 == 0)
    2875:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
    2877:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
    2879:	75 02                	jne    287d <preempt+0x3d>
    287b:	eb fe                	jmp    287b <preempt+0x3b>
    for(;;)
      ;

  pipe(pfds);
    287d:	8d 45 e0             	lea    -0x20(%ebp),%eax
    2880:	89 04 24             	mov    %eax,(%esp)
    2883:	e8 a0 04 00 00       	call   2d28 <pipe>
  pid3 = fork();
    2888:	e8 83 04 00 00       	call   2d10 <fork>
  if(pid3 == 0){
    288d:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
    288f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
    2891:	75 4c                	jne    28df <preempt+0x9f>
    close(pfds[0]);
    2893:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2896:	89 04 24             	mov    %eax,(%esp)
    2899:	e8 a2 04 00 00       	call   2d40 <close>
    if(write(pfds[1], "x", 1) != 1)
    289e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    28a8:	00 
    28a9:	c7 44 24 04 5f 38 00 	movl   $0x385f,0x4(%esp)
    28b0:	00 
    28b1:	89 04 24             	mov    %eax,(%esp)
    28b4:	e8 7f 04 00 00       	call   2d38 <write>
    28b9:	83 f8 01             	cmp    $0x1,%eax
    28bc:	74 14                	je     28d2 <preempt+0x92>
      printf(1, "preempt write error");
    28be:	c7 44 24 04 dd 3d 00 	movl   $0x3ddd,0x4(%esp)
    28c5:	00 
    28c6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28cd:	e8 ae 05 00 00       	call   2e80 <printf>
    close(pfds[1]);
    28d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28d5:	89 04 24             	mov    %eax,(%esp)
    28d8:	e8 63 04 00 00       	call   2d40 <close>
    28dd:	eb fe                	jmp    28dd <preempt+0x9d>
    for(;;)
      ;
  }

  close(pfds[1]);
    28df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    28e2:	89 04 24             	mov    %eax,(%esp)
    28e5:	e8 56 04 00 00       	call   2d40 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    28ea:	8b 45 e0             	mov    -0x20(%ebp),%eax
    28ed:	c7 44 24 08 00 08 00 	movl   $0x800,0x8(%esp)
    28f4:	00 
    28f5:	c7 44 24 04 40 44 00 	movl   $0x4440,0x4(%esp)
    28fc:	00 
    28fd:	89 04 24             	mov    %eax,(%esp)
    2900:	e8 2b 04 00 00       	call   2d30 <read>
    2905:	83 f8 01             	cmp    $0x1,%eax
    2908:	74 1c                	je     2926 <preempt+0xe6>
    printf(1, "preempt read error");
    290a:	c7 44 24 04 f1 3d 00 	movl   $0x3df1,0x4(%esp)
    2911:	00 
    2912:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2919:	e8 62 05 00 00       	call   2e80 <printf>
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
    291e:	83 c4 2c             	add    $0x2c,%esp
    2921:	5b                   	pop    %ebx
    2922:	5e                   	pop    %esi
    2923:	5f                   	pop    %edi
    2924:	5d                   	pop    %ebp
    2925:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
    2926:	8b 45 e0             	mov    -0x20(%ebp),%eax
    2929:	89 04 24             	mov    %eax,(%esp)
    292c:	e8 0f 04 00 00       	call   2d40 <close>
  printf(1, "kill... ");
    2931:	c7 44 24 04 04 3e 00 	movl   $0x3e04,0x4(%esp)
    2938:	00 
    2939:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2940:	e8 3b 05 00 00       	call   2e80 <printf>
  kill(pid1);
    2945:	89 3c 24             	mov    %edi,(%esp)
    2948:	e8 fb 03 00 00       	call   2d48 <kill>
  kill(pid2);
    294d:	89 34 24             	mov    %esi,(%esp)
    2950:	e8 f3 03 00 00       	call   2d48 <kill>
  kill(pid3);
    2955:	89 1c 24             	mov    %ebx,(%esp)
    2958:	e8 eb 03 00 00       	call   2d48 <kill>
  printf(1, "wait... ");
    295d:	c7 44 24 04 0d 3e 00 	movl   $0x3e0d,0x4(%esp)
    2964:	00 
    2965:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    296c:	e8 0f 05 00 00       	call   2e80 <printf>
  wait();
    2971:	e8 aa 03 00 00       	call   2d20 <wait>
  wait();
    2976:	e8 a5 03 00 00       	call   2d20 <wait>
    297b:	90                   	nop
    297c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait();
    2980:	e8 9b 03 00 00       	call   2d20 <wait>
  printf(1, "preempt ok\n");
    2985:	c7 44 24 04 16 3e 00 	movl   $0x3e16,0x4(%esp)
    298c:	00 
    298d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2994:	e8 e7 04 00 00       	call   2e80 <printf>
    2999:	eb 83                	jmp    291e <preempt+0xde>
    299b:	90                   	nop
    299c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000029a0 <exectest>:
  printf(stdout, "mkdir test\n");
}

void
exectest(void)
{
    29a0:	55                   	push   %ebp
    29a1:	89 e5                	mov    %esp,%ebp
    29a3:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
    29a6:	a1 08 44 00 00       	mov    0x4408,%eax
    29ab:	c7 44 24 04 22 3e 00 	movl   $0x3e22,0x4(%esp)
    29b2:	00 
    29b3:	89 04 24             	mov    %eax,(%esp)
    29b6:	e8 c5 04 00 00       	call   2e80 <printf>
  if(exec("echo", echo_args) < 0) {
    29bb:	c7 44 24 04 e8 43 00 	movl   $0x43e8,0x4(%esp)
    29c2:	00 
    29c3:	c7 04 24 9b 31 00 00 	movl   $0x319b,(%esp)
    29ca:	e8 81 03 00 00       	call   2d50 <exec>
    29cf:	85 c0                	test   %eax,%eax
    29d1:	78 02                	js     29d5 <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
    29d3:	c9                   	leave  
    29d4:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echo_args) < 0) {
    printf(stdout, "exec echo failed\n");
    29d5:	a1 08 44 00 00       	mov    0x4408,%eax
    29da:	c7 44 24 04 2d 3e 00 	movl   $0x3e2d,0x4(%esp)
    29e1:	00 
    29e2:	89 04 24             	mov    %eax,(%esp)
    29e5:	e8 96 04 00 00       	call   2e80 <printf>
    exit();
    29ea:	e8 29 03 00 00       	call   2d18 <exit>
    29ef:	90                   	nop

000029f0 <main>:
  printf(1, "fork test OK\n");
}

int
main(int argc, char *argv[])
{
    29f0:	55                   	push   %ebp
    29f1:	89 e5                	mov    %esp,%ebp
    29f3:	83 e4 f0             	and    $0xfffffff0,%esp
    29f6:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
    29f9:	c7 44 24 04 3f 3e 00 	movl   $0x3e3f,0x4(%esp)
    2a00:	00 
    2a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a08:	e8 73 04 00 00       	call   2e80 <printf>

  if(open("usertests.ran", 0) >= 0){
    2a0d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2a14:	00 
    2a15:	c7 04 24 53 3e 00 00 	movl   $0x3e53,(%esp)
    2a1c:	e8 37 03 00 00       	call   2d58 <open>
    2a21:	85 c0                	test   %eax,%eax
    2a23:	78 1b                	js     2a40 <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    2a25:	c7 44 24 04 a4 43 00 	movl   $0x43a4,0x4(%esp)
    2a2c:	00 
    2a2d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a34:	e8 47 04 00 00       	call   2e80 <printf>
    exit();
    2a39:	e8 da 02 00 00       	call   2d18 <exit>
    2a3e:	66 90                	xchg   %ax,%ax
  }
  close(open("usertests.ran", O_CREATE));
    2a40:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2a47:	00 
    2a48:	c7 04 24 53 3e 00 00 	movl   $0x3e53,(%esp)
    2a4f:	e8 04 03 00 00       	call   2d58 <open>
    2a54:	89 04 24             	mov    %eax,(%esp)
    2a57:	e8 e4 02 00 00       	call   2d40 <close>

  opentest();
    2a5c:	e8 9f d5 ff ff       	call   0 <opentest>
  writetest();
    2a61:	e8 7a f9 ff ff       	call   23e0 <writetest>
  writetest1();
    2a66:	e8 85 f7 ff ff       	call   21f0 <writetest1>
    2a6b:	90                   	nop
    2a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  createtest();
    2a70:	e8 2b e0 ff ff       	call   aa0 <createtest>

  mem();
    2a75:	e8 76 fb ff ff       	call   25f0 <mem>
  pipe1();
    2a7a:	e8 11 fc ff ff       	call   2690 <pipe1>
    2a7f:	90                   	nop
  preempt();
    2a80:	e8 bb fd ff ff       	call   2840 <preempt>
  exitwait();
    2a85:	e8 e6 d6 ff ff       	call   170 <exitwait>

  rmdot();
    2a8a:	e8 f1 d9 ff ff       	call   480 <rmdot>
    2a8f:	90                   	nop
  fourteen();
    2a90:	e8 6b d7 ff ff       	call   200 <fourteen>
  bigfile();
    2a95:	e8 f6 e2 ff ff       	call   d90 <bigfile>
  subdir();
    2a9a:	e8 f1 e4 ff ff       	call   f90 <subdir>
    2a9f:	90                   	nop
  concreate();
    2aa0:	e8 7b ec ff ff       	call   1720 <concreate>
  linktest();
    2aa5:	e8 36 ef ff ff       	call   19e0 <linktest>
  unlinkread();
    2aaa:	e8 91 f1 ff ff       	call   1c40 <unlinkread>
    2aaf:	90                   	nop
  createdelete();
    2ab0:	e8 ab dc ff ff       	call   760 <createdelete>
  twofiles();
    2ab5:	e8 56 f3 ff ff       	call   1e10 <twofiles>
  sharedfd();
    2aba:	e8 71 f5 ff ff       	call   2030 <sharedfd>
    2abf:	90                   	nop
  dirfile();
    2ac0:	e8 8b e0 ff ff       	call   b50 <dirfile>
  iref();
    2ac5:	e8 96 d8 ff ff       	call   360 <iref>
  forktest();
    2aca:	e8 d1 d5 ff ff       	call   a0 <forktest>
    2acf:	90                   	nop
  bigdir(); // slow
    2ad0:	e8 3b db ff ff       	call   610 <bigdir>

  exectest();
    2ad5:	e8 c6 fe ff ff       	call   29a0 <exectest>

  exit();
    2ada:	e8 39 02 00 00       	call   2d18 <exit>
    2adf:	90                   	nop

00002ae0 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
    2ae0:	55                   	push   %ebp
    2ae1:	31 d2                	xor    %edx,%edx
    2ae3:	89 e5                	mov    %esp,%ebp
    2ae5:	8b 45 08             	mov    0x8(%ebp),%eax
    2ae8:	53                   	push   %ebx
    2ae9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    2aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    2af0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
    2af4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    2af7:	83 c2 01             	add    $0x1,%edx
    2afa:	84 c9                	test   %cl,%cl
    2afc:	75 f2                	jne    2af0 <strcpy+0x10>
    ;
  return os;
}
    2afe:	5b                   	pop    %ebx
    2aff:	5d                   	pop    %ebp
    2b00:	c3                   	ret    
    2b01:	eb 0d                	jmp    2b10 <strcmp>
    2b03:	90                   	nop
    2b04:	90                   	nop
    2b05:	90                   	nop
    2b06:	90                   	nop
    2b07:	90                   	nop
    2b08:	90                   	nop
    2b09:	90                   	nop
    2b0a:	90                   	nop
    2b0b:	90                   	nop
    2b0c:	90                   	nop
    2b0d:	90                   	nop
    2b0e:	90                   	nop
    2b0f:	90                   	nop

00002b10 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    2b10:	55                   	push   %ebp
    2b11:	89 e5                	mov    %esp,%ebp
    2b13:	53                   	push   %ebx
    2b14:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2b17:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    2b1a:	0f b6 01             	movzbl (%ecx),%eax
    2b1d:	84 c0                	test   %al,%al
    2b1f:	75 14                	jne    2b35 <strcmp+0x25>
    2b21:	eb 25                	jmp    2b48 <strcmp+0x38>
    2b23:	90                   	nop
    2b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
    2b28:	83 c1 01             	add    $0x1,%ecx
    2b2b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    2b2e:	0f b6 01             	movzbl (%ecx),%eax
    2b31:	84 c0                	test   %al,%al
    2b33:	74 13                	je     2b48 <strcmp+0x38>
    2b35:	0f b6 1a             	movzbl (%edx),%ebx
    2b38:	38 d8                	cmp    %bl,%al
    2b3a:	74 ec                	je     2b28 <strcmp+0x18>
    2b3c:	0f b6 db             	movzbl %bl,%ebx
    2b3f:	0f b6 c0             	movzbl %al,%eax
    2b42:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    2b44:	5b                   	pop    %ebx
    2b45:	5d                   	pop    %ebp
    2b46:	c3                   	ret    
    2b47:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    2b48:	0f b6 1a             	movzbl (%edx),%ebx
    2b4b:	31 c0                	xor    %eax,%eax
    2b4d:	0f b6 db             	movzbl %bl,%ebx
    2b50:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
    2b52:	5b                   	pop    %ebx
    2b53:	5d                   	pop    %ebp
    2b54:	c3                   	ret    
    2b55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b60 <strlen>:

uint
strlen(char *s)
{
    2b60:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
    2b61:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    2b63:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
    2b65:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    2b67:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    2b6a:	80 39 00             	cmpb   $0x0,(%ecx)
    2b6d:	74 0c                	je     2b7b <strlen+0x1b>
    2b6f:	90                   	nop
    2b70:	83 c2 01             	add    $0x1,%edx
    2b73:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    2b77:	89 d0                	mov    %edx,%eax
    2b79:	75 f5                	jne    2b70 <strlen+0x10>
    ;
  return n;
}
    2b7b:	5d                   	pop    %ebp
    2b7c:	c3                   	ret    
    2b7d:	8d 76 00             	lea    0x0(%esi),%esi

00002b80 <memset>:

void*
memset(void *dst, int c, uint n)
{
    2b80:	55                   	push   %ebp
    2b81:	89 e5                	mov    %esp,%ebp
    2b83:	8b 4d 10             	mov    0x10(%ebp),%ecx
    2b86:	53                   	push   %ebx
    2b87:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
    2b8a:	85 c9                	test   %ecx,%ecx
    2b8c:	74 14                	je     2ba2 <memset+0x22>
    2b8e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
    2b92:	31 d2                	xor    %edx,%edx
    2b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
    2b98:	88 1c 10             	mov    %bl,(%eax,%edx,1)
    2b9b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
    2b9e:	39 ca                	cmp    %ecx,%edx
    2ba0:	75 f6                	jne    2b98 <memset+0x18>
    *d++ = c;
  return dst;
}
    2ba2:	5b                   	pop    %ebx
    2ba3:	5d                   	pop    %ebp
    2ba4:	c3                   	ret    
    2ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002bb0 <strchr>:

char*
strchr(const char *s, char c)
{
    2bb0:	55                   	push   %ebp
    2bb1:	89 e5                	mov    %esp,%ebp
    2bb3:	8b 45 08             	mov    0x8(%ebp),%eax
    2bb6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    2bba:	0f b6 10             	movzbl (%eax),%edx
    2bbd:	84 d2                	test   %dl,%dl
    2bbf:	75 11                	jne    2bd2 <strchr+0x22>
    2bc1:	eb 15                	jmp    2bd8 <strchr+0x28>
    2bc3:	90                   	nop
    2bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2bc8:	83 c0 01             	add    $0x1,%eax
    2bcb:	0f b6 10             	movzbl (%eax),%edx
    2bce:	84 d2                	test   %dl,%dl
    2bd0:	74 06                	je     2bd8 <strchr+0x28>
    if(*s == c)
    2bd2:	38 ca                	cmp    %cl,%dl
    2bd4:	75 f2                	jne    2bc8 <strchr+0x18>
      return (char*) s;
  return 0;
}
    2bd6:	5d                   	pop    %ebp
    2bd7:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    2bd8:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
    2bda:	5d                   	pop    %ebp
    2bdb:	90                   	nop
    2bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2be0:	c3                   	ret    
    2be1:	eb 0d                	jmp    2bf0 <atoi>
    2be3:	90                   	nop
    2be4:	90                   	nop
    2be5:	90                   	nop
    2be6:	90                   	nop
    2be7:	90                   	nop
    2be8:	90                   	nop
    2be9:	90                   	nop
    2bea:	90                   	nop
    2beb:	90                   	nop
    2bec:	90                   	nop
    2bed:	90                   	nop
    2bee:	90                   	nop
    2bef:	90                   	nop

00002bf0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    2bf0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    2bf1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
    2bf3:	89 e5                	mov    %esp,%ebp
    2bf5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2bf8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    2bf9:	0f b6 11             	movzbl (%ecx),%edx
    2bfc:	8d 5a d0             	lea    -0x30(%edx),%ebx
    2bff:	80 fb 09             	cmp    $0x9,%bl
    2c02:	77 1c                	ja     2c20 <atoi+0x30>
    2c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
    2c08:	0f be d2             	movsbl %dl,%edx
    2c0b:	83 c1 01             	add    $0x1,%ecx
    2c0e:	8d 04 80             	lea    (%eax,%eax,4),%eax
    2c11:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    2c15:	0f b6 11             	movzbl (%ecx),%edx
    2c18:	8d 5a d0             	lea    -0x30(%edx),%ebx
    2c1b:	80 fb 09             	cmp    $0x9,%bl
    2c1e:	76 e8                	jbe    2c08 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    2c20:	5b                   	pop    %ebx
    2c21:	5d                   	pop    %ebp
    2c22:	c3                   	ret    
    2c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002c30 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    2c30:	55                   	push   %ebp
    2c31:	89 e5                	mov    %esp,%ebp
    2c33:	56                   	push   %esi
    2c34:	8b 45 08             	mov    0x8(%ebp),%eax
    2c37:	53                   	push   %ebx
    2c38:	8b 5d 10             	mov    0x10(%ebp),%ebx
    2c3b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    2c3e:	85 db                	test   %ebx,%ebx
    2c40:	7e 14                	jle    2c56 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    2c42:	31 d2                	xor    %edx,%edx
    2c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
    2c48:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    2c4c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    2c4f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    2c52:	39 da                	cmp    %ebx,%edx
    2c54:	75 f2                	jne    2c48 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    2c56:	5b                   	pop    %ebx
    2c57:	5e                   	pop    %esi
    2c58:	5d                   	pop    %ebp
    2c59:	c3                   	ret    
    2c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00002c60 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
    2c60:	55                   	push   %ebp
    2c61:	89 e5                	mov    %esp,%ebp
    2c63:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2c66:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
    2c69:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    2c6c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    2c6f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2c74:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2c7b:	00 
    2c7c:	89 04 24             	mov    %eax,(%esp)
    2c7f:	e8 d4 00 00 00       	call   2d58 <open>
  if(fd < 0)
    2c84:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    2c86:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    2c88:	78 19                	js     2ca3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
    2c8a:	8b 45 0c             	mov    0xc(%ebp),%eax
    2c8d:	89 1c 24             	mov    %ebx,(%esp)
    2c90:	89 44 24 04          	mov    %eax,0x4(%esp)
    2c94:	e8 d7 00 00 00       	call   2d70 <fstat>
  close(fd);
    2c99:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    2c9c:	89 c6                	mov    %eax,%esi
  close(fd);
    2c9e:	e8 9d 00 00 00       	call   2d40 <close>
  return r;
}
    2ca3:	89 f0                	mov    %esi,%eax
    2ca5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    2ca8:	8b 75 fc             	mov    -0x4(%ebp),%esi
    2cab:	89 ec                	mov    %ebp,%esp
    2cad:	5d                   	pop    %ebp
    2cae:	c3                   	ret    
    2caf:	90                   	nop

00002cb0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
    2cb0:	55                   	push   %ebp
    2cb1:	89 e5                	mov    %esp,%ebp
    2cb3:	57                   	push   %edi
    2cb4:	56                   	push   %esi
    2cb5:	31 f6                	xor    %esi,%esi
    2cb7:	53                   	push   %ebx
    2cb8:	83 ec 2c             	sub    $0x2c,%esp
    2cbb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    2cbe:	eb 06                	jmp    2cc6 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    2cc0:	3c 0a                	cmp    $0xa,%al
    2cc2:	74 39                	je     2cfd <gets+0x4d>
    2cc4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    2cc6:	8d 5e 01             	lea    0x1(%esi),%ebx
    2cc9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    2ccc:	7d 31                	jge    2cff <gets+0x4f>
    cc = read(0, &c, 1);
    2cce:	8d 45 e7             	lea    -0x19(%ebp),%eax
    2cd1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2cd8:	00 
    2cd9:	89 44 24 04          	mov    %eax,0x4(%esp)
    2cdd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ce4:	e8 47 00 00 00       	call   2d30 <read>
    if(cc < 1)
    2ce9:	85 c0                	test   %eax,%eax
    2ceb:	7e 12                	jle    2cff <gets+0x4f>
      break;
    buf[i++] = c;
    2ced:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    2cf1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
    2cf5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    2cf9:	3c 0d                	cmp    $0xd,%al
    2cfb:	75 c3                	jne    2cc0 <gets+0x10>
    2cfd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
    2cff:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
    2d03:	89 f8                	mov    %edi,%eax
    2d05:	83 c4 2c             	add    $0x2c,%esp
    2d08:	5b                   	pop    %ebx
    2d09:	5e                   	pop    %esi
    2d0a:	5f                   	pop    %edi
    2d0b:	5d                   	pop    %ebp
    2d0c:	c3                   	ret    
    2d0d:	90                   	nop
    2d0e:	90                   	nop
    2d0f:	90                   	nop

00002d10 <fork>:
    2d10:	b8 01 00 00 00       	mov    $0x1,%eax
    2d15:	cd 30                	int    $0x30
    2d17:	c3                   	ret    

00002d18 <exit>:
    2d18:	b8 02 00 00 00       	mov    $0x2,%eax
    2d1d:	cd 30                	int    $0x30
    2d1f:	c3                   	ret    

00002d20 <wait>:
    2d20:	b8 03 00 00 00       	mov    $0x3,%eax
    2d25:	cd 30                	int    $0x30
    2d27:	c3                   	ret    

00002d28 <pipe>:
    2d28:	b8 04 00 00 00       	mov    $0x4,%eax
    2d2d:	cd 30                	int    $0x30
    2d2f:	c3                   	ret    

00002d30 <read>:
    2d30:	b8 06 00 00 00       	mov    $0x6,%eax
    2d35:	cd 30                	int    $0x30
    2d37:	c3                   	ret    

00002d38 <write>:
    2d38:	b8 05 00 00 00       	mov    $0x5,%eax
    2d3d:	cd 30                	int    $0x30
    2d3f:	c3                   	ret    

00002d40 <close>:
    2d40:	b8 07 00 00 00       	mov    $0x7,%eax
    2d45:	cd 30                	int    $0x30
    2d47:	c3                   	ret    

00002d48 <kill>:
    2d48:	b8 08 00 00 00       	mov    $0x8,%eax
    2d4d:	cd 30                	int    $0x30
    2d4f:	c3                   	ret    

00002d50 <exec>:
    2d50:	b8 09 00 00 00       	mov    $0x9,%eax
    2d55:	cd 30                	int    $0x30
    2d57:	c3                   	ret    

00002d58 <open>:
    2d58:	b8 0a 00 00 00       	mov    $0xa,%eax
    2d5d:	cd 30                	int    $0x30
    2d5f:	c3                   	ret    

00002d60 <mknod>:
    2d60:	b8 0b 00 00 00       	mov    $0xb,%eax
    2d65:	cd 30                	int    $0x30
    2d67:	c3                   	ret    

00002d68 <unlink>:
    2d68:	b8 0c 00 00 00       	mov    $0xc,%eax
    2d6d:	cd 30                	int    $0x30
    2d6f:	c3                   	ret    

00002d70 <fstat>:
    2d70:	b8 0d 00 00 00       	mov    $0xd,%eax
    2d75:	cd 30                	int    $0x30
    2d77:	c3                   	ret    

00002d78 <link>:
    2d78:	b8 0e 00 00 00       	mov    $0xe,%eax
    2d7d:	cd 30                	int    $0x30
    2d7f:	c3                   	ret    

00002d80 <mkdir>:
    2d80:	b8 0f 00 00 00       	mov    $0xf,%eax
    2d85:	cd 30                	int    $0x30
    2d87:	c3                   	ret    

00002d88 <chdir>:
    2d88:	b8 10 00 00 00       	mov    $0x10,%eax
    2d8d:	cd 30                	int    $0x30
    2d8f:	c3                   	ret    

00002d90 <dup>:
    2d90:	b8 11 00 00 00       	mov    $0x11,%eax
    2d95:	cd 30                	int    $0x30
    2d97:	c3                   	ret    

00002d98 <getpid>:
    2d98:	b8 12 00 00 00       	mov    $0x12,%eax
    2d9d:	cd 30                	int    $0x30
    2d9f:	c3                   	ret    

00002da0 <sbrk>:
    2da0:	b8 13 00 00 00       	mov    $0x13,%eax
    2da5:	cd 30                	int    $0x30
    2da7:	c3                   	ret    

00002da8 <sleep>:
    2da8:	b8 14 00 00 00       	mov    $0x14,%eax
    2dad:	cd 30                	int    $0x30
    2daf:	c3                   	ret    

00002db0 <getticks>:
    2db0:	b8 15 00 00 00       	mov    $0x15,%eax
    2db5:	cd 30                	int    $0x30
    2db7:	c3                   	ret    
    2db8:	90                   	nop
    2db9:	90                   	nop
    2dba:	90                   	nop
    2dbb:	90                   	nop
    2dbc:	90                   	nop
    2dbd:	90                   	nop
    2dbe:	90                   	nop
    2dbf:	90                   	nop

00002dc0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    2dc0:	55                   	push   %ebp
    2dc1:	89 e5                	mov    %esp,%ebp
    2dc3:	83 ec 28             	sub    $0x28,%esp
    2dc6:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
    2dc9:	8d 55 f4             	lea    -0xc(%ebp),%edx
    2dcc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2dd3:	00 
    2dd4:	89 54 24 04          	mov    %edx,0x4(%esp)
    2dd8:	89 04 24             	mov    %eax,(%esp)
    2ddb:	e8 58 ff ff ff       	call   2d38 <write>
}
    2de0:	c9                   	leave  
    2de1:	c3                   	ret    
    2de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002df0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    2df0:	55                   	push   %ebp
    2df1:	89 e5                	mov    %esp,%ebp
    2df3:	57                   	push   %edi
    2df4:	89 c7                	mov    %eax,%edi
    2df6:	56                   	push   %esi
    2df7:	89 ce                	mov    %ecx,%esi
    2df9:	53                   	push   %ebx
    2dfa:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    2dfd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    2e00:	85 c9                	test   %ecx,%ecx
    2e02:	74 04                	je     2e08 <printint+0x18>
    2e04:	85 d2                	test   %edx,%edx
    2e06:	78 5d                	js     2e65 <printint+0x75>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    2e08:	89 d0                	mov    %edx,%eax
    2e0a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    2e11:	31 c9                	xor    %ecx,%ecx
    2e13:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    2e16:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    2e18:	31 d2                	xor    %edx,%edx
    2e1a:	f7 f6                	div    %esi
    2e1c:	0f b6 92 d7 43 00 00 	movzbl 0x43d7(%edx),%edx
    2e23:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
    2e26:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
    2e29:	85 c0                	test   %eax,%eax
    2e2b:	75 eb                	jne    2e18 <printint+0x28>
  if(neg)
    2e2d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2e30:	85 c0                	test   %eax,%eax
    2e32:	74 08                	je     2e3c <printint+0x4c>
    buf[i++] = '-';
    2e34:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    2e39:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
    2e3c:	8d 71 ff             	lea    -0x1(%ecx),%esi
    2e3f:	01 f3                	add    %esi,%ebx
    2e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    2e48:	0f be 13             	movsbl (%ebx),%edx
    2e4b:	89 f8                	mov    %edi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    2e4d:	83 ee 01             	sub    $0x1,%esi
    2e50:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
    2e53:	e8 68 ff ff ff       	call   2dc0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    2e58:	83 fe ff             	cmp    $0xffffffff,%esi
    2e5b:	75 eb                	jne    2e48 <printint+0x58>
    putc(fd, buf[i]);
}
    2e5d:	83 c4 2c             	add    $0x2c,%esp
    2e60:	5b                   	pop    %ebx
    2e61:	5e                   	pop    %esi
    2e62:	5f                   	pop    %edi
    2e63:	5d                   	pop    %ebp
    2e64:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    2e65:	89 d0                	mov    %edx,%eax
    2e67:	f7 d8                	neg    %eax
    2e69:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    2e70:	eb 9f                	jmp    2e11 <printint+0x21>
    2e72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002e80 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2e80:	55                   	push   %ebp
    2e81:	89 e5                	mov    %esp,%ebp
    2e83:	57                   	push   %edi
    2e84:	56                   	push   %esi
    2e85:	53                   	push   %ebx
    2e86:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2e89:	8b 45 0c             	mov    0xc(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    2e8c:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2e8f:	0f b6 08             	movzbl (%eax),%ecx
    2e92:	84 c9                	test   %cl,%cl
    2e94:	0f 84 96 00 00 00    	je     2f30 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    2e9a:	8d 55 10             	lea    0x10(%ebp),%edx
    2e9d:	31 f6                	xor    %esi,%esi
    2e9f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    2ea2:	31 db                	xor    %ebx,%ebx
    2ea4:	eb 1a                	jmp    2ec0 <printf+0x40>
    2ea6:	66 90                	xchg   %ax,%ax
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    2ea8:	83 f9 25             	cmp    $0x25,%ecx
    2eab:	0f 85 87 00 00 00    	jne    2f38 <printf+0xb8>
    2eb1:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2eb5:	83 c3 01             	add    $0x1,%ebx
    2eb8:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
    2ebc:	84 c9                	test   %cl,%cl
    2ebe:	74 70                	je     2f30 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
    2ec0:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    2ec2:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
    2ec5:	74 e1                	je     2ea8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    2ec7:	83 fe 25             	cmp    $0x25,%esi
    2eca:	75 e9                	jne    2eb5 <printf+0x35>
      if(c == 'd'){
    2ecc:	83 f9 64             	cmp    $0x64,%ecx
    2ecf:	90                   	nop
    2ed0:	0f 84 fa 00 00 00    	je     2fd0 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    2ed6:	83 f9 70             	cmp    $0x70,%ecx
    2ed9:	74 75                	je     2f50 <printf+0xd0>
    2edb:	83 f9 78             	cmp    $0x78,%ecx
    2ede:	66 90                	xchg   %ax,%ax
    2ee0:	74 6e                	je     2f50 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    2ee2:	83 f9 73             	cmp    $0x73,%ecx
    2ee5:	0f 84 8d 00 00 00    	je     2f78 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    2eeb:	83 f9 63             	cmp    $0x63,%ecx
    2eee:	66 90                	xchg   %ax,%ax
    2ef0:	0f 84 fe 00 00 00    	je     2ff4 <printf+0x174>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    2ef6:	83 f9 25             	cmp    $0x25,%ecx
    2ef9:	0f 84 b9 00 00 00    	je     2fb8 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2eff:	ba 25 00 00 00       	mov    $0x25,%edx
    2f04:	89 f8                	mov    %edi,%eax
    2f06:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2f09:	83 c3 01             	add    $0x1,%ebx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    2f0c:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    2f0e:	e8 ad fe ff ff       	call   2dc0 <putc>
        putc(fd, c);
    2f13:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    2f16:	89 f8                	mov    %edi,%eax
    2f18:	0f be d1             	movsbl %cl,%edx
    2f1b:	e8 a0 fe ff ff       	call   2dc0 <putc>
    2f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    2f23:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
    2f27:	84 c9                	test   %cl,%cl
    2f29:	75 95                	jne    2ec0 <printf+0x40>
    2f2b:	90                   	nop
    2f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    2f30:	83 c4 2c             	add    $0x2c,%esp
    2f33:	5b                   	pop    %ebx
    2f34:	5e                   	pop    %esi
    2f35:	5f                   	pop    %edi
    2f36:	5d                   	pop    %ebp
    2f37:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    2f38:	89 f8                	mov    %edi,%eax
    2f3a:	0f be d1             	movsbl %cl,%edx
    2f3d:	e8 7e fe ff ff       	call   2dc0 <putc>
    2f42:	8b 45 0c             	mov    0xc(%ebp),%eax
    2f45:	e9 6b ff ff ff       	jmp    2eb5 <printf+0x35>
    2f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    2f50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2f53:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    2f58:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    2f5a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f61:	8b 10                	mov    (%eax),%edx
    2f63:	89 f8                	mov    %edi,%eax
    2f65:	e8 86 fe ff ff       	call   2df0 <printint>
    2f6a:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    2f6d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2f71:	e9 3f ff ff ff       	jmp    2eb5 <printf+0x35>
    2f76:	66 90                	xchg   %ax,%ax
      } else if(c == 's'){
        s = (char*)*ap;
    2f78:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    2f7b:	8b 32                	mov    (%edx),%esi
        ap++;
    2f7d:	83 c2 04             	add    $0x4,%edx
    2f80:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        if(s == 0)
    2f83:	85 f6                	test   %esi,%esi
    2f85:	0f 84 84 00 00 00    	je     300f <printf+0x18f>
          s = "(null)";
        while(*s != 0){
    2f8b:	0f b6 16             	movzbl (%esi),%edx
    2f8e:	84 d2                	test   %dl,%dl
    2f90:	74 1d                	je     2faf <printf+0x12f>
    2f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
    2f98:	0f be d2             	movsbl %dl,%edx
          s++;
    2f9b:	83 c6 01             	add    $0x1,%esi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
    2f9e:	89 f8                	mov    %edi,%eax
    2fa0:	e8 1b fe ff ff       	call   2dc0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    2fa5:	0f b6 16             	movzbl (%esi),%edx
    2fa8:	84 d2                	test   %dl,%dl
    2faa:	75 ec                	jne    2f98 <printf+0x118>
    2fac:	8b 45 0c             	mov    0xc(%ebp),%eax
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    2faf:	31 f6                	xor    %esi,%esi
    2fb1:	e9 ff fe ff ff       	jmp    2eb5 <printf+0x35>
    2fb6:	66 90                	xchg   %ax,%ax
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
    2fb8:	89 f8                	mov    %edi,%eax
    2fba:	ba 25 00 00 00       	mov    $0x25,%edx
    2fbf:	e8 fc fd ff ff       	call   2dc0 <putc>
    2fc4:	31 f6                	xor    %esi,%esi
    2fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
    2fc9:	e9 e7 fe ff ff       	jmp    2eb5 <printf+0x35>
    2fce:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    2fd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    2fd3:	b1 0a                	mov    $0xa,%cl
        ap++;
    2fd5:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    2fd8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fdf:	8b 10                	mov    (%eax),%edx
    2fe1:	89 f8                	mov    %edi,%eax
    2fe3:	e8 08 fe ff ff       	call   2df0 <printint>
    2fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    2feb:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    2fef:	e9 c1 fe ff ff       	jmp    2eb5 <printf+0x35>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    2ff4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        ap++;
    2ff7:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    2ff9:	0f be 10             	movsbl (%eax),%edx
    2ffc:	89 f8                	mov    %edi,%eax
    2ffe:	e8 bd fd ff ff       	call   2dc0 <putc>
    3003:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    3006:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    300a:	e9 a6 fe ff ff       	jmp    2eb5 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
    300f:	be d0 43 00 00       	mov    $0x43d0,%esi
    3014:	e9 72 ff ff ff       	jmp    2f8b <printf+0x10b>
    3019:	90                   	nop
    301a:	90                   	nop
    301b:	90                   	nop
    301c:	90                   	nop
    301d:	90                   	nop
    301e:	90                   	nop
    301f:	90                   	nop

00003020 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3020:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3021:	a1 28 44 00 00       	mov    0x4428,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    3026:	89 e5                	mov    %esp,%ebp
    3028:	57                   	push   %edi
    3029:	56                   	push   %esi
    302a:	53                   	push   %ebx
    302b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
    302e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3031:	39 c8                	cmp    %ecx,%eax
    3033:	73 1d                	jae    3052 <free+0x32>
    3035:	8d 76 00             	lea    0x0(%esi),%esi
    3038:	8b 10                	mov    (%eax),%edx
    303a:	39 d1                	cmp    %edx,%ecx
    303c:	72 1a                	jb     3058 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    303e:	39 d0                	cmp    %edx,%eax
    3040:	72 08                	jb     304a <free+0x2a>
    3042:	39 c8                	cmp    %ecx,%eax
    3044:	72 12                	jb     3058 <free+0x38>
    3046:	39 d1                	cmp    %edx,%ecx
    3048:	72 0e                	jb     3058 <free+0x38>
    304a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    304c:	39 c8                	cmp    %ecx,%eax
    304e:	66 90                	xchg   %ax,%ax
    3050:	72 e6                	jb     3038 <free+0x18>
    3052:	8b 10                	mov    (%eax),%edx
    3054:	eb e8                	jmp    303e <free+0x1e>
    3056:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    3058:	8b 71 04             	mov    0x4(%ecx),%esi
    305b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    305e:	39 d7                	cmp    %edx,%edi
    3060:	74 19                	je     307b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3062:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3065:	8b 50 04             	mov    0x4(%eax),%edx
    3068:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    306b:	39 ce                	cmp    %ecx,%esi
    306d:	74 21                	je     3090 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    306f:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3071:	a3 28 44 00 00       	mov    %eax,0x4428
}
    3076:	5b                   	pop    %ebx
    3077:	5e                   	pop    %esi
    3078:	5f                   	pop    %edi
    3079:	5d                   	pop    %ebp
    307a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    307b:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
    307e:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3080:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3083:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3086:	8b 50 04             	mov    0x4(%eax),%edx
    3089:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    308c:	39 ce                	cmp    %ecx,%esi
    308e:	75 df                	jne    306f <free+0x4f>
    p->s.size += bp->s.size;
    3090:	03 51 04             	add    0x4(%ecx),%edx
    3093:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3096:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3099:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    309b:	a3 28 44 00 00       	mov    %eax,0x4428
}
    30a0:	5b                   	pop    %ebx
    30a1:	5e                   	pop    %esi
    30a2:	5f                   	pop    %edi
    30a3:	5d                   	pop    %ebp
    30a4:	c3                   	ret    
    30a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000030b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    30b0:	55                   	push   %ebp
    30b1:	89 e5                	mov    %esp,%ebp
    30b3:	57                   	push   %edi
    30b4:	56                   	push   %esi
    30b5:	53                   	push   %ebx
    30b6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    30b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    30bc:	8b 0d 28 44 00 00    	mov    0x4428,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    30c2:	83 c3 07             	add    $0x7,%ebx
    30c5:	c1 eb 03             	shr    $0x3,%ebx
    30c8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    30cb:	85 c9                	test   %ecx,%ecx
    30cd:	0f 84 93 00 00 00    	je     3166 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    30d3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    30d5:	8b 50 04             	mov    0x4(%eax),%edx
    30d8:	39 d3                	cmp    %edx,%ebx
    30da:	76 1f                	jbe    30fb <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    30dc:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    30e3:	90                   	nop
    30e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
    30e8:	3b 05 28 44 00 00    	cmp    0x4428,%eax
    30ee:	74 30                	je     3120 <malloc+0x70>
    30f0:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    30f2:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    30f4:	8b 50 04             	mov    0x4(%eax),%edx
    30f7:	39 d3                	cmp    %edx,%ebx
    30f9:	77 ed                	ja     30e8 <malloc+0x38>
      if(p->s.size == nunits)
    30fb:	39 d3                	cmp    %edx,%ebx
    30fd:	74 61                	je     3160 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    30ff:	29 da                	sub    %ebx,%edx
    3101:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    3104:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    3107:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    310a:	89 0d 28 44 00 00    	mov    %ecx,0x4428
      return (void*) (p + 1);
    3110:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3113:	83 c4 1c             	add    $0x1c,%esp
    3116:	5b                   	pop    %ebx
    3117:	5e                   	pop    %esi
    3118:	5f                   	pop    %edi
    3119:	5d                   	pop    %ebp
    311a:	c3                   	ret    
    311b:	90                   	nop
    311c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
    3120:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
    3126:	b8 00 80 00 00       	mov    $0x8000,%eax
    312b:	bf 00 10 00 00       	mov    $0x1000,%edi
    3130:	76 04                	jbe    3136 <malloc+0x86>
    3132:	89 f0                	mov    %esi,%eax
    3134:	89 df                	mov    %ebx,%edi
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
    3136:	89 04 24             	mov    %eax,(%esp)
    3139:	e8 62 fc ff ff       	call   2da0 <sbrk>
  if(p == (char*) -1)
    313e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3141:	74 18                	je     315b <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    3143:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    3146:	83 c0 08             	add    $0x8,%eax
    3149:	89 04 24             	mov    %eax,(%esp)
    314c:	e8 cf fe ff ff       	call   3020 <free>
  return freep;
    3151:	8b 0d 28 44 00 00    	mov    0x4428,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    3157:	85 c9                	test   %ecx,%ecx
    3159:	75 97                	jne    30f2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    315b:	31 c0                	xor    %eax,%eax
    315d:	eb b4                	jmp    3113 <malloc+0x63>
    315f:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    3160:	8b 10                	mov    (%eax),%edx
    3162:	89 11                	mov    %edx,(%ecx)
    3164:	eb a4                	jmp    310a <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    3166:	c7 05 28 44 00 00 20 	movl   $0x4420,0x4428
    316d:	44 00 00 
    base.s.size = 0;
    3170:	b9 20 44 00 00       	mov    $0x4420,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    3175:	c7 05 20 44 00 00 20 	movl   $0x4420,0x4420
    317c:	44 00 00 
    base.s.size = 0;
    317f:	c7 05 24 44 00 00 00 	movl   $0x0,0x4424
    3186:	00 00 00 
    3189:	e9 45 ff ff ff       	jmp    30d3 <malloc+0x23>
