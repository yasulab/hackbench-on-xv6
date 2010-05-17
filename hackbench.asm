
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
   a:	c7 44 24 04 f0 0a 00 	movl   $0xaf0,0x4(%esp)
  11:	00 
  12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  19:	e8 c2 07 00 00       	call   7e0 <printf>
  exit();
  1e:	e8 55 06 00 00       	call   678 <exit>
  23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000030 <ready>:
  //barf("Creating fdpair");
}

/* Block until we're ready to go */
static void ready(int ready_out, int wakefd, int id, int caller)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	56                   	push   %esi
  34:	53                   	push   %ebx
  35:	89 cb                	mov    %ecx,%ebx
  37:	83 ec 20             	sub    $0x20,%esp
  3a:	8b 75 08             	mov    0x8(%ebp),%esi
  char dummy;
  // TODO: Implement myPoll function
  pollfd[id].fd = wakefd;
  3d:	89 14 cd 00 0c 00 00 	mov    %edx,0xc00(,%ecx,8)
  pollfd[id].events = POLLIN;

  /* Tell them we're ready. */
  if (write(ready_out, &dummy, 1) != 1)
  44:	8d 55 f7             	lea    -0x9(%ebp),%edx
static void ready(int ready_out, int wakefd, int id, int caller)
{
  char dummy;
  // TODO: Implement myPoll function
  pollfd[id].fd = wakefd;
  pollfd[id].events = POLLIN;
  47:	66 c7 04 cd 04 0c 00 	movw   $0x1,0xc04(,%ecx,8)
  4e:	00 01 00 

  /* Tell them we're ready. */
  if (write(ready_out, &dummy, 1) != 1)
  51:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  58:	00 
  59:	89 54 24 04          	mov    %edx,0x4(%esp)
  5d:	89 04 24             	mov    %eax,(%esp)
  60:	e8 33 06 00 00       	call   698 <write>
  65:	83 f8 01             	cmp    $0x1,%eax
  68:	74 0a                	je     74 <ready+0x44>
    barf("CLIENT: ready write");
  6a:	b8 fd 0a 00 00       	mov    $0xafd,%eax
  6f:	e8 8c ff ff ff       	call   0 <barf>

  /* Wait for "GO" signal */
  //TODO: Polling should be re-implemented for xv6.
  //if (poll(&pollfd, 1, -1) != 1)
  //        barf("poll");
  if(caller == SENDER){
  74:	83 fe 01             	cmp    $0x1,%esi
  77:	74 2f                	je     a8 <ready+0x78>
    while(pollfd[id].events == POLLIN);
  }else if(caller == RECEIVER){
  79:	83 fe 02             	cmp    $0x2,%esi
  7c:	74 12                	je     90 <ready+0x60>
    pollfd[id].events = FREE;
  }else{
    barf("failed being ready.");
  7e:	b8 11 0b 00 00       	mov    $0xb11,%eax
  83:	e8 78 ff ff ff       	call   0 <barf>
  }

}
  88:	83 c4 20             	add    $0x20,%esp
  8b:	5b                   	pop    %ebx
  8c:	5e                   	pop    %esi
  8d:	5d                   	pop    %ebp
  8e:	c3                   	ret    
  8f:	90                   	nop
  //if (poll(&pollfd, 1, -1) != 1)
  //        barf("poll");
  if(caller == SENDER){
    while(pollfd[id].events == POLLIN);
  }else if(caller == RECEIVER){
    pollfd[id].events = FREE;
  90:	66 c7 04 dd 04 0c 00 	movw   $0x0,0xc04(,%ebx,8)
  97:	00 00 00 
  }else{
    barf("failed being ready.");
  }

}
  9a:	83 c4 20             	add    $0x20,%esp
  9d:	5b                   	pop    %ebx
  9e:	5e                   	pop    %esi
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  /* Wait for "GO" signal */
  //TODO: Polling should be re-implemented for xv6.
  //if (poll(&pollfd, 1, -1) != 1)
  //        barf("poll");
  if(caller == SENDER){
    while(pollfd[id].events == POLLIN);
  a8:	66 83 3c dd 04 0c 00 	cmpw   $0x1,0xc04(,%ebx,8)
  af:	00 01 
  b1:	75 d5                	jne    88 <ready+0x58>
  b3:	eb fe                	jmp    b3 <ready+0x83>
  b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000c0 <fdpair>:
  printf(STDOUT, "(Error: %s)\n", msg);
  exit();
}

