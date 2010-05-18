
_hackbench:     file format elf32-i386


Disassembly of section .text:

00000000 <barf>:
}pollfd[512];



static void barf(const char *msg)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  printf(STDOUT, "(Error: %s)\n", msg);
   6:	89 44 24 08          	mov    %eax,0x8(%esp)
   a:	c7 44 24 04 50 0b 00 	movl   $0xb50,0x4(%esp)
  11:	00 
  12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  19:	e8 22 08 00 00       	call   840 <printf>
  exit();
  1e:	e8 b5 06 00 00       	call   6d8 <exit>
  23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000030 <ready>:
  }	      
}

/* Block until we're ready to go */
static void ready(int ready_out, int wakefd, int id, int caller)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	56                   	push   %esi
  34:	89 ce                	mov    %ecx,%esi
  36:	53                   	push   %ebx
  37:	83 ec 20             	sub    $0x20,%esp
  3a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char dummy;
  dummy = 'a';
  // TODO: Implement myPoll function
  pollfd[id].fd = wakefd;
  3d:	89 14 cd 80 0c 00 00 	mov    %edx,0xc80(,%ecx,8)
  if(caller == RECEIVER) pollfd[id].events = POLLIN;
  44:	83 fb 02             	cmp    $0x2,%ebx
  47:	74 6f                	je     b8 <ready+0x88>

