
_hackbench:     file format elf32-i386


Disassembly of section .text:

00000000 <barf>:
  short int events;    /* Types of events poller cares about. */
  short int revents;   /* Types of events that actually occurred. */
}pollfd[512];

static void barf(const char *msg)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  printf(STDOUT, "(Error: %s)\n", msg);
   6:	89 44 24 08          	mov    %eax,0x8(%esp)
   a:	c7 44 24 04 80 0c 00 	movl   $0xc80,0x4(%esp)
  11:	00 
  12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  19:	e8 52 09 00 00       	call   970 <printf>
  exit();
  1e:	e8 e5 07 00 00       	call   808 <exit>
  23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000030 <fdpair>:
}

static void fdpair(int fds[2])
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	83 ec 18             	sub    $0x18,%esp
  if (use_pipes) {
  36:	8b 15 e4 0e 00 00    	mov    0xee4,%edx
  3c:	85 d2                	test   %edx,%edx
  3e:	75 08                	jne    48 <fdpair+0x18>
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  }
  //barf("Creating fdpair");
}
  40:	c9                   	leave  
      return;
  } else {
    // This mode would not run correctly in xv6
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  41:	b8 74 0d 00 00       	mov    $0xd74,%eax
  46:	eb b8                	jmp    0 <barf>
static void fdpair(int fds[2])
{
  if (use_pipes) {
    // TODO: Implement myPipe
    //    pipe(fds[0], fds[1]);
    if (pipe(fds) == 0)
  48:	89 04 24             	mov    %eax,(%esp)
  4b:	e8 c8 07 00 00       	call   818 <pipe>
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  }
  //barf("Creating fdpair");
}
  50:	c9                   	leave  
  51:	c3                   	ret    
  52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000060 <T.21>:

static void checkEvents(int id, int event, int caller, char *msg){
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	83 ec 28             	sub    $0x28,%esp
  if(event == POLLIN){
  66:	83 fa 01             	cmp    $0x1,%edx
  69:	74 1d                	je     88 <T.21+0x28>
    }else if(caller == RECEIVER){
      printf(STDOUT, "recv[%d] is %s ... (pollfd[%d].events = POLLIN)\n", id, msg, id);
    }else{
      barf("checkEvents");
    }
  }else if(event == FREE){
  6b:	85 d2                	test   %edx,%edx
  6d:	75 0a                	jne    79 <T.21+0x19>
    if(caller == SENDER){
  6f:	83 f9 01             	cmp    $0x1,%ecx
  72:	74 6c                	je     e0 <T.21+0x80>
      printf(STDOUT, "send[%d] is %s ... (pollfd[%d].events = FREE)\n", id, msg, id);
    }else if(caller == RECEIVER){
  74:	83 f9 02             	cmp    $0x2,%ecx
  77:	74 3f                	je     b8 <T.21+0x58>
      barf("checkEvents");
    }
  }else{
    barf("checkEvents");
  }	      
}
  79:	c9                   	leave  
      printf(STDOUT, "recv[%d] is %s ... (pollfd[%d].events = FREE)\n", id, msg, id);
    }else{
      barf("checkEvents");
    }
  }else{
    barf("checkEvents");
  7a:	b8 93 0c 00 00       	mov    $0xc93,%eax
  7f:	e9 7c ff ff ff       	jmp    0 <barf>
  84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  //barf("Creating fdpair");
}

static void checkEvents(int id, int event, int caller, char *msg){
  if(event == POLLIN){
    if(caller == SENDER){
  88:	83 f9 01             	cmp    $0x1,%ecx
  8b:	74 7b                	je     108 <T.21+0xa8>
      printf(STDOUT, "send[%d] is %s ... (pollfd[%d].events = POLLIN)\n", id, msg, id);
    }else if(caller == RECEIVER){
  8d:	83 f9 02             	cmp    $0x2,%ecx
  90:	75 e7                	jne    79 <T.21+0x19>
      printf(STDOUT, "recv[%d] is %s ... (pollfd[%d].events = POLLIN)\n", id, msg, id);
  92:	89 44 24 10          	mov    %eax,0x10(%esp)
  96:	c7 44 24 0c 8d 0c 00 	movl   $0xc8d,0xc(%esp)
  9d:	00 
  9e:	89 44 24 08          	mov    %eax,0x8(%esp)
  a2:	c7 44 24 04 cc 0d 00 	movl   $0xdcc,0x4(%esp)
  a9:	00 
  aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b1:	e8 ba 08 00 00       	call   970 <printf>
      barf("checkEvents");
    }
  }else{
    barf("checkEvents");
  }	      
}
  b6:	c9                   	leave  
  b7:	c3                   	ret    
    }
  }else if(event == FREE){
    if(caller == SENDER){
      printf(STDOUT, "send[%d] is %s ... (pollfd[%d].events = FREE)\n", id, msg, id);
    }else if(caller == RECEIVER){
      printf(STDOUT, "recv[%d] is %s ... (pollfd[%d].events = FREE)\n", id, msg, id);
  b8:	89 44 24 10          	mov    %eax,0x10(%esp)
  bc:	c7 44 24 0c 8d 0c 00 	movl   $0xc8d,0xc(%esp)
  c3:	00 
  c4:	89 44 24 08          	mov    %eax,0x8(%esp)
  c8:	c7 44 24 04 30 0e 00 	movl   $0xe30,0x4(%esp)
  cf:	00 
  d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d7:	e8 94 08 00 00       	call   970 <printf>
      barf("checkEvents");
    }
  }else{
    barf("checkEvents");
  }	      
}
  dc:	c9                   	leave  
  dd:	c3                   	ret    
  de:	66 90                	xchg   %ax,%ax
    }else{
      barf("checkEvents");
    }
  }else if(event == FREE){
    if(caller == SENDER){
      printf(STDOUT, "send[%d] is %s ... (pollfd[%d].events = FREE)\n", id, msg, id);
  e0:	89 44 24 10          	mov    %eax,0x10(%esp)
  e4:	c7 44 24 0c 8d 0c 00 	movl   $0xc8d,0xc(%esp)
  eb:	00 
  ec:	89 44 24 08          	mov    %eax,0x8(%esp)
  f0:	c7 44 24 04 00 0e 00 	movl   $0xe00,0x4(%esp)
  f7:	00 
  f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ff:	e8 6c 08 00 00       	call   970 <printf>
      barf("checkEvents");
    }
  }else{
    barf("checkEvents");
  }	      
}
 104:	c9                   	leave  
 105:	c3                   	ret    
 106:	66 90                	xchg   %ax,%ax
}

static void checkEvents(int id, int event, int caller, char *msg){
  if(event == POLLIN){
    if(caller == SENDER){
      printf(STDOUT, "send[%d] is %s ... (pollfd[%d].events = POLLIN)\n", id, msg, id);
 108:	89 44 24 10          	mov    %eax,0x10(%esp)
 10c:	c7 44 24 0c 8d 0c 00 	movl   $0xc8d,0xc(%esp)
 113:	00 
 114:	89 44 24 08          	mov    %eax,0x8(%esp)
 118:	c7 44 24 04 98 0d 00 	movl   $0xd98,0x4(%esp)
 11f:	00 
 120:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 127:	e8 44 08 00 00       	call   970 <printf>
      barf("checkEvents");
    }
  }else{
    barf("checkEvents");
  }	      
}
 12c:	c9                   	leave  
 12d:	c3                   	ret    
 12e:	66 90                	xchg   %ax,%ax

00000130 <ready>:

/* Block until we're ready to go */
static void ready(int ready_out, int wakefd, int id, int caller)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	56                   	push   %esi
 134:	53                   	push   %ebx
 135:	89 cb                	mov    %ecx,%ebx
 137:	83 ec 20             	sub    $0x20,%esp
 13a:	8b 75 08             	mov    0x8(%ebp),%esi
  char dummy;
  // TODO: Implement myPoll function
  pollfd[id].fd = wakefd;
 13d:	89 14 cd 20 0f 00 00 	mov    %edx,0xf20(,%ecx,8)
  pollfd[id].events = POLLIN;

  /* Tell them we're ready. */
  if (write(ready_out, &dummy, 1) != 1)
 144:	8d 55 f7             	lea    -0x9(%ebp),%edx