static void fdpair(int fds[2])
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	83 ec 18             	sub    $0x18,%esp
  if (use_pipes) {
  c6:	8b 15 cc 0b 00 00    	mov    0xbcc,%edx
  cc:	85 d2                	test   %edx,%edx
  ce:	75 10                	jne    e0 <fdpair+0x20>
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  }
  //barf("Creating fdpair");
}
  d0:	c9                   	leave  
      return;
  } else {
    // This mode would not run correctly in xv6
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  d1:	b8 90 0b 00 00       	mov    $0xb90,%eax
  d6:	e9 25 ff ff ff       	jmp    0 <barf>
  db:	90                   	nop
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void fdpair(int fds[2])
{
  if (use_pipes) {
    // TODO: Implement myPipe
    //    pipe(fds[0], fds[1]);
    if (pipe(fds) == 0)
  e0:	89 04 24             	mov    %eax,(%esp)
  e3:	e8 a0 05 00 00       	call   688 <pipe>
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  }
  //barf("Creating fdpair");
}
  e8:	c9                   	leave  
  e9:	c3                   	ret    
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000f0 <group>:

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	56                   	push   %esi
  f5:	53                   	push   %ebx
  f6:	81 ec ac 00 00 00    	sub    $0xac,%esp
  fc:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  unsigned int i;
  unsigned int out_fds[num_fds];
 102:	8d 04 85 1e 00 00 00 	lea    0x1e(,%eax,4),%eax

  for (i = 0; i < num_fds; i++) {
 109:	8b b5 70 ff ff ff    	mov    -0x90(%ebp),%esi
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];
 10f:	83 e0 f0             	and    $0xfffffff0,%eax
 112:	29 c4                	sub    %eax,%esp
 114:	8d 5c 24 1b          	lea    0x1b(%esp),%ebx
 118:	83 e3 f0             	and    $0xfffffff0,%ebx

  for (i = 0; i < num_fds; i++) {
 11b:	85 f6                	test   %esi,%esi

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
 11d:	89 95 68 ff ff ff    	mov    %edx,-0x98(%ebp)
 123:	89 8d 64 ff ff ff    	mov    %ecx,-0x9c(%ebp)
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
 129:	74 36                	je     161 <group+0x71>
 12b:	31 f6                	xor    %esi,%esi
 12d:	8d 7d e0             	lea    -0x20(%ebp),%edi
    int fds[2];

    /* Create the pipe between client and server */
    fdpair(fds);
 130:	89 f8                	mov    %edi,%eax
 132:	e8 89 ff ff ff       	call   c0 <fdpair>

    /* Fork the receiver. */
    switch (fork()) {
 137:	e8 34 05 00 00       	call   670 <fork>
 13c:	83 f8 ff             	cmp    $0xffffffff,%eax
 13f:	74 4f                	je     190 <group+0xa0>
 141:	85 c0                	test   %eax,%eax
 143:	74 55                	je     19a <group+0xaa>
      close(fds[1]);
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
      exit();
    }

    out_fds[i] = fds[1];
 145:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 148:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
    close(fds[0]);
 14b:	8b 45 e0             	mov    -0x20(%ebp),%eax
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
 14e:	83 c6 01             	add    $0x1,%esi
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
      exit();
    }

    out_fds[i] = fds[1];
    close(fds[0]);
 151:	89 04 24             	mov    %eax,(%esp)
 154:	e8 47 05 00 00       	call   6a0 <close>
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
 159:	39 b5 70 ff ff ff    	cmp    %esi,-0x90(%ebp)
 15f:	77 cf                	ja     130 <group+0x40>
 161:	31 f6                	xor    %esi,%esi
    out_fds[i] = fds[1];
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
 163:	3b b5 70 ff ff ff    	cmp    -0x90(%ebp),%esi
 169:	0f 83 ad 01 00 00    	jae    31c <group+0x22c>
    switch (fork()) {
 16f:	e8 fc 04 00 00       	call   670 <fork>
 174:	83 f8 ff             	cmp    $0xffffffff,%eax
 177:	0f 84 ef 00 00 00    	je     26c <group+0x17c>
 17d:	85 c0                	test   %eax,%eax
 17f:	90                   	nop
 180:	0f 84 f0 00 00 00    	je     276 <group+0x186>
    out_fds[i] = fds[1];
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
 186:	83 c6 01             	add    $0x1,%esi
 189:	eb d8                	jmp    163 <group+0x73>
 18b:	90                   	nop
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    /* Create the pipe between client and server */
    fdpair(fds);

    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
 190:	b8 25 0b 00 00       	mov    $0xb25,%eax
 195:	e8 66 fe ff ff       	call   0 <barf>
    case 0:
      close(fds[1]);
 19a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 19d:	89 04 24             	mov    %eax,(%esp)
 1a0:	e8 fb 04 00 00       	call   6a0 <close>
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 1a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 1a8:	89 f1                	mov    %esi,%ecx
    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 1aa:	6b 95 70 ff ff ff 64 	imul   $0x64,-0x90(%ebp),%edx
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 1b1:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 1b8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 1be:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 1c4:	89 95 6c ff ff ff    	mov    %edx,-0x94(%ebp)
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 1ca:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
 1d0:	e8 5b fe ff ff       	call   30 <ready>

  /* Receive them all */
  for (i = 0; i < num_packets; i++) {
 1d5:	8b 9d 6c ff ff ff    	mov    -0x94(%ebp),%ebx
 1db:	85 db                	test   %ebx,%ebx
 1dd:	74 75                	je     254 <group+0x164>
 1df:	c7 85 70 ff ff ff 00 	movl   $0x0,-0x90(%ebp)
 1e6:	00 00 00 
    char data[DATASIZE];
    int ret, done = 0;

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
 1e9:	bf 64 00 00 00       	mov    $0x64,%edi
 1ee:	66 90                	xchg   %ax,%ax

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);

  /* Receive them all */
  for (i = 0; i < num_packets; i++) {
 1f0:	31 db                	xor    %ebx,%ebx
 1f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    char data[DATASIZE];
    int ret, done = 0;

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
 1f8:	89 f8                	mov    %edi,%eax
 1fa:	29 d8                	sub    %ebx,%eax
 1fc:	89 44 24 08          	mov    %eax,0x8(%esp)
 200:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
 206:	01 d8                	add    %ebx,%eax
 208:	89 44 24 04          	mov    %eax,0x4(%esp)
 20c:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
 212:	89 04 24             	mov    %eax,(%esp)
 215:	e8 76 04 00 00       	call   690 <read>
    printf(STDOUT, "ret = %d\n", ret);
 21a:	c7 44 24 04 2c 0b 00 	movl   $0xb2c,0x4(%esp)
 221:	00 
 222:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  for (i = 0; i < num_packets; i++) {
    char data[DATASIZE];
    int ret, done = 0;

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
 229:	89 c6                	mov    %eax,%esi
    printf(STDOUT, "ret = %d\n", ret);
 22b:	89 44 24 08          	mov    %eax,0x8(%esp)
 22f:	e8 ac 05 00 00       	call   7e0 <printf>
    if (ret < 0)
 234:	85 f6                	test   %esi,%esi
 236:	78 28                	js     260 <group+0x170>
      barf("SERVER: read");
    done += ret;
 238:	01 f3                	add    %esi,%ebx
    if (done < DATASIZE)
 23a:	83 fb 63             	cmp    $0x63,%ebx
 23d:	7e b9                	jle    1f8 <group+0x108>

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);

  /* Receive them all */
  for (i = 0; i < num_packets; i++) {
 23f:	83 85 70 ff ff ff 01 	addl   $0x1,-0x90(%ebp)
 246:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
 24c:	39 95 6c ff ff ff    	cmp    %edx,-0x94(%ebp)
 252:	77 9c                	ja     1f0 <group+0x100>
  for (i = 0; i < num_fds; i++) {
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      sender(num_fds, out_fds, ready_out, wakefd, i);
      exit();
 254:	e8 1f 04 00 00       	call   678 <exit>
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
    printf(STDOUT, "ret = %d\n", ret);
    if (ret < 0)
      barf("SERVER: read");
 260:	b8 36 0b 00 00       	mov    $0xb36,%eax
 265:	e8 96 fd ff ff       	call   0 <barf>
 26a:	eb cc                	jmp    238 <group+0x148>
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
    switch (fork()) {
    case -1: barf("fork()");
 26c:	b8 25 0b 00 00       	mov    $0xb25,%eax
 271:	e8 8a fd ff ff       	call   0 <barf>
{
  char data[DATASIZE];
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 276:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
 27c:	89 f1                	mov    %esi,%ecx
 27e:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
 284:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 28b:	e8 a0 fd ff ff       	call   30 <ready>
 290:	c7 85 6c ff ff ff 00 	movl   $0x0,-0x94(%ebp)
 297:	00 00 00 
 29a:	89 9d 74 ff ff ff    	mov    %ebx,-0x8c(%ebp)

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
 2a0:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
{
  char data[DATASIZE];
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 2a6:	31 db                	xor    %ebx,%ebx

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
 2a8:	85 c9                	test   %ecx,%ecx
 2aa:	74 4c                	je     2f8 <group+0x208>
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char data[DATASIZE];
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 2b0:	31 f6                	xor    %esi,%esi
 2b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
      int ret, done = 0;

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
 2b8:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
 2be:	b8 64 00 00 00       	mov    $0x64,%eax
 2c3:	29 f0                	sub    %esi,%eax
 2c5:	89 44 24 08          	mov    %eax,0x8(%esp)
 2c9:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
 2cf:	01 f0                	add    %esi,%eax
 2d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 2d5:	8b 04 9a             	mov    (%edx,%ebx,4),%eax
 2d8:	89 04 24             	mov    %eax,(%esp)
 2db:	e8 b8 03 00 00       	call   698 <write>
      if (ret < 0)
 2e0:	85 c0                	test   %eax,%eax
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
      int ret, done = 0;

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
 2e2:	89 c7                	mov    %eax,%edi
      if (ret < 0)
 2e4:	78 2a                	js     310 <group+0x220>
	barf("SENDER: write");
      done += ret;
 2e6:	01 fe                	add    %edi,%esi
      if (done < sizeof(data))
 2e8:	83 fe 63             	cmp    $0x63,%esi
 2eb:	76 cb                	jbe    2b8 <group+0x1c8>
  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
 2ed:	83 c3 01             	add    $0x1,%ebx
 2f0:	39 9d 70 ff ff ff    	cmp    %ebx,-0x90(%ebp)
 2f6:	77 b8                	ja     2b0 <group+0x1c0>

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
 2f8:	83 85 6c ff ff ff 01 	addl   $0x1,-0x94(%ebp)
 2ff:	83 bd 6c ff ff ff 64 	cmpl   $0x64,-0x94(%ebp)
 306:	75 98                	jne    2a0 <group+0x1b0>
 308:	e9 47 ff ff ff       	jmp    254 <group+0x164>
 30d:	8d 76 00             	lea    0x0(%esi),%esi
      int ret, done = 0;

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
      if (ret < 0)
	barf("SENDER: write");
 310:	b8 43 0b 00 00       	mov    $0xb43,%eax
 315:	e8 e6 fc ff ff       	call   0 <barf>
 31a:	eb ca                	jmp    2e6 <group+0x1f6>
    out_fds[i] = fds[1];
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
 31c:	31 f6                	xor    %esi,%esi
 31e:	eb 0e                	jmp    32e <group+0x23e>
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
    close(out_fds[i]);
 320:	8b 04 b3             	mov    (%ebx,%esi,4),%eax
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 323:	83 c6 01             	add    $0x1,%esi
    close(out_fds[i]);
 326:	89 04 24             	mov    %eax,(%esp)
 329:	e8 72 03 00 00       	call   6a0 <close>
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 32e:	3b b5 70 ff ff ff    	cmp    -0x90(%ebp),%esi
 334:	72 ea                	jb     320 <group+0x230>
 336:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
    close(out_fds[i]);

  /* Return number of children to reap */
  return num_fds * 2;
}
 33c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 33f:	5b                   	pop    %ebx
 340:	5e                   	pop    %esi
 341:	5f                   	pop    %edi
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 342:	01 c0                	add    %eax,%eax
    close(out_fds[i]);

  /* Return number of children to reap */
  return num_fds * 2;
}
 344:	5d                   	pop    %ebp
 345:	c3                   	ret    
 346:	8d 76 00             	lea    0x0(%esi),%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <main>:

int main(int argc, char *argv[])
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	83 e4 f0             	and    $0xfffffff0,%esp
 356:	57                   	push   %edi
 357:	56                   	push   %esi
 358:	53                   	push   %ebx
 359:	83 ec 44             	sub    $0x44,%esp
  //if (argc != 2 || (num_groups = atoi(argv[1])) == 0)
  //        barf("Usage: hackbench [-pipe] <num groups>\n");

  num_groups = 1; // TODO: This may seriously be considered.

  fdpair(readyfds);
 35c:	8d 44 24 34          	lea    0x34(%esp),%eax
    use_pipes = 1;
    argc--;
    argv++;
    }
  */
  use_pipes = 1;
 360:	c7 05 cc 0b 00 00 01 	movl   $0x1,0xbcc
 367:	00 00 00 
 36a:	8d 7c 24 3f          	lea    0x3f(%esp),%edi
  //if (argc != 2 || (num_groups = atoi(argv[1])) == 0)
  //        barf("Usage: hackbench [-pipe] <num groups>\n");

  num_groups = 1; // TODO: This may seriously be considered.

  fdpair(readyfds);
 36e:	e8 4d fd ff ff       	call   c0 <fdpair>
  fdpair(wakefds);
 373:	8d 44 24 2c          	lea    0x2c(%esp),%eax
 377:	e8 44 fd ff ff       	call   c0 <fdpair>

  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);
 37c:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
 380:	b8 14 00 00 00       	mov    $0x14,%eax
 385:	8b 54 24 38          	mov    0x38(%esp),%edx
 389:	e8 62 fd ff ff       	call   f0 <group>

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
 38e:	85 c0                	test   %eax,%eax
  fdpair(readyfds);
  fdpair(wakefds);

  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);
 390:	89 c6                	mov    %eax,%esi

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
 392:	74 32                	je     3c6 <main+0x76>
 394:	31 db                	xor    %ebx,%ebx
 396:	66 90                	xchg   %ax,%ax
    if (read(readyfds[0], &dummy, 1) != 1)
 398:	8b 44 24 34          	mov    0x34(%esp),%eax
 39c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a3:	00 
 3a4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 3a8:	89 04 24             	mov    %eax,(%esp)
 3ab:	e8 e0 02 00 00       	call   690 <read>
 3b0:	83 f8 01             	cmp    $0x1,%eax
 3b3:	74 0a                	je     3bf <main+0x6f>
      barf("Reading for readyfds");
 3b5:	b8 51 0b 00 00       	mov    $0xb51,%eax
 3ba:	e8 41 fc ff ff       	call   0 <barf>
  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
 3bf:	83 c3 01             	add    $0x1,%ebx
 3c2:	39 de                	cmp    %ebx,%esi
 3c4:	77 d2                	ja     398 <main+0x48>
    if (read(readyfds[0], &dummy, 1) != 1)
      barf("Reading for readyfds");

  //gettimeofday(&start, NULL);
  start = getticks();
 3c6:	e8 45 03 00 00       	call   710 <getticks>
  

  /* Kick them off */
  if (write(wakefds[1], &dummy, 1) != 1)
 3cb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3d2:	00 
 3d3:	89 7c 24 04          	mov    %edi,0x4(%esp)
  for (i = 0; i < total_children; i++)
    if (read(readyfds[0], &dummy, 1) != 1)
      barf("Reading for readyfds");

  //gettimeofday(&start, NULL);
  start = getticks();
 3d7:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  

  /* Kick them off */
  if (write(wakefds[1], &dummy, 1) != 1)
 3db:	8b 44 24 30          	mov    0x30(%esp),%eax
 3df:	89 04 24             	mov    %eax,(%esp)
 3e2:	e8 b1 02 00 00       	call   698 <write>
 3e7:	83 f8 01             	cmp    $0x1,%eax
 3ea:	74 0a                	je     3f6 <main+0xa6>
    barf("Writing to start them");
 3ec:	b8 66 0b 00 00       	mov    $0xb66,%eax
 3f1:	e8 0a fc ff ff       	call   0 <barf>

  /* Reap them all */
  for (i = 0; i < total_children; i++) {
 3f6:	85 f6                	test   %esi,%esi
 3f8:	74 12                	je     40c <main+0xbc>
 3fa:	31 db                	xor    %ebx,%ebx
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 400:	83 c3 01             	add    $0x1,%ebx
    int status;
    //wait(&status); // TODO: Too Many Arguments???
    wait();
 403:	e8 78 02 00 00       	call   680 <wait>
  /* Kick them off */
  if (write(wakefds[1], &dummy, 1) != 1)
    barf("Writing to start them");

  /* Reap them all */
  for (i = 0; i < total_children; i++) {
 408:	39 de                	cmp    %ebx,%esi
 40a:	77 f4                	ja     400 <main+0xb0>
    // TODO: What's WIFEXITED ???
    //if (!WIFEXITED(status))
    //  exit();
  }
  
  stop = getticks();
 40c:	e8 ff 02 00 00       	call   710 <getticks>
  diff = stop - start;

  /* Print time... */
  printf(STDOUT, "Time: %d [ticks]\n", diff);
 411:	c7 44 24 04 7c 0b 00 	movl   $0xb7c,0x4(%esp)
 418:	00 
 419:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 420:	2b 44 24 1c          	sub    0x1c(%esp),%eax
 424:	89 44 24 08          	mov    %eax,0x8(%esp)
 428:	e8 b3 03 00 00       	call   7e0 <printf>
  exit();
 42d:	e8 46 02 00 00       	call   678 <exit>
 432:	90                   	nop
 433:	90                   	nop
 434:	90                   	nop
 435:	90                   	nop
 436:	90                   	nop
 437:	90                   	nop
 438:	90                   	nop
 439:	90                   	nop
 43a:	90                   	nop
 43b:	90                   	nop
 43c:	90                   	nop
 43d:	90                   	nop
 43e:	90                   	nop
 43f:	90                   	nop

00000440 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 440:	55                   	push   %ebp
 441:	31 d2                	xor    %edx,%edx
 443:	89 e5                	mov    %esp,%ebp
 445:	8b 45 08             	mov    0x8(%ebp),%eax
 448:	53                   	push   %ebx
 449:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 44c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 450:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 454:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 457:	83 c2 01             	add    $0x1,%edx
 45a:	84 c9                	test   %cl,%cl
 45c:	75 f2                	jne    450 <strcpy+0x10>
    ;
  return os;
}
 45e:	5b                   	pop    %ebx
 45f:	5d                   	pop    %ebp
 460:	c3                   	ret    
 461:	eb 0d                	jmp    470 <strcmp>
 463:	90                   	nop
 464:	90                   	nop
 465:	90                   	nop
 466:	90                   	nop
 467:	90                   	nop
 468:	90                   	nop
 469:	90                   	nop
 46a:	90                   	nop
 46b:	90                   	nop
 46c:	90                   	nop
 46d:	90                   	nop
 46e:	90                   	nop
 46f:	90                   	nop

00000470 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	53                   	push   %ebx
 474:	8b 4d 08             	mov    0x8(%ebp),%ecx
 477:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 47a:	0f b6 01             	movzbl (%ecx),%eax
 47d:	84 c0                	test   %al,%al
 47f:	75 14                	jne    495 <strcmp+0x25>
 481:	eb 25                	jmp    4a8 <strcmp+0x38>
 483:	90                   	nop
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 488:	83 c1 01             	add    $0x1,%ecx
 48b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 48e:	0f b6 01             	movzbl (%ecx),%eax
 491:	84 c0                	test   %al,%al
 493:	74 13                	je     4a8 <strcmp+0x38>
 495:	0f b6 1a             	movzbl (%edx),%ebx
 498:	38 d8                	cmp    %bl,%al
 49a:	74 ec                	je     488 <strcmp+0x18>
 49c:	0f b6 db             	movzbl %bl,%ebx
 49f:	0f b6 c0             	movzbl %al,%eax
 4a2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 4a4:	5b                   	pop    %ebx
 4a5:	5d                   	pop    %ebp
 4a6:	c3                   	ret    
 4a7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 4a8:	0f b6 1a             	movzbl (%edx),%ebx
 4ab:	31 c0                	xor    %eax,%eax
 4ad:	0f b6 db             	movzbl %bl,%ebx
 4b0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 4b2:	5b                   	pop    %ebx
 4b3:	5d                   	pop    %ebp
 4b4:	c3                   	ret    
 4b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <strlen>:

uint
strlen(char *s)
{
 4c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 4c1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 4c3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 4c5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 4c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 4ca:	80 39 00             	cmpb   $0x0,(%ecx)
 4cd:	74 0c                	je     4db <strlen+0x1b>
 4cf:	90                   	nop
 4d0:	83 c2 01             	add    $0x1,%edx
 4d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 4d7:	89 d0                	mov    %edx,%eax
 4d9:	75 f5                	jne    4d0 <strlen+0x10>
    ;
  return n;
}
 4db:	5d                   	pop    %ebp
 4dc:	c3                   	ret    
 4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4e6:	53                   	push   %ebx
 4e7:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 4ea:	85 c9                	test   %ecx,%ecx
 4ec:	74 14                	je     502 <memset+0x22>
 4ee:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 4f8:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 4fb:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 4fe:	39 ca                	cmp    %ecx,%edx
 500:	75 f6                	jne    4f8 <memset+0x18>
    *d++ = c;
  return dst;
}
 502:	5b                   	pop    %ebx
 503:	5d                   	pop    %ebp
 504:	c3                   	ret    
 505:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000510 <strchr>:

char*
strchr(const char *s, char c)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	8b 45 08             	mov    0x8(%ebp),%eax
 516:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 51a:	0f b6 10             	movzbl (%eax),%edx
 51d:	84 d2                	test   %dl,%dl
 51f:	75 11                	jne    532 <strchr+0x22>
 521:	eb 15                	jmp    538 <strchr+0x28>
 523:	90                   	nop
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 528:	83 c0 01             	add    $0x1,%eax
 52b:	0f b6 10             	movzbl (%eax),%edx
 52e:	84 d2                	test   %dl,%dl
 530:	74 06                	je     538 <strchr+0x28>
    if(*s == c)
 532:	38 ca                	cmp    %cl,%dl
 534:	75 f2                	jne    528 <strchr+0x18>
      return (char*) s;
  return 0;
}
 536:	5d                   	pop    %ebp
 537:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 538:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 53a:	5d                   	pop    %ebp
 53b:	90                   	nop
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 540:	c3                   	ret    
 541:	eb 0d                	jmp    550 <atoi>
 543:	90                   	nop
 544:	90                   	nop
 545:	90                   	nop
 546:	90                   	nop
 547:	90                   	nop
 548:	90                   	nop
 549:	90                   	nop
 54a:	90                   	nop
 54b:	90                   	nop
 54c:	90                   	nop
 54d:	90                   	nop
 54e:	90                   	nop
 54f:	90                   	nop

00000550 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 550:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 551:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 553:	89 e5                	mov    %esp,%ebp
 555:	8b 4d 08             	mov    0x8(%ebp),%ecx
 558:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 559:	0f b6 11             	movzbl (%ecx),%edx
 55c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 55f:	80 fb 09             	cmp    $0x9,%bl
 562:	77 1c                	ja     580 <atoi+0x30>
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 568:	0f be d2             	movsbl %dl,%edx
 56b:	83 c1 01             	add    $0x1,%ecx
 56e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 571:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 575:	0f b6 11             	movzbl (%ecx),%edx
 578:	8d 5a d0             	lea    -0x30(%edx),%ebx
 57b:	80 fb 09             	cmp    $0x9,%bl
 57e:	76 e8                	jbe    568 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 580:	5b                   	pop    %ebx
 581:	5d                   	pop    %ebp
 582:	c3                   	ret    
 583:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000590 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	56                   	push   %esi
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	53                   	push   %ebx
 598:	8b 5d 10             	mov    0x10(%ebp),%ebx
 59b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 59e:	85 db                	test   %ebx,%ebx
 5a0:	7e 14                	jle    5b6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 5a2:	31 d2                	xor    %edx,%edx
 5a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 5a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 5ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5b2:	39 da                	cmp    %ebx,%edx
 5b4:	75 f2                	jne    5a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 5b6:	5b                   	pop    %ebx
 5b7:	5e                   	pop    %esi
 5b8:	5d                   	pop    %ebp
 5b9:	c3                   	ret    
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005c0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5c6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 5c9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 5cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 5cf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 5db:	00 
 5dc:	89 04 24             	mov    %eax,(%esp)
 5df:	e8 d4 00 00 00       	call   6b8 <open>
  if(fd < 0)
 5e4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5e6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 5e8:	78 19                	js     603 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 5ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 5ed:	89 1c 24             	mov    %ebx,(%esp)
 5f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f4:	e8 d7 00 00 00       	call   6d0 <fstat>
  close(fd);
 5f9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 5fc:	89 c6                	mov    %eax,%esi
  close(fd);
 5fe:	e8 9d 00 00 00       	call   6a0 <close>
  return r;
}
 603:	89 f0                	mov    %esi,%eax
 605:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 608:	8b 75 fc             	mov    -0x4(%ebp),%esi
 60b:	89 ec                	mov    %ebp,%esp
 60d:	5d                   	pop    %ebp
 60e:	c3                   	ret    
 60f:	90                   	nop