/* Block until we're ready to go */
static void ready(int ready_out, int wakefd, int id, int caller)
{
  char dummy;
  dummy = 'a';
  49:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  // TODO: Implement myPoll function
  pollfd[id].fd = wakefd;
  if(caller == RECEIVER) pollfd[id].events = POLLIN;

  /* Tell them we're ready. */
  if (write(ready_out, &dummy, 1) != 1)
  4d:	8d 55 f7             	lea    -0x9(%ebp),%edx
  50:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  57:	00 
  58:	89 54 24 04          	mov    %edx,0x4(%esp)
  5c:	89 04 24             	mov    %eax,(%esp)
  5f:	e8 94 06 00 00       	call   6f8 <write>
  64:	83 f8 01             	cmp    $0x1,%eax
  67:	74 0a                	je     73 <ready+0x43>
    barf("CLIENT: ready write");
  69:	b8 5d 0b 00 00       	mov    $0xb5d,%eax
  6e:	e8 8d ff ff ff       	call   0 <barf>

  /* Wait for "GO" signal */
  //TODO: Polling should be re-implemented for xv6.
  //if (poll(&pollfd, 1, -1) != 1)
  //        barf("poll");
  if(caller == SENDER){
  73:	83 fb 01             	cmp    $0x1,%ebx
  76:	74 30                	je     a8 <ready+0x78>
    if(DEBUG) checkEvents(id, pollfd[id].events, caller, "waiting");
    while(pollfd[id].events == POLLIN);
    if(DEBUG) checkEvents(id, pollfd[id].events, caller, "ready");
  }else if(caller == RECEIVER){
  78:	83 fb 02             	cmp    $0x2,%ebx
  7b:	74 13                	je     90 <ready+0x60>
    pollfd[id].events = FREE;
    //while(getticks() < TIMEOUT);
    if(DEBUG) checkEvents(id, pollfd[id].events, caller, "ready");
  }else{
    barf("Failed being ready.");
  7d:	b8 71 0b 00 00       	mov    $0xb71,%eax
  82:	e8 79 ff ff ff       	call   0 <barf>
  }
}
  87:	83 c4 20             	add    $0x20,%esp
  8a:	5b                   	pop    %ebx
  8b:	5e                   	pop    %esi
  8c:	5d                   	pop    %ebp
  8d:	c3                   	ret    
  8e:	66 90                	xchg   %ax,%ax
  if(caller == SENDER){
    if(DEBUG) checkEvents(id, pollfd[id].events, caller, "waiting");
    while(pollfd[id].events == POLLIN);
    if(DEBUG) checkEvents(id, pollfd[id].events, caller, "ready");
  }else if(caller == RECEIVER){
    pollfd[id].events = FREE;
  90:	66 c7 04 f5 84 0c 00 	movw   $0x0,0xc84(,%esi,8)
  97:	00 00 00 
    //while(getticks() < TIMEOUT);
    if(DEBUG) checkEvents(id, pollfd[id].events, caller, "ready");
  }else{
    barf("Failed being ready.");
  }
}
  9a:	83 c4 20             	add    $0x20,%esp
  9d:	5b                   	pop    %ebx
  9e:	5e                   	pop    %esi
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  //TODO: Polling should be re-implemented for xv6.
  //if (poll(&pollfd, 1, -1) != 1)
  //        barf("poll");
  if(caller == SENDER){
    if(DEBUG) checkEvents(id, pollfd[id].events, caller, "waiting");
    while(pollfd[id].events == POLLIN);
  a8:	66 83 3c f5 84 0c 00 	cmpw   $0x1,0xc84(,%esi,8)
  af:	00 01 
  b1:	75 d4                	jne    87 <ready+0x57>
  b3:	eb fe                	jmp    b3 <ready+0x83>
  b5:	8d 76 00             	lea    0x0(%esi),%esi
{
  char dummy;
  dummy = 'a';
  // TODO: Implement myPoll function
  pollfd[id].fd = wakefd;
  if(caller == RECEIVER) pollfd[id].events = POLLIN;
  b8:	66 c7 04 cd 84 0c 00 	movw   $0x1,0xc84(,%ecx,8)
  bf:	00 01 00 
  c2:	eb 85                	jmp    49 <ready+0x19>
  c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000d0 <fdpair>:
  printf(STDOUT, "(Error: %s)\n", msg);
  exit();
}

static void fdpair(int fds[2])
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	83 ec 18             	sub    $0x18,%esp
  if (use_pipes) {
  d6:	8b 15 54 0c 00 00    	mov    0xc54,%edx
  dc:	85 d2                	test   %edx,%edx
  de:	74 18                	je     f8 <fdpair+0x28>
    // TODO: Implement myPipe
    //    pipe(fds[0], fds[1]);
    if (pipe(fds) == 0)
  e0:	89 04 24             	mov    %eax,(%esp)
  e3:	e8 00 06 00 00       	call   6e8 <pipe>
  e8:	85 c0                	test   %eax,%eax
  ea:	75 07                	jne    f3 <fdpair+0x23>
      fd_count += 2;
  ec:	83 05 60 0c 00 00 02 	addl   $0x2,0xc60
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  }
  //barf("Creating fdpair");
}
  f3:	c9                   	leave  
  f4:	c3                   	ret    
  f5:	8d 76 00             	lea    0x0(%esi),%esi
  f8:	c9                   	leave  
      return;
  } else {
    // This mode would not run correctly in xv6
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  f9:	b8 18 0c 00 00       	mov    $0xc18,%eax
  fe:	e9 fd fe ff ff       	jmp    0 <barf>
 103:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <group>:

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	89 cf                	mov    %ecx,%edi
 116:	56                   	push   %esi
 117:	53                   	push   %ebx
 118:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
 11e:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  unsigned int i;
  unsigned int out_fds[num_fds];
 124:	8d 04 85 1e 00 00 00 	lea    0x1e(,%eax,4),%eax

  for (i = 0; i < num_fds; i++) {
 12b:	8b b5 6c ff ff ff    	mov    -0x94(%ebp),%esi
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];
 131:	83 e0 f0             	and    $0xfffffff0,%eax
 134:	29 c4                	sub    %eax,%esp
 136:	8d 44 24 1b          	lea    0x1b(%esp),%eax
 13a:	83 e0 f0             	and    $0xfffffff0,%eax

  for (i = 0; i < num_fds; i++) {
 13d:	85 f6                	test   %esi,%esi

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
 13f:	89 95 70 ff ff ff    	mov    %edx,-0x90(%ebp)
  unsigned int i;
  unsigned int out_fds[num_fds];
 145:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)

  for (i = 0; i < num_fds; i++) {
 14b:	74 3c                	je     189 <group+0x79>
 14d:	31 db                	xor    %ebx,%ebx
 14f:	8d 75 e0             	lea    -0x20(%ebp),%esi
    int fds[2];

    /* Create the pipe between client and server */
    fdpair(fds);
 152:	89 f0                	mov    %esi,%eax
 154:	e8 77 ff ff ff       	call   d0 <fdpair>

    /* Fork the receiver. */
    switch (fork()) {
 159:	e8 72 05 00 00       	call   6d0 <fork>
 15e:	83 f8 ff             	cmp    $0xffffffff,%eax
 161:	74 55                	je     1b8 <group+0xa8>
 163:	85 c0                	test   %eax,%eax
 165:	74 5b                	je     1c2 <group+0xb2>
      fd_count++;
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
      exit();
    }

    out_fds[i] = fds[1];
 167:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 16a:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
 170:	89 04 9a             	mov    %eax,(%edx,%ebx,4)
    close(fds[0]);
 173:	8b 45 e0             	mov    -0x20(%ebp),%eax
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
 176:	83 c3 01             	add    $0x1,%ebx
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
      exit();
    }

    out_fds[i] = fds[1];
    close(fds[0]);
 179:	89 04 24             	mov    %eax,(%esp)
 17c:	e8 7f 05 00 00       	call   700 <close>
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
 181:	39 9d 6c ff ff ff    	cmp    %ebx,-0x94(%ebp)
 187:	77 c9                	ja     152 <group+0x42>
 189:	31 f6                	xor    %esi,%esi
    out_fds[i] = fds[1];
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
 18b:	3b b5 6c ff ff ff    	cmp    -0x94(%ebp),%esi
 191:	0f 83 b5 01 00 00    	jae    34c <group+0x23c>
    switch (fork()) {
 197:	e8 34 05 00 00       	call   6d0 <fork>
 19c:	83 f8 ff             	cmp    $0xffffffff,%eax
 19f:	0f 84 d7 00 00 00    	je     27c <group+0x16c>
 1a5:	85 c0                	test   %eax,%eax
 1a7:	0f 84 d9 00 00 00    	je     286 <group+0x176>
    out_fds[i] = fds[1];
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
 1ad:	83 c6 01             	add    $0x1,%esi
 1b0:	eb d9                	jmp    18b <group+0x7b>
 1b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    /* Create the pipe between client and server */
    fdpair(fds);

    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
 1b8:	b8 85 0b 00 00       	mov    $0xb85,%eax
 1bd:	e8 3e fe ff ff       	call   0 <barf>
    case 0:
      close(fds[1]);
 1c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1c5:	89 04 24             	mov    %eax,(%esp)
 1c8:	e8 33 05 00 00       	call   700 <close>
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 1cd:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
 1d3:	89 d9                	mov    %ebx,%ecx
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
      fd_count++;
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 1d5:	6b 95 6c ff ff ff 64 	imul   $0x64,-0x94(%ebp),%edx
    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
      fd_count++;
 1dc:	83 05 60 0c 00 00 01 	addl   $0x1,0xc60
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 1e3:	8b 75 e0             	mov    -0x20(%ebp),%esi
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 1e6:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
      fd_count++;
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
 1ed:	89 95 6c ff ff ff    	mov    %edx,-0x94(%ebp)
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);
 1f3:	89 fa                	mov    %edi,%edx
 1f5:	e8 36 fe ff ff       	call   30 <ready>

  /* Receive them all */
  int timeout = 0;
  for (i = 0; i < num_packets; i++) {
 1fa:	8b 9d 6c ff ff ff    	mov    -0x94(%ebp),%ebx
 200:	85 db                	test   %ebx,%ebx
 202:	74 65                	je     269 <group+0x159>
 204:	8d 9d 7c ff ff ff    	lea    -0x84(%ebp),%ebx
    char data[DATASIZE];
    int ret, done = 0;

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
 20a:	89 9d 74 ff ff ff    	mov    %ebx,-0x8c(%ebp)
 210:	89 f3                	mov    %esi,%ebx
  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);

  /* Receive them all */
  int timeout = 0;
  for (i = 0; i < num_packets; i++) {
 212:	c7 85 70 ff ff ff 00 	movl   $0x0,-0x90(%ebp)
 219:	00 00 00 
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 220:	31 f6                	xor    %esi,%esi
 222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    char data[DATASIZE];
    int ret, done = 0;

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
 228:	b8 64 00 00 00       	mov    $0x64,%eax
 22d:	29 f0                	sub    %esi,%eax
 22f:	89 44 24 08          	mov    %eax,0x8(%esp)
 233:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
 239:	89 1c 24             	mov    %ebx,(%esp)
 23c:	01 f0                	add    %esi,%eax
 23e:	89 44 24 04          	mov    %eax,0x4(%esp)
 242:	e8 a9 04 00 00       	call   6f0 <read>
    if(DEBUG) printf(STDOUT, "recv[%d]: ret = %d. (%d/%d)\n", id, ret, i, num_packets);
    if (ret < 0)
 247:	85 c0                	test   %eax,%eax
  for (i = 0; i < num_packets; i++) {
    char data[DATASIZE];
    int ret, done = 0;

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
 249:	89 c7                	mov    %eax,%edi
    if(DEBUG) printf(STDOUT, "recv[%d]: ret = %d. (%d/%d)\n", id, ret, i, num_packets);
    if (ret < 0)
 24b:	78 23                	js     270 <group+0x160>
      barf("SERVER: read");
    done += ret;
 24d:	01 fe                	add    %edi,%esi
    if (done < DATASIZE){
 24f:	83 fe 63             	cmp    $0x63,%esi
 252:	7e d4                	jle    228 <group+0x118>
  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);

  /* Receive them all */
  int timeout = 0;
  for (i = 0; i < num_packets; i++) {
 254:	83 85 70 ff ff ff 01 	addl   $0x1,-0x90(%ebp)
 25b:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
 261:	39 85 6c ff ff ff    	cmp    %eax,-0x94(%ebp)
 267:	77 b7                	ja     220 <group+0x110>
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      fd_count += 2;
      sender(num_fds, out_fds, ready_out, wakefd, i);
      exit();
 269:	e8 6a 04 00 00       	call   6d8 <exit>
 26e:	66 90                	xchg   %ax,%ax

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
    if(DEBUG) printf(STDOUT, "recv[%d]: ret = %d. (%d/%d)\n", id, ret, i, num_packets);
    if (ret < 0)
      barf("SERVER: read");
 270:	b8 8c 0b 00 00       	mov    $0xb8c,%eax
 275:	e8 86 fd ff ff       	call   0 <barf>
 27a:	eb d1                	jmp    24d <group+0x13d>
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
    switch (fork()) {
    case -1: barf("fork()");
 27c:	b8 85 0b 00 00       	mov    $0xb85,%eax
 281:	e8 7a fd ff ff       	call   0 <barf>
    case 0:
      fd_count += 2;
 286:	83 05 60 0c 00 00 02 	addl   $0x2,0xc60
 28d:	31 c0                	xor    %eax,%eax
 28f:	8d 9d 7c ff ff ff    	lea    -0x84(%ebp),%ebx
 295:	8d 76 00             	lea    0x0(%esi),%esi
		   int id)
{
  char data[DATASIZE];
  int k;
  for(k=0; k<DATASIZE-1 ; k++){
    data[k] = 'b';
 298:	c6 04 03 62          	movb   $0x62,(%ebx,%eax,1)
                   int wakefd,
		   int id)
{
  char data[DATASIZE];
  int k;
  for(k=0; k<DATASIZE-1 ; k++){
 29c:	83 c0 01             	add    $0x1,%eax
 29f:	83 f8 63             	cmp    $0x63,%eax
 2a2:	75 f4                	jne    298 <group+0x188>
  data[k] = '\0';
  
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 2a4:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
 2aa:	89 f1                	mov    %esi,%ecx
 2ac:	89 fa                	mov    %edi,%edx
  char data[DATASIZE];
  int k;
  for(k=0; k<DATASIZE-1 ; k++){
    data[k] = 'b';
  }
  data[k] = '\0';
 2ae:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
  
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 2b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2b9:	e8 72 fd ff ff       	call   30 <ready>
 2be:	c7 85 68 ff ff ff 00 	movl   $0x0,-0x98(%ebp)
 2c5:	00 00 00 
 2c8:	89 9d 70 ff ff ff    	mov    %ebx,-0x90(%ebp)

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
 2ce:	8b 8d 6c ff ff ff    	mov    -0x94(%ebp),%ecx
  data[k] = '\0';
  
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 2d4:	31 ff                	xor    %edi,%edi

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
 2d6:	85 c9                	test   %ecx,%ecx
 2d8:	74 4e                	je     328 <group+0x218>
 2da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  data[k] = '\0';
  
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);
 2e0:	31 db                	xor    %ebx,%ebx
 2e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
      int ret, done = 0;

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
 2e8:	b8 64 00 00 00       	mov    $0x64,%eax
 2ed:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
 2f3:	29 d8                	sub    %ebx,%eax
 2f5:	89 44 24 08          	mov    %eax,0x8(%esp)
 2f9:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
 2ff:	01 d8                	add    %ebx,%eax
 301:	89 44 24 04          	mov    %eax,0x4(%esp)
 305:	8b 04 ba             	mov    (%edx,%edi,4),%eax
 308:	89 04 24             	mov    %eax,(%esp)
 30b:	e8 e8 03 00 00       	call   6f8 <write>
      if(DEBUG) printf(STDOUT, "send[%d]: ret = %d. (%d/%d/%d)\n", id, ret, i, num_fds, loops);
      if (ret < 0)
 310:	85 c0                	test   %eax,%eax
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
      int ret, done = 0;

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
 312:	89 c6                	mov    %eax,%esi
      if(DEBUG) printf(STDOUT, "send[%d]: ret = %d. (%d/%d/%d)\n", id, ret, i, num_fds, loops);
      if (ret < 0)
 314:	78 2a                	js     340 <group+0x230>
	barf("SENDER: write");
      done += ret;
 316:	01 f3                	add    %esi,%ebx
      if (done < sizeof(data))
 318:	83 fb 63             	cmp    $0x63,%ebx
 31b:	76 cb                	jbe    2e8 <group+0x1d8>
  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
 31d:	83 c7 01             	add    $0x1,%edi
 320:	39 bd 6c ff ff ff    	cmp    %edi,-0x94(%ebp)
 326:	77 b8                	ja     2e0 <group+0x1d0>

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
 328:	83 85 68 ff ff ff 01 	addl   $0x1,-0x98(%ebp)
 32f:	83 bd 68 ff ff ff 64 	cmpl   $0x64,-0x98(%ebp)
 336:	75 96                	jne    2ce <group+0x1be>
 338:	e9 2c ff ff ff       	jmp    269 <group+0x159>
 33d:	8d 76 00             	lea    0x0(%esi),%esi

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
      if(DEBUG) printf(STDOUT, "send[%d]: ret = %d. (%d/%d/%d)\n", id, ret, i, num_fds, loops);
      if (ret < 0)
	barf("SENDER: write");
 340:	b8 99 0b 00 00       	mov    $0xb99,%eax
 345:	e8 b6 fc ff ff       	call   0 <barf>
 34a:	eb ca                	jmp    316 <group+0x206>
    out_fds[i] = fds[1];
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
 34c:	31 db                	xor    %ebx,%ebx
 34e:	8b b5 74 ff ff ff    	mov    -0x8c(%ebp),%esi
 354:	eb 0e                	jmp    364 <group+0x254>
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
    close(out_fds[i]);
 356:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 359:	83 c3 01             	add    $0x1,%ebx
    close(out_fds[i]);
 35c:	89 04 24             	mov    %eax,(%esp)
 35f:	e8 9c 03 00 00       	call   700 <close>
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 364:	3b 9d 6c ff ff ff    	cmp    -0x94(%ebp),%ebx
 36a:	72 ea                	jb     356 <group+0x246>
 36c:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
    close(out_fds[i]);

  /* Reap number of children to reap */
  return num_fds * 2;
}
 372:	8d 65 f4             	lea    -0xc(%ebp),%esp
 375:	5b                   	pop    %ebx
 376:	5e                   	pop    %esi
 377:	5f                   	pop    %edi
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
 378:	01 c0                	add    %eax,%eax
    close(out_fds[i]);

  /* Reap number of children to reap */
  return num_fds * 2;
}
 37a:	5d                   	pop    %ebp
 37b:	c3                   	ret    
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000380 <main>:

int main(int argc, char *argv[])
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	83 e4 f0             	and    $0xfffffff0,%esp
 386:	57                   	push   %edi
 387:	56                   	push   %esi
 388:	53                   	push   %ebx
 389:	83 ec 44             	sub    $0x44,%esp
  //        barf("Usage: hackbench [-pipe] <num groups>\n");

  // NOTE: More than 3 causes error due to num of processes.
  num_groups = NUM_GROUPS; // TODO: This may seriously be considered.

  fdpair(readyfds);
 38c:	8d 44 24 34          	lea    0x34(%esp),%eax
    use_pipes = 1;
    argc--;
    argv++;
    }
  */
  use_pipes = 1;
 390:	c7 05 54 0c 00 00 01 	movl   $0x1,0xc54
 397:	00 00 00 
 39a:	8d 7c 24 3f          	lea    0x3f(%esp),%edi
  //        barf("Usage: hackbench [-pipe] <num groups>\n");

  // NOTE: More than 3 causes error due to num of processes.
  num_groups = NUM_GROUPS; // TODO: This may seriously be considered.

  fdpair(readyfds);
 39e:	e8 2d fd ff ff       	call   d0 <fdpair>
  fdpair(wakefds);
 3a3:	8d 44 24 2c          	lea    0x2c(%esp),%eax
 3a7:	e8 24 fd ff ff       	call   d0 <fdpair>

  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);
 3ac:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
 3b0:	b8 08 00 00 00       	mov    $0x8,%eax
 3b5:	8b 54 24 38          	mov    0x38(%esp),%edx
 3b9:	e8 52 fd ff ff       	call   110 <group>
 3be:	8b 4c 24 2c          	mov    0x2c(%esp),%ecx
 3c2:	8b 54 24 38          	mov    0x38(%esp),%edx
 3c6:	89 c3                	mov    %eax,%ebx
 3c8:	b8 08 00 00 00       	mov    $0x8,%eax
 3cd:	e8 3e fd ff ff       	call   110 <group>

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
 3d2:	01 c3                	add    %eax,%ebx
 3d4:	74 30                	je     406 <main+0x86>
 3d6:	31 f6                	xor    %esi,%esi
    if (read(readyfds[0], &dummy, 1) != 1)
 3d8:	8b 44 24 34          	mov    0x34(%esp),%eax
 3dc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3e3:	00 
 3e4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 3e8:	89 04 24             	mov    %eax,(%esp)
 3eb:	e8 00 03 00 00       	call   6f0 <read>
 3f0:	83 f8 01             	cmp    $0x1,%eax
 3f3:	74 0a                	je     3ff <main+0x7f>
      barf("Reading for readyfds");
 3f5:	b8 a7 0b 00 00       	mov    $0xba7,%eax
 3fa:	e8 01 fc ff ff       	call   0 <barf>
  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
 3ff:	83 c6 01             	add    $0x1,%esi
 402:	39 de                	cmp    %ebx,%esi
 404:	72 d2                	jb     3d8 <main+0x58>
    if (read(readyfds[0], &dummy, 1) != 1)
      barf("Reading for readyfds");

  //gettimeofday(&start, NULL);
  start = getticks();
 406:	e8 65 03 00 00       	call   770 <getticks>
  printf(STDOUT, "Start Watching Time ...\n");
 40b:	c7 44 24 04 bc 0b 00 	movl   $0xbbc,0x4(%esp)
 412:	00 
 413:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  for (i = 0; i < total_children; i++)
    if (read(readyfds[0], &dummy, 1) != 1)
      barf("Reading for readyfds");

  //gettimeofday(&start, NULL);
  start = getticks();
 41a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  printf(STDOUT, "Start Watching Time ...\n");
 41e:	e8 1d 04 00 00       	call   840 <printf>
  

  /* Kick them off */
  if (write(wakefds[1], &dummy, 1) != 1)
 423:	8b 44 24 30          	mov    0x30(%esp),%eax
 427:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 42e:	00 
 42f:	89 7c 24 04          	mov    %edi,0x4(%esp)
 433:	89 04 24             	mov    %eax,(%esp)
 436:	e8 bd 02 00 00       	call   6f8 <write>
 43b:	83 f8 01             	cmp    $0x1,%eax
 43e:	74 0a                	je     44a <main+0xca>
    barf("Writing to start them");
 440:	b8 d5 0b 00 00       	mov    $0xbd5,%eax
 445:	e8 b6 fb ff ff       	call   0 <barf>

  /* Reap them all */
  //TODO: Fix different specifications between xv6 and Linux
  for (i = 0; i < total_children; i++) {
 44a:	85 db                	test   %ebx,%ebx
 44c:	74 0e                	je     45c <main+0xdc>
 44e:	31 f6                	xor    %esi,%esi
 450:	83 c6 01             	add    $0x1,%esi
    //int status;
    //wait(&status); // TODO: Too Many Arguments???
    wait(); // Waiting for that all child's tasks finish.
 453:	e8 88 02 00 00       	call   6e0 <wait>
  if (write(wakefds[1], &dummy, 1) != 1)
    barf("Writing to start them");

  /* Reap them all */
  //TODO: Fix different specifications between xv6 and Linux
  for (i = 0; i < total_children; i++) {
 458:	39 de                	cmp    %ebx,%esi
 45a:	72 f4                	jb     450 <main+0xd0>
    // TODO: What's WIFEXITED ???
    //if (!WIFEXITED(status))
    //  exit();
  }
  
  stop = getticks();
 45c:	e8 0f 03 00 00       	call   770 <getticks>
  printf(STDOUT, "Stop Watching Time ...\n");
 461:	c7 44 24 04 eb 0b 00 	movl   $0xbeb,0x4(%esp)
 468:	00 
 469:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    // TODO: What's WIFEXITED ???
    //if (!WIFEXITED(status))
    //  exit();
  }
  
  stop = getticks();
 470:	89 c3                	mov    %eax,%ebx
  printf(STDOUT, "Stop Watching Time ...\n");
 472:	e8 c9 03 00 00       	call   840 <printf>
  diff = stop - start;

  /* Print time... */
  printf(STDOUT, "Time: %d [ticks]\n", diff);
 477:	89 d8                	mov    %ebx,%eax
 479:	2b 44 24 1c          	sub    0x1c(%esp),%eax
 47d:	c7 44 24 04 03 0c 00 	movl   $0xc03,0x4(%esp)
 484:	00 
 485:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 48c:	89 44 24 08          	mov    %eax,0x8(%esp)
 490:	e8 ab 03 00 00       	call   840 <printf>
  if(DEBUG) printf(STDOUT, "fd_count = %d\n", fd_count);
  exit();
 495:	e8 3e 02 00 00       	call   6d8 <exit>
 49a:	90                   	nop
 49b:	90                   	nop
 49c:	90                   	nop
 49d:	90                   	nop
 49e:	90                   	nop
 49f:	90                   	nop

000004a0 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 4a0:	55                   	push   %ebp
 4a1:	31 d2                	xor    %edx,%edx
 4a3:	89 e5                	mov    %esp,%ebp
 4a5:	8b 45 08             	mov    0x8(%ebp),%eax
 4a8:	53                   	push   %ebx
 4a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 4b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4b7:	83 c2 01             	add    $0x1,%edx
 4ba:	84 c9                	test   %cl,%cl
 4bc:	75 f2                	jne    4b0 <strcpy+0x10>
    ;
  return os;
}
 4be:	5b                   	pop    %ebx
 4bf:	5d                   	pop    %ebp
 4c0:	c3                   	ret    
 4c1:	eb 0d                	jmp    4d0 <strcmp>
 4c3:	90                   	nop
 4c4:	90                   	nop
 4c5:	90                   	nop
 4c6:	90                   	nop
 4c7:	90                   	nop
 4c8:	90                   	nop
 4c9:	90                   	nop
 4ca:	90                   	nop
 4cb:	90                   	nop
 4cc:	90                   	nop
 4cd:	90                   	nop
 4ce:	90                   	nop
 4cf:	90                   	nop

000004d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	53                   	push   %ebx
 4d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 4da:	0f b6 01             	movzbl (%ecx),%eax
 4dd:	84 c0                	test   %al,%al
 4df:	75 14                	jne    4f5 <strcmp+0x25>
 4e1:	eb 25                	jmp    508 <strcmp+0x38>
 4e3:	90                   	nop
 4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
 4e8:	83 c1 01             	add    $0x1,%ecx
 4eb:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 4ee:	0f b6 01             	movzbl (%ecx),%eax
 4f1:	84 c0                	test   %al,%al
 4f3:	74 13                	je     508 <strcmp+0x38>
 4f5:	0f b6 1a             	movzbl (%edx),%ebx
 4f8:	38 d8                	cmp    %bl,%al
 4fa:	74 ec                	je     4e8 <strcmp+0x18>
 4fc:	0f b6 db             	movzbl %bl,%ebx
 4ff:	0f b6 c0             	movzbl %al,%eax
 502:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 504:	5b                   	pop    %ebx
 505:	5d                   	pop    %ebp
 506:	c3                   	ret    
 507:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 508:	0f b6 1a             	movzbl (%edx),%ebx
 50b:	31 c0                	xor    %eax,%eax
 50d:	0f b6 db             	movzbl %bl,%ebx
 510:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
 512:	5b                   	pop    %ebx
 513:	5d                   	pop    %ebp
 514:	c3                   	ret    
 515:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000520 <strlen>:

uint
strlen(char *s)
{
 520:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 521:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 523:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
 525:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
 527:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 52a:	80 39 00             	cmpb   $0x0,(%ecx)
 52d:	74 0c                	je     53b <strlen+0x1b>
 52f:	90                   	nop
 530:	83 c2 01             	add    $0x1,%edx
 533:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 537:	89 d0                	mov    %edx,%eax
 539:	75 f5                	jne    530 <strlen+0x10>
    ;
  return n;
}
 53b:	5d                   	pop    %ebp
 53c:	c3                   	ret    
 53d:	8d 76 00             	lea    0x0(%esi),%esi

00000540 <memset>:

void*
memset(void *dst, int c, uint n)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	8b 4d 10             	mov    0x10(%ebp),%ecx
 546:	53                   	push   %ebx
 547:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
 54a:	85 c9                	test   %ecx,%ecx
 54c:	74 14                	je     562 <memset+0x22>
 54e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
 552:	31 d2                	xor    %edx,%edx
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
 558:	88 1c 10             	mov    %bl,(%eax,%edx,1)
 55b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
 55e:	39 ca                	cmp    %ecx,%edx
 560:	75 f6                	jne    558 <memset+0x18>
    *d++ = c;
  return dst;
}
 562:	5b                   	pop    %ebx
 563:	5d                   	pop    %ebp
 564:	c3                   	ret    
 565:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000570 <strchr>:

char*
strchr(const char *s, char c)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	8b 45 08             	mov    0x8(%ebp),%eax
 576:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 57a:	0f b6 10             	movzbl (%eax),%edx
 57d:	84 d2                	test   %dl,%dl
 57f:	75 11                	jne    592 <strchr+0x22>
 581:	eb 15                	jmp    598 <strchr+0x28>
 583:	90                   	nop
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 588:	83 c0 01             	add    $0x1,%eax
 58b:	0f b6 10             	movzbl (%eax),%edx
 58e:	84 d2                	test   %dl,%dl
 590:	74 06                	je     598 <strchr+0x28>
    if(*s == c)
 592:	38 ca                	cmp    %cl,%dl
 594:	75 f2                	jne    588 <strchr+0x18>
      return (char*) s;
  return 0;
}
 596:	5d                   	pop    %ebp
 597:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 598:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
 59a:	5d                   	pop    %ebp
 59b:	90                   	nop
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5a0:	c3                   	ret    
 5a1:	eb 0d                	jmp    5b0 <atoi>
 5a3:	90                   	nop
 5a4:	90                   	nop
 5a5:	90                   	nop
 5a6:	90                   	nop
 5a7:	90                   	nop
 5a8:	90                   	nop
 5a9:	90                   	nop
 5aa:	90                   	nop
 5ab:	90                   	nop
 5ac:	90                   	nop
 5ad:	90                   	nop
 5ae:	90                   	nop
 5af:	90                   	nop