static void ready(int ready_out, int wakefd, int id, int caller)
{
  char dummy;
  // TODO: Implement myPoll function
  pollfd[id].fd = wakefd;
  pollfd[id].events = POLLIN;
 147:	66 c7 04 cd 24 0f 00 	movw   $0x1,0xf24(,%ecx,8)
 14e:	00 01 00 

  /* Tell them we're ready. */
  if (write(ready_out, &dummy, 1) != 1)
 151:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 158:	00 
 159:	89 54 24 04          	mov    %edx,0x4(%esp)
 15d:	89 04 24             	mov    %eax,(%esp)
 160:	e8 c3 06 00 00       	call   828 <write>
 165:	83 f8 01             	cmp    $0x1,%eax
 168:	74 0a                	je     174 <ready+0x44>
    barf("CLIENT: ready write");
 16a:	b8 9f 0c 00 00       	mov    $0xc9f,%eax
 16f:	e8 8c fe ff ff       	call   0 <barf>

  /* Wait for "GO" signal */
  //TODO: Polling should be re-implemented for xv6.
  //if (poll(&pollfd, 1, -1) != 1)
  //        barf("poll");
  if(caller == SENDER){
 174:	83 fe 01             	cmp    $0x1,%esi
 177:	74 37                	je     1b0 <ready+0x80>
    //checkEvents(id, pollfd[id].events, caller, "waiting");
    //while(pollfd[id].events == POLLIN);
    checkEvents(id, pollfd[id].events, caller, "ready");
  }else if(caller == RECEIVER){
 179:	83 fe 02             	cmp    $0x2,%esi
 17c:	74 12                	je     190 <ready+0x60>
    pollfd[id].events = FREE;
    //while(getticks() < TIMEOUT);
    checkEvents(id, pollfd[id].events, caller, "ready");
  }else{
    barf("Failed being ready.");
 17e:	b8 b3 0c 00 00       	mov    $0xcb3,%eax
 183:	e8 78 fe ff ff       	call   0 <barf>
  }
}
 188:	83 c4 20             	add    $0x20,%esp
 18b:	5b                   	pop    %ebx
 18c:	5e                   	pop    %esi
 18d:	5d                   	pop    %ebp
 18e:	c3                   	ret    
 18f:	90                   	nop
    //while(pollfd[id].events == POLLIN);
    checkEvents(id, pollfd[id].events, caller, "ready");
  }else if(caller == RECEIVER){
    pollfd[id].events = FREE;
    //while(getticks() < TIMEOUT);
    checkEvents(id, pollfd[id].events, caller, "ready");
 190:	89 d8                	mov    %ebx,%eax
 192:	b9 02 00 00 00       	mov    $0x2,%ecx
 197:	31 d2                	xor    %edx,%edx
  if(caller == SENDER){
    //checkEvents(id, pollfd[id].events, caller, "waiting");
    //while(pollfd[id].events == POLLIN);
    checkEvents(id, pollfd[id].events, caller, "ready");
  }else if(caller == RECEIVER){
    pollfd[id].events = FREE;
 199:	66 c7 04 dd 24 0f 00 	movw   $0x0,0xf24(,%ebx,8)
 1a0:	00 00 00 
    //while(getticks() < TIMEOUT);
    checkEvents(id, pollfd[id].events, caller, "ready");
 1a3:	e8 b8 fe ff ff       	call   60 <T.21>
  }else{
    barf("Failed being ready.");
  }
}
 1a8:	83 c4 20             	add    $0x20,%esp
 1ab:	5b                   	pop    %ebx
 1ac:	5e                   	pop    %esi
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    
 1af:	90                   	nop
  //if (poll(&pollfd, 1, -1) != 1)
  //        barf("poll");
  if(caller == SENDER){
    //checkEvents(id, pollfd[id].events, caller, "waiting");
    //while(pollfd[id].events == POLLIN);
    checkEvents(id, pollfd[id].events, caller, "ready");
 1b0:	0f bf 14 dd 24 0f 00 	movswl 0xf24(,%ebx,8),%edx
 1b7:	00 
 1b8:	b9 01 00 00 00       	mov    $0x1,%ecx
 1bd:	89 d8                	mov    %ebx,%eax
 1bf:	e8 9c fe ff ff       	call   60 <T.21>
 1c4:	eb c2                	jmp    188 <ready+0x58>
 1c6:	8d 76 00             	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <group>:

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	89 c7                	mov    %eax,%edi
 1d6:	56                   	push   %esi
 1d7:	53                   	push   %ebx
  unsigned int i;
  unsigned int out_fds[num_fds];
 1d8:	8d 04 85 1e 00 00 00 	lea    0x1e(,%eax,4),%eax

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
 1df:	81 ec bc 00 00 00    	sub    $0xbc,%esp
  unsigned int i;
  unsigned int out_fds[num_fds];
 1e5:	83 e0 f0             	and    $0xfffffff0,%eax
 1e8:	29 c4                	sub    %eax,%esp
 1ea:	8d 5c 24 2b          	lea    0x2b(%esp),%ebx
 1ee:	83 e3 f0             	and    $0xfffffff0,%ebx

  for (i = 0; i < num_fds; i++) {
 1f1:	85 ff                	test   %edi,%edi

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
 1f3:	89 95 70 ff ff ff    	mov    %edx,-0x90(%ebp)
 1f9:	89 8d 68 ff ff ff    	mov    %ecx,-0x98(%ebp)
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
 1ff:	74 59                	je     25a <group+0x8a>
 201:	31 f6                	xor    %esi,%esi
    int fds[2];

    /* Create the pipe between client and server */
    fdpair(fds);
 203:	8d 45 e0             	lea    -0x20(%ebp),%eax
 206:	e8 25 fe ff ff       	call   30 <fdpair>

    /* Fork the receiver. */
    switch (fork()) {
 20b:	e8 f0 05 00 00       	call   800 <fork>
 210:	83 f8 ff             	cmp    $0xffffffff,%eax
 213:	74 6b                	je     280 <group+0xb0>
 215:	85 c0                	test   %eax,%eax
 217:	74 71                	je     28a <group+0xba>
      close(fds[1]);
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
      exit();
    }

    out_fds[i] = fds[1];
 219:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 21c:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
    close(fds[0]);
 21f:	8b 45 e0             	mov    -0x20(%ebp),%eax
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
 222:	83 c6 01             	add    $0x1,%esi
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
      exit();
    }

    out_fds[i] = fds[1];
    close(fds[0]);
 225:	89 04 24             	mov    %eax,(%esp)
 228:	e8 03 06 00 00       	call   830 <close>
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
 22d:	39 f7                	cmp    %esi,%edi
 22f:	77 d2                	ja     203 <group+0x33>
 231:	c7 85 6c ff ff ff 00 	movl   $0x0,-0x94(%ebp)
 238:	00 00 00 
 23b:	31 f6                	xor    %esi,%esi
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
    switch (fork()) {
 23d:	e8 be 05 00 00       	call   800 <fork>
 242:	83 f8 ff             	cmp    $0xffffffff,%eax
 245:	0f 84 51 02 00 00    	je     49c <group+0x2cc>
 24b:	85 c0                	test   %eax,%eax
 24d:	0f 84 13 01 00 00    	je     366 <group+0x196>
    out_fds[i] = fds[1];
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
 253:	83 c6 01             	add    $0x1,%esi
 256:	39 f7                	cmp    %esi,%edi
 258:	77 e3                	ja     23d <group+0x6d>
 25a:	31 f6                	xor    %esi,%esi
 25c:	eb 0e                	jmp    26c <group+0x9c>
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
    close(out_fds[i]);
 25e:	8b 04 b3             	mov    (%ebx,%esi,4),%eax
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 261:	83 c6 01             	add    $0x1,%esi
    close(out_fds[i]);
 264:	89 04 24             	mov    %eax,(%esp)
 267:	e8 c4 05 00 00       	call   830 <close>
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 26c:	39 fe                	cmp    %edi,%esi
 26e:	72 ee                	jb     25e <group+0x8e>
    close(out_fds[i]);

  /* Return number of children to reap */
  return num_fds * 2;
}
 270:	8d 65 f4             	lea    -0xc(%ebp),%esp
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 273:	8d 04 3f             	lea    (%edi,%edi,1),%eax
    close(out_fds[i]);

  /* Return number of children to reap */
  return num_fds * 2;
}
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5f                   	pop    %edi
 279:	5d                   	pop    %ebp
 27a:	c3                   	ret    
 27b:	90                   	nop
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    /* Create the pipe between client and server */
    fdpair(fds);

    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
 280:	b8 c7 0c 00 00       	mov    $0xcc7,%eax
 285:	e8 76 fd ff ff       	call   0 <barf>
    case 0:
      close(fds[1]);
 28a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 28d:	6b df 64             	imul   $0x64,%edi,%ebx

    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
 290:	89 04 24             	mov    %eax,(%esp)
 293:	e8 98 05 00 00       	call   830 <close>
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 298:	8b 45 e0             	mov    -0x20(%ebp),%eax
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 29b:	89 f1                	mov    %esi,%ecx
 29d:	8b 95 68 ff ff ff    	mov    -0x98(%ebp),%edx
 2a3:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 2aa:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 2b0:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
 2b6:	e8 75 fe ff ff       	call   130 <ready>

  /* Receive them all */
  int timeout = 0;
  for (i = 0; i < num_packets; i++) {
 2bb:	85 db                	test   %ebx,%ebx
 2bd:	0f 84 c5 01 00 00    	je     488 <group+0x2b8>
 2c3:	8d 95 7c ff ff ff    	lea    -0x84(%ebp),%edx
 2c9:	31 ff                	xor    %edi,%edi
 2cb:	89 95 70 ff ff ff    	mov    %edx,-0x90(%ebp)
 2d1:	eb 30                	jmp    303 <group+0x133>
 2d3:	90                   	nop
 2d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    done += ret;
    if (done < DATASIZE){
      timeout++;
      if(timeout < TIMEOUT)goto again;
    }
    printf(STDOUT, "recv[%d]'s task has done. (%d/%d)\n", id, i, num_packets);
 2d8:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);

  /* Receive them all */
  int timeout = 0;
  for (i = 0; i < num_packets; i++) {
 2dc:	83 c7 01             	add    $0x1,%edi
    done += ret;
    if (done < DATASIZE){
      timeout++;
      if(timeout < TIMEOUT)goto again;
    }
    printf(STDOUT, "recv[%d]'s task has done. (%d/%d)\n", id, i, num_packets);
 2df:	89 5c 24 10          	mov    %ebx,0x10(%esp)
 2e3:	89 74 24 08          	mov    %esi,0x8(%esp)
 2e7:	c7 44 24 04 60 0e 00 	movl   $0xe60,0x4(%esp)
 2ee:	00 
 2ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2f6:	e8 75 06 00 00       	call   970 <printf>
  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);

  /* Receive them all */
  int timeout = 0;
  for (i = 0; i < num_packets; i++) {
 2fb:	39 fb                	cmp    %edi,%ebx
 2fd:	0f 86 85 01 00 00    	jbe    488 <group+0x2b8>
    char data[DATASIZE];
    int ret, done = 0;

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
 303:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
 309:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
 30f:	c7 44 24 08 64 00 00 	movl   $0x64,0x8(%esp)
 316:	00 
 317:	89 14 24             	mov    %edx,(%esp)
 31a:	89 44 24 04          	mov    %eax,0x4(%esp)
 31e:	e8 fd 04 00 00       	call   820 <read>
    printf(STDOUT, "recv[%d]: ret = %d. (%d/%d)\n", id, ret, i, num_packets);
 323:	89 5c 24 14          	mov    %ebx,0x14(%esp)
 327:	89 7c 24 10          	mov    %edi,0x10(%esp)
 32b:	89 74 24 08          	mov    %esi,0x8(%esp)
 32f:	c7 44 24 04 ce 0c 00 	movl   $0xcce,0x4(%esp)
 336:	00 
 337:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 33e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 342:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
 348:	e8 23 06 00 00       	call   970 <printf>
    if (ret < 0)
 34d:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
 353:	85 c0                	test   %eax,%eax
 355:	79 81                	jns    2d8 <group+0x108>
      barf("SERVER: read");
 357:	b8 eb 0c 00 00       	mov    $0xceb,%eax
 35c:	e8 9f fc ff ff       	call   0 <barf>
 361:	e9 72 ff ff ff       	jmp    2d8 <group+0x108>
 366:	89 b5 6c ff ff ff    	mov    %esi,-0x94(%ebp)
{
  char data[DATASIZE];
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 36c:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
 372:	8b 8d 6c ff ff ff    	mov    -0x94(%ebp),%ecx
 378:	8b 95 68 ff ff ff    	mov    -0x98(%ebp),%edx
 37e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 385:	e8 a6 fd ff ff       	call   130 <ready>
 38a:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
 390:	c7 85 74 ff ff ff 00 	movl   $0x0,-0x8c(%ebp)
 397:	00 00 00 
 39a:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
 3a0:	89 9d 68 ff ff ff    	mov    %ebx,-0x98(%ebp)
 3a6:	66 90                	xchg   %ax,%ax

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
 3a8:	31 db                	xor    %ebx,%ebx
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  char data[DATASIZE];
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 3b0:	31 f6                	xor    %esi,%esi
 3b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
      int ret, done = 0;

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
 3b8:	b8 64 00 00 00       	mov    $0x64,%eax
 3bd:	8b 95 68 ff ff ff    	mov    -0x98(%ebp),%edx
 3c3:	29 f0                	sub    %esi,%eax
 3c5:	89 44 24 08          	mov    %eax,0x8(%esp)
 3c9:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
 3cf:	01 f0                	add    %esi,%eax
 3d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 3d5:	8b 04 9a             	mov    (%edx,%ebx,4),%eax
 3d8:	89 04 24             	mov    %eax,(%esp)
 3db:	e8 48 04 00 00       	call   828 <write>
      printf(STDOUT, "send[%d]: ret = %d. (%d/%d/%d)\n", id, ret, i, num_fds, loops);
 3e0:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
 3e6:	c7 44 24 18 64 00 00 	movl   $0x64,0x18(%esp)
 3ed:	00 
 3ee:	c7 44 24 14 14 00 00 	movl   $0x14,0x14(%esp)
 3f5:	00 
 3f6:	c7 44 24 04 84 0e 00 	movl   $0xe84,0x4(%esp)
 3fd:	00 
 3fe:	89 54 24 08          	mov    %edx,0x8(%esp)
 402:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
      int ret, done = 0;

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
 409:	89 c7                	mov    %eax,%edi
      printf(STDOUT, "send[%d]: ret = %d. (%d/%d/%d)\n", id, ret, i, num_fds, loops);
 40b:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
 411:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 415:	89 44 24 10          	mov    %eax,0x10(%esp)
 419:	e8 52 05 00 00       	call   970 <printf>
      if (ret < 0)
 41e:	85 ff                	test   %edi,%edi
 420:	78 6e                	js     490 <group+0x2c0>
	barf("SENDER: write");
      done += ret;
 422:	01 fe                	add    %edi,%esi
      if (done < sizeof(data))
 424:	83 fe 63             	cmp    $0x63,%esi
 427:	76 8f                	jbe    3b8 <group+0x1e8>
	goto again;
      printf(STDOUT, "send[%d]'s task has done. (%d/%d/%d)\n", id, ret, i, num_fds, loops);
 429:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
 42f:	83 c3 01             	add    $0x1,%ebx
      if (ret < 0)
	barf("SENDER: write");
      done += ret;
      if (done < sizeof(data))
	goto again;
      printf(STDOUT, "send[%d]'s task has done. (%d/%d/%d)\n", id, ret, i, num_fds, loops);
 432:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
 438:	c7 44 24 18 64 00 00 	movl   $0x64,0x18(%esp)
 43f:	00 
 440:	c7 44 24 14 14 00 00 	movl   $0x14,0x14(%esp)
 447:	00 
 448:	89 44 24 10          	mov    %eax,0x10(%esp)
 44c:	89 7c 24 0c          	mov    %edi,0xc(%esp)
 450:	89 54 24 08          	mov    %edx,0x8(%esp)
 454:	c7 44 24 04 a4 0e 00 	movl   $0xea4,0x4(%esp)
 45b:	00 
 45c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 463:	e8 08 05 00 00       	call   970 <printf>
  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
 468:	83 fb 14             	cmp    $0x14,%ebx
 46b:	0f 85 3f ff ff ff    	jne    3b0 <group+0x1e0>

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
 471:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
 478:	83 bd 74 ff ff ff 64 	cmpl   $0x64,-0x8c(%ebp)
 47f:	0f 85 23 ff ff ff    	jne    3a8 <group+0x1d8>
 485:	8d 76 00             	lea    0x0(%esi),%esi
  for (i = 0; i < num_fds; i++) {
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      sender(num_fds, out_fds, ready_out, wakefd, i);
      exit();
 488:	e8 7b 03 00 00       	call   808 <exit>
 48d:	8d 76 00             	lea    0x0(%esi),%esi

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
      printf(STDOUT, "send[%d]: ret = %d. (%d/%d/%d)\n", id, ret, i, num_fds, loops);
      if (ret < 0)
	barf("SENDER: write");
 490:	b8 f8 0c 00 00       	mov    $0xcf8,%eax
 495:	e8 66 fb ff ff       	call   0 <barf>
 49a:	eb 86                	jmp    422 <group+0x252>
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
    switch (fork()) {
    case -1: barf("fork()");
 49c:	b8 c7 0c 00 00       	mov    $0xcc7,%eax
 4a1:	89 b5 6c ff ff ff    	mov    %esi,-0x94(%ebp)
 4a7:	e8 54 fb ff ff       	call   0 <barf>
 4ac:	e9 bb fe ff ff       	jmp    36c <group+0x19c>
 4b1:	eb 0d                	jmp    4c0 <main>
 4b3:	90                   	nop
 4b4:	90                   	nop
 4b5:	90                   	nop
 4b6:	90                   	nop
 4b7:	90                   	nop
 4b8:	90                   	nop
 4b9:	90                   	nop
 4ba:	90                   	nop
 4bb:	90                   	nop
 4bc:	90                   	nop
 4bd:	90                   	nop
 4be:	90                   	nop
 4bf:	90                   	nop

000004c0 <main>:
  /* Return number of children to reap */
  return num_fds * 2;
}

int main(int argc, char *argv[])
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	83 e4 f0             	and    $0xfffffff0,%esp
 4c6:	57                   	push   %edi
 4c7:	56                   	push   %esi
 4c8:	53                   	push   %ebx
 4c9:	83 ec 44             	sub    $0x44,%esp
  //if (argc != 2 || (num_groups = atoi(argv[1])) == 0)
  //        barf("Usage: hackbench [-pipe] <num groups>\n");

  num_groups = 1; // TODO: This may seriously be considered.

  fdpair(readyfds);
 4cc:	8d 44 24 34          	lea    0x34(%esp),%eax
    use_pipes = 1;
    argc--;
    argv++;
    }
  */
  use_pipes = 1;
 4d0:	c7 05 e4 0e 00 00 01 	movl   $0x1,0xee4
 4d7:	00 00 00 
 4da:	8d 7c 24 3f          	lea    0x3f(%esp),%edi
  //if (argc != 2 || (num_groups = atoi(argv[1])) == 0)
  //        barf("Usage: hackbench [-pipe] <num groups>\n");

  num_groups = 1; // TODO: This may seriously be considered.

  fdpair(readyfds);
 4de:	e8 4d fb ff ff       	call   30 <fdpair>
  fdpair(wakefds);
 4e3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
 4e7:	e8 44 fb ff ff       	call   30 <fdpair>

  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);
 4ec:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
 4f0:	b8 14 00 00 00       	mov    $0x14,%eax
 4f5:	8b 54 24 38          	mov    0x38(%esp),%edx
 4f9:	e8 d2 fc ff ff       	call   1d0 <group>

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
 4fe:	85 c0                	test   %eax,%eax
  fdpair(readyfds);
  fdpair(wakefds);

  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);
 500:	89 c6                	mov    %eax,%esi

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
 502:	74 32                	je     536 <main+0x76>
 504:	31 db                	xor    %ebx,%ebx
 506:	66 90                	xchg   %ax,%ax
    if (read(readyfds[0], &dummy, 1) != 1)
 508:	8b 44 24 34          	mov    0x34(%esp),%eax
 50c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 513:	00 
 514:	89 7c 24 04          	mov    %edi,0x4(%esp)
 518:	89 04 24             	mov    %eax,(%esp)
 51b:	e8 00 03 00 00       	call   820 <read>
 520:	83 f8 01             	cmp    $0x1,%eax
 523:	74 0a                	je     52f <main+0x6f>
      barf("Reading for readyfds");
 525:	b8 06 0d 00 00       	mov    $0xd06,%eax
 52a:	e8 d1 fa ff ff       	call   0 <barf>
  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
 52f:	83 c3 01             	add    $0x1,%ebx
 532:	39 de                	cmp    %ebx,%esi
 534:	77 d2                	ja     508 <main+0x48>
    if (read(readyfds[0], &dummy, 1) != 1)
      barf("Reading for readyfds");

  //gettimeofday(&start, NULL);
  start = getticks();
 536:	e8 65 03 00 00       	call   8a0 <getticks>
  printf(STDOUT, "Start Watching Time ...\n");
 53b:	c7 44 24 04 1b 0d 00 	movl   $0xd1b,0x4(%esp)
 542:	00 
 543:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  for (i = 0; i < total_children; i++)
    if (read(readyfds[0], &dummy, 1) != 1)
      barf("Reading for readyfds");

  //gettimeofday(&start, NULL);
  start = getticks();
 54a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(STDOUT, "Start Watching Time ...\n");
 54e:	e8 1d 04 00 00       	call   970 <printf>
  

  /* Kick them off */
  if (write(wakefds[1], &dummy, 1) != 1)
 553:	8b 44 24 30          	mov    0x30(%esp),%eax
 557:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 55e:	00 
 55f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 563:	89 04 24             	mov    %eax,(%esp)
 566:	e8 bd 02 00 00       	call   828 <write>
 56b:	83 f8 01             	cmp    $0x1,%eax
 56e:	74 0a                	je     57a <main+0xba>
    barf("Writing to start them");
 570:	b8 34 0d 00 00       	mov    $0xd34,%eax
 575:	e8 86 fa ff ff       	call   0 <barf>

  /* Reap them all */
  //TODO: Fix different specifications between xv6 and Linux
  for (i = 0; i < total_children; i++) {
 57a:	85 f6                	test   %esi,%esi
 57c:	74 0e                	je     58c <main+0xcc>
 57e:	31 db                	xor    %ebx,%ebx
 580:	83 c3 01             	add    $0x1,%ebx
    int status;
    //wait(&status); // TODO: Too Many Arguments???
    wait();
 583:	e8 88 02 00 00       	call   810 <wait>
  if (write(wakefds[1], &dummy, 1) != 1)
    barf("Writing to start them");

  /* Reap them all */
  //TODO: Fix different specifications between xv6 and Linux
  for (i = 0; i < total_children; i++) {
 588:	39 de                	cmp    %ebx,%esi
 58a:	77 f4                	ja     580 <main+0xc0>
    // TODO: What's WIFEXITED ???
    //if (!WIFEXITED(status))
    //  exit();
  }
  
  stop = getticks();
 58c:	e8 0f 03 00 00       	call   8a0 <getticks>
  printf(STDOUT, "Stop Watching Time ...\n");
 591:	c7 44 24 04 4a 0d 00 	movl   $0xd4a,0x4(%esp)
 598:	00 
 599:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    // TODO: What's WIFEXITED ???
    //if (!WIFEXITED(status))
    //  exit();
  }
  
  stop = getticks();
 5a0:	89 c3                	mov    %eax,%ebx
  printf(STDOUT, "Stop Watching Time ...\n");
 5a2:	e8 c9 03 00 00       	call   970 <printf>
  diff = stop - start;

  /* Print time... */
  printf(STDOUT, "Time: %d [ticks]\n", diff);
 5a7:	89 d8                	mov    %ebx,%eax
 5a9:	2b 44 24 1c          	sub    0x1c(%esp),%eax
 5ad:	c7 44 24 04 62 0d 00 	movl   $0xd62,0x4(%esp)
 5b4:	00 
 5b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5bc:	89 44 24 08          	mov    %eax,0x8(%esp)
 5c0:	e8 ab 03 00 00       	call   970 <printf>
  exit();
 5c5:	e8 3e 02 00 00       	call   808 <exit>
 5ca:	90                   	nop
 5cb:	90                   	nop
 5cc:	90                   	nop
 5cd:	90                   	nop
 5ce:	90                   	nop
 5cf:	90                   	nop