00000610 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	56                   	push   %esi
 615:	31 f6                	xor    %esi,%esi
 617:	53                   	push   %ebx
 618:	83 ec 2c             	sub    $0x2c,%esp
 61b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 61e:	eb 06                	jmp    626 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 620:	3c 0a                	cmp    $0xa,%al
 622:	74 39                	je     65d <gets+0x4d>
 624:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 626:	8d 5e 01             	lea    0x1(%esi),%ebx
 629:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 62c:	7d 31                	jge    65f <gets+0x4f>
    cc = read(0, &c, 1);
 62e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 631:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 638:	00 
 639:	89 44 24 04          	mov    %eax,0x4(%esp)
 63d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 644:	e8 47 00 00 00       	call   690 <read>
    if(cc < 1)
 649:	85 c0                	test   %eax,%eax
 64b:	7e 12                	jle    65f <gets+0x4f>
      break;
    buf[i++] = c;
 64d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 651:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 655:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 659:	3c 0d                	cmp    $0xd,%al
 65b:	75 c3                	jne    620 <gets+0x10>
 65d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 65f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 663:	89 f8                	mov    %edi,%eax
 665:	83 c4 2c             	add    $0x2c,%esp
 668:	5b                   	pop    %ebx
 669:	5e                   	pop    %esi
 66a:	5f                   	pop    %edi
 66b:	5d                   	pop    %ebp
 66c:	c3                   	ret    
 66d:	90                   	nop
 66e:	90                   	nop
 66f:	90                   	nop