000005b0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 5b0:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5b1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 5b3:	89 e5                	mov    %esp,%ebp
 5b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5b8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5b9:	0f b6 11             	movzbl (%ecx),%edx
 5bc:	8d 5a d0             	lea    -0x30(%edx),%ebx
 5bf:	80 fb 09             	cmp    $0x9,%bl
 5c2:	77 1c                	ja     5e0 <atoi+0x30>
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 5c8:	0f be d2             	movsbl %dl,%edx
 5cb:	83 c1 01             	add    $0x1,%ecx
 5ce:	8d 04 80             	lea    (%eax,%eax,4),%eax
 5d1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5d5:	0f b6 11             	movzbl (%ecx),%edx
 5d8:	8d 5a d0             	lea    -0x30(%edx),%ebx
 5db:	80 fb 09             	cmp    $0x9,%bl
 5de:	76 e8                	jbe    5c8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 5e0:	5b                   	pop    %ebx
 5e1:	5d                   	pop    %ebp
 5e2:	c3                   	ret    
 5e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	56                   	push   %esi
 5f4:	8b 45 08             	mov    0x8(%ebp),%eax
 5f7:	53                   	push   %ebx
 5f8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5fe:	85 db                	test   %ebx,%ebx
 600:	7e 14                	jle    616 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 602:	31 d2                	xor    %edx,%edx
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 608:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 60c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 60f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 612:	39 da                	cmp    %ebx,%edx
 614:	75 f2                	jne    608 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 616:	5b                   	pop    %ebx
 617:	5e                   	pop    %esi
 618:	5d                   	pop    %ebp
 619:	c3                   	ret    
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000620 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 626:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
 629:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 62c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
 62f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 634:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 63b:	00 
 63c:	89 04 24             	mov    %eax,(%esp)
 63f:	e8 d4 00 00 00       	call   718 <open>
  if(fd < 0)
 644:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 646:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 648:	78 19                	js     663 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 64a:	8b 45 0c             	mov    0xc(%ebp),%eax
 64d:	89 1c 24             	mov    %ebx,(%esp)
 650:	89 44 24 04          	mov    %eax,0x4(%esp)
 654:	e8 d7 00 00 00       	call   730 <fstat>
  close(fd);
 659:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 65c:	89 c6                	mov    %eax,%esi
  close(fd);
 65e:	e8 9d 00 00 00       	call   700 <close>
  return r;
}
 663:	89 f0                	mov    %esi,%eax
 665:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 668:	8b 75 fc             	mov    -0x4(%ebp),%esi
 66b:	89 ec                	mov    %ebp,%esp
 66d:	5d                   	pop    %ebp
 66e:	c3                   	ret    
 66f:	90                   	nop