000005d0 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 5d0:	55                   	push   %ebp
 5d1:	31 d2                	xor    %edx,%edx
 5d3:	89 e5                	mov    %esp,%ebp
 5d5:	8b 45 08             	mov    0x8(%ebp),%eax
 5d8:	53                   	push   %ebx
 5d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 5e0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 5e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5e7:	83 c2 01             	add    $0x1,%edx
 5ea:	84 c9                	test   %cl,%cl
 5ec:	75 f2                	jne    5e0 <strcpy+0x10>
    ;
  return os;
}
 5ee:	5b                   	pop    %ebx
 5ef:	5d                   	pop    %ebp
 5f0:	c3                   	ret    
 5f1:	eb 0d                	jmp    600 <strcmp>
 5f3:	90                   	nop
 5f4:	90                   	nop
 5f5:	90                   	nop
 5f6:	90                   	nop
 5f7:	90                   	nop
 5f8:	90                   	nop
 5f9:	90                   	nop
 5fa:	90                   	nop
 5fb:	90                   	nop
 5fc:	90                   	nop
 5fd:	90                   	nop
 5fe:	90                   	nop
 5ff:	90                   	nop

00000600 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	53                   	push   %ebx
 604:	8b 4d 08             	mov    0x8(%ebp),%ecx
 607:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 60a:	0f b6 01             	movzbl (%ecx),%eax
 60d:	84 c0                	test   %al,%al
 60f:	75 14                	jne    625 <strcmp+0x25>
 611:	eb 25                	jmp    638 <strcmp+0x38>
 613:	90                   	nop
 614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 618:	83 c1 01             	add    $0x1,%ecx
 61b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 61e:	0f b6 01             	movzbl (%ecx),%eax
 621:	84 c0                	test   %al,%al
 623:	74 13                	je     638 <strcmp+0x38>
 625:	0f b6 1a             	movzbl (%edx),%ebx
 628:	38 d8                	cmp    %bl,%al
 62a:	74 ec                	je     618 <strcmp+0x18>
 62c:	0f b6 db             	movzbl %bl,%ebx
 62f:	0f b6 c0             	movzbl %al,%eax
 632:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 634:	5b                   	pop    %ebx
 635:	5d                   	pop    %ebp
 636:	c3                   	ret    
 637:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 638:	0f b6 1a             	movzbl (%edx),%ebx
 63b:	31 c0                	xor    %eax,%eax
 63d:	0f b6 db             	movzbl %bl,%ebx
 640:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 642:	5b                   	pop    %ebx
 643:	5d                   	pop    %ebp
 644:	c3                   	ret    
 645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <strlen>:

uint
strlen(char *s)
{
 650:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 651:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 653:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 655:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 657:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 65a:	80 39 00             	cmpb   $0x0,(%ecx)
 65d:	74 0c                	je     66b <strlen+0x1b>
 65f:	90                   	nop
 660:	83 c2 01             	add    $0x1,%edx
 663:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 667:	89 d0                	mov    %edx,%eax
 669:	75 f5                	jne    660 <strlen+0x10>
    ;
  return n;
}
 66b:	5d                   	pop    %ebp
 66c:	c3                   	ret    
 66d:	8d 76 00             	lea    0x0(%esi),%esi

00000670 <memset>:

void*
memset(void *dst, int c, uint n)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	8b 4d 10             	mov    0x10(%ebp),%ecx
 676:	53                   	push   %ebx
 677:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 67a:	85 c9                	test   %ecx,%ecx
 67c:	74 14                	je     692 <memset+0x22>
 67e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 682:	31 d2                	xor    %edx,%edx
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 688:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 68b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 68e:	39 ca                	cmp    %ecx,%edx
 690:	75 f6                	jne    688 <memset+0x18>
    *d++ = c;
  return dst;
}
 692:	5b                   	pop    %ebx
 693:	5d                   	pop    %ebp
 694:	c3                   	ret    
 695:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <strchr>:

char*
strchr(const char *s, char c)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	8b 45 08             	mov    0x8(%ebp),%eax
 6a6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 6aa:	0f b6 10             	movzbl (%eax),%edx
 6ad:	84 d2                	test   %dl,%dl
 6af:	75 11                	jne    6c2 <strchr+0x22>
 6b1:	eb 15                	jmp    6c8 <strchr+0x28>
 6b3:	90                   	nop
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6b8:	83 c0 01             	add    $0x1,%eax
 6bb:	0f b6 10             	movzbl (%eax),%edx
 6be:	84 d2                	test   %dl,%dl
 6c0:	74 06                	je     6c8 <strchr+0x28>
    if(*s == c)
 6c2:	38 ca                	cmp    %cl,%dl
 6c4:	75 f2                	jne    6b8 <strchr+0x18>
      return (char*) s;
  return 0;
}
 6c6:	5d                   	pop    %ebp
 6c7:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 6c8:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 6ca:	5d                   	pop    %ebp
 6cb:	90                   	nop
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d0:	c3                   	ret    
 6d1:	eb 0d                	jmp    6e0 <atoi>
 6d3:	90                   	nop
 6d4:	90                   	nop
 6d5:	90                   	nop
 6d6:	90                   	nop
 6d7:	90                   	nop
 6d8:	90                   	nop
 6d9:	90                   	nop
 6da:	90                   	nop
 6db:	90                   	nop
 6dc:	90                   	nop
 6dd:	90                   	nop
 6de:	90                   	nop
 6df:	90                   	nop