00000670 <fork>:
 670:	b8 01 00 00 00       	mov    $0x1,%eax
 675:	cd 30                	int    $0x30
 677:	c3                   	ret    

00000678 <exit>:
 678:	b8 02 00 00 00       	mov    $0x2,%eax
 67d:	cd 30                	int    $0x30
 67f:	c3                   	ret    

00000680 <wait>:
 680:	b8 03 00 00 00       	mov    $0x3,%eax
 685:	cd 30                	int    $0x30
 687:	c3                   	ret    

00000688 <pipe>:
 688:	b8 04 00 00 00       	mov    $0x4,%eax
 68d:	cd 30                	int    $0x30
 68f:	c3                   	ret    

00000690 <read>:
 690:	b8 06 00 00 00       	mov    $0x6,%eax
 695:	cd 30                	int    $0x30
 697:	c3                   	ret    

00000698 <write>:
 698:	b8 05 00 00 00       	mov    $0x5,%eax
 69d:	cd 30                	int    $0x30
 69f:	c3                   	ret    

000006a0 <close>:
 6a0:	b8 07 00 00 00       	mov    $0x7,%eax
 6a5:	cd 30                	int    $0x30
 6a7:	c3                   	ret    

000006a8 <kill>:
 6a8:	b8 08 00 00 00       	mov    $0x8,%eax
 6ad:	cd 30                	int    $0x30
 6af:	c3                   	ret    