00000670 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	57                   	push   %edi
 674:	56                   	push   %esi
 675:	31 f6                	xor    %esi,%esi
 677:	53                   	push   %ebx
 678:	83 ec 2c             	sub    $0x2c,%esp
 67b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 67e:	eb 06                	jmp    686 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 680:	3c 0a                	cmp    $0xa,%al
 682:	74 39                	je     6bd <gets+0x4d>
 684:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 686:	8d 5e 01             	lea    0x1(%esi),%ebx
 689:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 68c:	7d 31                	jge    6bf <gets+0x4f>
    cc = read(0, &c, 1);
 68e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 691:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 698:	00 
 699:	89 44 24 04          	mov    %eax,0x4(%esp)
 69d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6a4:	e8 47 00 00 00       	call   6f0 <read>
    if(cc < 1)
 6a9:	85 c0                	test   %eax,%eax
 6ab:	7e 12                	jle    6bf <gets+0x4f>
      break;
    buf[i++] = c;
 6ad:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 6b1:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 6b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 6b9:	3c 0d                	cmp    $0xd,%al
 6bb:	75 c3                	jne    680 <gets+0x10>
 6bd:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
 6bf:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 6c3:	89 f8                	mov    %edi,%eax
 6c5:	83 c4 2c             	add    $0x2c,%esp
 6c8:	5b                   	pop    %ebx
 6c9:	5e                   	pop    %esi
 6ca:	5f                   	pop    %edi
 6cb:	5d                   	pop    %ebp
 6cc:	c3                   	ret    
 6cd:	90                   	nop
 6ce:	90                   	nop
 6cf:	90                   	nop