000006e0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 6e0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6e1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 6e3:	89 e5                	mov    %esp,%ebp
 6e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 6e8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6e9:	0f b6 11             	movzbl (%ecx),%edx
 6ec:	8d 5a d0             	lea    -0x30(%edx),%ebx
 6ef:	80 fb 09             	cmp    $0x9,%bl
 6f2:	77 1c                	ja     710 <atoi+0x30>
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 6f8:	0f be d2             	movsbl %dl,%edx
 6fb:	83 c1 01             	add    $0x1,%ecx
 6fe:	8d 04 80             	lea    (%eax,%eax,4),%eax
 701:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 705:	0f b6 11             	movzbl (%ecx),%edx
 708:	8d 5a d0             	lea    -0x30(%edx),%ebx
 70b:	80 fb 09             	cmp    $0x9,%bl
 70e:	76 e8                	jbe    6f8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 710:	5b                   	pop    %ebx
 711:	5d                   	pop    %ebp
 712:	c3                   	ret    
 713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	56                   	push   %esi
 724:	8b 45 08             	mov    0x8(%ebp),%eax
 727:	53                   	push   %ebx
 728:	8b 5d 10             	mov    0x10(%ebp),%ebx
 72b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 72e:	85 db                	test   %ebx,%ebx
 730:	7e 14                	jle    746 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 732:	31 d2                	xor    %edx,%edx
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 738:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 73c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 73f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 742:	39 da                	cmp    %ebx,%edx
 744:	75 f2                	jne    738 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 746:	5b                   	pop    %ebx
 747:	5e                   	pop    %esi
 748:	5d                   	pop    %ebp
 749:	c3                   	ret    
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000750 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 756:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 759:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 75c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 75f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 764:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 76b:	00 
 76c:	89 04 24             	mov    %eax,(%esp)
 76f:	e8 d4 00 00 00       	call   848 <open>
  if(fd < 0)
 774:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 776:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 778:	78 19                	js     793 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 77a:	8b 45 0c             	mov    0xc(%ebp),%eax
 77d:	89 1c 24             	mov    %ebx,(%esp)
 780:	89 44 24 04          	mov    %eax,0x4(%esp)
 784:	e8 d7 00 00 00       	call   860 <fstat>
  close(fd);
 789:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 78c:	89 c6                	mov    %eax,%esi
  close(fd);
 78e:	e8 9d 00 00 00       	call   830 <close>
  return r;
}
 793:	89 f0                	mov    %esi,%eax
 795:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 798:	8b 75 fc             	mov    -0x4(%ebp),%esi
 79b:	89 ec                	mov    %ebp,%esp
 79d:	5d                   	pop    %ebp
 79e:	c3                   	ret    
 79f:	90                   	nop

000007a0 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	31 f6                	xor    %esi,%esi
 7a7:	53                   	push   %ebx
 7a8:	83 ec 2c             	sub    $0x2c,%esp
 7ab:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 7ae:	eb 06                	jmp    7b6 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 7b0:	3c 0a                	cmp    $0xa,%al
 7b2:	74 39                	je     7ed <gets+0x4d>
 7b4:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 7b6:	8d 5e 01             	lea    0x1(%esi),%ebx
 7b9:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 7bc:	7d 31                	jge    7ef <gets+0x4f>
    cc = read(0, &c, 1);
 7be:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7c8:	00 
 7c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 7cd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7d4:	e8 47 00 00 00       	call   820 <read>
    if(cc < 1)
 7d9:	85 c0                	test   %eax,%eax
 7db:	7e 12                	jle    7ef <gets+0x4f>
      break;
    buf[i++] = c;
 7dd:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7e1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 7e5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7e9:	3c 0d                	cmp    $0xd,%al
 7eb:	75 c3                	jne    7b0 <gets+0x10>
 7ed:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 7ef:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 7f3:	89 f8                	mov    %edi,%eax
 7f5:	83 c4 2c             	add    $0x2c,%esp
 7f8:	5b                   	pop    %ebx
 7f9:	5e                   	pop    %esi
 7fa:	5f                   	pop    %edi
 7fb:	5d                   	pop    %ebp
 7fc:	c3                   	ret    
 7fd:	90                   	nop
 7fe:	90                   	nop
 7ff:	90                   	nop

00000800 <fork>:
 800:	b8 01 00 00 00       	mov    $0x1,%eax
 805:	cd 30                	int    $0x30
 807:	c3                   	ret    

00000808 <exit>:
 808:	b8 02 00 00 00       	mov    $0x2,%eax
 80d:	cd 30                	int    $0x30
 80f:	c3                   	ret    

00000810 <wait>:
 810:	b8 03 00 00 00       	mov    $0x3,%eax
 815:	cd 30                	int    $0x30
 817:	c3                   	ret    

00000818 <pipe>:
 818:	b8 04 00 00 00       	mov    $0x4,%eax
 81d:	cd 30                	int    $0x30
 81f:	c3                   	ret    

00000820 <read>:
 820:	b8 06 00 00 00       	mov    $0x6,%eax
 825:	cd 30                	int    $0x30
 827:	c3                   	ret    

00000828 <write>:
 828:	b8 05 00 00 00       	mov    $0x5,%eax
 82d:	cd 30                	int    $0x30
 82f:	c3                   	ret    

00000830 <close>:
 830:	b8 07 00 00 00       	mov    $0x7,%eax
 835:	cd 30                	int    $0x30
 837:	c3                   	ret    

00000838 <kill>:
 838:	b8 08 00 00 00       	mov    $0x8,%eax
 83d:	cd 30                	int    $0x30
 83f:	c3                   	ret    

00000840 <exec>:
 840:	b8 09 00 00 00       	mov    $0x9,%eax
 845:	cd 30                	int    $0x30
 847:	c3                   	ret    

00000848 <open>:
 848:	b8 0a 00 00 00       	mov    $0xa,%eax
 84d:	cd 30                	int    $0x30
 84f:	c3                   	ret    

00000850 <mknod>:
 850:	b8 0b 00 00 00       	mov    $0xb,%eax
 855:	cd 30                	int    $0x30
 857:	c3                   	ret    

00000858 <unlink>:
 858:	b8 0c 00 00 00       	mov    $0xc,%eax
 85d:	cd 30                	int    $0x30
 85f:	c3                   	ret    

00000860 <fstat>:
 860:	b8 0d 00 00 00       	mov    $0xd,%eax
 865:	cd 30                	int    $0x30
 867:	c3                   	ret    

00000868 <link>:
 868:	b8 0e 00 00 00       	mov    $0xe,%eax
 86d:	cd 30                	int    $0x30
 86f:	c3                   	ret    

00000870 <mkdir>:
 870:	b8 0f 00 00 00       	mov    $0xf,%eax
 875:	cd 30                	int    $0x30
 877:	c3                   	ret    

00000878 <chdir>:
 878:	b8 10 00 00 00       	mov    $0x10,%eax
 87d:	cd 30                	int    $0x30
 87f:	c3                   	ret    

00000880 <dup>:
 880:	b8 11 00 00 00       	mov    $0x11,%eax
 885:	cd 30                	int    $0x30
 887:	c3                   	ret    

00000888 <getpid>:
 888:	b8 12 00 00 00       	mov    $0x12,%eax
 88d:	cd 30                	int    $0x30
 88f:	c3                   	ret    

00000890 <sbrk>:
 890:	b8 13 00 00 00       	mov    $0x13,%eax
 895:	cd 30                	int    $0x30
 897:	c3                   	ret    

00000898 <sleep>:
 898:	b8 14 00 00 00       	mov    $0x14,%eax
 89d:	cd 30                	int    $0x30
 89f:	c3                   	ret    

000008a0 <getticks>:
 8a0:	b8 15 00 00 00       	mov    $0x15,%eax
 8a5:	cd 30                	int    $0x30
 8a7:	c3                   	ret    
 8a8:	90                   	nop
 8a9:	90                   	nop
 8aa:	90                   	nop
 8ab:	90                   	nop
 8ac:	90                   	nop
 8ad:	90                   	nop
 8ae:	90                   	nop
 8af:	90                   	nop