000006b0 <exec>:
 6b0:	b8 09 00 00 00       	mov    $0x9,%eax
 6b5:	cd 30                	int    $0x30
 6b7:	c3                   	ret    

000006b8 <open>:
 6b8:	b8 0a 00 00 00       	mov    $0xa,%eax
 6bd:	cd 30                	int    $0x30
 6bf:	c3                   	ret    

000006c0 <mknod>:
 6c0:	b8 0b 00 00 00       	mov    $0xb,%eax
 6c5:	cd 30                	int    $0x30
 6c7:	c3                   	ret    

000006c8 <unlink>:
 6c8:	b8 0c 00 00 00       	mov    $0xc,%eax
 6cd:	cd 30                	int    $0x30
 6cf:	c3                   	ret    

000006d0 <fstat>:
 6d0:	b8 0d 00 00 00       	mov    $0xd,%eax
 6d5:	cd 30                	int    $0x30
 6d7:	c3                   	ret    

000006d8 <link>:
 6d8:	b8 0e 00 00 00       	mov    $0xe,%eax
 6dd:	cd 30                	int    $0x30
 6df:	c3                   	ret    

000006e0 <mkdir>:
 6e0:	b8 0f 00 00 00       	mov    $0xf,%eax
 6e5:	cd 30                	int    $0x30
 6e7:	c3                   	ret    