000006d0 <fork>:
 6d0:	b8 01 00 00 00       	mov    $0x1,%eax
 6d5:	cd 30                	int    $0x30
 6d7:	c3                   	ret    

000006d8 <exit>:
 6d8:	b8 02 00 00 00       	mov    $0x2,%eax
 6dd:	cd 30                	int    $0x30
 6df:	c3                   	ret    

000006e0 <wait>:
 6e0:	b8 03 00 00 00       	mov    $0x3,%eax
 6e5:	cd 30                	int    $0x30
 6e7:	c3                   	ret    

000006e8 <pipe>:
 6e8:	b8 04 00 00 00       	mov    $0x4,%eax
 6ed:	cd 30                	int    $0x30
 6ef:	c3                   	ret    

000006f0 <read>:
 6f0:	b8 06 00 00 00       	mov    $0x6,%eax
 6f5:	cd 30                	int    $0x30
 6f7:	c3                   	ret    

000006f8 <write>:
 6f8:	b8 05 00 00 00       	mov    $0x5,%eax
 6fd:	cd 30                	int    $0x30
 6ff:	c3                   	ret    

00000700 <close>:
 700:	b8 07 00 00 00       	mov    $0x7,%eax
 705:	cd 30                	int    $0x30
 707:	c3                   	ret    

00000708 <kill>:
 708:	b8 08 00 00 00       	mov    $0x8,%eax
 70d:	cd 30                	int    $0x30
 70f:	c3                   	ret    

00000710 <exec>:
 710:	b8 09 00 00 00       	mov    $0x9,%eax
 715:	cd 30                	int    $0x30
 717:	c3                   	ret    

00000718 <open>:
 718:	b8 0a 00 00 00       	mov    $0xa,%eax
 71d:	cd 30                	int    $0x30
 71f:	c3                   	ret    

00000720 <mknod>:
 720:	b8 0b 00 00 00       	mov    $0xb,%eax
 725:	cd 30                	int    $0x30
 727:	c3                   	ret    

00000728 <unlink>:
 728:	b8 0c 00 00 00       	mov    $0xc,%eax
 72d:	cd 30                	int    $0x30
 72f:	c3                   	ret    

00000730 <fstat>:
 730:	b8 0d 00 00 00       	mov    $0xd,%eax
 735:	cd 30                	int    $0x30
 737:	c3                   	ret    

00000738 <link>:
 738:	b8 0e 00 00 00       	mov    $0xe,%eax
 73d:	cd 30                	int    $0x30
 73f:	c3                   	ret    

00000740 <mkdir>:
 740:	b8 0f 00 00 00       	mov    $0xf,%eax
 745:	cd 30                	int    $0x30
 747:	c3                   	ret    

00000748 <chdir>:
 748:	b8 10 00 00 00       	mov    $0x10,%eax
 74d:	cd 30                	int    $0x30
 74f:	c3                   	ret    

00000750 <dup>:
 750:	b8 11 00 00 00       	mov    $0x11,%eax
 755:	cd 30                	int    $0x30
 757:	c3                   	ret    

00000758 <getpid>:
 758:	b8 12 00 00 00       	mov    $0x12,%eax
 75d:	cd 30                	int    $0x30
 75f:	c3                   	ret    

00000760 <sbrk>:
 760:	b8 13 00 00 00       	mov    $0x13,%eax
 765:	cd 30                	int    $0x30
 767:	c3                   	ret    

00000768 <sleep>:
 768:	b8 14 00 00 00       	mov    $0x14,%eax
 76d:	cd 30                	int    $0x30
 76f:	c3                   	ret    

00000770 <getticks>:
 770:	b8 15 00 00 00       	mov    $0x15,%eax
 775:	cd 30                	int    $0x30
 777:	c3                   	ret    
 778:	90                   	nop
 779:	90                   	nop
 77a:	90                   	nop
 77b:	90                   	nop
 77c:	90                   	nop
 77d:	90                   	nop
 77e:	90                   	nop
 77f:	90                   	nop