000008b0 <putc>:
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	83 ec 28             	sub    $0x28,%esp
 8b6:	88 55 f4             	mov    %dl,-0xc(%ebp)
 8b9:	8d 55 f4             	lea    -0xc(%ebp),%edx
 8bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8c3:	00 
 8c4:	89 54 24 04          	mov    %edx,0x4(%esp)
 8c8:	89 04 24             	mov    %eax,(%esp)
 8cb:	e8 58 ff ff ff       	call   828 <write>
 8d0:	c9                   	leave  
 8d1:	c3                   	ret    
 8d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008e0 <printint>:
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	89 c7                	mov    %eax,%edi
 8e6:	56                   	push   %esi
 8e7:	89 ce                	mov    %ecx,%esi
 8e9:	53                   	push   %ebx
 8ea:	83 ec 2c             	sub    $0x2c,%esp
 8ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8f0:	85 c9                	test   %ecx,%ecx
 8f2:	74 04                	je     8f8 <printint+0x18>
 8f4:	85 d2                	test   %edx,%edx
 8f6:	78 5d                	js     955 <printint+0x75>
 8f8:	89 d0                	mov    %edx,%eax
 8fa:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 901:	31 c9                	xor    %ecx,%ecx
 903:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 906:	66 90                	xchg   %ax,%ax
 908:	31 d2                	xor    %edx,%edx
 90a:	f7 f6                	div    %esi
 90c:	0f b6 92 d3 0e 00 00 	movzbl 0xed3(%edx),%edx
 913:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 916:	83 c1 01             	add    $0x1,%ecx
 919:	85 c0                	test   %eax,%eax
 91b:	75 eb                	jne    908 <printint+0x28>
 91d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 920:	85 c0                	test   %eax,%eax
 922:	74 08                	je     92c <printint+0x4c>
 924:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 929:	83 c1 01             	add    $0x1,%ecx
 92c:	8d 71 ff             	lea    -0x1(%ecx),%esi
 92f:	01 f3                	add    %esi,%ebx
 931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 938:	0f be 13             	movsbl (%ebx),%edx
 93b:	89 f8                	mov    %edi,%eax
 93d:	83 ee 01             	sub    $0x1,%esi
 940:	83 eb 01             	sub    $0x1,%ebx
 943:	e8 68 ff ff ff       	call   8b0 <putc>
 948:	83 fe ff             	cmp    $0xffffffff,%esi
 94b:	75 eb                	jne    938 <printint+0x58>
 94d:	83 c4 2c             	add    $0x2c,%esp
 950:	5b                   	pop    %ebx
 951:	5e                   	pop    %esi
 952:	5f                   	pop    %edi
 953:	5d                   	pop    %ebp
 954:	c3                   	ret    
 955:	89 d0                	mov    %edx,%eax
 957:	f7 d8                	neg    %eax
 959:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 960:	eb 9f                	jmp    901 <printint+0x21>
 962:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000970 <printf>:
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	57                   	push   %edi
 974:	56                   	push   %esi
 975:	53                   	push   %ebx
 976:	83 ec 2c             	sub    $0x2c,%esp
 979:	8b 45 0c             	mov    0xc(%ebp),%eax
 97c:	8b 7d 08             	mov    0x8(%ebp),%edi
 97f:	0f b6 08             	movzbl (%eax),%ecx
 982:	84 c9                	test   %cl,%cl
 984:	0f 84 96 00 00 00    	je     a20 <printf+0xb0>
 98a:	8d 55 10             	lea    0x10(%ebp),%edx
 98d:	31 f6                	xor    %esi,%esi
 98f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 992:	31 db                	xor    %ebx,%ebx
 994:	eb 1a                	jmp    9b0 <printf+0x40>
 996:	66 90                	xchg   %ax,%ax
 998:	83 f9 25             	cmp    $0x25,%ecx
 99b:	0f 85 87 00 00 00    	jne    a28 <printf+0xb8>
 9a1:	66 be 25 00          	mov    $0x25,%si
 9a5:	83 c3 01             	add    $0x1,%ebx
 9a8:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 9ac:	84 c9                	test   %cl,%cl
 9ae:	74 70                	je     a20 <printf+0xb0>
 9b0:	85 f6                	test   %esi,%esi
 9b2:	0f b6 c9             	movzbl %cl,%ecx
 9b5:	74 e1                	je     998 <printf+0x28>
 9b7:	83 fe 25             	cmp    $0x25,%esi
 9ba:	75 e9                	jne    9a5 <printf+0x35>
 9bc:	83 f9 64             	cmp    $0x64,%ecx
 9bf:	90                   	nop
 9c0:	0f 84 fa 00 00 00    	je     ac0 <printf+0x150>
 9c6:	83 f9 70             	cmp    $0x70,%ecx
 9c9:	74 75                	je     a40 <printf+0xd0>
 9cb:	83 f9 78             	cmp    $0x78,%ecx
 9ce:	66 90                	xchg   %ax,%ax
 9d0:	74 6e                	je     a40 <printf+0xd0>
 9d2:	83 f9 73             	cmp    $0x73,%ecx
 9d5:	0f 84 8d 00 00 00    	je     a68 <printf+0xf8>
 9db:	83 f9 63             	cmp    $0x63,%ecx
 9de:	66 90                	xchg   %ax,%ax
 9e0:	0f 84 fe 00 00 00    	je     ae4 <printf+0x174>
 9e6:	83 f9 25             	cmp    $0x25,%ecx
 9e9:	0f 84 b9 00 00 00    	je     aa8 <printf+0x138>
 9ef:	ba 25 00 00 00       	mov    $0x25,%edx
 9f4:	89 f8                	mov    %edi,%eax
 9f6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 9f9:	83 c3 01             	add    $0x1,%ebx
 9fc:	31 f6                	xor    %esi,%esi
 9fe:	e8 ad fe ff ff       	call   8b0 <putc>
 a03:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 a06:	89 f8                	mov    %edi,%eax
 a08:	0f be d1             	movsbl %cl,%edx
 a0b:	e8 a0 fe ff ff       	call   8b0 <putc>
 a10:	8b 45 0c             	mov    0xc(%ebp),%eax
 a13:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 a17:	84 c9                	test   %cl,%cl
 a19:	75 95                	jne    9b0 <printf+0x40>
 a1b:	90                   	nop
 a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a20:	83 c4 2c             	add    $0x2c,%esp
 a23:	5b                   	pop    %ebx
 a24:	5e                   	pop    %esi
 a25:	5f                   	pop    %edi
 a26:	5d                   	pop    %ebp
 a27:	c3                   	ret    
 a28:	89 f8                	mov    %edi,%eax
 a2a:	0f be d1             	movsbl %cl,%edx
 a2d:	e8 7e fe ff ff       	call   8b0 <putc>
 a32:	8b 45 0c             	mov    0xc(%ebp),%eax
 a35:	e9 6b ff ff ff       	jmp    9a5 <printf+0x35>
 a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 a43:	b9 10 00 00 00       	mov    $0x10,%ecx
 a48:	31 f6                	xor    %esi,%esi
 a4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 a51:	8b 10                	mov    (%eax),%edx
 a53:	89 f8                	mov    %edi,%eax
 a55:	e8 86 fe ff ff       	call   8e0 <printint>
 a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
 a5d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 a61:	e9 3f ff ff ff       	jmp    9a5 <printf+0x35>
 a66:	66 90                	xchg   %ax,%ax
 a68:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 a6b:	8b 32                	mov    (%edx),%esi
 a6d:	83 c2 04             	add    $0x4,%edx
 a70:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 a73:	85 f6                	test   %esi,%esi
 a75:	0f 84 84 00 00 00    	je     aff <printf+0x18f>
 a7b:	0f b6 16             	movzbl (%esi),%edx
 a7e:	84 d2                	test   %dl,%dl
 a80:	74 1d                	je     a9f <printf+0x12f>
 a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 a88:	0f be d2             	movsbl %dl,%edx
 a8b:	83 c6 01             	add    $0x1,%esi
 a8e:	89 f8                	mov    %edi,%eax
 a90:	e8 1b fe ff ff       	call   8b0 <putc>
 a95:	0f b6 16             	movzbl (%esi),%edx
 a98:	84 d2                	test   %dl,%dl
 a9a:	75 ec                	jne    a88 <printf+0x118>
 a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
 a9f:	31 f6                	xor    %esi,%esi
 aa1:	e9 ff fe ff ff       	jmp    9a5 <printf+0x35>
 aa6:	66 90                	xchg   %ax,%ax
 aa8:	89 f8                	mov    %edi,%eax
 aaa:	ba 25 00 00 00       	mov    $0x25,%edx
 aaf:	e8 fc fd ff ff       	call   8b0 <putc>
 ab4:	31 f6                	xor    %esi,%esi
 ab6:	8b 45 0c             	mov    0xc(%ebp),%eax
 ab9:	e9 e7 fe ff ff       	jmp    9a5 <printf+0x35>
 abe:	66 90                	xchg   %ax,%ax
 ac0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 ac3:	b1 0a                	mov    $0xa,%cl
 ac5:	66 31 f6             	xor    %si,%si
 ac8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 acf:	8b 10                	mov    (%eax),%edx
 ad1:	89 f8                	mov    %edi,%eax
 ad3:	e8 08 fe ff ff       	call   8e0 <printint>
 ad8:	8b 45 0c             	mov    0xc(%ebp),%eax
 adb:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 adf:	e9 c1 fe ff ff       	jmp    9a5 <printf+0x35>
 ae4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 ae7:	31 f6                	xor    %esi,%esi
 ae9:	0f be 10             	movsbl (%eax),%edx
 aec:	89 f8                	mov    %edi,%eax
 aee:	e8 bd fd ff ff       	call   8b0 <putc>
 af3:	8b 45 0c             	mov    0xc(%ebp),%eax
 af6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 afa:	e9 a6 fe ff ff       	jmp    9a5 <printf+0x35>
 aff:	be cc 0e 00 00       	mov    $0xecc,%esi
 b04:	e9 72 ff ff ff       	jmp    a7b <printf+0x10b>
 b09:	90                   	nop
 b0a:	90                   	nop
 b0b:	90                   	nop
 b0c:	90                   	nop
 b0d:	90                   	nop
 b0e:	90                   	nop
 b0f:	90                   	nop