000006e8 <chdir>:
 6e8:	b8 10 00 00 00       	mov    $0x10,%eax
 6ed:	cd 30                	int    $0x30
 6ef:	c3                   	ret    

000006f0 <dup>:
 6f0:	b8 11 00 00 00       	mov    $0x11,%eax
 6f5:	cd 30                	int    $0x30
 6f7:	c3                   	ret    

000006f8 <getpid>:
 6f8:	b8 12 00 00 00       	mov    $0x12,%eax
 6fd:	cd 30                	int    $0x30
 6ff:	c3                   	ret    

00000700 <sbrk>:
 700:	b8 13 00 00 00       	mov    $0x13,%eax
 705:	cd 30                	int    $0x30
 707:	c3                   	ret    

00000708 <sleep>:
 708:	b8 14 00 00 00       	mov    $0x14,%eax
 70d:	cd 30                	int    $0x30
 70f:	c3                   	ret    

00000710 <getticks>:
 710:	b8 15 00 00 00       	mov    $0x15,%eax
 715:	cd 30                	int    $0x30
 717:	c3                   	ret    
 718:	90                   	nop
 719:	90                   	nop
 71a:	90                   	nop
 71b:	90                   	nop
 71c:	90                   	nop
 71d:	90                   	nop
 71e:	90                   	nop
 71f:	90                   	nop