00000780 <putc>:
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	83 ec 28             	sub    $0x28,%esp
 786:	88 55 f4             	mov    %dl,-0xc(%ebp)
 789:	8d 55 f4             	lea    -0xc(%ebp),%edx
 78c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 793:	00 
 794:	89 54 24 04          	mov    %edx,0x4(%esp)
 798:	89 04 24             	mov    %eax,(%esp)
 79b:	e8 58 ff ff ff       	call   6f8 <write>
 7a0:	c9                   	leave  
 7a1:	c3                   	ret    
 7a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007b0 <printint>:
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	89 c7                	mov    %eax,%edi
 7b6:	56                   	push   %esi
 7b7:	89 ce                	mov    %ecx,%esi
 7b9:	53                   	push   %ebx
 7ba:	83 ec 2c             	sub    $0x2c,%esp
 7bd:	8b 4d 08             	mov    0x8(%ebp),%ecx
 7c0:	85 c9                	test   %ecx,%ecx
 7c2:	74 04                	je     7c8 <printint+0x18>
 7c4:	85 d2                	test   %edx,%edx
 7c6:	78 5d                	js     825 <printint+0x75>
 7c8:	89 d0                	mov    %edx,%eax
 7ca:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 7d1:	31 c9                	xor    %ecx,%ecx
 7d3:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 7d6:	66 90                	xchg   %ax,%ax
 7d8:	31 d2                	xor    %edx,%edx
 7da:	f7 f6                	div    %esi
 7dc:	0f b6 92 43 0c 00 00 	movzbl 0xc43(%edx),%edx
 7e3:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
 7e6:	83 c1 01             	add    $0x1,%ecx
 7e9:	85 c0                	test   %eax,%eax
 7eb:	75 eb                	jne    7d8 <printint+0x28>
 7ed:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7f0:	85 c0                	test   %eax,%eax
 7f2:	74 08                	je     7fc <printint+0x4c>
 7f4:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 7f9:	83 c1 01             	add    $0x1,%ecx
 7fc:	8d 71 ff             	lea    -0x1(%ecx),%esi
 7ff:	01 f3                	add    %esi,%ebx
 801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 808:	0f be 13             	movsbl (%ebx),%edx
 80b:	89 f8                	mov    %edi,%eax
 80d:	83 ee 01             	sub    $0x1,%esi
 810:	83 eb 01             	sub    $0x1,%ebx
 813:	e8 68 ff ff ff       	call   780 <putc>
 818:	83 fe ff             	cmp    $0xffffffff,%esi
 81b:	75 eb                	jne    808 <printint+0x58>
 81d:	83 c4 2c             	add    $0x2c,%esp
 820:	5b                   	pop    %ebx
 821:	5e                   	pop    %esi
 822:	5f                   	pop    %edi
 823:	5d                   	pop    %ebp
 824:	c3                   	ret    
 825:	89 d0                	mov    %edx,%eax
 827:	f7 d8                	neg    %eax
 829:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
 830:	eb 9f                	jmp    7d1 <printint+0x21>
 832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000840 <printf>:
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	83 ec 2c             	sub    $0x2c,%esp
 849:	8b 45 0c             	mov    0xc(%ebp),%eax
 84c:	8b 7d 08             	mov    0x8(%ebp),%edi
 84f:	0f b6 08             	movzbl (%eax),%ecx
 852:	84 c9                	test   %cl,%cl
 854:	0f 84 96 00 00 00    	je     8f0 <printf+0xb0>
 85a:	8d 55 10             	lea    0x10(%ebp),%edx
 85d:	31 f6                	xor    %esi,%esi
 85f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 862:	31 db                	xor    %ebx,%ebx
 864:	eb 1a                	jmp    880 <printf+0x40>
 866:	66 90                	xchg   %ax,%ax
 868:	83 f9 25             	cmp    $0x25,%ecx
 86b:	0f 85 87 00 00 00    	jne    8f8 <printf+0xb8>
 871:	66 be 25 00          	mov    $0x25,%si
 875:	83 c3 01             	add    $0x1,%ebx
 878:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 87c:	84 c9                	test   %cl,%cl
 87e:	74 70                	je     8f0 <printf+0xb0>
 880:	85 f6                	test   %esi,%esi
 882:	0f b6 c9             	movzbl %cl,%ecx
 885:	74 e1                	je     868 <printf+0x28>
 887:	83 fe 25             	cmp    $0x25,%esi
 88a:	75 e9                	jne    875 <printf+0x35>
 88c:	83 f9 64             	cmp    $0x64,%ecx
 88f:	90                   	nop
 890:	0f 84 fa 00 00 00    	je     990 <printf+0x150>
 896:	83 f9 70             	cmp    $0x70,%ecx
 899:	74 75                	je     910 <printf+0xd0>
 89b:	83 f9 78             	cmp    $0x78,%ecx
 89e:	66 90                	xchg   %ax,%ax
 8a0:	74 6e                	je     910 <printf+0xd0>
 8a2:	83 f9 73             	cmp    $0x73,%ecx
 8a5:	0f 84 8d 00 00 00    	je     938 <printf+0xf8>
 8ab:	83 f9 63             	cmp    $0x63,%ecx
 8ae:	66 90                	xchg   %ax,%ax
 8b0:	0f 84 fe 00 00 00    	je     9b4 <printf+0x174>
 8b6:	83 f9 25             	cmp    $0x25,%ecx
 8b9:	0f 84 b9 00 00 00    	je     978 <printf+0x138>
 8bf:	ba 25 00 00 00       	mov    $0x25,%edx
 8c4:	89 f8                	mov    %edi,%eax
 8c6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 8c9:	83 c3 01             	add    $0x1,%ebx
 8cc:	31 f6                	xor    %esi,%esi
 8ce:	e8 ad fe ff ff       	call   780 <putc>
 8d3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 8d6:	89 f8                	mov    %edi,%eax
 8d8:	0f be d1             	movsbl %cl,%edx
 8db:	e8 a0 fe ff ff       	call   780 <putc>
 8e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 8e3:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
 8e7:	84 c9                	test   %cl,%cl
 8e9:	75 95                	jne    880 <printf+0x40>
 8eb:	90                   	nop
 8ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8f0:	83 c4 2c             	add    $0x2c,%esp
 8f3:	5b                   	pop    %ebx
 8f4:	5e                   	pop    %esi
 8f5:	5f                   	pop    %edi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret    
 8f8:	89 f8                	mov    %edi,%eax
 8fa:	0f be d1             	movsbl %cl,%edx
 8fd:	e8 7e fe ff ff       	call   780 <putc>
 902:	8b 45 0c             	mov    0xc(%ebp),%eax
 905:	e9 6b ff ff ff       	jmp    875 <printf+0x35>
 90a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 910:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 913:	b9 10 00 00 00       	mov    $0x10,%ecx
 918:	31 f6                	xor    %esi,%esi
 91a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 921:	8b 10                	mov    (%eax),%edx
 923:	89 f8                	mov    %edi,%eax
 925:	e8 86 fe ff ff       	call   7b0 <printint>
 92a:	8b 45 0c             	mov    0xc(%ebp),%eax
 92d:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 931:	e9 3f ff ff ff       	jmp    875 <printf+0x35>
 936:	66 90                	xchg   %ax,%ax
 938:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 93b:	8b 32                	mov    (%edx),%esi
 93d:	83 c2 04             	add    $0x4,%edx
 940:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 943:	85 f6                	test   %esi,%esi
 945:	0f 84 84 00 00 00    	je     9cf <printf+0x18f>
 94b:	0f b6 16             	movzbl (%esi),%edx
 94e:	84 d2                	test   %dl,%dl
 950:	74 1d                	je     96f <printf+0x12f>
 952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 958:	0f be d2             	movsbl %dl,%edx
 95b:	83 c6 01             	add    $0x1,%esi
 95e:	89 f8                	mov    %edi,%eax
 960:	e8 1b fe ff ff       	call   780 <putc>
 965:	0f b6 16             	movzbl (%esi),%edx
 968:	84 d2                	test   %dl,%dl
 96a:	75 ec                	jne    958 <printf+0x118>
 96c:	8b 45 0c             	mov    0xc(%ebp),%eax
 96f:	31 f6                	xor    %esi,%esi
 971:	e9 ff fe ff ff       	jmp    875 <printf+0x35>
 976:	66 90                	xchg   %ax,%ax
 978:	89 f8                	mov    %edi,%eax
 97a:	ba 25 00 00 00       	mov    $0x25,%edx
 97f:	e8 fc fd ff ff       	call   780 <putc>
 984:	31 f6                	xor    %esi,%esi
 986:	8b 45 0c             	mov    0xc(%ebp),%eax
 989:	e9 e7 fe ff ff       	jmp    875 <printf+0x35>
 98e:	66 90                	xchg   %ax,%ax
 990:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 993:	b1 0a                	mov    $0xa,%cl
 995:	66 31 f6             	xor    %si,%si
 998:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 99f:	8b 10                	mov    (%eax),%edx
 9a1:	89 f8                	mov    %edi,%eax
 9a3:	e8 08 fe ff ff       	call   7b0 <printint>
 9a8:	8b 45 0c             	mov    0xc(%ebp),%eax
 9ab:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 9af:	e9 c1 fe ff ff       	jmp    875 <printf+0x35>
 9b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9b7:	31 f6                	xor    %esi,%esi
 9b9:	0f be 10             	movsbl (%eax),%edx
 9bc:	89 f8                	mov    %edi,%eax
 9be:	e8 bd fd ff ff       	call   780 <putc>
 9c3:	8b 45 0c             	mov    0xc(%ebp),%eax
 9c6:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 9ca:	e9 a6 fe ff ff       	jmp    875 <printf+0x35>
 9cf:	be 3c 0c 00 00       	mov    $0xc3c,%esi
 9d4:	e9 72 ff ff ff       	jmp    94b <printf+0x10b>
 9d9:	90                   	nop
 9da:	90                   	nop
 9db:	90                   	nop
 9dc:	90                   	nop
 9dd:	90                   	nop
 9de:	90                   	nop
 9df:	90                   	nop