00000b10 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b10:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b11:	a1 08 0f 00 00       	mov    0xf08,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 b16:	89 e5                	mov    %esp,%ebp
 b18:	57                   	push   %edi
 b19:	56                   	push   %esi
 b1a:	53                   	push   %ebx
 b1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 b1e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b21:	39 c8                	cmp    %ecx,%eax
 b23:	73 1d                	jae    b42 <free+0x32>
 b25:	8d 76 00             	lea    0x0(%esi),%esi
 b28:	8b 10                	mov    (%eax),%edx
 b2a:	39 d1                	cmp    %edx,%ecx
 b2c:	72 1a                	jb     b48 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b2e:	39 d0                	cmp    %edx,%eax
 b30:	72 08                	jb     b3a <free+0x2a>
 b32:	39 c8                	cmp    %ecx,%eax
 b34:	72 12                	jb     b48 <free+0x38>
 b36:	39 d1                	cmp    %edx,%ecx
 b38:	72 0e                	jb     b48 <free+0x38>
 b3a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b3c:	39 c8                	cmp    %ecx,%eax
 b3e:	66 90                	xchg   %ax,%ax
 b40:	72 e6                	jb     b28 <free+0x18>
 b42:	8b 10                	mov    (%eax),%edx
 b44:	eb e8                	jmp    b2e <free+0x1e>
 b46:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 b48:	8b 71 04             	mov    0x4(%ecx),%esi
 b4b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b4e:	39 d7                	cmp    %edx,%edi
 b50:	74 19                	je     b6b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b52:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b55:	8b 50 04             	mov    0x4(%eax),%edx
 b58:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b5b:	39 ce                	cmp    %ecx,%esi
 b5d:	74 21                	je     b80 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b5f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b61:	a3 08 0f 00 00       	mov    %eax,0xf08
}
 b66:	5b                   	pop    %ebx
 b67:	5e                   	pop    %esi
 b68:	5f                   	pop    %edi
 b69:	5d                   	pop    %ebp
 b6a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b6b:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 b6e:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b70:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b73:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 b76:	8b 50 04             	mov    0x4(%eax),%edx
 b79:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b7c:	39 ce                	cmp    %ecx,%esi
 b7e:	75 df                	jne    b5f <free+0x4f>
    p->s.size += bp->s.size;
 b80:	03 51 04             	add    0x4(%ecx),%edx
 b83:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b86:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b89:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 b8b:	a3 08 0f 00 00       	mov    %eax,0xf08
}
 b90:	5b                   	pop    %ebx
 b91:	5e                   	pop    %esi
 b92:	5f                   	pop    %edi
 b93:	5d                   	pop    %ebp
 b94:	c3                   	ret    
 b95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ba0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ba0:	55                   	push   %ebp
 ba1:	89 e5                	mov    %esp,%ebp
 ba3:	57                   	push   %edi
 ba4:	56                   	push   %esi
 ba5:	53                   	push   %ebx
 ba6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ba9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 bac:	8b 0d 08 0f 00 00    	mov    0xf08,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bb2:	83 c3 07             	add    $0x7,%ebx
 bb5:	c1 eb 03             	shr    $0x3,%ebx
 bb8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 bbb:	85 c9                	test   %ecx,%ecx
 bbd:	0f 84 93 00 00 00    	je     c56 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc3:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 bc5:	8b 50 04             	mov    0x4(%eax),%edx
 bc8:	39 d3                	cmp    %edx,%ebx
 bca:	76 1f                	jbe    beb <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 bcc:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 bd3:	90                   	nop
 bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 bd8:	3b 05 08 0f 00 00    	cmp    0xf08,%eax
 bde:	74 30                	je     c10 <malloc+0x70>
 be0:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be2:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 be4:	8b 50 04             	mov    0x4(%eax),%edx
 be7:	39 d3                	cmp    %edx,%ebx
 be9:	77 ed                	ja     bd8 <malloc+0x38>
      if(p->s.size == nunits)
 beb:	39 d3                	cmp    %edx,%ebx
 bed:	74 61                	je     c50 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 bef:	29 da                	sub    %ebx,%edx
 bf1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 bf4:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 bf7:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 bfa:	89 0d 08 0f 00 00    	mov    %ecx,0xf08
      return (void*) (p + 1);
 c00:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c03:	83 c4 1c             	add    $0x1c,%esp
 c06:	5b                   	pop    %ebx
 c07:	5e                   	pop    %esi
 c08:	5f                   	pop    %edi
 c09:	5d                   	pop    %ebp
 c0a:	c3                   	ret    
 c0b:	90                   	nop
 c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 c10:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 c16:	b8 00 80 00 00       	mov    $0x8000,%eax
 c1b:	bf 00 10 00 00       	mov    $0x1000,%edi
 c20:	76 04                	jbe    c26 <malloc+0x86>
 c22:	89 f0                	mov    %esi,%eax
 c24:	89 df                	mov    %ebx,%edi
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 c26:	89 04 24             	mov    %eax,(%esp)
 c29:	e8 62 fc ff ff       	call   890 <sbrk>
  if(p == (char*) -1)
 c2e:	83 f8 ff             	cmp    $0xffffffff,%eax
 c31:	74 18                	je     c4b <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 c33:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 c36:	83 c0 08             	add    $0x8,%eax
 c39:	89 04 24             	mov    %eax,(%esp)
 c3c:	e8 cf fe ff ff       	call   b10 <free>
  return freep;
 c41:	8b 0d 08 0f 00 00    	mov    0xf08,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 c47:	85 c9                	test   %ecx,%ecx
 c49:	75 97                	jne    be2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 c4b:	31 c0                	xor    %eax,%eax
 c4d:	eb b4                	jmp    c03 <malloc+0x63>
 c4f:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 c50:	8b 10                	mov    (%eax),%edx
 c52:	89 11                	mov    %edx,(%ecx)
 c54:	eb a4                	jmp    bfa <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c56:	c7 05 08 0f 00 00 00 	movl   $0xf00,0xf08
 c5d:	0f 00 00 
    base.s.size = 0;
 c60:	b9 00 0f 00 00       	mov    $0xf00,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 c65:	c7 05 00 0f 00 00 00 	movl   $0xf00,0xf00
 c6c:	0f 00 00 
    base.s.size = 0;
 c6f:	c7 05 04 0f 00 00 00 	movl   $0x0,0xf04
 c76:	00 00 00 
 c79:	e9 45 ff ff ff       	jmp    bc3 <malloc+0x23>