00000720 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	83 ec 28             	sub    $0x28,%esp
 726:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 729:	8d 55 f4             	lea    -0xc(%ebp),%edx
 72c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 733:	00 
 734:	89 54 24 04          	mov    %edx,0x4(%esp)
 738:	89 04 24             	mov    %eax,(%esp)
 73b:	e8 58 ff ff ff       	call   698 <write>
}
 740:	c9                   	leave  
 741:	c3                   	ret    
 742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000750 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	89 c7                	mov    %eax,%edi
 756:	56                   	push   %esi
 757:	89 ce                	mov    %ecx,%esi
 759:	53                   	push   %ebx
 75a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 75d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 760:	85 c9                	test   %ecx,%ecx
 762:	74 04                	je     768 <printint+0x18>
 764:	85 d2                	test   %edx,%edx
 766:	78 5d                	js     7c5 <printint+0x75>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 768:	89 d0                	mov    %edx,%eax
 76a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 771:	31 c9                	xor    %ecx,%ecx
 773:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 776:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 778:	31 d2                	xor    %edx,%edx
 77a:	f7 f6                	div    %esi
 77c:	0f b6 92 bb 0b 00 00 	movzbl 0xbbb(%edx),%edx
 783:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 786:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
 789:	85 c0                	test   %eax,%eax
 78b:	75 eb                	jne    778 <printint+0x28>
  if(neg)
 78d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 790:	85 c0                	test   %eax,%eax
 792:	74 08                	je     79c <printint+0x4c>
    buf[i++] = '-';
 794:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 799:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
 79c:	8d 71 ff             	lea    -0x1(%ecx),%esi
 79f:	01 f3                	add    %esi,%ebx
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 7a8:	0f be 13             	movsbl (%ebx),%edx
 7ab:	89 f8                	mov    %edi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 7ad:	83 ee 01             	sub    $0x1,%esi
 7b0:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
 7b3:	e8 68 ff ff ff       	call   720 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 7b8:	83 fe ff             	cmp    $0xffffffff,%esi
 7bb:	75 eb                	jne    7a8 <printint+0x58>
    putc(fd, buf[i]);
}
 7bd:	83 c4 2c             	add    $0x2c,%esp
 7c0:	5b                   	pop    %ebx
 7c1:	5e                   	pop    %esi
 7c2:	5f                   	pop    %edi
 7c3:	5d                   	pop    %ebp
 7c4:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 7c5:	89 d0                	mov    %edx,%eax
 7c7:	f7 d8                	neg    %eax
 7c9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 7d0:	eb 9f                	jmp    771 <printint+0x21>
 7d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7e9:	8b 45 0c             	mov    0xc(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7ec:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7ef:	0f b6 08             	movzbl (%eax),%ecx
 7f2:	84 c9                	test   %cl,%cl
 7f4:	0f 84 96 00 00 00    	je     890 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 7fa:	8d 55 10             	lea    0x10(%ebp),%edx
 7fd:	31 f6                	xor    %esi,%esi
 7ff:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 802:	31 db                	xor    %ebx,%ebx
 804:	eb 1a                	jmp    820 <printf+0x40>
 806:	66 90                	xchg   %ax,%ax
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 808:	83 f9 25             	cmp    $0x25,%ecx
 80b:	0f 85 87 00 00 00    	jne    898 <printf+0xb8>
 811:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 815:	83 c3 01             	add    $0x1,%ebx
 818:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 81c:	84 c9                	test   %cl,%cl
 81e:	74 70                	je     890 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
 820:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 822:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 825:	74 e1                	je     808 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 827:	83 fe 25             	cmp    $0x25,%esi
 82a:	75 e9                	jne    815 <printf+0x35>
      if(c == 'd'){
 82c:	83 f9 64             	cmp    $0x64,%ecx
 82f:	90                   	nop
 830:	0f 84 fa 00 00 00    	je     930 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 836:	83 f9 70             	cmp    $0x70,%ecx
 839:	74 75                	je     8b0 <printf+0xd0>
 83b:	83 f9 78             	cmp    $0x78,%ecx
 83e:	66 90                	xchg   %ax,%ax
 840:	74 6e                	je     8b0 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 842:	83 f9 73             	cmp    $0x73,%ecx
 845:	0f 84 8d 00 00 00    	je     8d8 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 84b:	83 f9 63             	cmp    $0x63,%ecx
 84e:	66 90                	xchg   %ax,%ax
 850:	0f 84 fe 00 00 00    	je     954 <printf+0x174>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 856:	83 f9 25             	cmp    $0x25,%ecx
 859:	0f 84 b9 00 00 00    	je     918 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 85f:	ba 25 00 00 00       	mov    $0x25,%edx
 864:	89 f8                	mov    %edi,%eax
 866:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 869:	83 c3 01             	add    $0x1,%ebx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 86c:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 86e:	e8 ad fe ff ff       	call   720 <putc>
        putc(fd, c);
 873:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 876:	89 f8                	mov    %edi,%eax
 878:	0f be d1             	movsbl %cl,%edx
 87b:	e8 a0 fe ff ff       	call   720 <putc>
 880:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 883:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 887:	84 c9                	test   %cl,%cl
 889:	75 95                	jne    820 <printf+0x40>
 88b:	90                   	nop
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 890:	83 c4 2c             	add    $0x2c,%esp
 893:	5b                   	pop    %ebx
 894:	5e                   	pop    %esi
 895:	5f                   	pop    %edi
 896:	5d                   	pop    %ebp
 897:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 898:	89 f8                	mov    %edi,%eax
 89a:	0f be d1             	movsbl %cl,%edx
 89d:	e8 7e fe ff ff       	call   720 <putc>
 8a2:	8b 45 0c             	mov    0xc(%ebp),%eax
 8a5:	e9 6b ff ff ff       	jmp    815 <printf+0x35>
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 8b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8b3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
 8b8:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 8ba:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 8c1:	8b 10                	mov    (%eax),%edx
 8c3:	89 f8                	mov    %edi,%eax
 8c5:	e8 86 fe ff ff       	call   750 <printint>
 8ca:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 8cd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 8d1:	e9 3f ff ff ff       	jmp    815 <printf+0x35>
 8d6:	66 90                	xchg   %ax,%ax
      } else if(c == 's'){
        s = (char*)*ap;
 8d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 8db:	8b 32                	mov    (%edx),%esi
        ap++;
 8dd:	83 c2 04             	add    $0x4,%edx
 8e0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        if(s == 0)
 8e3:	85 f6                	test   %esi,%esi
 8e5:	0f 84 84 00 00 00    	je     96f <printf+0x18f>
          s = "(null)";
        while(*s != 0){
 8eb:	0f b6 16             	movzbl (%esi),%edx
 8ee:	84 d2                	test   %dl,%dl
 8f0:	74 1d                	je     90f <printf+0x12f>
 8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
 8f8:	0f be d2             	movsbl %dl,%edx
          s++;
 8fb:	83 c6 01             	add    $0x1,%esi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 8fe:	89 f8                	mov    %edi,%eax
 900:	e8 1b fe ff ff       	call   720 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 905:	0f b6 16             	movzbl (%esi),%edx
 908:	84 d2                	test   %dl,%dl
 90a:	75 ec                	jne    8f8 <printf+0x118>
 90c:	8b 45 0c             	mov    0xc(%ebp),%eax
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 90f:	31 f6                	xor    %esi,%esi
 911:	e9 ff fe ff ff       	jmp    815 <printf+0x35>
 916:	66 90                	xchg   %ax,%ax
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
 918:	89 f8                	mov    %edi,%eax
 91a:	ba 25 00 00 00       	mov    $0x25,%edx
 91f:	e8 fc fd ff ff       	call   720 <putc>
 924:	31 f6                	xor    %esi,%esi
 926:	8b 45 0c             	mov    0xc(%ebp),%eax
 929:	e9 e7 fe ff ff       	jmp    815 <printf+0x35>
 92e:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 930:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 933:	b1 0a                	mov    $0xa,%cl
        ap++;
 935:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 938:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 93f:	8b 10                	mov    (%eax),%edx
 941:	89 f8                	mov    %edi,%eax
 943:	e8 08 fe ff ff       	call   750 <printint>
 948:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 94b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 94f:	e9 c1 fe ff ff       	jmp    815 <printf+0x35>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 954:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        ap++;
 957:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 959:	0f be 10             	movsbl (%eax),%edx
 95c:	89 f8                	mov    %edi,%eax
 95e:	e8 bd fd ff ff       	call   720 <putc>
 963:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
 966:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 96a:	e9 a6 fe ff ff       	jmp    815 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
 96f:	be b4 0b 00 00       	mov    $0xbb4,%esi
 974:	e9 72 ff ff ff       	jmp    8eb <printf+0x10b>
 979:	90                   	nop
 97a:	90                   	nop
 97b:	90                   	nop
 97c:	90                   	nop
 97d:	90                   	nop
 97e:	90                   	nop
 97f:	90                   	nop

00000980 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 980:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 981:	a1 e8 0b 00 00       	mov    0xbe8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 986:	89 e5                	mov    %esp,%ebp
 988:	57                   	push   %edi
 989:	56                   	push   %esi
 98a:	53                   	push   %ebx
 98b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 98e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 991:	39 c8                	cmp    %ecx,%eax
 993:	73 1d                	jae    9b2 <free+0x32>
 995:	8d 76 00             	lea    0x0(%esi),%esi
 998:	8b 10                	mov    (%eax),%edx
 99a:	39 d1                	cmp    %edx,%ecx
 99c:	72 1a                	jb     9b8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 99e:	39 d0                	cmp    %edx,%eax
 9a0:	72 08                	jb     9aa <free+0x2a>
 9a2:	39 c8                	cmp    %ecx,%eax
 9a4:	72 12                	jb     9b8 <free+0x38>
 9a6:	39 d1                	cmp    %edx,%ecx
 9a8:	72 0e                	jb     9b8 <free+0x38>
 9aa:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ac:	39 c8                	cmp    %ecx,%eax
 9ae:	66 90                	xchg   %ax,%ax
 9b0:	72 e6                	jb     998 <free+0x18>
 9b2:	8b 10                	mov    (%eax),%edx
 9b4:	eb e8                	jmp    99e <free+0x1e>
 9b6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 9b8:	8b 71 04             	mov    0x4(%ecx),%esi
 9bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9be:	39 d7                	cmp    %edx,%edi
 9c0:	74 19                	je     9db <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 9c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9c5:	8b 50 04             	mov    0x4(%eax),%edx
 9c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9cb:	39 ce                	cmp    %ecx,%esi
 9cd:	74 21                	je     9f0 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9cf:	89 08                	mov    %ecx,(%eax)
  freep = p;
 9d1:	a3 e8 0b 00 00       	mov    %eax,0xbe8
}
 9d6:	5b                   	pop    %ebx
 9d7:	5e                   	pop    %esi
 9d8:	5f                   	pop    %edi
 9d9:	5d                   	pop    %ebp
 9da:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9db:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 9de:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9e0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9e6:	8b 50 04             	mov    0x4(%eax),%edx
 9e9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9ec:	39 ce                	cmp    %ecx,%esi
 9ee:	75 df                	jne    9cf <free+0x4f>
    p->s.size += bp->s.size;
 9f0:	03 51 04             	add    0x4(%ecx),%edx
 9f3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9f6:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9f9:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 9fb:	a3 e8 0b 00 00       	mov    %eax,0xbe8
}
 a00:	5b                   	pop    %ebx
 a01:	5e                   	pop    %esi
 a02:	5f                   	pop    %edi
 a03:	5d                   	pop    %ebp
 a04:	c3                   	ret    
 a05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	57                   	push   %edi
 a14:	56                   	push   %esi
 a15:	53                   	push   %ebx
 a16:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 a1c:	8b 0d e8 0b 00 00    	mov    0xbe8,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a22:	83 c3 07             	add    $0x7,%ebx
 a25:	c1 eb 03             	shr    $0x3,%ebx
 a28:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 a2b:	85 c9                	test   %ecx,%ecx
 a2d:	0f 84 93 00 00 00    	je     ac6 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a33:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 a35:	8b 50 04             	mov    0x4(%eax),%edx
 a38:	39 d3                	cmp    %edx,%ebx
 a3a:	76 1f                	jbe    a5b <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 a3c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a43:	90                   	nop
 a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 a48:	3b 05 e8 0b 00 00    	cmp    0xbe8,%eax
 a4e:	74 30                	je     a80 <malloc+0x70>
 a50:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a52:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 a54:	8b 50 04             	mov    0x4(%eax),%edx
 a57:	39 d3                	cmp    %edx,%ebx
 a59:	77 ed                	ja     a48 <malloc+0x38>
      if(p->s.size == nunits)
 a5b:	39 d3                	cmp    %edx,%ebx
 a5d:	74 61                	je     ac0 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a5f:	29 da                	sub    %ebx,%edx
 a61:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a64:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 a67:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 a6a:	89 0d e8 0b 00 00    	mov    %ecx,0xbe8
      return (void*) (p + 1);
 a70:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a73:	83 c4 1c             	add    $0x1c,%esp
 a76:	5b                   	pop    %ebx
 a77:	5e                   	pop    %esi
 a78:	5f                   	pop    %edi
 a79:	5d                   	pop    %ebp
 a7a:	c3                   	ret    
 a7b:	90                   	nop
 a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 a80:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 a86:	b8 00 80 00 00       	mov    $0x8000,%eax
 a8b:	bf 00 10 00 00       	mov    $0x1000,%edi
 a90:	76 04                	jbe    a96 <malloc+0x86>
 a92:	89 f0                	mov    %esi,%eax
 a94:	89 df                	mov    %ebx,%edi
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 a96:	89 04 24             	mov    %eax,(%esp)
 a99:	e8 62 fc ff ff       	call   700 <sbrk>
  if(p == (char*) -1)
 a9e:	83 f8 ff             	cmp    $0xffffffff,%eax
 aa1:	74 18                	je     abb <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 aa3:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 aa6:	83 c0 08             	add    $0x8,%eax
 aa9:	89 04 24             	mov    %eax,(%esp)
 aac:	e8 cf fe ff ff       	call   980 <free>
  return freep;
 ab1:	8b 0d e8 0b 00 00    	mov    0xbe8,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 ab7:	85 c9                	test   %ecx,%ecx
 ab9:	75 97                	jne    a52 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 abb:	31 c0                	xor    %eax,%eax
 abd:	eb b4                	jmp    a73 <malloc+0x63>
 abf:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 ac0:	8b 10                	mov    (%eax),%edx
 ac2:	89 11                	mov    %edx,(%ecx)
 ac4:	eb a4                	jmp    a6a <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 ac6:	c7 05 e8 0b 00 00 e0 	movl   $0xbe0,0xbe8
 acd:	0b 00 00 
    base.s.size = 0;
 ad0:	b9 e0 0b 00 00       	mov    $0xbe0,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 ad5:	c7 05 e0 0b 00 00 e0 	movl   $0xbe0,0xbe0
 adc:	0b 00 00 
    base.s.size = 0;
 adf:	c7 05 e4 0b 00 00 00 	movl   $0x0,0xbe4
 ae6:	00 00 00 
 ae9:	e9 45 ff ff ff       	jmp    a33 <malloc+0x23>