000009e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e1:	a1 6c 0c 00 00       	mov    0xc6c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e6:	89 e5                	mov    %esp,%ebp
 9e8:	57                   	push   %edi
 9e9:	56                   	push   %esi
 9ea:	53                   	push   %ebx
 9eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
 9ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f1:	39 c8                	cmp    %ecx,%eax
 9f3:	73 1d                	jae    a12 <free+0x32>
 9f5:	8d 76 00             	lea    0x0(%esi),%esi
 9f8:	8b 10                	mov    (%eax),%edx
 9fa:	39 d1                	cmp    %edx,%ecx
 9fc:	72 1a                	jb     a18 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9fe:	39 d0                	cmp    %edx,%eax
 a00:	72 08                	jb     a0a <free+0x2a>
 a02:	39 c8                	cmp    %ecx,%eax
 a04:	72 12                	jb     a18 <free+0x38>
 a06:	39 d1                	cmp    %edx,%ecx
 a08:	72 0e                	jb     a18 <free+0x38>
 a0a:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a0c:	39 c8                	cmp    %ecx,%eax
 a0e:	66 90                	xchg   %ax,%ax
 a10:	72 e6                	jb     9f8 <free+0x18>
 a12:	8b 10                	mov    (%eax),%edx
 a14:	eb e8                	jmp    9fe <free+0x1e>
 a16:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 a18:	8b 71 04             	mov    0x4(%ecx),%esi
 a1b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a1e:	39 d7                	cmp    %edx,%edi
 a20:	74 19                	je     a3b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a22:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a25:	8b 50 04             	mov    0x4(%eax),%edx
 a28:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a2b:	39 ce                	cmp    %ecx,%esi
 a2d:	74 21                	je     a50 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a2f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a31:	a3 6c 0c 00 00       	mov    %eax,0xc6c
}
 a36:	5b                   	pop    %ebx
 a37:	5e                   	pop    %esi
 a38:	5f                   	pop    %edi
 a39:	5d                   	pop    %ebp
 a3a:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a3b:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
 a3e:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a40:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a43:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a46:	8b 50 04             	mov    0x4(%eax),%edx
 a49:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a4c:	39 ce                	cmp    %ecx,%esi
 a4e:	75 df                	jne    a2f <free+0x4f>
    p->s.size += bp->s.size;
 a50:	03 51 04             	add    0x4(%ecx),%edx
 a53:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a56:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a59:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 a5b:	a3 6c 0c 00 00       	mov    %eax,0xc6c
}
 a60:	5b                   	pop    %ebx
 a61:	5e                   	pop    %esi
 a62:	5f                   	pop    %edi
 a63:	5d                   	pop    %ebp
 a64:	c3                   	ret    
 a65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	57                   	push   %edi
 a74:	56                   	push   %esi
 a75:	53                   	push   %ebx
 a76:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 a7c:	8b 0d 6c 0c 00 00    	mov    0xc6c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a82:	83 c3 07             	add    $0x7,%ebx
 a85:	c1 eb 03             	shr    $0x3,%ebx
 a88:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 a8b:	85 c9                	test   %ecx,%ecx
 a8d:	0f 84 93 00 00 00    	je     b26 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a93:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 a95:	8b 50 04             	mov    0x4(%eax),%edx
 a98:	39 d3                	cmp    %edx,%ebx
 a9a:	76 1f                	jbe    abb <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
 a9c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 aa3:	90                   	nop
 aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
 aa8:	3b 05 6c 0c 00 00    	cmp    0xc6c,%eax
 aae:	74 30                	je     ae0 <malloc+0x70>
 ab0:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab2:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 ab4:	8b 50 04             	mov    0x4(%eax),%edx
 ab7:	39 d3                	cmp    %edx,%ebx
 ab9:	77 ed                	ja     aa8 <malloc+0x38>
      if(p->s.size == nunits)
 abb:	39 d3                	cmp    %edx,%ebx
 abd:	74 61                	je     b20 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 abf:	29 da                	sub    %ebx,%edx
 ac1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 ac4:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 ac7:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 aca:	89 0d 6c 0c 00 00    	mov    %ecx,0xc6c
      return (void*) (p + 1);
 ad0:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ad3:	83 c4 1c             	add    $0x1c,%esp
 ad6:	5b                   	pop    %ebx
 ad7:	5e                   	pop    %esi
 ad8:	5f                   	pop    %edi
 ad9:	5d                   	pop    %ebp
 ada:	c3                   	ret    
 adb:	90                   	nop
 adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
 ae0:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
 ae6:	b8 00 80 00 00       	mov    $0x8000,%eax
 aeb:	bf 00 10 00 00       	mov    $0x1000,%edi
 af0:	76 04                	jbe    af6 <malloc+0x86>
 af2:	89 f0                	mov    %esi,%eax
 af4:	89 df                	mov    %ebx,%edi
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
 af6:	89 04 24             	mov    %eax,(%esp)
 af9:	e8 62 fc ff ff       	call   760 <sbrk>
  if(p == (char*) -1)
 afe:	83 f8 ff             	cmp    $0xffffffff,%eax
 b01:	74 18                	je     b1b <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 b03:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 b06:	83 c0 08             	add    $0x8,%eax
 b09:	89 04 24             	mov    %eax,(%esp)
 b0c:	e8 cf fe ff ff       	call   9e0 <free>
  return freep;
 b11:	8b 0d 6c 0c 00 00    	mov    0xc6c,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 b17:	85 c9                	test   %ecx,%ecx
 b19:	75 97                	jne    ab2 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b1b:	31 c0                	xor    %eax,%eax
 b1d:	eb b4                	jmp    ad3 <malloc+0x63>
 b1f:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 b20:	8b 10                	mov    (%eax),%edx
 b22:	89 11                	mov    %edx,(%ecx)
 b24:	eb a4                	jmp    aca <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 b26:	c7 05 6c 0c 00 00 64 	movl   $0xc64,0xc6c
 b2d:	0c 00 00 
    base.s.size = 0;
 b30:	b9 64 0c 00 00       	mov    $0xc64,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 b35:	c7 05 64 0c 00 00 64 	movl   $0xc64,0xc64
 b3c:	0c 00 00 
    base.s.size = 0;
 b3f:	c7 05 68 0c 00 00 00 	movl   $0x0,0xc68
 b46:	00 00 00 
 b49:	e9 45 ff ff ff       	jmp    a93 <malloc+0x23>
