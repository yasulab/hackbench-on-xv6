
kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <brelse>:
}

// Release the buffer buf.
void
brelse(struct buf *b)
{
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	53                   	push   %ebx
  100004:	83 ec 14             	sub    $0x14,%esp
  100007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
  10000a:	f6 03 01             	testb  $0x1,(%ebx)
  10000d:	74 58                	je     100067 <brelse+0x67>
    panic("brelse");

  acquire(&buf_table_lock);
  10000f:	c7 04 24 80 8f 10 00 	movl   $0x108f80,(%esp)
  100016:	e8 75 3f 00 00       	call   103f90 <acquire>

  b->next->prev = b->prev;
  10001b:	8b 43 10             	mov    0x10(%ebx),%eax
  10001e:	8b 53 0c             	mov    0xc(%ebx),%edx
  b->next = bufhead.next;
  b->prev = &bufhead;
  bufhead.next->prev = b;
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  100021:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  if((b->flags & B_BUSY) == 0)
    panic("brelse");

  acquire(&buf_table_lock);

  b->next->prev = b->prev;
  100024:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
  100027:	8b 53 0c             	mov    0xc(%ebx),%edx
  b->next = bufhead.next;
  b->prev = &bufhead;
  10002a:	c7 43 0c 60 78 10 00 	movl   $0x107860,0xc(%ebx)
    panic("brelse");

  acquire(&buf_table_lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  100031:	89 42 10             	mov    %eax,0x10(%edx)
  b->next = bufhead.next;
  100034:	a1 70 78 10 00       	mov    0x107870,%eax
  100039:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bufhead;
  bufhead.next->prev = b;
  10003c:	a1 70 78 10 00       	mov    0x107870,%eax
  bufhead.next = b;
  100041:	89 1d 70 78 10 00    	mov    %ebx,0x107870

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bufhead.next;
  b->prev = &bufhead;
  bufhead.next->prev = b;
  100047:	89 58 0c             	mov    %ebx,0xc(%eax)
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  wakeup(buf);
  10004a:	c7 04 24 80 7a 10 00 	movl   $0x107a80,(%esp)
  100051:	e8 aa 32 00 00       	call   103300 <wakeup>

  release(&buf_table_lock);
  100056:	c7 45 08 80 8f 10 00 	movl   $0x108f80,0x8(%ebp)
}
  10005d:	83 c4 14             	add    $0x14,%esp
  100060:	5b                   	pop    %ebx
  100061:	5d                   	pop    %ebp
  bufhead.next = b;

  b->flags &= ~B_BUSY;
  wakeup(buf);

  release(&buf_table_lock);
  100062:	e9 e9 3e 00 00       	jmp    103f50 <release>
// Release the buffer buf.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
  100067:	c7 04 24 80 5f 10 00 	movl   $0x105f80,(%esp)
  10006e:	e8 ad 08 00 00       	call   100920 <panic>
  100073:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100080 <bwrite>:
}

// Write buf's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  100080:	55                   	push   %ebp
  100081:	89 e5                	mov    %esp,%ebp
  100083:	83 ec 18             	sub    $0x18,%esp
  100086:	8b 45 08             	mov    0x8(%ebp),%eax
  if((b->flags & B_BUSY) == 0)
  100089:	8b 10                	mov    (%eax),%edx
  10008b:	f6 c2 01             	test   $0x1,%dl
  10008e:	74 0e                	je     10009e <bwrite+0x1e>
    panic("bwrite");
  b->flags |= B_DIRTY;
  100090:	83 ca 04             	or     $0x4,%edx
  100093:	89 10                	mov    %edx,(%eax)
  ide_rw(b);
  100095:	89 45 08             	mov    %eax,0x8(%ebp)
}
  100098:	c9                   	leave  
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  ide_rw(b);
  100099:	e9 c2 1f 00 00       	jmp    102060 <ide_rw>
// Write buf's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  10009e:	c7 04 24 87 5f 10 00 	movl   $0x105f87,(%esp)
  1000a5:	e8 76 08 00 00       	call   100920 <panic>
  1000aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001000b0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
  1000b0:	55                   	push   %ebp
  1000b1:	89 e5                	mov    %esp,%ebp
  1000b3:	57                   	push   %edi
  1000b4:	56                   	push   %esi
  1000b5:	53                   	push   %ebx
  1000b6:	83 ec 1c             	sub    $0x1c,%esp
  1000b9:	8b 75 08             	mov    0x8(%ebp),%esi
  1000bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint sector)
{
  struct buf *b;

  acquire(&buf_table_lock);
  1000bf:	c7 04 24 80 8f 10 00 	movl   $0x108f80,(%esp)
  1000c6:	e8 c5 3e 00 00       	call   103f90 <acquire>

 loop:
  // Try for cached block.
  for(b = bufhead.next; b != &bufhead; b = b->next){
  1000cb:	8b 1d 70 78 10 00    	mov    0x107870,%ebx
  1000d1:	81 fb 60 78 10 00    	cmp    $0x107860,%ebx
  1000d7:	75 12                	jne    1000eb <bread+0x3b>
  1000d9:	eb 3d                	jmp    100118 <bread+0x68>
  1000db:	90                   	nop
  1000dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1000e0:	8b 5b 10             	mov    0x10(%ebx),%ebx
  1000e3:	81 fb 60 78 10 00    	cmp    $0x107860,%ebx
  1000e9:	74 2d                	je     100118 <bread+0x68>
    if((b->flags & (B_BUSY|B_VALID)) &&
  1000eb:	8b 03                	mov    (%ebx),%eax
  1000ed:	a8 03                	test   $0x3,%al
  1000ef:	74 ef                	je     1000e0 <bread+0x30>
  1000f1:	3b 73 04             	cmp    0x4(%ebx),%esi
  1000f4:	75 ea                	jne    1000e0 <bread+0x30>
  1000f6:	3b 7b 08             	cmp    0x8(%ebx),%edi
  1000f9:	75 e5                	jne    1000e0 <bread+0x30>
       b->dev == dev && b->sector == sector){
      if(b->flags & B_BUSY){
  1000fb:	a8 01                	test   $0x1,%al
  1000fd:	8d 76 00             	lea    0x0(%esi),%esi
  100100:	74 71                	je     100173 <bread+0xc3>
        sleep(buf, &buf_table_lock);
  100102:	c7 44 24 04 80 8f 10 	movl   $0x108f80,0x4(%esp)
  100109:	00 
  10010a:	c7 04 24 80 7a 10 00 	movl   $0x107a80,(%esp)
  100111:	e8 ca 34 00 00       	call   1035e0 <sleep>
  100116:	eb b3                	jmp    1000cb <bread+0x1b>
      return b;
    }
  }

  // Allocate fresh block.
  for(b = bufhead.prev; b != &bufhead; b = b->prev){
  100118:	8b 1d 6c 78 10 00    	mov    0x10786c,%ebx
  10011e:	81 fb 60 78 10 00    	cmp    $0x107860,%ebx
  100124:	75 0d                	jne    100133 <bread+0x83>
  100126:	eb 3f                	jmp    100167 <bread+0xb7>
  100128:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  10012b:	81 fb 60 78 10 00    	cmp    $0x107860,%ebx
  100131:	74 34                	je     100167 <bread+0xb7>
    if((b->flags & B_BUSY) == 0){
  100133:	f6 03 01             	testb  $0x1,(%ebx)
  100136:	75 f0                	jne    100128 <bread+0x78>
      b->flags = B_BUSY;
  100138:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      b->dev = dev;
  10013e:	89 73 04             	mov    %esi,0x4(%ebx)
      b->sector = sector;
  100141:	89 7b 08             	mov    %edi,0x8(%ebx)
      release(&buf_table_lock);
  100144:	c7 04 24 80 8f 10 00 	movl   $0x108f80,(%esp)
  10014b:	e8 00 3e 00 00       	call   103f50 <release>
bread(uint dev, uint sector)
{
  struct buf *b;

  b = bget(dev, sector);
  if(!(b->flags & B_VALID))
  100150:	f6 03 02             	testb  $0x2,(%ebx)
  100153:	75 08                	jne    10015d <bread+0xad>
    ide_rw(b);
  100155:	89 1c 24             	mov    %ebx,(%esp)
  100158:	e8 03 1f 00 00       	call   102060 <ide_rw>
  return b;
}
  10015d:	83 c4 1c             	add    $0x1c,%esp
  100160:	89 d8                	mov    %ebx,%eax
  100162:	5b                   	pop    %ebx
  100163:	5e                   	pop    %esi
  100164:	5f                   	pop    %edi
  100165:	5d                   	pop    %ebp
  100166:	c3                   	ret    
      b->sector = sector;
      release(&buf_table_lock);
      return b;
    }
  }
  panic("bget: no buffers");
  100167:	c7 04 24 8e 5f 10 00 	movl   $0x105f8e,(%esp)
  10016e:	e8 ad 07 00 00       	call   100920 <panic>
       b->dev == dev && b->sector == sector){
      if(b->flags & B_BUSY){
        sleep(buf, &buf_table_lock);
        goto loop;
      }
      b->flags |= B_BUSY;
  100173:	83 c8 01             	or     $0x1,%eax
  100176:	89 03                	mov    %eax,(%ebx)
      release(&buf_table_lock);
  100178:	c7 04 24 80 8f 10 00 	movl   $0x108f80,(%esp)
  10017f:	e8 cc 3d 00 00       	call   103f50 <release>
  100184:	eb ca                	jmp    100150 <bread+0xa0>
  100186:	8d 76 00             	lea    0x0(%esi),%esi
  100189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100190 <binit>:
// bufhead->tail is least recently used.
struct buf bufhead;

void
binit(void)
{
  100190:	55                   	push   %ebp
  100191:	89 e5                	mov    %esp,%ebp
  100193:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&buf_table_lock, "buf_table");
  100196:	c7 44 24 04 9f 5f 10 	movl   $0x105f9f,0x4(%esp)
  10019d:	00 
  10019e:	c7 04 24 80 8f 10 00 	movl   $0x108f80,(%esp)
  1001a5:	e8 26 3c 00 00       	call   103dd0 <initlock>

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  1001aa:	b8 70 8f 10 00       	mov    $0x108f70,%eax
  1001af:	3d 80 7a 10 00       	cmp    $0x107a80,%eax
  struct buf *b;

  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  1001b4:	c7 05 6c 78 10 00 60 	movl   $0x107860,0x10786c
  1001bb:	78 10 00 
  bufhead.next = &bufhead;
  1001be:	c7 05 70 78 10 00 60 	movl   $0x107860,0x107870
  1001c5:	78 10 00 
  for(b = buf; b < buf+NBUF; b++){
  1001c8:	76 33                	jbe    1001fd <binit+0x6d>
// bufhead->next is most recently used.
// bufhead->tail is least recently used.
struct buf bufhead;

void
binit(void)
  1001ca:	ba 60 78 10 00       	mov    $0x107860,%edx
  1001cf:	b8 80 7a 10 00       	mov    $0x107a80,%eax
  1001d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
    b->next = bufhead.next;
  1001d8:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bufhead;
  1001db:	c7 40 0c 60 78 10 00 	movl   $0x107860,0xc(%eax)
    bufhead.next->prev = b;
  1001e2:	89 42 0c             	mov    %eax,0xc(%edx)
  initlock(&buf_table_lock, "buf_table");

  // Create linked list of buffers
  bufhead.prev = &bufhead;
  bufhead.next = &bufhead;
  for(b = buf; b < buf+NBUF; b++){
  1001e5:	89 c2                	mov    %eax,%edx
  1001e7:	05 18 02 00 00       	add    $0x218,%eax
  1001ec:	3d 70 8f 10 00       	cmp    $0x108f70,%eax
  1001f1:	75 e5                	jne    1001d8 <binit+0x48>
  1001f3:	c7 05 70 78 10 00 58 	movl   $0x108d58,0x107870
  1001fa:	8d 10 00 
    b->next = bufhead.next;
    b->prev = &bufhead;
    bufhead.next->prev = b;
    bufhead.next = b;
  }
}
  1001fd:	c9                   	leave  
  1001fe:	c3                   	ret    
  1001ff:	90                   	nop

00100200 <console_init>:
  return target - n;
}

void
console_init(void)
{
  100200:	55                   	push   %ebp
  100201:	89 e5                	mov    %esp,%ebp
  100203:	83 ec 18             	sub    $0x18,%esp
  initlock(&console_lock, "console");
  100206:	c7 44 24 04 a9 5f 10 	movl   $0x105fa9,0x4(%esp)
  10020d:	00 
  10020e:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100215:	e8 b6 3b 00 00       	call   103dd0 <initlock>
  initlock(&input.lock, "console input");
  10021a:	c7 44 24 04 b1 5f 10 	movl   $0x105fb1,0x4(%esp)
  100221:	00 
  100222:	c7 04 24 c0 8f 10 00 	movl   $0x108fc0,(%esp)
  100229:	e8 a2 3b 00 00       	call   103dd0 <initlock>

  devsw[CONSOLE].write = console_write;
  devsw[CONSOLE].read = console_read;
  use_console_lock = 1;

  pic_enable(IRQ_KBD);
  10022e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
console_init(void)
{
  initlock(&console_lock, "console");
  initlock(&input.lock, "console input");

  devsw[CONSOLE].write = console_write;
  100235:	c7 05 2c 9a 10 00 90 	movl   $0x100690,0x109a2c
  10023c:	06 10 00 
  devsw[CONSOLE].read = console_read;
  10023f:	c7 05 28 9a 10 00 70 	movl   $0x100270,0x109a28
  100246:	02 10 00 
  use_console_lock = 1;
  100249:	c7 05 a4 77 10 00 01 	movl   $0x1,0x1077a4
  100250:	00 00 00 

  pic_enable(IRQ_KBD);
  100253:	e8 08 2b 00 00       	call   102d60 <pic_enable>
  ioapic_enable(IRQ_KBD, 0);
  100258:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10025f:	00 
  100260:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  100267:	e8 e4 1f 00 00       	call   102250 <ioapic_enable>
}
  10026c:	c9                   	leave  
  10026d:	c3                   	ret    
  10026e:	66 90                	xchg   %ax,%ax

00100270 <console_read>:
  release(&input.lock);
}

int
console_read(struct inode *ip, char *dst, int n)
{
  100270:	55                   	push   %ebp
  100271:	89 e5                	mov    %esp,%ebp
  100273:	57                   	push   %edi
  100274:	56                   	push   %esi
  100275:	53                   	push   %ebx
  100276:	83 ec 2c             	sub    $0x2c,%esp
  100279:	8b 5d 10             	mov    0x10(%ebp),%ebx
  10027c:	8b 75 08             	mov    0x8(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
  10027f:	89 34 24             	mov    %esi,(%esp)
  100282:	e8 a9 19 00 00       	call   101c30 <iunlock>
  target = n;
  100287:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&input.lock);
  10028a:	c7 04 24 c0 8f 10 00 	movl   $0x108fc0,(%esp)
  100291:	e8 fa 3c 00 00       	call   103f90 <acquire>
  while(n > 0){
  100296:	85 db                	test   %ebx,%ebx
  100298:	7f 26                	jg     1002c0 <console_read+0x50>
  10029a:	e9 c3 00 00 00       	jmp    100362 <console_read+0xf2>
  10029f:	90                   	nop
    while(input.r == input.w){
      if(cp->killed){
  1002a0:	e8 db 30 00 00       	call   103380 <curproc>
  1002a5:	8b 40 1c             	mov    0x1c(%eax),%eax
  1002a8:	85 c0                	test   %eax,%eax
  1002aa:	75 64                	jne    100310 <console_read+0xa0>
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
  1002ac:	c7 44 24 04 c0 8f 10 	movl   $0x108fc0,0x4(%esp)
  1002b3:	00 
  1002b4:	c7 04 24 74 90 10 00 	movl   $0x109074,(%esp)
  1002bb:	e8 20 33 00 00       	call   1035e0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  1002c0:	a1 74 90 10 00       	mov    0x109074,%eax
  1002c5:	3b 05 78 90 10 00    	cmp    0x109078,%eax
  1002cb:	74 d3                	je     1002a0 <console_read+0x30>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
  1002cd:	89 c1                	mov    %eax,%ecx
  1002cf:	c1 f9 1f             	sar    $0x1f,%ecx
  1002d2:	c1 e9 19             	shr    $0x19,%ecx
  1002d5:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1002d8:	83 e2 7f             	and    $0x7f,%edx
  1002db:	29 ca                	sub    %ecx,%edx
  1002dd:	0f b6 8a f4 8f 10 00 	movzbl 0x108ff4(%edx),%ecx
  1002e4:	8d 78 01             	lea    0x1(%eax),%edi
  1002e7:	89 3d 74 90 10 00    	mov    %edi,0x109074
  1002ed:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
  1002f0:	83 fa 04             	cmp    $0x4,%edx
  1002f3:	74 3c                	je     100331 <console_read+0xc1>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  1002f5:	8b 45 0c             	mov    0xc(%ebp),%eax
    --n;
  1002f8:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
  1002fb:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  1002fe:	88 08                	mov    %cl,(%eax)
    --n;
    if(c == '\n')
  100300:	74 39                	je     10033b <console_read+0xcb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
  100302:	85 db                	test   %ebx,%ebx
  100304:	7e 35                	jle    10033b <console_read+0xcb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
  100306:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  10030a:	eb b4                	jmp    1002c0 <console_read+0x50>
  10030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
  100310:	c7 04 24 c0 8f 10 00 	movl   $0x108fc0,(%esp)
  100317:	e8 34 3c 00 00       	call   103f50 <release>
        ilock(ip);
  10031c:	89 34 24             	mov    %esi,(%esp)
  10031f:	e8 7c 19 00 00       	call   101ca0 <ilock>
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  100324:	83 c4 2c             	add    $0x2c,%esp
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
      if(cp->killed){
        release(&input.lock);
        ilock(ip);
  100327:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
  10032c:	5b                   	pop    %ebx
  10032d:	5e                   	pop    %esi
  10032e:	5f                   	pop    %edi
  10032f:	5d                   	pop    %ebp
  100330:	c3                   	ret    
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
  100331:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
  100334:	76 05                	jbe    10033b <console_read+0xcb>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
  100336:	a3 74 90 10 00       	mov    %eax,0x109074
  10033b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10033e:	29 d8                	sub    %ebx,%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
  100340:	c7 04 24 c0 8f 10 00 	movl   $0x108fc0,(%esp)
  100347:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10034a:	e8 01 3c 00 00       	call   103f50 <release>
  ilock(ip);
  10034f:	89 34 24             	mov    %esi,(%esp)
  100352:	e8 49 19 00 00       	call   101ca0 <ilock>
  100357:	8b 45 e0             	mov    -0x20(%ebp),%eax

  return target - n;
}
  10035a:	83 c4 2c             	add    $0x2c,%esp
  10035d:	5b                   	pop    %ebx
  10035e:	5e                   	pop    %esi
  10035f:	5f                   	pop    %edi
  100360:	5d                   	pop    %ebp
  100361:	c3                   	ret    

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
  100362:	31 c0                	xor    %eax,%eax
  100364:	eb da                	jmp    100340 <console_read+0xd0>
  100366:	8d 76 00             	lea    0x0(%esi),%esi
  100369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100370 <cons_putc>:
  crt[pos] = ' ' | 0x0700;
}

void
cons_putc(int c)
{
  100370:	55                   	push   %ebp
  100371:	89 e5                	mov    %esp,%ebp
  100373:	57                   	push   %edi
  100374:	56                   	push   %esi
  100375:	53                   	push   %ebx
  100376:	83 ec 1c             	sub    $0x1c,%esp
  100379:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(panicked){
  10037c:	83 3d a0 77 10 00 00 	cmpl   $0x0,0x1077a0
  100383:	0f 85 e1 00 00 00    	jne    10046a <cons_putc+0xfa>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  100389:	b8 79 03 00 00       	mov    $0x379,%eax
  10038e:	89 c2                	mov    %eax,%edx
  100390:	ec                   	in     (%dx),%al
}

static inline void
cli(void)
{
  asm volatile("cli");
  100391:	31 db                	xor    %ebx,%ebx
static void
lpt_putc(int c)
{
  int i;

  for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
  100393:	84 c0                	test   %al,%al
  100395:	79 14                	jns    1003ab <cons_putc+0x3b>
  100397:	eb 19                	jmp    1003b2 <cons_putc+0x42>
  100399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1003a0:	83 c3 01             	add    $0x1,%ebx
  1003a3:	81 fb 00 32 00 00    	cmp    $0x3200,%ebx
  1003a9:	74 07                	je     1003b2 <cons_putc+0x42>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1003ab:	ec                   	in     (%dx),%al
  1003ac:	84 c0                	test   %al,%al
  1003ae:	66 90                	xchg   %ax,%ax
  1003b0:	79 ee                	jns    1003a0 <cons_putc+0x30>
    ;
  if(c == BACKSPACE)
  1003b2:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  1003b8:	89 c8                	mov    %ecx,%eax
  1003ba:	0f 84 ad 00 00 00    	je     10046d <cons_putc+0xfd>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1003c0:	ba 78 03 00 00       	mov    $0x378,%edx
  1003c5:	ee                   	out    %al,(%dx)
  1003c6:	b8 0d 00 00 00       	mov    $0xd,%eax
  1003cb:	b2 7a                	mov    $0x7a,%dl
  1003cd:	ee                   	out    %al,(%dx)
  1003ce:	b8 08 00 00 00       	mov    $0x8,%eax
  1003d3:	ee                   	out    %al,(%dx)
  1003d4:	be d4 03 00 00       	mov    $0x3d4,%esi
  1003d9:	b8 0e 00 00 00       	mov    $0xe,%eax
  1003de:	89 f2                	mov    %esi,%edx
  1003e0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1003e1:	bf d5 03 00 00       	mov    $0x3d5,%edi
  1003e6:	89 fa                	mov    %edi,%edx
  1003e8:	ec                   	in     (%dx),%al
{
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  1003e9:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  1003ec:	89 f2                	mov    %esi,%edx
  1003ee:	c1 e3 08             	shl    $0x8,%ebx
  1003f1:	b8 0f 00 00 00       	mov    $0xf,%eax
  1003f6:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1003f7:	89 fa                	mov    %edi,%edx
  1003f9:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
  1003fa:	0f b6 c0             	movzbl %al,%eax
  1003fd:	09 c3                	or     %eax,%ebx

  if(c == '\n')
  1003ff:	83 f9 0a             	cmp    $0xa,%ecx
  100402:	0f 84 da 00 00 00    	je     1004e2 <cons_putc+0x172>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
  100408:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
  10040e:	0f 84 ad 00 00 00    	je     1004c1 <cons_putc+0x151>
    if(pos > 0)
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  100414:	66 81 e1 ff 00       	and    $0xff,%cx
  100419:	80 cd 07             	or     $0x7,%ch
  10041c:	66 89 8c 1b 00 80 0b 	mov    %cx,0xb8000(%ebx,%ebx,1)
  100423:	00 
  100424:	83 c3 01             	add    $0x1,%ebx
  
  if((pos/80) >= 24){  // Scroll up.
  100427:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
  10042d:	8d 8c 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%ecx
  100434:	7f 41                	jg     100477 <cons_putc+0x107>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  100436:	be d4 03 00 00       	mov    $0x3d4,%esi
  10043b:	b8 0e 00 00 00       	mov    $0xe,%eax
  100440:	89 f2                	mov    %esi,%edx
  100442:	ee                   	out    %al,(%dx)
  100443:	bf d5 03 00 00       	mov    $0x3d5,%edi
  100448:	89 d8                	mov    %ebx,%eax
  10044a:	c1 f8 08             	sar    $0x8,%eax
  10044d:	89 fa                	mov    %edi,%edx
  10044f:	ee                   	out    %al,(%dx)
  100450:	b8 0f 00 00 00       	mov    $0xf,%eax
  100455:	89 f2                	mov    %esi,%edx
  100457:	ee                   	out    %al,(%dx)
  100458:	89 d8                	mov    %ebx,%eax
  10045a:	89 fa                	mov    %edi,%edx
  10045c:	ee                   	out    %al,(%dx)
  
  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
  10045d:	66 c7 01 20 07       	movw   $0x720,(%ecx)
      ;
  }

  lpt_putc(c);
  cga_putc(c);
}
  100462:	83 c4 1c             	add    $0x1c,%esp
  100465:	5b                   	pop    %ebx
  100466:	5e                   	pop    %esi
  100467:	5f                   	pop    %edi
  100468:	5d                   	pop    %ebp
  100469:	c3                   	ret    
}

static inline void
cli(void)
{
  asm volatile("cli");
  10046a:	fa                   	cli    
  10046b:	eb fe                	jmp    10046b <cons_putc+0xfb>
{
  int i;

  for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
    ;
  if(c == BACKSPACE)
  10046d:	b8 08 00 00 00       	mov    $0x8,%eax
  100472:	e9 49 ff ff ff       	jmp    1003c0 <cons_putc+0x50>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
  100477:	83 eb 50             	sub    $0x50,%ebx
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  10047a:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
  100481:	00 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  100482:	8d b4 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%esi
      crt[--pos] = ' ' | 0x0700;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
  
  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
  100489:	c7 44 24 04 a0 80 0b 	movl   $0xb80a0,0x4(%esp)
  100490:	00 
  100491:	c7 04 24 00 80 0b 00 	movl   $0xb8000,(%esp)
  100498:	e8 f3 3b 00 00       	call   104090 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  10049d:	b8 80 07 00 00       	mov    $0x780,%eax
  1004a2:	29 d8                	sub    %ebx,%eax
  1004a4:	01 c0                	add    %eax,%eax
  1004a6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1004aa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1004b1:	00 
  1004b2:	89 34 24             	mov    %esi,(%esp)
  1004b5:	e8 46 3b 00 00       	call   104000 <memset>
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
}

void
cons_putc(int c)
  1004ba:	89 f1                	mov    %esi,%ecx
  1004bc:	e9 75 ff ff ff       	jmp    100436 <cons_putc+0xc6>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0)
  1004c1:	85 db                	test   %ebx,%ebx
  1004c3:	8d 8c 1b 00 80 0b 00 	lea    0xb8000(%ebx,%ebx,1),%ecx
  1004ca:	0f 8e 66 ff ff ff    	jle    100436 <cons_putc+0xc6>
      crt[--pos] = ' ' | 0x0700;
  1004d0:	83 eb 01             	sub    $0x1,%ebx
  1004d3:	66 c7 84 1b 00 80 0b 	movw   $0x720,0xb8000(%ebx,%ebx,1)
  1004da:	00 20 07 
  1004dd:	e9 45 ff ff ff       	jmp    100427 <cons_putc+0xb7>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  1004e2:	89 da                	mov    %ebx,%edx
  1004e4:	89 d8                	mov    %ebx,%eax
  1004e6:	b1 50                	mov    $0x50,%cl
  1004e8:	83 c3 50             	add    $0x50,%ebx
  1004eb:	c1 fa 1f             	sar    $0x1f,%edx
  1004ee:	f7 f9                	idiv   %ecx
  1004f0:	29 d3                	sub    %edx,%ebx
  1004f2:	e9 30 ff ff ff       	jmp    100427 <cons_putc+0xb7>
  1004f7:	89 f6                	mov    %esi,%esi
  1004f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100500 <console_intr>:

#define C(x)  ((x)-'@')  // Control-x

void
console_intr(int (*getc)(void))
{
  100500:	55                   	push   %ebp
  100501:	89 e5                	mov    %esp,%ebp
  100503:	57                   	push   %edi
  100504:	56                   	push   %esi
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
  100505:	be f0 8f 10 00       	mov    $0x108ff0,%esi

#define C(x)  ((x)-'@')  // Control-x

void
console_intr(int (*getc)(void))
{
  10050a:	53                   	push   %ebx
  10050b:	83 ec 2c             	sub    $0x2c,%esp
  10050e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c;

  acquire(&input.lock);
  100511:	c7 04 24 c0 8f 10 00 	movl   $0x108fc0,(%esp)
  100518:	e8 73 3a 00 00       	call   103f90 <acquire>
  10051d:	8d 76 00             	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
  100520:	ff d3                	call   *%ebx
  100522:	85 c0                	test   %eax,%eax
  100524:	0f 88 96 00 00 00    	js     1005c0 <console_intr+0xc0>
    switch(c){
  10052a:	83 f8 10             	cmp    $0x10,%eax
  10052d:	8d 76 00             	lea    0x0(%esi),%esi
  100530:	0f 84 a2 00 00 00    	je     1005d8 <console_intr+0xd8>
  100536:	83 f8 15             	cmp    $0x15,%eax
  100539:	0f 84 d9 00 00 00    	je     100618 <console_intr+0x118>
  10053f:	83 f8 08             	cmp    $0x8,%eax
  100542:	0f 84 a0 00 00 00    	je     1005e8 <console_intr+0xe8>
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
  100548:	85 c0                	test   %eax,%eax
  10054a:	74 d4                	je     100520 <console_intr+0x20>
  10054c:	8b 0d 74 90 10 00    	mov    0x109074,%ecx
  100552:	8b 15 7c 90 10 00    	mov    0x10907c,%edx
  100558:	83 c1 7f             	add    $0x7f,%ecx
  10055b:	39 d1                	cmp    %edx,%ecx
  10055d:	7c c1                	jl     100520 <console_intr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
  10055f:	89 d7                	mov    %edx,%edi
  100561:	c1 ff 1f             	sar    $0x1f,%edi
  100564:	c1 ef 19             	shr    $0x19,%edi
  100567:	8d 0c 3a             	lea    (%edx,%edi,1),%ecx
  10056a:	83 c2 01             	add    $0x1,%edx
  10056d:	83 e1 7f             	and    $0x7f,%ecx
  100570:	29 f9                	sub    %edi,%ecx
  100572:	88 44 0e 04          	mov    %al,0x4(%esi,%ecx,1)
        cons_putc(c);
  100576:	89 04 24             	mov    %eax,(%esp)
  100579:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        cons_putc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
  10057c:	89 15 7c 90 10 00    	mov    %edx,0x10907c
        cons_putc(c);
  100582:	e8 e9 fd ff ff       	call   100370 <cons_putc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100587:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10058a:	83 f8 04             	cmp    $0x4,%eax
  10058d:	0f 84 e2 00 00 00    	je     100675 <console_intr+0x175>
  100593:	83 f8 0a             	cmp    $0xa,%eax
  100596:	0f 84 d9 00 00 00    	je     100675 <console_intr+0x175>
  10059c:	a1 74 90 10 00       	mov    0x109074,%eax
  1005a1:	83 e8 80             	sub    $0xffffff80,%eax
  1005a4:	39 05 7c 90 10 00    	cmp    %eax,0x10907c
  1005aa:	0f 84 ca 00 00 00    	je     10067a <console_intr+0x17a>
console_intr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
  1005b0:	ff d3                	call   *%ebx
  1005b2:	85 c0                	test   %eax,%eax
  1005b4:	0f 89 70 ff ff ff    	jns    10052a <console_intr+0x2a>
  1005ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        }
      }
      break;
    }
  }
  release(&input.lock);
  1005c0:	c7 45 08 c0 8f 10 00 	movl   $0x108fc0,0x8(%ebp)
}
  1005c7:	83 c4 2c             	add    $0x2c,%esp
  1005ca:	5b                   	pop    %ebx
  1005cb:	5e                   	pop    %esi
  1005cc:	5f                   	pop    %edi
  1005cd:	5d                   	pop    %ebp
        }
      }
      break;
    }
  }
  release(&input.lock);
  1005ce:	e9 7d 39 00 00       	jmp    103f50 <release>
  1005d3:	90                   	nop
  1005d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  acquire(&input.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      procdump();
  1005d8:	e8 c3 2b 00 00       	call   1031a0 <procdump>
      break;
  1005dd:	e9 3e ff ff ff       	jmp    100520 <console_intr+0x20>
  1005e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
        cons_putc(BACKSPACE);
      }
      break;
    case C('H'):  // Backspace
      if(input.e > input.w){
  1005e8:	a1 7c 90 10 00       	mov    0x10907c,%eax
  1005ed:	3b 05 78 90 10 00    	cmp    0x109078,%eax
  1005f3:	0f 8e 27 ff ff ff    	jle    100520 <console_intr+0x20>
        input.e--;
  1005f9:	83 e8 01             	sub    $0x1,%eax
  1005fc:	a3 7c 90 10 00       	mov    %eax,0x10907c
        cons_putc(BACKSPACE);
  100601:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  100608:	e8 63 fd ff ff       	call   100370 <cons_putc>
  10060d:	e9 0e ff ff ff       	jmp    100520 <console_intr+0x20>
  100612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
  100618:	8b 0d 7c 90 10 00    	mov    0x10907c,%ecx
  10061e:	39 0d 78 90 10 00    	cmp    %ecx,0x109078
  100624:	7c 2e                	jl     100654 <console_intr+0x154>
  100626:	e9 f5 fe ff ff       	jmp    100520 <console_intr+0x20>
  10062b:	90                   	nop
  10062c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
  100630:	89 0d 7c 90 10 00    	mov    %ecx,0x10907c
        cons_putc(BACKSPACE);
  100636:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  10063d:	e8 2e fd ff ff       	call   100370 <cons_putc>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e > input.w &&
  100642:	8b 0d 7c 90 10 00    	mov    0x10907c,%ecx
  100648:	3b 0d 78 90 10 00    	cmp    0x109078,%ecx
  10064e:	0f 8e cc fe ff ff    	jle    100520 <console_intr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
  100654:	83 e9 01             	sub    $0x1,%ecx
  100657:	89 ca                	mov    %ecx,%edx
  100659:	c1 fa 1f             	sar    $0x1f,%edx
  10065c:	c1 ea 19             	shr    $0x19,%edx
  10065f:	8d 04 11             	lea    (%ecx,%edx,1),%eax
  100662:	83 e0 7f             	and    $0x7f,%eax
  100665:	29 d0                	sub    %edx,%eax
  100667:	80 b8 f4 8f 10 00 0a 	cmpb   $0xa,0x108ff4(%eax)
  10066e:	75 c0                	jne    100630 <console_intr+0x130>
  100670:	e9 ab fe ff ff       	jmp    100520 <console_intr+0x20>
      break;
    default:
      if(c != 0 && input.e < input.r+INPUT_BUF){
        input.buf[input.e++ % INPUT_BUF] = c;
        cons_putc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
  100675:	a1 7c 90 10 00       	mov    0x10907c,%eax
          input.w = input.e;
  10067a:	a3 78 90 10 00       	mov    %eax,0x109078
          wakeup(&input.r);
  10067f:	c7 04 24 74 90 10 00 	movl   $0x109074,(%esp)
  100686:	e8 75 2c 00 00       	call   103300 <wakeup>
  10068b:	e9 90 fe ff ff       	jmp    100520 <console_intr+0x20>

00100690 <console_write>:
    release(&console_lock);
}

int
console_write(struct inode *ip, char *buf, int n)
{
  100690:	55                   	push   %ebp
  100691:	89 e5                	mov    %esp,%ebp
  100693:	57                   	push   %edi
  100694:	56                   	push   %esi
  100695:	53                   	push   %ebx
  100696:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
  100699:	8b 45 08             	mov    0x8(%ebp),%eax
    release(&console_lock);
}

int
console_write(struct inode *ip, char *buf, int n)
{
  10069c:	8b 75 10             	mov    0x10(%ebp),%esi
  10069f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  iunlock(ip);
  1006a2:	89 04 24             	mov    %eax,(%esp)
  1006a5:	e8 86 15 00 00       	call   101c30 <iunlock>
  acquire(&console_lock);
  1006aa:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1006b1:	e8 da 38 00 00       	call   103f90 <acquire>
  for(i = 0; i < n; i++)
  1006b6:	85 f6                	test   %esi,%esi
  1006b8:	7e 19                	jle    1006d3 <console_write+0x43>
  1006ba:	31 db                	xor    %ebx,%ebx
  1006bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cons_putc(buf[i] & 0xff);
  1006c0:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
  1006c4:	83 c3 01             	add    $0x1,%ebx
    cons_putc(buf[i] & 0xff);
  1006c7:	89 14 24             	mov    %edx,(%esp)
  1006ca:	e8 a1 fc ff ff       	call   100370 <cons_putc>
{
  int i;

  iunlock(ip);
  acquire(&console_lock);
  for(i = 0; i < n; i++)
  1006cf:	39 de                	cmp    %ebx,%esi
  1006d1:	7f ed                	jg     1006c0 <console_write+0x30>
    cons_putc(buf[i] & 0xff);
  release(&console_lock);
  1006d3:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  1006da:	e8 71 38 00 00       	call   103f50 <release>
  ilock(ip);
  1006df:	8b 45 08             	mov    0x8(%ebp),%eax
  1006e2:	89 04 24             	mov    %eax,(%esp)
  1006e5:	e8 b6 15 00 00       	call   101ca0 <ilock>

  return n;
}
  1006ea:	83 c4 1c             	add    $0x1c,%esp
  1006ed:	89 f0                	mov    %esi,%eax
  1006ef:	5b                   	pop    %ebx
  1006f0:	5e                   	pop    %esi
  1006f1:	5f                   	pop    %edi
  1006f2:	5d                   	pop    %ebp
  1006f3:	c3                   	ret    
  1006f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1006fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00100700 <printint>:
  cga_putc(c);
}

void
printint(int xx, int base, int sgn)
{
  100700:	55                   	push   %ebp
  100701:	89 e5                	mov    %esp,%ebp
  100703:	57                   	push   %edi
  100704:	56                   	push   %esi
  100705:	53                   	push   %ebx
  100706:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  100709:	8b 55 10             	mov    0x10(%ebp),%edx
  cga_putc(c);
}

void
printint(int xx, int base, int sgn)
{
  10070c:	8b 45 08             	mov    0x8(%ebp),%eax
  10070f:	8b 75 0c             	mov    0xc(%ebp),%esi
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
  100712:	85 d2                	test   %edx,%edx
  100714:	74 04                	je     10071a <printint+0x1a>
  100716:	85 c0                	test   %eax,%eax
  100718:	78 54                	js     10076e <printint+0x6e>
    neg = 1;
    x = 0 - xx;
  } else {
    x = xx;
  10071a:	31 ff                	xor    %edi,%edi
  10071c:	31 c9                	xor    %ecx,%ecx
  10071e:	8d 5d d8             	lea    -0x28(%ebp),%ebx
  100721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  do{
    buf[i++] = digits[x % base];
  100728:	31 d2                	xor    %edx,%edx
  10072a:	f7 f6                	div    %esi
  10072c:	0f b6 92 d9 5f 10 00 	movzbl 0x105fd9(%edx),%edx
  100733:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  100736:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
  100739:	85 c0                	test   %eax,%eax
  10073b:	75 eb                	jne    100728 <printint+0x28>
  if(neg)
  10073d:	85 ff                	test   %edi,%edi
  10073f:	74 08                	je     100749 <printint+0x49>
    buf[i++] = '-';
  100741:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
  100746:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
  100749:	8d 71 ff             	lea    -0x1(%ecx),%esi
  10074c:	01 f3                	add    %esi,%ebx
  10074e:	66 90                	xchg   %ax,%ax
    cons_putc(buf[i]);
  100750:	0f be 03             	movsbl (%ebx),%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  100753:	83 ee 01             	sub    $0x1,%esi
  100756:	83 eb 01             	sub    $0x1,%ebx
    cons_putc(buf[i]);
  100759:	89 04 24             	mov    %eax,(%esp)
  10075c:	e8 0f fc ff ff       	call   100370 <cons_putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
  100761:	83 fe ff             	cmp    $0xffffffff,%esi
  100764:	75 ea                	jne    100750 <printint+0x50>
    cons_putc(buf[i]);
}
  100766:	83 c4 2c             	add    $0x2c,%esp
  100769:	5b                   	pop    %ebx
  10076a:	5e                   	pop    %esi
  10076b:	5f                   	pop    %edi
  10076c:	5d                   	pop    %ebp
  10076d:	c3                   	ret    
  int i = 0, neg = 0;
  uint x;

  if(sgn && xx < 0){
    neg = 1;
    x = 0 - xx;
  10076e:	f7 d8                	neg    %eax
  100770:	bf 01 00 00 00       	mov    $0x1,%edi
  100775:	eb a5                	jmp    10071c <printint+0x1c>
  100777:	89 f6                	mov    %esi,%esi
  100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100780 <cprintf>:
}

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  100780:	55                   	push   %ebp
  100781:	89 e5                	mov    %esp,%ebp
  100783:	57                   	push   %edi
  100784:	56                   	push   %esi
  100785:	53                   	push   %ebx
  100786:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = use_console_lock;
  100789:	a1 a4 77 10 00       	mov    0x1077a4,%eax
  if(locking)
  10078e:	85 c0                	test   %eax,%eax
{
  int i, c, state, locking;
  uint *argp;
  char *s;

  locking = use_console_lock;
  100790:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
  100793:	0f 85 67 01 00 00    	jne    100900 <cprintf+0x180>
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100799:	8b 55 08             	mov    0x8(%ebp),%edx
  10079c:	0f b6 02             	movzbl (%edx),%eax
  10079f:	84 c0                	test   %al,%al
  1007a1:	0f 84 81 00 00 00    	je     100828 <cprintf+0xa8>

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  1007a7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  1007aa:	31 db                	xor    %ebx,%ebx
  1007ac:	31 f6                	xor    %esi,%esi
  1007ae:	eb 1b                	jmp    1007cb <cprintf+0x4b>
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    switch(state){
    case 0:
      if(c == '%')
  1007b0:	83 f8 25             	cmp    $0x25,%eax
  1007b3:	0f 85 8f 00 00 00    	jne    100848 <cprintf+0xc8>
  1007b9:	be 25 00 00 00       	mov    $0x25,%esi
  1007be:	66 90                	xchg   %ax,%ax
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  1007c0:	83 c3 01             	add    $0x1,%ebx
  1007c3:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
  1007c7:	84 c0                	test   %al,%al
  1007c9:	74 5d                	je     100828 <cprintf+0xa8>
    c = fmt[i] & 0xff;
    switch(state){
  1007cb:	85 f6                	test   %esi,%esi
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
  1007cd:	0f b6 c0             	movzbl %al,%eax
    switch(state){
  1007d0:	74 de                	je     1007b0 <cprintf+0x30>
  1007d2:	83 fe 25             	cmp    $0x25,%esi
  1007d5:	75 e9                	jne    1007c0 <cprintf+0x40>
      else
        cons_putc(c);
      break;
    
    case '%':
      switch(c){
  1007d7:	83 f8 70             	cmp    $0x70,%eax
  1007da:	0f 84 82 00 00 00    	je     100862 <cprintf+0xe2>
  1007e0:	7f 76                	jg     100858 <cprintf+0xd8>
  1007e2:	83 f8 25             	cmp    $0x25,%eax
  1007e5:	8d 76 00             	lea    0x0(%esi),%esi
  1007e8:	0f 84 fa 00 00 00    	je     1008e8 <cprintf+0x168>
  1007ee:	83 f8 64             	cmp    $0x64,%eax
  1007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  1007f8:	0f 84 c2 00 00 00    	je     1008c0 <cprintf+0x140>
      case '%':
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
  1007fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100801:	83 c3 01             	add    $0x1,%ebx
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
  100804:	31 f6                	xor    %esi,%esi
      case '%':
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
  100806:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  10080d:	e8 5e fb ff ff       	call   100370 <cons_putc>
        cons_putc(c);
  100812:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100815:	89 04 24             	mov    %eax,(%esp)
  100818:	e8 53 fb ff ff       	call   100370 <cons_putc>
  10081d:	8b 55 08             	mov    0x8(%ebp),%edx
  if(locking)
    acquire(&console_lock);

  argp = (uint*)(void*)&fmt + 1;
  state = 0;
  for(i = 0; fmt[i]; i++){
  100820:	0f b6 04 1a          	movzbl (%edx,%ebx,1),%eax
  100824:	84 c0                	test   %al,%al
  100826:	75 a3                	jne    1007cb <cprintf+0x4b>
      state = 0;
      break;
    }
  }

  if(locking)
  100828:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  10082b:	85 c9                	test   %ecx,%ecx
  10082d:	74 0c                	je     10083b <cprintf+0xbb>
    release(&console_lock);
  10082f:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100836:	e8 15 37 00 00       	call   103f50 <release>
}
  10083b:	83 c4 2c             	add    $0x2c,%esp
  10083e:	5b                   	pop    %ebx
  10083f:	5e                   	pop    %esi
  100840:	5f                   	pop    %edi
  100841:	5d                   	pop    %ebp
  100842:	c3                   	ret    
  100843:	90                   	nop
  100844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(state){
    case 0:
      if(c == '%')
        state = '%';
      else
        cons_putc(c);
  100848:	89 04 24             	mov    %eax,(%esp)
  10084b:	e8 20 fb ff ff       	call   100370 <cons_putc>
  100850:	8b 55 08             	mov    0x8(%ebp),%edx
  100853:	e9 68 ff ff ff       	jmp    1007c0 <cprintf+0x40>
      break;
    
    case '%':
      switch(c){
  100858:	83 f8 73             	cmp    $0x73,%eax
  10085b:	74 33                	je     100890 <cprintf+0x110>
  10085d:	83 f8 78             	cmp    $0x78,%eax
  100860:	75 9c                	jne    1007fe <cprintf+0x7e>
      case 'd':
        printint(*argp++, 10, 1);
        break;
      case 'x':
      case 'p':
        printint(*argp++, 16, 0);
  100862:	8b 07                	mov    (%edi),%eax
  100864:	31 f6                	xor    %esi,%esi
  100866:	83 c7 04             	add    $0x4,%edi
  100869:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100870:	00 
  100871:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100878:	00 
  100879:	89 04 24             	mov    %eax,(%esp)
  10087c:	e8 7f fe ff ff       	call   100700 <printint>
  100881:	8b 55 08             	mov    0x8(%ebp),%edx
        break;
  100884:	e9 37 ff ff ff       	jmp    1007c0 <cprintf+0x40>
  100889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      case 's':
        s = (char*)*argp++;
  100890:	8b 37                	mov    (%edi),%esi
  100892:	83 c7 04             	add    $0x4,%edi
        if(s == 0)
  100895:	85 f6                	test   %esi,%esi
  100897:	74 78                	je     100911 <cprintf+0x191>
          s = "(null)";
        for(; *s; s++)
  100899:	0f b6 06             	movzbl (%esi),%eax
  10089c:	84 c0                	test   %al,%al
  10089e:	74 18                	je     1008b8 <cprintf+0x138>
          cons_putc(*s);
  1008a0:	0f be c0             	movsbl %al,%eax
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  1008a3:	83 c6 01             	add    $0x1,%esi
          cons_putc(*s);
  1008a6:	89 04 24             	mov    %eax,(%esp)
  1008a9:	e8 c2 fa ff ff       	call   100370 <cons_putc>
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
          s = "(null)";
        for(; *s; s++)
  1008ae:	0f b6 06             	movzbl (%esi),%eax
  1008b1:	84 c0                	test   %al,%al
  1008b3:	75 eb                	jne    1008a0 <cprintf+0x120>
  1008b5:	8b 55 08             	mov    0x8(%ebp),%edx
        cons_putc('%');
        break;
      default:
        // Print unknown % sequence to draw attention.
        cons_putc('%');
        cons_putc(c);
  1008b8:	31 f6                	xor    %esi,%esi
  1008ba:	e9 01 ff ff ff       	jmp    1007c0 <cprintf+0x40>
  1008bf:	90                   	nop
      break;
    
    case '%':
      switch(c){
      case 'd':
        printint(*argp++, 10, 1);
  1008c0:	8b 07                	mov    (%edi),%eax
  1008c2:	31 f6                	xor    %esi,%esi
  1008c4:	83 c7 04             	add    $0x4,%edi
  1008c7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  1008ce:	00 
  1008cf:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
  1008d6:	00 
  1008d7:	89 04 24             	mov    %eax,(%esp)
  1008da:	e8 21 fe ff ff       	call   100700 <printint>
  1008df:	8b 55 08             	mov    0x8(%ebp),%edx
        break;
  1008e2:	e9 d9 fe ff ff       	jmp    1007c0 <cprintf+0x40>
  1008e7:	90                   	nop
          s = "(null)";
        for(; *s; s++)
          cons_putc(*s);
        break;
      case '%':
        cons_putc('%');
  1008e8:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  1008ef:	31 f6                	xor    %esi,%esi
  1008f1:	e8 7a fa ff ff       	call   100370 <cons_putc>
  1008f6:	8b 55 08             	mov    0x8(%ebp),%edx
        break;
  1008f9:	e9 c2 fe ff ff       	jmp    1007c0 <cprintf+0x40>
  1008fe:	66 90                	xchg   %ax,%ax
  uint *argp;
  char *s;

  locking = use_console_lock;
  if(locking)
    acquire(&console_lock);
  100900:	c7 04 24 c0 77 10 00 	movl   $0x1077c0,(%esp)
  100907:	e8 84 36 00 00       	call   103f90 <acquire>
  10090c:	e9 88 fe ff ff       	jmp    100799 <cprintf+0x19>
      case 'p':
        printint(*argp++, 16, 0);
        break;
      case 's':
        s = (char*)*argp++;
        if(s == 0)
  100911:	be bf 5f 10 00       	mov    $0x105fbf,%esi
  100916:	eb 81                	jmp    100899 <cprintf+0x119>
  100918:	90                   	nop
  100919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100920 <panic>:
  ioapic_enable(IRQ_KBD, 0);
}

void
panic(char *s)
{
  100920:	55                   	push   %ebp
  100921:	89 e5                	mov    %esp,%ebp
  100923:	56                   	push   %esi
  100924:	53                   	push   %ebx
  100925:	83 ec 40             	sub    $0x40,%esp
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  use_console_lock = 0;
  100928:	c7 05 a4 77 10 00 00 	movl   $0x0,0x1077a4
  10092f:	00 00 00 
panic(char *s)
{
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  100932:	fa                   	cli    
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  100933:	e8 98 1f 00 00       	call   1028d0 <cpu>
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  100938:	8d 75 d0             	lea    -0x30(%ebp),%esi
  10093b:	31 db                	xor    %ebx,%ebx
  int i;
  uint pcs[10];
  
  __asm __volatile("cli");
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  10093d:	c7 04 24 c6 5f 10 00 	movl   $0x105fc6,(%esp)
  100944:	89 44 24 04          	mov    %eax,0x4(%esp)
  100948:	e8 33 fe ff ff       	call   100780 <cprintf>
  cprintf(s, 0);
  10094d:	8b 45 08             	mov    0x8(%ebp),%eax
  100950:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100957:	00 
  100958:	89 04 24             	mov    %eax,(%esp)
  10095b:	e8 20 fe ff ff       	call   100780 <cprintf>
  cprintf("\n", 0);
  100960:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100967:	00 
  100968:	c7 04 24 13 64 10 00 	movl   $0x106413,(%esp)
  10096f:	e8 0c fe ff ff       	call   100780 <cprintf>
  getcallerpcs(&s, pcs);
  100974:	8d 45 08             	lea    0x8(%ebp),%eax
  100977:	89 74 24 04          	mov    %esi,0x4(%esp)
  10097b:	89 04 24             	mov    %eax,(%esp)
  10097e:	e8 6d 34 00 00       	call   103df0 <getcallerpcs>
  100983:	90                   	nop
  100984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  100988:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  10098b:	83 c3 01             	add    $0x1,%ebx
    cprintf(" %p", pcs[i]);
  10098e:	c7 04 24 d5 5f 10 00 	movl   $0x105fd5,(%esp)
  100995:	89 44 24 04          	mov    %eax,0x4(%esp)
  100999:	e8 e2 fd ff ff       	call   100780 <cprintf>
  use_console_lock = 0;
  cprintf("cpu%d: panic: ", cpu());
  cprintf(s, 0);
  cprintf("\n", 0);
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
  10099e:	83 fb 0a             	cmp    $0xa,%ebx
  1009a1:	75 e5                	jne    100988 <panic+0x68>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  1009a3:	c7 05 a0 77 10 00 01 	movl   $0x1,0x1077a0
  1009aa:	00 00 00 
  1009ad:	eb fe                	jmp    1009ad <panic+0x8d>
  1009af:	90                   	nop

001009b0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
  1009b0:	55                   	push   %ebp
  1009b1:	89 e5                	mov    %esp,%ebp
  1009b3:	57                   	push   %edi
  1009b4:	56                   	push   %esi
  1009b5:	53                   	push   %ebx
  1009b6:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
  uint sz, sp, argp;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;

  if((ip = namei(path)) == 0)
  1009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  1009bf:	89 04 24             	mov    %eax,(%esp)
  1009c2:	e8 99 15 00 00       	call   101f60 <namei>
  1009c7:	89 c3                	mov    %eax,%ebx
  1009c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1009ce:	85 db                	test   %ebx,%ebx
  1009d0:	0f 84 81 03 00 00    	je     100d57 <exec+0x3a7>
    return -1;
  ilock(ip);
  1009d6:	89 1c 24             	mov    %ebx,(%esp)
  1009d9:	e8 c2 12 00 00       	call   101ca0 <ilock>
  // Compute memory size of new process.
  mem = 0;
  sz = 0;

  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
  1009de:	8d 45 94             	lea    -0x6c(%ebp),%eax
  1009e1:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
  1009e8:	00 
  1009e9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1009f0:	00 
  1009f1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009f5:	89 1c 24             	mov    %ebx,(%esp)
  1009f8:	e8 63 0a 00 00       	call   101460 <readi>
  1009fd:	83 f8 33             	cmp    $0x33,%eax
  100a00:	0f 86 74 03 00 00    	jbe    100d7a <exec+0x3ca>
    goto bad;
  if(elf.magic != ELF_MAGIC)
  100a06:	81 7d 94 7f 45 4c 46 	cmpl   $0x464c457f,-0x6c(%ebp)
  100a0d:	0f 85 67 03 00 00    	jne    100d7a <exec+0x3ca>
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100a13:	66 83 7d c0 00       	cmpw   $0x0,-0x40(%ebp)
  100a18:	bf ff 1f 00 00       	mov    $0x1fff,%edi
  100a1d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100a20:	74 6b                	je     100a8d <exec+0xdd>
  100a22:	89 c7                	mov    %eax,%edi
  100a24:	31 f6                	xor    %esi,%esi
  100a26:	c7 45 84 00 00 00 00 	movl   $0x0,-0x7c(%ebp)
  100a2d:	eb 0f                	jmp    100a3e <exec+0x8e>
  100a2f:	90                   	nop
  100a30:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  100a34:	83 c6 01             	add    $0x1,%esi
  100a37:	39 f0                	cmp    %esi,%eax
  100a39:	7e 49                	jle    100a84 <exec+0xd4>
  100a3b:	83 c7 20             	add    $0x20,%edi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100a3e:	8d 55 c8             	lea    -0x38(%ebp),%edx
  100a41:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  100a48:	00 
  100a49:	89 7c 24 08          	mov    %edi,0x8(%esp)
  100a4d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a51:	89 1c 24             	mov    %ebx,(%esp)
  100a54:	e8 07 0a 00 00       	call   101460 <readi>
  100a59:	83 f8 20             	cmp    $0x20,%eax
  100a5c:	0f 85 18 03 00 00    	jne    100d7a <exec+0x3ca>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100a62:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
  100a66:	75 c8                	jne    100a30 <exec+0x80>
      continue;
    if(ph.memsz < ph.filesz)
  100a68:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a6b:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  100a6e:	66 90                	xchg   %ax,%ax
  100a70:	0f 82 04 03 00 00    	jb     100d7a <exec+0x3ca>
      goto bad;
    sz += ph.memsz;
  100a76:	01 45 84             	add    %eax,-0x7c(%ebp)
  // Program segments.
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
    goto bad;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100a79:	83 c6 01             	add    $0x1,%esi
  100a7c:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  100a80:	39 f0                	cmp    %esi,%eax
  100a82:	7f b7                	jg     100a3b <exec+0x8b>
  100a84:	8b 7d 84             	mov    -0x7c(%ebp),%edi
  100a87:	81 c7 ff 1f 00 00    	add    $0x1fff,%edi
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100a8d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100a90:	31 f6                	xor    %esi,%esi
  100a92:	c7 85 78 ff ff ff 00 	movl   $0x0,-0x88(%ebp)
  100a99:	00 00 00 
  100a9c:	8b 11                	mov    (%ecx),%edx
  100a9e:	85 d2                	test   %edx,%edx
  100aa0:	0f 84 ec 02 00 00    	je     100d92 <exec+0x3e2>
  100aa6:	89 7d 84             	mov    %edi,-0x7c(%ebp)
  100aa9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  100aac:	89 5d 80             	mov    %ebx,-0x80(%ebp)
  100aaf:	8b 9d 78 ff ff ff    	mov    -0x88(%ebp),%ebx
  100ab5:	8d 76 00             	lea    0x0(%esi),%esi
    arglen += strlen(argv[argc]) + 1;
  100ab8:	89 14 24             	mov    %edx,(%esp)
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100abb:	83 c3 01             	add    $0x1,%ebx
    arglen += strlen(argv[argc]) + 1;
  100abe:	e8 1d 37 00 00       	call   1041e0 <strlen>
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100ac3:	8b 14 9f             	mov    (%edi,%ebx,4),%edx
  100ac6:	89 d9                	mov    %ebx,%ecx
    arglen += strlen(argv[argc]) + 1;
  100ac8:	01 f0                	add    %esi,%eax
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100aca:	85 d2                	test   %edx,%edx
    arglen += strlen(argv[argc]) + 1;
  100acc:	8d 70 01             	lea    0x1(%eax),%esi
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100acf:	75 e7                	jne    100ab8 <exec+0x108>
  100ad1:	89 9d 78 ff ff ff    	mov    %ebx,-0x88(%ebp)
  100ad7:	8b 7d 84             	mov    -0x7c(%ebp),%edi
  100ada:	83 c0 04             	add    $0x4,%eax
  100add:	8b 5d 80             	mov    -0x80(%ebp),%ebx
  100ae0:	83 e0 fc             	and    $0xfffffffc,%eax
  100ae3:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  100ae9:	8d 44 88 04          	lea    0x4(%eax,%ecx,4),%eax
  100aed:	89 8d 74 ff ff ff    	mov    %ecx,-0x8c(%ebp)

  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  100af3:	8d 3c 38             	lea    (%eax,%edi,1),%edi
  100af6:	89 7d 80             	mov    %edi,-0x80(%ebp)
  100af9:	81 65 80 00 f0 ff ff 	andl   $0xfffff000,-0x80(%ebp)
  mem = kalloc(sz);
  100b00:	8b 4d 80             	mov    -0x80(%ebp),%ecx
  100b03:	89 0c 24             	mov    %ecx,(%esp)
  100b06:	e8 35 18 00 00       	call   102340 <kalloc>
  if(mem == 0)
  100b0b:	85 c0                	test   %eax,%eax
  // Stack.
  sz += PAGE;
  
  // Allocate program memory.
  sz = (sz+PAGE-1) & ~(PAGE-1);
  mem = kalloc(sz);
  100b0d:	89 45 84             	mov    %eax,-0x7c(%ebp)
  if(mem == 0)
  100b10:	0f 84 64 02 00 00    	je     100d7a <exec+0x3ca>
    goto bad;
  memset(mem, 0, sz);
  100b16:	8b 45 80             	mov    -0x80(%ebp),%eax
  100b19:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100b20:	00 
  100b21:	89 44 24 08          	mov    %eax,0x8(%esp)
  100b25:	8b 55 84             	mov    -0x7c(%ebp),%edx
  100b28:	89 14 24             	mov    %edx,(%esp)
  100b2b:	e8 d0 34 00 00       	call   104000 <memset>

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100b30:	8b 7d b0             	mov    -0x50(%ebp),%edi
  100b33:	66 83 7d c0 00       	cmpw   $0x0,-0x40(%ebp)
  100b38:	0f 84 ab 00 00 00    	je     100be9 <exec+0x239>
  100b3e:	31 f6                	xor    %esi,%esi
  100b40:	eb 18                	jmp    100b5a <exec+0x1aa>
  100b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100b48:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  100b4c:	83 c6 01             	add    $0x1,%esi
  100b4f:	39 f0                	cmp    %esi,%eax
  100b51:	0f 8e 92 00 00 00    	jle    100be9 <exec+0x239>
  100b57:	83 c7 20             	add    $0x20,%edi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
  100b5a:	8d 4d c8             	lea    -0x38(%ebp),%ecx
  100b5d:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  100b64:	00 
  100b65:	89 7c 24 08          	mov    %edi,0x8(%esp)
  100b69:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100b6d:	89 1c 24             	mov    %ebx,(%esp)
  100b70:	e8 eb 08 00 00       	call   101460 <readi>
  100b75:	83 f8 20             	cmp    $0x20,%eax
  100b78:	0f 85 ea 01 00 00    	jne    100d68 <exec+0x3b8>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
  100b7e:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
  100b82:	75 c4                	jne    100b48 <exec+0x198>
      continue;
    if(ph.va + ph.memsz > sz)
  100b84:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100b87:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100b8a:	01 c2                	add    %eax,%edx
  100b8c:	39 55 80             	cmp    %edx,-0x80(%ebp)
  100b8f:	0f 82 d3 01 00 00    	jb     100d68 <exec+0x3b8>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
  100b95:	8b 55 d8             	mov    -0x28(%ebp),%edx
  100b98:	89 54 24 0c          	mov    %edx,0xc(%esp)
  100b9c:	8b 55 cc             	mov    -0x34(%ebp),%edx
  100b9f:	89 54 24 08          	mov    %edx,0x8(%esp)
  100ba3:	03 45 84             	add    -0x7c(%ebp),%eax
  100ba6:	89 1c 24             	mov    %ebx,(%esp)
  100ba9:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bad:	e8 ae 08 00 00       	call   101460 <readi>
  100bb2:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  100bb5:	0f 85 ad 01 00 00    	jne    100d68 <exec+0x3b8>
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100bbb:	8b 55 dc             	mov    -0x24(%ebp),%edx
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100bbe:	83 c6 01             	add    $0x1,%esi
      continue;
    if(ph.va + ph.memsz > sz)
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  100bc1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100bc8:	00 
  100bc9:	29 c2                	sub    %eax,%edx
  100bcb:	89 54 24 08          	mov    %edx,0x8(%esp)
  100bcf:	03 45 d0             	add    -0x30(%ebp),%eax
  100bd2:	03 45 84             	add    -0x7c(%ebp),%eax
  100bd5:	89 04 24             	mov    %eax,(%esp)
  100bd8:	e8 23 34 00 00       	call   104000 <memset>
  if(mem == 0)
    goto bad;
  memset(mem, 0, sz);

  // Load program into memory.
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
  100bdd:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  100be1:	39 f0                	cmp    %esi,%eax
  100be3:	0f 8f 6e ff ff ff    	jg     100b57 <exec+0x1a7>
      goto bad;
    if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
      goto bad;
    memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
  }
  iunlockput(ip);
  100be9:	89 1c 24             	mov    %ebx,(%esp)
  100bec:	e8 8f 10 00 00       	call   101c80 <iunlockput>
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100bf1:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  100bf7:	8b 55 80             	mov    -0x80(%ebp),%edx
  100bfa:	2b 95 7c ff ff ff    	sub    -0x84(%ebp),%edx

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100c00:	8b 4d 84             	mov    -0x7c(%ebp),%ecx
  }
  iunlockput(ip);
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100c03:	f7 d0                	not    %eax
  100c05:	8d 04 82             	lea    (%edx,%eax,4),%eax

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100c08:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
  }
  iunlockput(ip);
  
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);
  100c0e:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100c14:	89 d7                	mov    %edx,%edi
  100c16:	83 ef 01             	sub    $0x1,%edi
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100c19:	8d 04 90             	lea    (%eax,%edx,4),%eax
  for(i=argc-1; i>=0; i--){
  100c1c:	83 ff ff             	cmp    $0xffffffff,%edi
  // Initialize stack.
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  100c1f:	c7 04 08 00 00 00 00 	movl   $0x0,(%eax,%ecx,1)
  for(i=argc-1; i>=0; i--){
  100c26:	74 62                	je     100c8a <exec+0x2da>
  100c28:	8b 75 0c             	mov    0xc(%ebp),%esi
  100c2b:	8d 04 bd 00 00 00 00 	lea    0x0(,%edi,4),%eax
  100c32:	89 ca                	mov    %ecx,%edx
  100c34:	8b 5d 80             	mov    -0x80(%ebp),%ebx
  100c37:	01 c6                	add    %eax,%esi
  100c39:	03 85 7c ff ff ff    	add    -0x84(%ebp),%eax
  100c3f:	01 c2                	add    %eax,%edx
  100c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    len = strlen(argv[i]) + 1;
  100c48:	8b 06                	mov    (%esi),%eax
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100c4a:	83 ef 01             	sub    $0x1,%edi
    len = strlen(argv[i]) + 1;
  100c4d:	89 04 24             	mov    %eax,(%esp)
  100c50:	89 95 70 ff ff ff    	mov    %edx,-0x90(%ebp)
  100c56:	e8 85 35 00 00       	call   1041e0 <strlen>
    sp -= len;
  100c5b:	83 c0 01             	add    $0x1,%eax
  100c5e:	29 c3                	sub    %eax,%ebx
    memmove(mem+sp, argv[i], len);
  100c60:	89 44 24 08          	mov    %eax,0x8(%esp)
  100c64:	8b 06                	mov    (%esi),%eax
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100c66:	83 ee 04             	sub    $0x4,%esi
    len = strlen(argv[i]) + 1;
    sp -= len;
    memmove(mem+sp, argv[i], len);
  100c69:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c6d:	8b 45 84             	mov    -0x7c(%ebp),%eax
  100c70:	01 d8                	add    %ebx,%eax
  100c72:	89 04 24             	mov    %eax,(%esp)
  100c75:	e8 16 34 00 00       	call   104090 <memmove>
    *(uint*)(mem+argp + 4*i) = sp;  // argv[i]
  100c7a:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
  100c80:	89 1a                	mov    %ebx,(%edx)
  sp = sz;
  argp = sz - arglen - 4*(argc+1);

  // Copy argv strings and pointers to stack.
  *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
  for(i=argc-1; i>=0; i--){
  100c82:	83 ea 04             	sub    $0x4,%edx
  100c85:	83 ff ff             	cmp    $0xffffffff,%edi
  100c88:	75 be                	jne    100c48 <exec+0x298>
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100c8a:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  100c90:	8b 55 84             	mov    -0x7c(%ebp),%edx
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100c93:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
  sp -= 4;
  100c99:	89 c6                	mov    %eax,%esi
  }

  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  100c9b:	89 44 02 fc          	mov    %eax,-0x4(%edx,%eax,1)
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  100c9f:	83 ee 0c             	sub    $0xc,%esi
  // Stack frame for main(argc, argv), below arguments.
  sp = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argp;
  sp -= 4;
  *(uint*)(mem+sp) = argc;
  100ca2:	89 4c 02 f8          	mov    %ecx,-0x8(%edx,%eax,1)
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc
  100ca6:	c7 44 02 f4 ff ff ff 	movl   $0xffffffff,-0xc(%edx,%eax,1)
  100cad:	ff 

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100cae:	8b 45 08             	mov    0x8(%ebp),%eax
  100cb1:	0f b6 10             	movzbl (%eax),%edx
  100cb4:	89 c3                	mov    %eax,%ebx
  100cb6:	84 d2                	test   %dl,%dl
  100cb8:	74 21                	je     100cdb <exec+0x32b>
  100cba:	83 c0 01             	add    $0x1,%eax
  100cbd:	eb 0b                	jmp    100cca <exec+0x31a>
  100cbf:	90                   	nop
  100cc0:	0f b6 10             	movzbl (%eax),%edx
  100cc3:	83 c0 01             	add    $0x1,%eax
  100cc6:	84 d2                	test   %dl,%dl
  100cc8:	74 11                	je     100cdb <exec+0x32b>
    if(*s == '/')
  100cca:	80 fa 2f             	cmp    $0x2f,%dl
  100ccd:	75 f1                	jne    100cc0 <exec+0x310>
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100ccf:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
  100cd2:	89 c3                	mov    %eax,%ebx
  *(uint*)(mem+sp) = argc;
  sp -= 4;
  *(uint*)(mem+sp) = 0xffffffff;   // fake return pc

  // Save program name for debugging.
  for(last=s=path; *s; s++)
  100cd4:	83 c0 01             	add    $0x1,%eax
  100cd7:	84 d2                	test   %dl,%dl
  100cd9:	75 ef                	jne    100cca <exec+0x31a>
    if(*s == '/')
      last = s+1;
  safestrcpy(cp->name, last, sizeof(cp->name));
  100cdb:	e8 a0 26 00 00       	call   103380 <curproc>
  100ce0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  100ce4:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  100ceb:	00 
  100cec:	05 88 00 00 00       	add    $0x88,%eax
  100cf1:	89 04 24             	mov    %eax,(%esp)
  100cf4:	e8 a7 34 00 00       	call   1041a0 <safestrcpy>

  // Commit to the new image.
  kfree(cp->mem, cp->sz);
  100cf9:	e8 82 26 00 00       	call   103380 <curproc>
  100cfe:	8b 58 04             	mov    0x4(%eax),%ebx
  100d01:	e8 7a 26 00 00       	call   103380 <curproc>
  100d06:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  100d0a:	8b 00                	mov    (%eax),%eax
  100d0c:	89 04 24             	mov    %eax,(%esp)
  100d0f:	e8 ec 16 00 00       	call   102400 <kfree>
  cp->mem = mem;
  100d14:	e8 67 26 00 00       	call   103380 <curproc>
  100d19:	8b 55 84             	mov    -0x7c(%ebp),%edx
  100d1c:	89 10                	mov    %edx,(%eax)
  cp->sz = sz;
  100d1e:	e8 5d 26 00 00       	call   103380 <curproc>
  100d23:	8b 4d 80             	mov    -0x80(%ebp),%ecx
  100d26:	89 48 04             	mov    %ecx,0x4(%eax)
  cp->tf->eip = elf.entry;  // main
  100d29:	e8 52 26 00 00       	call   103380 <curproc>
  100d2e:	8b 55 ac             	mov    -0x54(%ebp),%edx
  100d31:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  100d37:	89 50 30             	mov    %edx,0x30(%eax)
  cp->tf->esp = sp;
  100d3a:	e8 41 26 00 00       	call   103380 <curproc>
  100d3f:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  100d45:	89 70 3c             	mov    %esi,0x3c(%eax)
  setupsegs(cp);
  100d48:	e8 33 26 00 00       	call   103380 <curproc>
  100d4d:	89 04 24             	mov    %eax,(%esp)
  100d50:	e8 ab 2a 00 00       	call   103800 <setupsegs>
  100d55:	31 c0                	xor    %eax,%eax
 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  return -1;
}
  100d57:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  100d5d:	5b                   	pop    %ebx
  100d5e:	5e                   	pop    %esi
  100d5f:	5f                   	pop    %edi
  100d60:	5d                   	pop    %ebp
  100d61:	c3                   	ret    
  100d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  setupsegs(cp);
  return 0;

 bad:
  if(mem)
    kfree(mem, sz);
  100d68:	8b 45 80             	mov    -0x80(%ebp),%eax
  100d6b:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d6f:	8b 55 84             	mov    -0x7c(%ebp),%edx
  100d72:	89 14 24             	mov    %edx,(%esp)
  100d75:	e8 86 16 00 00       	call   102400 <kfree>
  iunlockput(ip);
  100d7a:	89 1c 24             	mov    %ebx,(%esp)
  100d7d:	e8 fe 0e 00 00       	call   101c80 <iunlockput>
  return -1;
}
  100d82:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  return 0;

 bad:
  if(mem)
    kfree(mem, sz);
  iunlockput(ip);
  100d88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  100d8d:	5b                   	pop    %ebx
  100d8e:	5e                   	pop    %esi
  100d8f:	5f                   	pop    %edi
  100d90:	5d                   	pop    %ebp
  100d91:	c3                   	ret    
    sz += ph.memsz;
  }
  
  // Arguments.
  arglen = 0;
  for(argc=0; argv[argc]; argc++)
  100d92:	b8 04 00 00 00       	mov    $0x4,%eax
  100d97:	c7 85 7c ff ff ff 00 	movl   $0x0,-0x84(%ebp)
  100d9e:	00 00 00 
  100da1:	c7 85 74 ff ff ff 00 	movl   $0x0,-0x8c(%ebp)
  100da8:	00 00 00 
  100dab:	e9 43 fd ff ff       	jmp    100af3 <exec+0x143>

00100db0 <filewrite>:
}

// Write to file f.  Addr is kernel address.
int
filewrite(struct file *f, char *addr, int n)
{
  100db0:	55                   	push   %ebp
  100db1:	89 e5                	mov    %esp,%ebp
  100db3:	83 ec 38             	sub    $0x38,%esp
  100db6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100db9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100dbc:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100dbf:	8b 75 0c             	mov    0xc(%ebp),%esi
  100dc2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100dc5:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->writable == 0)
  100dc8:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
  100dcc:	74 5a                	je     100e28 <filewrite+0x78>
    return -1;
  if(f->type == FD_PIPE)
  100dce:	8b 03                	mov    (%ebx),%eax
  100dd0:	83 f8 02             	cmp    $0x2,%eax
  100dd3:	74 5b                	je     100e30 <filewrite+0x80>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100dd5:	83 f8 03             	cmp    $0x3,%eax
  100dd8:	75 6d                	jne    100e47 <filewrite+0x97>
    ilock(f->ip);
  100dda:	8b 43 10             	mov    0x10(%ebx),%eax
  100ddd:	89 04 24             	mov    %eax,(%esp)
  100de0:	e8 bb 0e 00 00       	call   101ca0 <ilock>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
  100de5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  100de9:	8b 43 14             	mov    0x14(%ebx),%eax
  100dec:	89 74 24 04          	mov    %esi,0x4(%esp)
  100df0:	89 44 24 08          	mov    %eax,0x8(%esp)
  100df4:	8b 43 10             	mov    0x10(%ebx),%eax
  100df7:	89 04 24             	mov    %eax,(%esp)
  100dfa:	e8 01 08 00 00       	call   101600 <writei>
  100dff:	85 c0                	test   %eax,%eax
  100e01:	7e 03                	jle    100e06 <filewrite+0x56>
      f->off += r;
  100e03:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100e06:	8b 53 10             	mov    0x10(%ebx),%edx
  100e09:	89 14 24             	mov    %edx,(%esp)
  100e0c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100e0f:	e8 1c 0e 00 00       	call   101c30 <iunlock>
    return r;
  100e14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("filewrite");
}
  100e17:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100e1a:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100e1d:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100e20:	89 ec                	mov    %ebp,%esp
  100e22:	5d                   	pop    %ebp
  100e23:	c3                   	ret    
  100e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100e2d:	eb e8                	jmp    100e17 <filewrite+0x67>
  100e2f:	90                   	nop
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100e30:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100e33:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100e36:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100e39:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100e3c:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
}
  100e3f:	89 ec                	mov    %ebp,%esp
  100e41:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  100e42:	e9 d9 20 00 00       	jmp    102f20 <pipewrite>
    if((r = writei(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("filewrite");
  100e47:	c7 04 24 ea 5f 10 00 	movl   $0x105fea,(%esp)
  100e4e:	e8 cd fa ff ff       	call   100920 <panic>
  100e53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100e60 <fileread>:
}

// Read from file f.  Addr is kernel address.
int
fileread(struct file *f, char *addr, int n)
{
  100e60:	55                   	push   %ebp
  100e61:	89 e5                	mov    %esp,%ebp
  100e63:	83 ec 38             	sub    $0x38,%esp
  100e66:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  100e69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  100e6c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  100e6f:	8b 75 0c             	mov    0xc(%ebp),%esi
  100e72:	89 7d fc             	mov    %edi,-0x4(%ebp)
  100e75:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
  100e78:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  100e7c:	74 5a                	je     100ed8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
  100e7e:	8b 03                	mov    (%ebx),%eax
  100e80:	83 f8 02             	cmp    $0x2,%eax
  100e83:	74 5b                	je     100ee0 <fileread+0x80>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
  100e85:	83 f8 03             	cmp    $0x3,%eax
  100e88:	75 6d                	jne    100ef7 <fileread+0x97>
    ilock(f->ip);
  100e8a:	8b 43 10             	mov    0x10(%ebx),%eax
  100e8d:	89 04 24             	mov    %eax,(%esp)
  100e90:	e8 0b 0e 00 00       	call   101ca0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
  100e95:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  100e99:	8b 43 14             	mov    0x14(%ebx),%eax
  100e9c:	89 74 24 04          	mov    %esi,0x4(%esp)
  100ea0:	89 44 24 08          	mov    %eax,0x8(%esp)
  100ea4:	8b 43 10             	mov    0x10(%ebx),%eax
  100ea7:	89 04 24             	mov    %eax,(%esp)
  100eaa:	e8 b1 05 00 00       	call   101460 <readi>
  100eaf:	85 c0                	test   %eax,%eax
  100eb1:	7e 03                	jle    100eb6 <fileread+0x56>
      f->off += r;
  100eb3:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
  100eb6:	8b 53 10             	mov    0x10(%ebx),%edx
  100eb9:	89 14 24             	mov    %edx,(%esp)
  100ebc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  100ebf:	e8 6c 0d 00 00       	call   101c30 <iunlock>
    return r;
  100ec4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  panic("fileread");
}
  100ec7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100eca:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100ecd:	8b 7d fc             	mov    -0x4(%ebp),%edi
  100ed0:	89 ec                	mov    %ebp,%esp
  100ed2:	5d                   	pop    %ebp
  100ed3:	c3                   	ret    
  100ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100ed8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100edd:	eb e8                	jmp    100ec7 <fileread+0x67>
  100edf:	90                   	nop
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100ee0:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100ee3:	8b 75 f8             	mov    -0x8(%ebp),%esi
  100ee6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  100ee9:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100eec:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
  100eef:	89 ec                	mov    %ebp,%esp
  100ef1:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  100ef2:	e9 39 1f 00 00       	jmp    102e30 <piperead>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
  100ef7:	c7 04 24 f4 5f 10 00 	movl   $0x105ff4,(%esp)
  100efe:	e8 1d fa ff ff       	call   100920 <panic>
  100f03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  100f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00100f10 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100f10:	55                   	push   %ebp
  if(f->type == FD_INODE){
  100f11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  100f16:	89 e5                	mov    %esp,%ebp
  100f18:	53                   	push   %ebx
  100f19:	83 ec 14             	sub    $0x14,%esp
  100f1c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
  100f1f:	83 3b 03             	cmpl   $0x3,(%ebx)
  100f22:	74 0c                	je     100f30 <filestat+0x20>
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}
  100f24:	83 c4 14             	add    $0x14,%esp
  100f27:	5b                   	pop    %ebx
  100f28:	5d                   	pop    %ebp
  100f29:	c3                   	ret    
  100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
  100f30:	8b 43 10             	mov    0x10(%ebx),%eax
  100f33:	89 04 24             	mov    %eax,(%esp)
  100f36:	e8 65 0d 00 00       	call   101ca0 <ilock>
    stati(f->ip, st);
  100f3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  100f3e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100f42:	8b 43 10             	mov    0x10(%ebx),%eax
  100f45:	89 04 24             	mov    %eax,(%esp)
  100f48:	e8 f3 01 00 00       	call   101140 <stati>
    iunlock(f->ip);
  100f4d:	8b 43 10             	mov    0x10(%ebx),%eax
  100f50:	89 04 24             	mov    %eax,(%esp)
  100f53:	e8 d8 0c 00 00       	call   101c30 <iunlock>
    return 0;
  }
  return -1;
}
  100f58:	83 c4 14             	add    $0x14,%esp
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
  100f5b:	31 c0                	xor    %eax,%eax
    return 0;
  }
  return -1;
}
  100f5d:	5b                   	pop    %ebx
  100f5e:	5d                   	pop    %ebp
  100f5f:	c3                   	ret    

00100f60 <filedup>:
}

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  100f60:	55                   	push   %ebp
  100f61:	89 e5                	mov    %esp,%ebp
  100f63:	53                   	push   %ebx
  100f64:	83 ec 14             	sub    $0x14,%esp
  100f67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&file_table_lock);
  100f6a:	c7 04 24 e0 99 10 00 	movl   $0x1099e0,(%esp)
  100f71:	e8 1a 30 00 00       	call   103f90 <acquire>
  if(f->ref < 1 || f->type == FD_CLOSED)
  100f76:	8b 43 04             	mov    0x4(%ebx),%eax
  100f79:	85 c0                	test   %eax,%eax
  100f7b:	7e 20                	jle    100f9d <filedup+0x3d>
  100f7d:	8b 13                	mov    (%ebx),%edx
  100f7f:	85 d2                	test   %edx,%edx
  100f81:	74 1a                	je     100f9d <filedup+0x3d>
    panic("filedup");
  f->ref++;
  100f83:	83 c0 01             	add    $0x1,%eax
  100f86:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&file_table_lock);
  100f89:	c7 04 24 e0 99 10 00 	movl   $0x1099e0,(%esp)
  100f90:	e8 bb 2f 00 00       	call   103f50 <release>
  return f;
}
  100f95:	89 d8                	mov    %ebx,%eax
  100f97:	83 c4 14             	add    $0x14,%esp
  100f9a:	5b                   	pop    %ebx
  100f9b:	5d                   	pop    %ebp
  100f9c:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("filedup");
  100f9d:	c7 04 24 fd 5f 10 00 	movl   $0x105ffd,(%esp)
  100fa4:	e8 77 f9 ff ff       	call   100920 <panic>
  100fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00100fb0 <filealloc>:
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  100fb0:	55                   	push   %ebp
  100fb1:	89 e5                	mov    %esp,%ebp
  100fb3:	53                   	push   %ebx
  100fb4:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&file_table_lock);
  100fb7:	c7 04 24 e0 99 10 00 	movl   $0x1099e0,(%esp)
  100fbe:	e8 cd 2f 00 00       	call   103f90 <acquire>
  100fc3:	ba 80 90 10 00       	mov    $0x109080,%edx
  100fc8:	31 c0                	xor    %eax,%eax
  100fca:	eb 0f                	jmp    100fdb <filealloc+0x2b>
  100fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < NFILE; i++){
  100fd0:	83 c0 01             	add    $0x1,%eax
  100fd3:	83 c2 18             	add    $0x18,%edx
  100fd6:	83 f8 64             	cmp    $0x64,%eax
  100fd9:	74 45                	je     101020 <filealloc+0x70>
    if(file[i].type == FD_CLOSED){
  100fdb:	8b 0a                	mov    (%edx),%ecx
  100fdd:	85 c9                	test   %ecx,%ecx
  100fdf:	75 ef                	jne    100fd0 <filealloc+0x20>
      file[i].type = FD_NONE;
  100fe1:	8d 14 40             	lea    (%eax,%eax,2),%edx
  100fe4:	8d 1c d5 00 00 00 00 	lea    0x0(,%edx,8),%ebx
      file[i].ref = 1;
      release(&file_table_lock);
  100feb:	c7 04 24 e0 99 10 00 	movl   $0x1099e0,(%esp)
  int i;

  acquire(&file_table_lock);
  for(i = 0; i < NFILE; i++){
    if(file[i].type == FD_CLOSED){
      file[i].type = FD_NONE;
  100ff2:	c7 04 d5 80 90 10 00 	movl   $0x1,0x109080(,%edx,8)
  100ff9:	01 00 00 00 
      file[i].ref = 1;
  100ffd:	c7 04 d5 84 90 10 00 	movl   $0x1,0x109084(,%edx,8)
  101004:	01 00 00 00 
      release(&file_table_lock);
  101008:	e8 43 2f 00 00       	call   103f50 <release>
      return file + i;
  10100d:	8d 83 80 90 10 00    	lea    0x109080(%ebx),%eax
    }
  }
  release(&file_table_lock);
  return 0;
}
  101013:	83 c4 14             	add    $0x14,%esp
  101016:	5b                   	pop    %ebx
  101017:	5d                   	pop    %ebp
  101018:	c3                   	ret    
  101019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      file[i].ref = 1;
      release(&file_table_lock);
      return file + i;
    }
  }
  release(&file_table_lock);
  101020:	c7 04 24 e0 99 10 00 	movl   $0x1099e0,(%esp)
  101027:	e8 24 2f 00 00       	call   103f50 <release>
  return 0;
}
  10102c:	83 c4 14             	add    $0x14,%esp
      file[i].ref = 1;
      release(&file_table_lock);
      return file + i;
    }
  }
  release(&file_table_lock);
  10102f:	31 c0                	xor    %eax,%eax
  return 0;
}
  101031:	5b                   	pop    %ebx
  101032:	5d                   	pop    %ebp
  101033:	c3                   	ret    
  101034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10103a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101040 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  101040:	55                   	push   %ebp
  101041:	89 e5                	mov    %esp,%ebp
  101043:	83 ec 38             	sub    $0x38,%esp
  101046:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101049:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10104c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10104f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&file_table_lock);
  101052:	c7 04 24 e0 99 10 00 	movl   $0x1099e0,(%esp)
  101059:	e8 32 2f 00 00       	call   103f90 <acquire>
  if(f->ref < 1 || f->type == FD_CLOSED)
  10105e:	8b 43 04             	mov    0x4(%ebx),%eax
  101061:	85 c0                	test   %eax,%eax
  101063:	0f 8e 9f 00 00 00    	jle    101108 <fileclose+0xc8>
  101069:	8b 33                	mov    (%ebx),%esi
  10106b:	85 f6                	test   %esi,%esi
  10106d:	0f 84 95 00 00 00    	je     101108 <fileclose+0xc8>
    panic("fileclose");
  if(--f->ref > 0){
  101073:	83 e8 01             	sub    $0x1,%eax
  101076:	85 c0                	test   %eax,%eax
  101078:	89 43 04             	mov    %eax,0x4(%ebx)
  10107b:	74 1b                	je     101098 <fileclose+0x58>
    release(&file_table_lock);
  10107d:	c7 45 08 e0 99 10 00 	movl   $0x1099e0,0x8(%ebp)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
}
  101084:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101087:	8b 75 f8             	mov    -0x8(%ebp),%esi
  10108a:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10108d:	89 ec                	mov    %ebp,%esp
  10108f:	5d                   	pop    %ebp

  acquire(&file_table_lock);
  if(f->ref < 1 || f->type == FD_CLOSED)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
  101090:	e9 bb 2e 00 00       	jmp    103f50 <release>
  101095:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }
  ff = *f;
  101098:	8b 43 0c             	mov    0xc(%ebx),%eax
  10109b:	8b 33                	mov    (%ebx),%esi
  10109d:	8b 7b 10             	mov    0x10(%ebx),%edi
  f->ref = 0;
  1010a0:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
    return;
  }
  ff = *f;
  1010a7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1010aa:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_CLOSED;
  1010ae:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    panic("fileclose");
  if(--f->ref > 0){
    release(&file_table_lock);
    return;
  }
  ff = *f;
  1010b4:	88 45 e7             	mov    %al,-0x19(%ebp)
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);
  1010b7:	c7 04 24 e0 99 10 00 	movl   $0x1099e0,(%esp)
  1010be:	e8 8d 2e 00 00       	call   103f50 <release>
  
  if(ff.type == FD_PIPE)
  1010c3:	83 fe 02             	cmp    $0x2,%esi
  1010c6:	74 20                	je     1010e8 <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
  1010c8:	83 fe 03             	cmp    $0x3,%esi
  1010cb:	75 3b                	jne    101108 <fileclose+0xc8>
    iput(ff.ip);
  1010cd:	89 7d 08             	mov    %edi,0x8(%ebp)
  else
    panic("fileclose");
}
  1010d0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1010d3:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1010d6:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1010d9:	89 ec                	mov    %ebp,%esp
  1010db:	5d                   	pop    %ebp
  release(&file_table_lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  1010dc:	e9 0f 09 00 00       	jmp    1019f0 <iput>
  1010e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f->ref = 0;
  f->type = FD_CLOSED;
  release(&file_table_lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  1010e8:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  1010ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  1010f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1010f3:	89 04 24             	mov    %eax,(%esp)
  1010f6:	e8 35 1f 00 00       	call   103030 <pipeclose>
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
}
  1010fb:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1010fe:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101101:	8b 7d fc             	mov    -0x4(%ebp),%edi
  101104:	89 ec                	mov    %ebp,%esp
  101106:	5d                   	pop    %ebp
  101107:	c3                   	ret    
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE)
    iput(ff.ip);
  else
    panic("fileclose");
  101108:	c7 04 24 05 60 10 00 	movl   $0x106005,(%esp)
  10110f:	e8 0c f8 ff ff       	call   100920 <panic>
  101114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  10111a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101120 <fileinit>:
struct spinlock file_table_lock;
struct file file[NFILE];

void
fileinit(void)
{
  101120:	55                   	push   %ebp
  101121:	89 e5                	mov    %esp,%ebp
  101123:	83 ec 18             	sub    $0x18,%esp
  initlock(&file_table_lock, "file_table");
  101126:	c7 44 24 04 0f 60 10 	movl   $0x10600f,0x4(%esp)
  10112d:	00 
  10112e:	c7 04 24 e0 99 10 00 	movl   $0x1099e0,(%esp)
  101135:	e8 96 2c 00 00       	call   103dd0 <initlock>
}
  10113a:	c9                   	leave  
  10113b:	c3                   	ret    
  10113c:	90                   	nop
  10113d:	90                   	nop
  10113e:	90                   	nop
  10113f:	90                   	nop

00101140 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
  101140:	55                   	push   %ebp
  101141:	89 e5                	mov    %esp,%ebp
  101143:	8b 55 08             	mov    0x8(%ebp),%edx
  101146:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
  101149:	8b 0a                	mov    (%edx),%ecx
  10114b:	89 08                	mov    %ecx,(%eax)
  st->ino = ip->inum;
  10114d:	8b 4a 04             	mov    0x4(%edx),%ecx
  101150:	89 48 04             	mov    %ecx,0x4(%eax)
  st->type = ip->type;
  101153:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
  101157:	66 89 48 08          	mov    %cx,0x8(%eax)
  st->nlink = ip->nlink;
  10115b:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
  st->size = ip->size;
  10115f:	8b 52 18             	mov    0x18(%edx),%edx
stati(struct inode *ip, struct stat *st)
{
  st->dev = ip->dev;
  st->ino = ip->inum;
  st->type = ip->type;
  st->nlink = ip->nlink;
  101162:	66 89 48 0a          	mov    %cx,0xa(%eax)
  st->size = ip->size;
  101166:	89 50 0c             	mov    %edx,0xc(%eax)
}
  101169:	5d                   	pop    %ebp
  10116a:	c3                   	ret    
  10116b:	90                   	nop
  10116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101170 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  101170:	55                   	push   %ebp
  101171:	89 e5                	mov    %esp,%ebp
  101173:	53                   	push   %ebx
  101174:	83 ec 14             	sub    $0x14,%esp
  101177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
  10117a:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101181:	e8 0a 2e 00 00       	call   103f90 <acquire>
  ip->ref++;
  101186:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
  10118a:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101191:	e8 ba 2d 00 00       	call   103f50 <release>
  return ip;
}
  101196:	89 d8                	mov    %ebx,%eax
  101198:	83 c4 14             	add    $0x14,%esp
  10119b:	5b                   	pop    %ebx
  10119c:	5d                   	pop    %ebp
  10119d:	c3                   	ret    
  10119e:	66 90                	xchg   %ax,%ax

001011a0 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
{
  1011a0:	55                   	push   %ebp
  1011a1:	89 e5                	mov    %esp,%ebp
  1011a3:	57                   	push   %edi
  1011a4:	89 d7                	mov    %edx,%edi
  1011a6:	56                   	push   %esi
}

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
  1011a7:	31 f6                	xor    %esi,%esi
{
  1011a9:	53                   	push   %ebx
  1011aa:	89 c3                	mov    %eax,%ebx
  1011ac:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
  1011af:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  1011b6:	e8 d5 2d 00 00       	call   103f90 <acquire>
}

// Find the inode with number inum on device dev
// and return the in-memory copy.
static struct inode*
iget(uint dev, uint inum)
  1011bb:	b8 b4 9a 10 00       	mov    $0x109ab4,%eax
  1011c0:	eb 14                	jmp    1011d6 <iget+0x36>
  1011c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  1011c8:	85 f6                	test   %esi,%esi
  1011ca:	74 3c                	je     101208 <iget+0x68>

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  1011cc:	83 c0 50             	add    $0x50,%eax
  1011cf:	3d 54 aa 10 00       	cmp    $0x10aa54,%eax
  1011d4:	74 42                	je     101218 <iget+0x78>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
  1011d6:	8b 48 08             	mov    0x8(%eax),%ecx
  1011d9:	85 c9                	test   %ecx,%ecx
  1011db:	7e eb                	jle    1011c8 <iget+0x28>
  1011dd:	39 18                	cmp    %ebx,(%eax)
  1011df:	75 e7                	jne    1011c8 <iget+0x28>
  1011e1:	39 78 04             	cmp    %edi,0x4(%eax)
  1011e4:	75 e2                	jne    1011c8 <iget+0x28>
      ip->ref++;
  1011e6:	83 c1 01             	add    $0x1,%ecx
  1011e9:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
  1011ec:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  1011f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1011f6:	e8 55 2d 00 00       	call   103f50 <release>
      return ip;
  1011fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
  1011fe:	83 c4 2c             	add    $0x2c,%esp
  101201:	5b                   	pop    %ebx
  101202:	5e                   	pop    %esi
  101203:	5f                   	pop    %edi
  101204:	5d                   	pop    %ebp
  101205:	c3                   	ret    
  101206:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
  101208:	85 c9                	test   %ecx,%ecx
  10120a:	75 c0                	jne    1011cc <iget+0x2c>
  10120c:	89 c6                	mov    %eax,%esi

  acquire(&icache.lock);

  // Try for cached inode.
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
  10120e:	83 c0 50             	add    $0x50,%eax
  101211:	3d 54 aa 10 00       	cmp    $0x10aa54,%eax
  101216:	75 be                	jne    1011d6 <iget+0x36>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
  101218:	85 f6                	test   %esi,%esi
  10121a:	74 29                	je     101245 <iget+0xa5>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
  10121c:	89 1e                	mov    %ebx,(%esi)
  ip->inum = inum;
  10121e:	89 7e 04             	mov    %edi,0x4(%esi)
  ip->ref = 1;
  101221:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
  101228:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
  10122f:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101236:	e8 15 2d 00 00       	call   103f50 <release>

  return ip;
}
  10123b:	83 c4 2c             	add    $0x2c,%esp
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
  10123e:	89 f0                	mov    %esi,%eax

  return ip;
}
  101240:	5b                   	pop    %ebx
  101241:	5e                   	pop    %esi
  101242:	5f                   	pop    %edi
  101243:	5d                   	pop    %ebp
  101244:	c3                   	ret    
      empty = ip;
  }

  // Allocate fresh inode.
  if(empty == 0)
    panic("iget: no inodes");
  101245:	c7 04 24 1a 60 10 00 	movl   $0x10601a,(%esp)
  10124c:	e8 cf f6 ff ff       	call   100920 <panic>
  101251:	eb 0d                	jmp    101260 <readsb>
  101253:	90                   	nop
  101254:	90                   	nop
  101255:	90                   	nop
  101256:	90                   	nop
  101257:	90                   	nop
  101258:	90                   	nop
  101259:	90                   	nop
  10125a:	90                   	nop
  10125b:	90                   	nop
  10125c:	90                   	nop
  10125d:	90                   	nop
  10125e:	90                   	nop
  10125f:	90                   	nop

00101260 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  101260:	55                   	push   %ebp
  101261:	89 e5                	mov    %esp,%ebp
  101263:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
  101266:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10126d:	00 
static void itrunc(struct inode*);

// Read the super block.
static void
readsb(int dev, struct superblock *sb)
{
  10126e:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  101271:	89 75 fc             	mov    %esi,-0x4(%ebp)
  101274:	89 d6                	mov    %edx,%esi
  struct buf *bp;
  
  bp = bread(dev, 1);
  101276:	89 04 24             	mov    %eax,(%esp)
  101279:	e8 32 ee ff ff       	call   1000b0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
  10127e:	89 34 24             	mov    %esi,(%esp)
  101281:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
  101288:	00 
static void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;
  
  bp = bread(dev, 1);
  101289:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
  10128b:	8d 40 18             	lea    0x18(%eax),%eax
  10128e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101292:	e8 f9 2d 00 00       	call   104090 <memmove>
  brelse(bp);
  101297:	89 1c 24             	mov    %ebx,(%esp)
  10129a:	e8 61 ed ff ff       	call   100000 <brelse>
}
  10129f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  1012a2:	8b 75 fc             	mov    -0x4(%ebp),%esi
  1012a5:	89 ec                	mov    %ebp,%esp
  1012a7:	5d                   	pop    %ebp
  1012a8:	c3                   	ret    
  1012a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001012b0 <balloc>:
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1012b0:	55                   	push   %ebp
  1012b1:	89 e5                	mov    %esp,%ebp
  1012b3:	57                   	push   %edi
  1012b4:	56                   	push   %esi
  1012b5:	53                   	push   %ebx
  1012b6:	83 ec 3c             	sub    $0x3c,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1012b9:	8d 55 dc             	lea    -0x24(%ebp),%edx
// Blocks. 

// Allocate a disk block.
static uint
balloc(uint dev)
{
  1012bc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  1012bf:	e8 9c ff ff ff       	call   101260 <readsb>
  for(b = 0; b < sb.size; b += BPB){
  1012c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1012c7:	85 c0                	test   %eax,%eax
  1012c9:	0f 84 9c 00 00 00    	je     10136b <balloc+0xbb>
  1012cf:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    bp = bread(dev, BBLOCK(b, sb.ninodes));
  1012d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1012d9:	31 db                	xor    %ebx,%ebx
  1012db:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1012de:	c1 e8 03             	shr    $0x3,%eax
  1012e1:	c1 fa 0c             	sar    $0xc,%edx
  1012e4:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  1012e8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1012ec:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1012ef:	89 04 24             	mov    %eax,(%esp)
  1012f2:	e8 b9 ed ff ff       	call   1000b0 <bread>
  1012f7:	89 c6                	mov    %eax,%esi
  1012f9:	eb 10                	jmp    10130b <balloc+0x5b>
  1012fb:	90                   	nop
  1012fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(bi = 0; bi < BPB; bi++){
  101300:	83 c3 01             	add    $0x1,%ebx
  101303:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
  101309:	74 45                	je     101350 <balloc+0xa0>
      m = 1 << (bi % 8);
  10130b:	89 d9                	mov    %ebx,%ecx
  10130d:	ba 01 00 00 00       	mov    $0x1,%edx
  101312:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101315:	89 d8                	mov    %ebx,%eax
  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  101317:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  101319:	c1 f8 03             	sar    $0x3,%eax
  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
  10131c:	89 d1                	mov    %edx,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
  10131e:	0f b6 54 06 18       	movzbl 0x18(%esi,%eax,1),%edx
  101323:	0f b6 fa             	movzbl %dl,%edi
  101326:	85 cf                	test   %ecx,%edi
  101328:	75 d6                	jne    101300 <balloc+0x50>
        bp->data[bi/8] |= m;  // Mark block in use on disk.
  10132a:	09 d1                	or     %edx,%ecx
  10132c:	88 4c 06 18          	mov    %cl,0x18(%esi,%eax,1)
        bwrite(bp);
  101330:	89 34 24             	mov    %esi,(%esp)
  101333:	e8 48 ed ff ff       	call   100080 <bwrite>
        brelse(bp);
  101338:	89 34 24             	mov    %esi,(%esp)
  10133b:	e8 c0 ec ff ff       	call   100000 <brelse>
  101340:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101343:	83 c4 3c             	add    $0x3c,%esp
    for(bi = 0; bi < BPB; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use on disk.
        bwrite(bp);
        brelse(bp);
  101346:	8d 04 13             	lea    (%ebx,%edx,1),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
  101349:	5b                   	pop    %ebx
  10134a:	5e                   	pop    %esi
  10134b:	5f                   	pop    %edi
  10134c:	5d                   	pop    %ebp
  10134d:	c3                   	ret    
  10134e:	66 90                	xchg   %ax,%ax
        bwrite(bp);
        brelse(bp);
        return b + bi;
      }
    }
    brelse(bp);
  101350:	89 34 24             	mov    %esi,(%esp)
  101353:	e8 a8 ec ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
  101358:	81 45 d4 00 10 00 00 	addl   $0x1000,-0x2c(%ebp)
  10135f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  101362:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  101365:	0f 87 6b ff ff ff    	ja     1012d6 <balloc+0x26>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
  10136b:	c7 04 24 2a 60 10 00 	movl   $0x10602a,(%esp)
  101372:	e8 a9 f5 ff ff       	call   100920 <panic>
  101377:	89 f6                	mov    %esi,%esi
  101379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101380 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, alloc controls whether one is allocated.
static uint
bmap(struct inode *ip, uint bn, int alloc)
{
  101380:	55                   	push   %ebp
  101381:	89 e5                	mov    %esp,%ebp
  101383:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  101386:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, alloc controls whether one is allocated.
static uint
bmap(struct inode *ip, uint bn, int alloc)
{
  101389:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10138c:	89 c3                	mov    %eax,%ebx
  10138e:	89 75 f8             	mov    %esi,-0x8(%ebp)
  101391:	89 ce                	mov    %ecx,%esi
  101393:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
  101396:	77 30                	ja     1013c8 <bmap+0x48>
    if((addr = ip->addrs[bn]) == 0){
  101398:	8d 7a 04             	lea    0x4(%edx),%edi
  10139b:	8b 44 b8 0c          	mov    0xc(%eax,%edi,4),%eax
  10139f:	85 c0                	test   %eax,%eax
  1013a1:	75 15                	jne    1013b8 <bmap+0x38>
      if(!alloc)
  1013a3:	85 c9                	test   %ecx,%ecx
  1013a5:	74 38                	je     1013df <bmap+0x5f>
        return -1;
      ip->addrs[bn] = addr = balloc(ip->dev);
  1013a7:	8b 03                	mov    (%ebx),%eax
  1013a9:	e8 02 ff ff ff       	call   1012b0 <balloc>
  1013ae:	89 44 bb 0c          	mov    %eax,0xc(%ebx,%edi,4)
  1013b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
  1013b8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1013bb:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1013be:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1013c1:	89 ec                	mov    %ebp,%esp
  1013c3:	5d                   	pop    %ebp
  1013c4:	c3                   	ret    
  1013c5:	8d 76 00             	lea    0x0(%esi),%esi
        return -1;
      ip->addrs[bn] = addr = balloc(ip->dev);
    }
    return addr;
  }
  bn -= NDIRECT;
  1013c8:	8d 7a f4             	lea    -0xc(%edx),%edi

  if(bn < NINDIRECT){
  1013cb:	83 ff 7f             	cmp    $0x7f,%edi
  1013ce:	0f 87 7f 00 00 00    	ja     101453 <bmap+0xd3>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[INDIRECT]) == 0){
  1013d4:	8b 40 4c             	mov    0x4c(%eax),%eax
  1013d7:	85 c0                	test   %eax,%eax
  1013d9:	75 17                	jne    1013f2 <bmap+0x72>
      if(!alloc)
  1013db:	85 c9                	test   %ecx,%ecx
  1013dd:	75 09                	jne    1013e8 <bmap+0x68>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
  1013df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1013e4:	eb d2                	jmp    1013b8 <bmap+0x38>
  1013e6:	66 90                	xchg   %ax,%ax
  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[INDIRECT]) == 0){
      if(!alloc)
        return -1;
      ip->addrs[INDIRECT] = addr = balloc(ip->dev);
  1013e8:	8b 03                	mov    (%ebx),%eax
  1013ea:	e8 c1 fe ff ff       	call   1012b0 <balloc>
  1013ef:	89 43 4c             	mov    %eax,0x4c(%ebx)
    }
    bp = bread(ip->dev, addr);
  1013f2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1013f6:	8b 03                	mov    (%ebx),%eax
  1013f8:	89 04 24             	mov    %eax,(%esp)
  1013fb:	e8 b0 ec ff ff       	call   1000b0 <bread>
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
  101400:	8d 7c b8 18          	lea    0x18(%eax,%edi,4),%edi
    if((addr = ip->addrs[INDIRECT]) == 0){
      if(!alloc)
        return -1;
      ip->addrs[INDIRECT] = addr = balloc(ip->dev);
    }
    bp = bread(ip->dev, addr);
  101404:	89 c2                	mov    %eax,%edx
    a = (uint*)bp->data;
  
    if((addr = a[bn]) == 0){
  101406:	8b 07                	mov    (%edi),%eax
  101408:	85 c0                	test   %eax,%eax
  10140a:	75 34                	jne    101440 <bmap+0xc0>
      if(!alloc){
  10140c:	85 f6                	test   %esi,%esi
  10140e:	75 10                	jne    101420 <bmap+0xa0>
        brelse(bp);
  101410:	89 14 24             	mov    %edx,(%esp)
  101413:	e8 e8 eb ff ff       	call   100000 <brelse>
  101418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        return -1;
  10141d:	eb 99                	jmp    1013b8 <bmap+0x38>
  10141f:	90                   	nop
      }
      a[bn] = addr = balloc(ip->dev);
  101420:	8b 03                	mov    (%ebx),%eax
  101422:	89 55 e0             	mov    %edx,-0x20(%ebp)
  101425:	e8 86 fe ff ff       	call   1012b0 <balloc>
      bwrite(bp);
  10142a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    if((addr = a[bn]) == 0){
      if(!alloc){
        brelse(bp);
        return -1;
      }
      a[bn] = addr = balloc(ip->dev);
  10142d:	89 07                	mov    %eax,(%edi)
      bwrite(bp);
  10142f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  101432:	89 14 24             	mov    %edx,(%esp)
  101435:	e8 46 ec ff ff       	call   100080 <bwrite>
  10143a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10143d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    brelse(bp);
  101440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  101443:	89 14 24             	mov    %edx,(%esp)
  101446:	e8 b5 eb ff ff       	call   100000 <brelse>
    return addr;
  10144b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10144e:	e9 65 ff ff ff       	jmp    1013b8 <bmap+0x38>
  }

  panic("bmap: out of range");
  101453:	c7 04 24 40 60 10 00 	movl   $0x106040,(%esp)
  10145a:	e8 c1 f4 ff ff       	call   100920 <panic>
  10145f:	90                   	nop

00101460 <readi>:
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101460:	55                   	push   %ebp
  101461:	89 e5                	mov    %esp,%ebp
  101463:	83 ec 38             	sub    $0x38,%esp
  101466:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  101469:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10146c:	8b 45 14             	mov    0x14(%ebp),%eax
  10146f:	89 75 f8             	mov    %esi,-0x8(%ebp)
  101472:	8b 75 10             	mov    0x10(%ebp),%esi
  101475:	89 7d fc             	mov    %edi,-0x4(%ebp)
  101478:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  10147b:	66 83 7b 10 03       	cmpw   $0x3,0x10(%ebx)
}

// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
  101480:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101483:	74 1b                	je     1014a0 <readi+0x40>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
  101485:	8b 43 18             	mov    0x18(%ebx),%eax
  101488:	39 f0                	cmp    %esi,%eax
  10148a:	73 44                	jae    1014d0 <readi+0x70>
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  10148c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  101491:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  101494:	8b 75 f8             	mov    -0x8(%ebp),%esi
  101497:	8b 7d fc             	mov    -0x4(%ebp),%edi
  10149a:	89 ec                	mov    %ebp,%esp
  10149c:	5d                   	pop    %ebp
  10149d:	c3                   	ret    
  10149e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
  1014a0:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
  1014a4:	66 83 f8 09          	cmp    $0x9,%ax
  1014a8:	77 e2                	ja     10148c <readi+0x2c>
  1014aa:	98                   	cwtl   
  1014ab:	8b 04 c5 20 9a 10 00 	mov    0x109a20(,%eax,8),%eax
  1014b2:	85 c0                	test   %eax,%eax
  1014b4:	74 d6                	je     10148c <readi+0x2c>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014b6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1014b9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1014bc:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1014bf:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014c2:	89 55 10             	mov    %edx,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
  1014c5:	89 ec                	mov    %ebp,%esp
  1014c7:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  1014c8:	ff e0                	jmp    *%eax
  1014ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  if(off > ip->size || off + n < off)
  1014d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1014d3:	01 f2                	add    %esi,%edx
  1014d5:	72 b5                	jb     10148c <readi+0x2c>
    return -1;
  if(off + n > ip->size)
  1014d7:	39 d0                	cmp    %edx,%eax
  1014d9:	73 05                	jae    1014e0 <readi+0x80>
    n = ip->size - off;
  1014db:	29 f0                	sub    %esi,%eax
  1014dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  1014e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1014e3:	85 d2                	test   %edx,%edx
  1014e5:	74 7e                	je     101565 <readi+0x105>
  1014e7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
  1014ee:	89 7d dc             	mov    %edi,-0x24(%ebp)
  1014f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  1014f8:	89 f2                	mov    %esi,%edx
  1014fa:	31 c9                	xor    %ecx,%ecx
  1014fc:	c1 ea 09             	shr    $0x9,%edx
  1014ff:	89 d8                	mov    %ebx,%eax
  101501:	e8 7a fe ff ff       	call   101380 <bmap>
    m = min(n - tot, BSIZE - off%BSIZE);
  101506:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  10150b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10150f:	8b 03                	mov    (%ebx),%eax
  101511:	89 04 24             	mov    %eax,(%esp)
  101514:	e8 97 eb ff ff       	call   1000b0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  101519:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  10151c:	2b 4d e0             	sub    -0x20(%ebp),%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
  10151f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  101521:	89 f0                	mov    %esi,%eax
  101523:	25 ff 01 00 00       	and    $0x1ff,%eax
  101528:	29 c7                	sub    %eax,%edi
  10152a:	39 cf                	cmp    %ecx,%edi
  10152c:	76 02                	jbe    101530 <readi+0xd0>
  10152e:	89 cf                	mov    %ecx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
  101530:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101534:	01 fe                	add    %edi,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
  101536:	89 7c 24 08          	mov    %edi,0x8(%esp)
  10153a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10153e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  101541:	89 04 24             	mov    %eax,(%esp)
  101544:	89 55 d8             	mov    %edx,-0x28(%ebp)
  101547:	e8 44 2b 00 00       	call   104090 <memmove>
    brelse(bp);
  10154c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  10154f:	89 14 24             	mov    %edx,(%esp)
  101552:	e8 a9 ea ff ff       	call   100000 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
  101557:	01 7d e0             	add    %edi,-0x20(%ebp)
  10155a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10155d:	01 7d dc             	add    %edi,-0x24(%ebp)
  101560:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
  101563:	77 93                	ja     1014f8 <readi+0x98>
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 0));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
  101565:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101568:	e9 24 ff ff ff       	jmp    101491 <readi+0x31>
  10156d:	8d 76 00             	lea    0x0(%esi),%esi

00101570 <iupdate>:
}

// Copy inode, which has changed, from memory to disk.
void
iupdate(struct inode *ip)
{
  101570:	55                   	push   %ebp
  101571:	89 e5                	mov    %esp,%ebp
  101573:	56                   	push   %esi
  101574:	53                   	push   %ebx
  101575:	83 ec 10             	sub    $0x10,%esp
  101578:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  10157b:	8b 43 04             	mov    0x4(%ebx),%eax
  10157e:	c1 e8 03             	shr    $0x3,%eax
  101581:	83 c0 02             	add    $0x2,%eax
  101584:	89 44 24 04          	mov    %eax,0x4(%esp)
  101588:	8b 03                	mov    (%ebx),%eax
  10158a:	89 04 24             	mov    %eax,(%esp)
  10158d:	e8 1e eb ff ff       	call   1000b0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  101592:	0f b7 53 10          	movzwl 0x10(%ebx),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
  101596:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  101598:	8b 43 04             	mov    0x4(%ebx),%eax
  10159b:	83 e0 07             	and    $0x7,%eax
  10159e:	c1 e0 06             	shl    $0x6,%eax
  1015a1:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
  1015a5:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
  1015a8:	0f b7 53 12          	movzwl 0x12(%ebx),%edx
  1015ac:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
  1015b0:	0f b7 53 14          	movzwl 0x14(%ebx),%edx
  1015b4:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
  1015b8:	0f b7 53 16          	movzwl 0x16(%ebx),%edx
  1015bc:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
  1015c0:	8b 53 18             	mov    0x18(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1015c3:	83 c3 1c             	add    $0x1c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  1015c6:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  1015c9:	83 c0 0c             	add    $0xc,%eax
  1015cc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1015d0:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  1015d7:	00 
  1015d8:	89 04 24             	mov    %eax,(%esp)
  1015db:	e8 b0 2a 00 00       	call   104090 <memmove>
  bwrite(bp);
  1015e0:	89 34 24             	mov    %esi,(%esp)
  1015e3:	e8 98 ea ff ff       	call   100080 <bwrite>
  brelse(bp);
  1015e8:	89 75 08             	mov    %esi,0x8(%ebp)
}
  1015eb:	83 c4 10             	add    $0x10,%esp
  1015ee:	5b                   	pop    %ebx
  1015ef:	5e                   	pop    %esi
  1015f0:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  bwrite(bp);
  brelse(bp);
  1015f1:	e9 0a ea ff ff       	jmp    100000 <brelse>
  1015f6:	8d 76 00             	lea    0x0(%esi),%esi
  1015f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101600 <writei>:
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  101600:	55                   	push   %ebp
  101601:	89 e5                	mov    %esp,%ebp
  101603:	57                   	push   %edi
  101604:	56                   	push   %esi
  101605:	53                   	push   %ebx
  101606:	83 ec 2c             	sub    $0x2c,%esp
  101609:	8b 75 08             	mov    0x8(%ebp),%esi
  10160c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10160f:	8b 55 14             	mov    0x14(%ebp),%edx
  101612:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101615:	66 83 7e 10 03       	cmpw   $0x3,0x10(%esi)
}

// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
  10161a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10161d:	89 55 dc             	mov    %edx,-0x24(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
  101620:	0f 84 c2 00 00 00    	je     1016e8 <writei+0xe8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off + n < off)
  101626:	8b 45 dc             	mov    -0x24(%ebp),%eax
  101629:	01 d8                	add    %ebx,%eax
  10162b:	0f 82 c1 00 00 00    	jb     1016f2 <writei+0xf2>
    return -1;
  if(off + n > MAXFILE*BSIZE)
  101631:	3d 00 18 01 00       	cmp    $0x11800,%eax
  101636:	76 0a                	jbe    101642 <writei+0x42>
    n = MAXFILE*BSIZE - off;
  101638:	c7 45 dc 00 18 01 00 	movl   $0x11800,-0x24(%ebp)
  10163f:	29 5d dc             	sub    %ebx,-0x24(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  101642:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  101645:	85 c9                	test   %ecx,%ecx
  101647:	0f 84 8b 00 00 00    	je     1016d8 <writei+0xd8>
  10164d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  101654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  101658:	89 da                	mov    %ebx,%edx
  10165a:	b9 01 00 00 00       	mov    $0x1,%ecx
  10165f:	c1 ea 09             	shr    $0x9,%edx
  101662:	89 f0                	mov    %esi,%eax
  101664:	e8 17 fd ff ff       	call   101380 <bmap>
    m = min(n - tot, BSIZE - off%BSIZE);
  101669:	bf 00 02 00 00       	mov    $0x200,%edi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  10166e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101672:	8b 06                	mov    (%esi),%eax
  101674:	89 04 24             	mov    %eax,(%esp)
  101677:	e8 34 ea ff ff       	call   1000b0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
  10167c:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  10167f:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
  101682:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
  101684:	89 d8                	mov    %ebx,%eax
  101686:	25 ff 01 00 00       	and    $0x1ff,%eax
  10168b:	29 c7                	sub    %eax,%edi
  10168d:	39 cf                	cmp    %ecx,%edi
  10168f:	76 02                	jbe    101693 <writei+0x93>
  101691:	89 cf                	mov    %ecx,%edi
    memmove(bp->data + off%BSIZE, src, m);
  101693:	89 7c 24 08          	mov    %edi,0x8(%esp)
  101697:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  10169a:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  10169e:	89 04 24             	mov    %eax,(%esp)
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1016a1:	01 fb                	add    %edi,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE, 1));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
  1016a3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  1016a7:	89 55 d8             	mov    %edx,-0x28(%ebp)
  1016aa:	e8 e1 29 00 00       	call   104090 <memmove>
    bwrite(bp);
  1016af:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1016b2:	89 14 24             	mov    %edx,(%esp)
  1016b5:	e8 c6 e9 ff ff       	call   100080 <bwrite>
    brelse(bp);
  1016ba:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1016bd:	89 14 24             	mov    %edx,(%esp)
  1016c0:	e8 3b e9 ff ff       	call   100000 <brelse>
  if(off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    n = MAXFILE*BSIZE - off;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
  1016c5:	01 7d e4             	add    %edi,-0x1c(%ebp)
  1016c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1016cb:	01 7d e0             	add    %edi,-0x20(%ebp)
  1016ce:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  1016d1:	77 85                	ja     101658 <writei+0x58>
    memmove(bp->data + off%BSIZE, src, m);
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
  1016d3:	3b 5e 18             	cmp    0x18(%esi),%ebx
  1016d6:	77 28                	ja     101700 <writei+0x100>
    ip->size = off;
    iupdate(ip);
  }
  return n;
  1016d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
  1016db:	83 c4 2c             	add    $0x2c,%esp
  1016de:	5b                   	pop    %ebx
  1016df:	5e                   	pop    %esi
  1016e0:	5f                   	pop    %edi
  1016e1:	5d                   	pop    %ebp
  1016e2:	c3                   	ret    
  1016e3:	90                   	nop
  1016e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  1016e8:	0f b7 46 12          	movzwl 0x12(%esi),%eax
  1016ec:	66 83 f8 09          	cmp    $0x9,%ax
  1016f0:	76 1b                	jbe    10170d <writei+0x10d>
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  1016f2:	83 c4 2c             	add    $0x2c,%esp

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
  1016f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1016fa:	5b                   	pop    %ebx
  1016fb:	5e                   	pop    %esi
  1016fc:	5f                   	pop    %edi
  1016fd:	5d                   	pop    %ebp
  1016fe:	c3                   	ret    
  1016ff:	90                   	nop
    bwrite(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
  101700:	89 5e 18             	mov    %ebx,0x18(%esi)
    iupdate(ip);
  101703:	89 34 24             	mov    %esi,(%esp)
  101706:	e8 65 fe ff ff       	call   101570 <iupdate>
  10170b:	eb cb                	jmp    1016d8 <writei+0xd8>
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
  10170d:	98                   	cwtl   
  10170e:	8b 04 c5 24 9a 10 00 	mov    0x109a24(,%eax,8),%eax
  101715:	85 c0                	test   %eax,%eax
  101717:	74 d9                	je     1016f2 <writei+0xf2>
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101719:	89 55 10             	mov    %edx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
  10171c:	83 c4 2c             	add    $0x2c,%esp
  10171f:	5b                   	pop    %ebx
  101720:	5e                   	pop    %esi
  101721:	5f                   	pop    %edi
  101722:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  101723:	ff e0                	jmp    *%eax
  101725:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101730 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
  101730:	55                   	push   %ebp
  101731:	89 e5                	mov    %esp,%ebp
  101733:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
  101736:	8b 45 0c             	mov    0xc(%ebp),%eax
  101739:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101740:	00 
  101741:	89 44 24 04          	mov    %eax,0x4(%esp)
  101745:	8b 45 08             	mov    0x8(%ebp),%eax
  101748:	89 04 24             	mov    %eax,(%esp)
  10174b:	e8 a0 29 00 00       	call   1040f0 <strncmp>
}
  101750:	c9                   	leave  
  101751:	c3                   	ret    
  101752:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101760 <dirlookup>:
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101760:	55                   	push   %ebp
  101761:	89 e5                	mov    %esp,%ebp
  101763:	57                   	push   %edi
  101764:	56                   	push   %esi
  101765:	53                   	push   %ebx
  101766:	83 ec 3c             	sub    $0x3c,%esp
  101769:	8b 45 08             	mov    0x8(%ebp),%eax
  10176c:	8b 55 10             	mov    0x10(%ebp),%edx
  10176f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  101772:	66 83 78 10 01       	cmpw   $0x1,0x10(%eax)
// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
  101777:	89 45 dc             	mov    %eax,-0x24(%ebp)
  10177a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
  10177d:	0f 85 d0 00 00 00    	jne    101853 <dirlookup+0xf3>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101783:	8b 70 18             	mov    0x18(%eax),%esi
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  101786:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)

  for(off = 0; off < dp->size; off += BSIZE){
  10178d:	85 f6                	test   %esi,%esi
  10178f:	0f 84 b4 00 00 00    	je     101849 <dirlookup+0xe9>
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
  101795:	8b 55 e0             	mov    -0x20(%ebp),%edx
  101798:	31 c9                	xor    %ecx,%ecx
  10179a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10179d:	c1 ea 09             	shr    $0x9,%edx
  1017a0:	e8 db fb ff ff       	call   101380 <bmap>
  1017a5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1017a9:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1017ac:	8b 01                	mov    (%ecx),%eax
  1017ae:	89 04 24             	mov    %eax,(%esp)
  1017b1:	e8 fa e8 ff ff       	call   1000b0 <bread>
  1017b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
  1017b9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
  1017bc:	83 c0 18             	add    $0x18,%eax
  1017bf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  1017c2:	89 c6                	mov    %eax,%esi

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
// Caller must have already locked dp.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
  1017c4:	81 c7 18 02 00 00    	add    $0x218,%edi
  1017ca:	eb 0b                	jmp    1017d7 <dirlookup+0x77>
  1017cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
  1017d0:	83 c6 10             	add    $0x10,%esi
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
    bp = bread(dp->dev, bmap(dp, off / BSIZE, 0));
    for(de = (struct dirent*)bp->data;
  1017d3:	39 fe                	cmp    %edi,%esi
  1017d5:	74 51                	je     101828 <dirlookup+0xc8>
        de < (struct dirent*)(bp->data + BSIZE);
        de++){
      if(de->inum == 0)
  1017d7:	66 83 3e 00          	cmpw   $0x0,(%esi)
  1017db:	74 f3                	je     1017d0 <dirlookup+0x70>
        continue;
      if(namecmp(name, de->name) == 0){
  1017dd:	8d 46 02             	lea    0x2(%esi),%eax
  1017e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1017e4:	89 1c 24             	mov    %ebx,(%esp)
  1017e7:	e8 44 ff ff ff       	call   101730 <namecmp>
  1017ec:	85 c0                	test   %eax,%eax
  1017ee:	75 e0                	jne    1017d0 <dirlookup+0x70>
        // entry matches path element
        if(poff)
  1017f0:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
  1017f3:	85 db                	test   %ebx,%ebx
  1017f5:	74 0e                	je     101805 <dirlookup+0xa5>
          *poff = off + (uchar*)de - bp->data;
  1017f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1017fa:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  1017fd:	8d 04 16             	lea    (%esi,%edx,1),%eax
  101800:	2b 45 d8             	sub    -0x28(%ebp),%eax
  101803:	89 01                	mov    %eax,(%ecx)
        inum = de->inum;
        brelse(bp);
  101805:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        continue;
      if(namecmp(name, de->name) == 0){
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
  101808:	0f b7 1e             	movzwl (%esi),%ebx
        brelse(bp);
  10180b:	89 04 24             	mov    %eax,(%esp)
  10180e:	e8 ed e7 ff ff       	call   100000 <brelse>
        return iget(dp->dev, inum);
  101813:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  101816:	89 da                	mov    %ebx,%edx
  101818:	8b 01                	mov    (%ecx),%eax
      }
    }
    brelse(bp);
  }
  return 0;
}
  10181a:	83 c4 3c             	add    $0x3c,%esp
  10181d:	5b                   	pop    %ebx
  10181e:	5e                   	pop    %esi
  10181f:	5f                   	pop    %edi
  101820:	5d                   	pop    %ebp
        // entry matches path element
        if(poff)
          *poff = off + (uchar*)de - bp->data;
        inum = de->inum;
        brelse(bp);
        return iget(dp->dev, inum);
  101821:	e9 7a f9 ff ff       	jmp    1011a0 <iget>
  101826:	66 90                	xchg   %ax,%ax
      }
    }
    brelse(bp);
  101828:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10182b:	89 04 24             	mov    %eax,(%esp)
  10182e:	e8 cd e7 ff ff       	call   100000 <brelse>
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += BSIZE){
  101833:	8b 55 dc             	mov    -0x24(%ebp),%edx
  101836:	81 45 e0 00 02 00 00 	addl   $0x200,-0x20(%ebp)
  10183d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101840:	39 4a 18             	cmp    %ecx,0x18(%edx)
  101843:	0f 87 4c ff ff ff    	ja     101795 <dirlookup+0x35>
      }
    }
    brelse(bp);
  }
  return 0;
}
  101849:	83 c4 3c             	add    $0x3c,%esp
  10184c:	31 c0                	xor    %eax,%eax
  10184e:	5b                   	pop    %ebx
  10184f:	5e                   	pop    %esi
  101850:	5f                   	pop    %edi
  101851:	5d                   	pop    %ebp
  101852:	c3                   	ret    
  uint off, inum;
  struct buf *bp;
  struct dirent *de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
  101853:	c7 04 24 53 60 10 00 	movl   $0x106053,(%esp)
  10185a:	e8 c1 f0 ff ff       	call   100920 <panic>
  10185f:	90                   	nop

00101860 <ialloc>:
}

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101860:	55                   	push   %ebp
  101861:	89 e5                	mov    %esp,%ebp
  101863:	57                   	push   %edi
  101864:	56                   	push   %esi
  101865:	53                   	push   %ebx
  101866:	83 ec 3c             	sub    $0x3c,%esp
  101869:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  10186d:	8d 55 dc             	lea    -0x24(%ebp),%edx
}

// Allocate a new inode with the given type on device dev.
struct inode*
ialloc(uint dev, short type)
{
  101870:	66 89 45 d6          	mov    %ax,-0x2a(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  101874:	8b 45 08             	mov    0x8(%ebp),%eax
  101877:	e8 e4 f9 ff ff       	call   101260 <readsb>
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10187c:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  101880:	0f 86 96 00 00 00    	jbe    10191c <ialloc+0xbc>
  101886:	be 01 00 00 00       	mov    $0x1,%esi
  10188b:	bb 01 00 00 00       	mov    $0x1,%ebx
  101890:	eb 18                	jmp    1018aa <ialloc+0x4a>
  101892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101898:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  10189b:	89 3c 24             	mov    %edi,(%esp)
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  10189e:	89 de                	mov    %ebx,%esi
      dip->type = type;
      bwrite(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  1018a0:	e8 5b e7 ff ff       	call   100000 <brelse>
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
  for(inum = 1; inum < sb.ninodes; inum++){  // loop over inode blocks
  1018a5:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
  1018a8:	73 72                	jae    10191c <ialloc+0xbc>
    bp = bread(dev, IBLOCK(inum));
  1018aa:	89 f0                	mov    %esi,%eax
  1018ac:	c1 e8 03             	shr    $0x3,%eax
  1018af:	83 c0 02             	add    $0x2,%eax
  1018b2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1018b6:	8b 45 08             	mov    0x8(%ebp),%eax
  1018b9:	89 04 24             	mov    %eax,(%esp)
  1018bc:	e8 ef e7 ff ff       	call   1000b0 <bread>
  1018c1:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
  1018c3:	89 f0                	mov    %esi,%eax
  1018c5:	83 e0 07             	and    $0x7,%eax
  1018c8:	c1 e0 06             	shl    $0x6,%eax
  1018cb:	8d 54 07 18          	lea    0x18(%edi,%eax,1),%edx
    if(dip->type == 0){  // a free inode
  1018cf:	66 83 3a 00          	cmpw   $0x0,(%edx)
  1018d3:	75 c3                	jne    101898 <ialloc+0x38>
      memset(dip, 0, sizeof(*dip));
  1018d5:	89 14 24             	mov    %edx,(%esp)
  1018d8:	89 55 d0             	mov    %edx,-0x30(%ebp)
  1018db:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
  1018e2:	00 
  1018e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1018ea:	00 
  1018eb:	e8 10 27 00 00       	call   104000 <memset>
      dip->type = type;
  1018f0:	8b 55 d0             	mov    -0x30(%ebp),%edx
  1018f3:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  1018f7:	66 89 02             	mov    %ax,(%edx)
      bwrite(bp);   // mark it allocated on the disk
  1018fa:	89 3c 24             	mov    %edi,(%esp)
  1018fd:	e8 7e e7 ff ff       	call   100080 <bwrite>
      brelse(bp);
  101902:	89 3c 24             	mov    %edi,(%esp)
  101905:	e8 f6 e6 ff ff       	call   100000 <brelse>
      return iget(dev, inum);
  10190a:	8b 45 08             	mov    0x8(%ebp),%eax
  10190d:	89 f2                	mov    %esi,%edx
  10190f:	e8 8c f8 ff ff       	call   1011a0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
  101914:	83 c4 3c             	add    $0x3c,%esp
  101917:	5b                   	pop    %ebx
  101918:	5e                   	pop    %esi
  101919:	5f                   	pop    %edi
  10191a:	5d                   	pop    %ebp
  10191b:	c3                   	ret    
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
  10191c:	c7 04 24 65 60 10 00 	movl   $0x106065,(%esp)
  101923:	e8 f8 ef ff ff       	call   100920 <panic>
  101928:	90                   	nop
  101929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00101930 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
  101930:	55                   	push   %ebp
  101931:	89 e5                	mov    %esp,%ebp
  101933:	57                   	push   %edi
  101934:	56                   	push   %esi
  101935:	89 c6                	mov    %eax,%esi
  101937:	53                   	push   %ebx
  101938:	89 d3                	mov    %edx,%ebx
  10193a:	83 ec 2c             	sub    $0x2c,%esp
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  10193d:	89 54 24 04          	mov    %edx,0x4(%esp)
  101941:	89 04 24             	mov    %eax,(%esp)
  101944:	e8 67 e7 ff ff       	call   1000b0 <bread>
  memset(bp->data, 0, BSIZE);
  101949:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  101950:	00 
  101951:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  101958:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;
  
  bp = bread(dev, bno);
  101959:	89 c7                	mov    %eax,%edi
  memset(bp->data, 0, BSIZE);
  10195b:	8d 40 18             	lea    0x18(%eax),%eax
  10195e:	89 04 24             	mov    %eax,(%esp)
  101961:	e8 9a 26 00 00       	call   104000 <memset>
  bwrite(bp);
  101966:	89 3c 24             	mov    %edi,(%esp)
  101969:	e8 12 e7 ff ff       	call   100080 <bwrite>
  brelse(bp);
  10196e:	89 3c 24             	mov    %edi,(%esp)
  101971:	e8 8a e6 ff ff       	call   100000 <brelse>
  struct superblock sb;
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  101976:	89 f0                	mov    %esi,%eax
  101978:	8d 55 dc             	lea    -0x24(%ebp),%edx
  10197b:	e8 e0 f8 ff ff       	call   101260 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101980:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101983:	89 da                	mov    %ebx,%edx
  101985:	c1 ea 0c             	shr    $0xc,%edx
  101988:	89 34 24             	mov    %esi,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  10198b:	be 01 00 00 00       	mov    $0x1,%esi
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  101990:	c1 e8 03             	shr    $0x3,%eax
  101993:	8d 44 10 03          	lea    0x3(%eax,%edx,1),%eax
  101997:	89 44 24 04          	mov    %eax,0x4(%esp)
  10199b:	e8 10 e7 ff ff       	call   1000b0 <bread>
  bi = b % BPB;
  1019a0:	89 da                	mov    %ebx,%edx
  m = 1 << (bi % 8);
  1019a2:	89 d9                	mov    %ebx,%ecx

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  1019a4:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  m = 1 << (bi % 8);
  1019aa:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
  1019ad:	c1 fa 03             	sar    $0x3,%edx
  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  1019b0:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
  1019b2:	0f b6 4c 10 18       	movzbl 0x18(%eax,%edx,1),%ecx
  int bi, m;

  bzero(dev, b);

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  1019b7:	89 c7                	mov    %eax,%edi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
  1019b9:	0f b6 c1             	movzbl %cl,%eax
  1019bc:	85 f0                	test   %esi,%eax
  1019be:	74 22                	je     1019e2 <bfree+0xb2>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;  // Mark block free on disk.
  1019c0:	89 f0                	mov    %esi,%eax
  1019c2:	f7 d0                	not    %eax
  1019c4:	21 c8                	and    %ecx,%eax
  1019c6:	88 44 17 18          	mov    %al,0x18(%edi,%edx,1)
  bwrite(bp);
  1019ca:	89 3c 24             	mov    %edi,(%esp)
  1019cd:	e8 ae e6 ff ff       	call   100080 <bwrite>
  brelse(bp);
  1019d2:	89 3c 24             	mov    %edi,(%esp)
  1019d5:	e8 26 e6 ff ff       	call   100000 <brelse>
}
  1019da:	83 c4 2c             	add    $0x2c,%esp
  1019dd:	5b                   	pop    %ebx
  1019de:	5e                   	pop    %esi
  1019df:	5f                   	pop    %edi
  1019e0:	5d                   	pop    %ebp
  1019e1:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb.ninodes));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  1019e2:	c7 04 24 77 60 10 00 	movl   $0x106077,(%esp)
  1019e9:	e8 32 ef ff ff       	call   100920 <panic>
  1019ee:	66 90                	xchg   %ax,%ax

001019f0 <iput>:
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
{
  1019f0:	55                   	push   %ebp
  1019f1:	89 e5                	mov    %esp,%ebp
  1019f3:	57                   	push   %edi
  1019f4:	56                   	push   %esi
  1019f5:	53                   	push   %ebx
  1019f6:	83 ec 2c             	sub    $0x2c,%esp
  1019f9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
  1019fc:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101a03:	e8 88 25 00 00       	call   103f90 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
  101a08:	8b 46 08             	mov    0x8(%esi),%eax
  101a0b:	83 f8 01             	cmp    $0x1,%eax
  101a0e:	0f 85 9e 00 00 00    	jne    101ab2 <iput+0xc2>
  101a14:	8b 56 0c             	mov    0xc(%esi),%edx
  101a17:	f6 c2 02             	test   $0x2,%dl
  101a1a:	0f 84 92 00 00 00    	je     101ab2 <iput+0xc2>
  101a20:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  101a25:	0f 85 87 00 00 00    	jne    101ab2 <iput+0xc2>
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
  101a2b:	f6 c2 01             	test   $0x1,%dl
  101a2e:	66 90                	xchg   %ax,%ax
  101a30:	0f 85 ef 00 00 00    	jne    101b25 <iput+0x135>
      panic("iput busy");
    ip->flags |= I_BUSY;
  101a36:	83 ca 01             	or     $0x1,%edx
    release(&icache.lock);
  101a39:	89 f3                	mov    %esi,%ebx
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
  101a3b:	89 56 0c             	mov    %edx,0xc(%esi)
  release(&icache.lock);
}

// Caller holds reference to unlocked ip.  Drop reference.
void
iput(struct inode *ip)
  101a3e:	8d 7e 30             	lea    0x30(%esi),%edi
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
  101a41:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101a48:	e8 03 25 00 00       	call   103f50 <release>
  101a4d:	eb 08                	jmp    101a57 <iput+0x67>
  101a4f:	90                   	nop
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
  101a50:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  101a53:	39 fb                	cmp    %edi,%ebx
  101a55:	74 1c                	je     101a73 <iput+0x83>
    if(ip->addrs[i]){
  101a57:	8b 53 1c             	mov    0x1c(%ebx),%edx
  101a5a:	85 d2                	test   %edx,%edx
  101a5c:	74 f2                	je     101a50 <iput+0x60>
      bfree(ip->dev, ip->addrs[i]);
  101a5e:	8b 06                	mov    (%esi),%eax
  101a60:	e8 cb fe ff ff       	call   101930 <bfree>
      ip->addrs[i] = 0;
  101a65:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
  101a6c:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
  101a6f:	39 fb                	cmp    %edi,%ebx
  101a71:	75 e4                	jne    101a57 <iput+0x67>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
  101a73:	8b 46 4c             	mov    0x4c(%esi),%eax
  101a76:	85 c0                	test   %eax,%eax
  101a78:	75 56                	jne    101ad0 <iput+0xe0>
    }
    brelse(bp);
    ip->addrs[INDIRECT] = 0;
  }

  ip->size = 0;
  101a7a:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
  101a81:	89 34 24             	mov    %esi,(%esp)
  101a84:	e8 e7 fa ff ff       	call   101570 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
  101a89:	66 c7 46 10 00 00    	movw   $0x0,0x10(%esi)
    iupdate(ip);
  101a8f:	89 34 24             	mov    %esi,(%esp)
  101a92:	e8 d9 fa ff ff       	call   101570 <iupdate>
    acquire(&icache.lock);
  101a97:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101a9e:	e8 ed 24 00 00       	call   103f90 <acquire>
    ip->flags &= ~I_BUSY;
  101aa3:	83 66 0c fe          	andl   $0xfffffffe,0xc(%esi)
    wakeup(ip);
  101aa7:	89 34 24             	mov    %esi,(%esp)
  101aaa:	e8 51 18 00 00       	call   103300 <wakeup>
  101aaf:	8b 46 08             	mov    0x8(%esi),%eax
  }
  ip->ref--;
  101ab2:	83 e8 01             	sub    $0x1,%eax
  101ab5:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
  101ab8:	c7 45 08 80 9a 10 00 	movl   $0x109a80,0x8(%ebp)
}
  101abf:	83 c4 2c             	add    $0x2c,%esp
  101ac2:	5b                   	pop    %ebx
  101ac3:	5e                   	pop    %esi
  101ac4:	5f                   	pop    %edi
  101ac5:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags &= ~I_BUSY;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
  101ac6:	e9 85 24 00 00       	jmp    103f50 <release>
  101acb:	90                   	nop
  101acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  101ad0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ad4:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
  101ad6:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  101ad8:	89 04 24             	mov    %eax,(%esp)
  101adb:	e8 d0 e5 ff ff       	call   1000b0 <bread>
    a = (uint*)bp->data;
  101ae0:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[INDIRECT]){
    bp = bread(ip->dev, ip->addrs[INDIRECT]);
  101ae2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
  101ae5:	83 c7 18             	add    $0x18,%edi
  101ae8:	31 c0                	xor    %eax,%eax
  101aea:	eb 11                	jmp    101afd <iput+0x10d>
  101aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(j = 0; j < NINDIRECT; j++){
  101af0:	83 c3 01             	add    $0x1,%ebx
  101af3:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
  101af9:	89 d8                	mov    %ebx,%eax
  101afb:	74 10                	je     101b0d <iput+0x11d>
      if(a[j])
  101afd:	8b 14 87             	mov    (%edi,%eax,4),%edx
  101b00:	85 d2                	test   %edx,%edx
  101b02:	74 ec                	je     101af0 <iput+0x100>
        bfree(ip->dev, a[j]);
  101b04:	8b 06                	mov    (%esi),%eax
  101b06:	e8 25 fe ff ff       	call   101930 <bfree>
  101b0b:	eb e3                	jmp    101af0 <iput+0x100>
    }
    brelse(bp);
  101b0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101b10:	89 04 24             	mov    %eax,(%esp)
  101b13:	e8 e8 e4 ff ff       	call   100000 <brelse>
    ip->addrs[INDIRECT] = 0;
  101b18:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  101b1f:	90                   	nop
  101b20:	e9 55 ff ff ff       	jmp    101a7a <iput+0x8a>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode is no longer used: truncate and free inode.
    if(ip->flags & I_BUSY)
      panic("iput busy");
  101b25:	c7 04 24 8a 60 10 00 	movl   $0x10608a,(%esp)
  101b2c:	e8 ef ed ff ff       	call   100920 <panic>
  101b31:	eb 0d                	jmp    101b40 <dirlink>
  101b33:	90                   	nop
  101b34:	90                   	nop
  101b35:	90                   	nop
  101b36:	90                   	nop
  101b37:	90                   	nop
  101b38:	90                   	nop
  101b39:	90                   	nop
  101b3a:	90                   	nop
  101b3b:	90                   	nop
  101b3c:	90                   	nop
  101b3d:	90                   	nop
  101b3e:	90                   	nop
  101b3f:	90                   	nop

00101b40 <dirlink>:
}

// Write a new directory entry (name, ino) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint ino)
{
  101b40:	55                   	push   %ebp
  101b41:	89 e5                	mov    %esp,%ebp
  101b43:	57                   	push   %edi
  101b44:	56                   	push   %esi
  101b45:	53                   	push   %ebx
  101b46:	83 ec 2c             	sub    $0x2c,%esp
  101b49:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
  101b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  101b4f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101b56:	00 
  101b57:	89 34 24             	mov    %esi,(%esp)
  101b5a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b5e:	e8 fd fb ff ff       	call   101760 <dirlookup>
  101b63:	85 c0                	test   %eax,%eax
  101b65:	0f 85 89 00 00 00    	jne    101bf4 <dirlink+0xb4>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101b6b:	8b 7e 18             	mov    0x18(%esi),%edi
  101b6e:	85 ff                	test   %edi,%edi
  101b70:	0f 84 8d 00 00 00    	je     101c03 <dirlink+0xc3>
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
    return -1;
  101b76:	8d 7d d8             	lea    -0x28(%ebp),%edi
  101b79:	31 db                	xor    %ebx,%ebx
  101b7b:	eb 0b                	jmp    101b88 <dirlink+0x48>
  101b7d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101b80:	83 c3 10             	add    $0x10,%ebx
  101b83:	39 5e 18             	cmp    %ebx,0x18(%esi)
  101b86:	76 24                	jbe    101bac <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101b88:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101b8f:	00 
  101b90:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101b94:	89 7c 24 04          	mov    %edi,0x4(%esp)
  101b98:	89 34 24             	mov    %esi,(%esp)
  101b9b:	e8 c0 f8 ff ff       	call   101460 <readi>
  101ba0:	83 f8 10             	cmp    $0x10,%eax
  101ba3:	75 65                	jne    101c0a <dirlink+0xca>
      panic("dirlink read");
    if(de.inum == 0)
  101ba5:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
  101baa:	75 d4                	jne    101b80 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  101bac:	8b 45 0c             	mov    0xc(%ebp),%eax
  101baf:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101bb6:	00 
  101bb7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bbb:	8d 45 da             	lea    -0x26(%ebp),%eax
  101bbe:	89 04 24             	mov    %eax,(%esp)
  101bc1:	e8 8a 25 00 00       	call   104150 <strncpy>
  de.inum = ino;
  101bc6:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101bc9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  101bd0:	00 
  101bd1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  101bd5:	89 7c 24 04          	mov    %edi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  101bd9:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  101bdd:	89 34 24             	mov    %esi,(%esp)
  101be0:	e8 1b fa ff ff       	call   101600 <writei>
  101be5:	83 f8 10             	cmp    $0x10,%eax
  101be8:	75 2c                	jne    101c16 <dirlink+0xd6>
    panic("dirlink");
  101bea:	31 c0                	xor    %eax,%eax
  
  return 0;
}
  101bec:	83 c4 2c             	add    $0x2c,%esp
  101bef:	5b                   	pop    %ebx
  101bf0:	5e                   	pop    %esi
  101bf1:	5f                   	pop    %edi
  101bf2:	5d                   	pop    %ebp
  101bf3:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
  101bf4:	89 04 24             	mov    %eax,(%esp)
  101bf7:	e8 f4 fd ff ff       	call   1019f0 <iput>
  101bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  101c01:	eb e9                	jmp    101bec <dirlink+0xac>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
  101c03:	8d 7d d8             	lea    -0x28(%ebp),%edi
  101c06:	31 db                	xor    %ebx,%ebx
  101c08:	eb a2                	jmp    101bac <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
  101c0a:	c7 04 24 94 60 10 00 	movl   $0x106094,(%esp)
  101c11:	e8 0a ed ff ff       	call   100920 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = ino;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
  101c16:	c7 04 24 a1 60 10 00 	movl   $0x1060a1,(%esp)
  101c1d:	e8 fe ec ff ff       	call   100920 <panic>
  101c22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  101c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101c30 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  101c30:	55                   	push   %ebp
  101c31:	89 e5                	mov    %esp,%ebp
  101c33:	53                   	push   %ebx
  101c34:	83 ec 14             	sub    $0x14,%esp
  101c37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
  101c3a:	85 db                	test   %ebx,%ebx
  101c3c:	74 36                	je     101c74 <iunlock+0x44>
  101c3e:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
  101c42:	74 30                	je     101c74 <iunlock+0x44>
  101c44:	8b 43 08             	mov    0x8(%ebx),%eax
  101c47:	85 c0                	test   %eax,%eax
  101c49:	7e 29                	jle    101c74 <iunlock+0x44>
    panic("iunlock");

  acquire(&icache.lock);
  101c4b:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101c52:	e8 39 23 00 00       	call   103f90 <acquire>
  ip->flags &= ~I_BUSY;
  101c57:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
  101c5b:	89 1c 24             	mov    %ebx,(%esp)
  101c5e:	e8 9d 16 00 00       	call   103300 <wakeup>
  release(&icache.lock);
  101c63:	c7 45 08 80 9a 10 00 	movl   $0x109a80,0x8(%ebp)
}
  101c6a:	83 c4 14             	add    $0x14,%esp
  101c6d:	5b                   	pop    %ebx
  101c6e:	5d                   	pop    %ebp
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
  101c6f:	e9 dc 22 00 00       	jmp    103f50 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
  101c74:	c7 04 24 a9 60 10 00 	movl   $0x1060a9,(%esp)
  101c7b:	e8 a0 ec ff ff       	call   100920 <panic>

00101c80 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  101c80:	55                   	push   %ebp
  101c81:	89 e5                	mov    %esp,%ebp
  101c83:	53                   	push   %ebx
  101c84:	83 ec 14             	sub    $0x14,%esp
  101c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
  101c8a:	89 1c 24             	mov    %ebx,(%esp)
  101c8d:	e8 9e ff ff ff       	call   101c30 <iunlock>
  iput(ip);
  101c92:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  101c95:	83 c4 14             	add    $0x14,%esp
  101c98:	5b                   	pop    %ebx
  101c99:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
  101c9a:	e9 51 fd ff ff       	jmp    1019f0 <iput>
  101c9f:	90                   	nop

00101ca0 <ilock>:
}

// Lock the given inode.
void
ilock(struct inode *ip)
{
  101ca0:	55                   	push   %ebp
  101ca1:	89 e5                	mov    %esp,%ebp
  101ca3:	56                   	push   %esi
  101ca4:	53                   	push   %ebx
  101ca5:	83 ec 10             	sub    $0x10,%esp
  101ca8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
  101cab:	85 db                	test   %ebx,%ebx
  101cad:	0f 84 e5 00 00 00    	je     101d98 <ilock+0xf8>
  101cb3:	8b 53 08             	mov    0x8(%ebx),%edx
  101cb6:	85 d2                	test   %edx,%edx
  101cb8:	0f 8e da 00 00 00    	jle    101d98 <ilock+0xf8>
    panic("ilock");

  acquire(&icache.lock);
  101cbe:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101cc5:	e8 c6 22 00 00       	call   103f90 <acquire>
  while(ip->flags & I_BUSY)
  101cca:	8b 43 0c             	mov    0xc(%ebx),%eax
  101ccd:	a8 01                	test   $0x1,%al
  101ccf:	74 1e                	je     101cef <ilock+0x4f>
  101cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  101cd8:	c7 44 24 04 80 9a 10 	movl   $0x109a80,0x4(%esp)
  101cdf:	00 
  101ce0:	89 1c 24             	mov    %ebx,(%esp)
  101ce3:	e8 f8 18 00 00       	call   1035e0 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
  101ce8:	8b 43 0c             	mov    0xc(%ebx),%eax
  101ceb:	a8 01                	test   $0x1,%al
  101ced:	75 e9                	jne    101cd8 <ilock+0x38>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  101cef:	83 c8 01             	or     $0x1,%eax
  101cf2:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
  101cf5:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101cfc:	e8 4f 22 00 00       	call   103f50 <release>

  if(!(ip->flags & I_VALID)){
  101d01:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
  101d05:	74 09                	je     101d10 <ilock+0x70>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
  101d07:	83 c4 10             	add    $0x10,%esp
  101d0a:	5b                   	pop    %ebx
  101d0b:	5e                   	pop    %esi
  101d0c:	5d                   	pop    %ebp
  101d0d:	c3                   	ret    
  101d0e:	66 90                	xchg   %ax,%ax
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum));
  101d10:	8b 43 04             	mov    0x4(%ebx),%eax
  101d13:	c1 e8 03             	shr    $0x3,%eax
  101d16:	83 c0 02             	add    $0x2,%eax
  101d19:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d1d:	8b 03                	mov    (%ebx),%eax
  101d1f:	89 04 24             	mov    %eax,(%esp)
  101d22:	e8 89 e3 ff ff       	call   1000b0 <bread>
  101d27:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
  101d29:	8b 43 04             	mov    0x4(%ebx),%eax
  101d2c:	83 e0 07             	and    $0x7,%eax
  101d2f:	c1 e0 06             	shl    $0x6,%eax
  101d32:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
  101d36:	0f b7 10             	movzwl (%eax),%edx
  101d39:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
  101d3d:	0f b7 50 02          	movzwl 0x2(%eax),%edx
  101d41:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
  101d45:	0f b7 50 04          	movzwl 0x4(%eax),%edx
  101d49:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
  101d4d:	0f b7 50 06          	movzwl 0x6(%eax),%edx
  101d51:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
  101d55:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101d58:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
  101d5b:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
  101d5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d62:	8d 43 1c             	lea    0x1c(%ebx),%eax
  101d65:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
  101d6c:	00 
  101d6d:	89 04 24             	mov    %eax,(%esp)
  101d70:	e8 1b 23 00 00       	call   104090 <memmove>
    brelse(bp);
  101d75:	89 34 24             	mov    %esi,(%esp)
  101d78:	e8 83 e2 ff ff       	call   100000 <brelse>
    ip->flags |= I_VALID;
  101d7d:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
  101d81:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
  101d86:	0f 85 7b ff ff ff    	jne    101d07 <ilock+0x67>
      panic("ilock: no type");
  101d8c:	c7 04 24 b7 60 10 00 	movl   $0x1060b7,(%esp)
  101d93:	e8 88 eb ff ff       	call   100920 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
  101d98:	c7 04 24 b1 60 10 00 	movl   $0x1060b1,(%esp)
  101d9f:	e8 7c eb ff ff       	call   100920 <panic>
  101da4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  101daa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00101db0 <_namei>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
_namei(char *path, int parent, char *name)
{
  101db0:	55                   	push   %ebp
  101db1:	89 e5                	mov    %esp,%ebp
  101db3:	57                   	push   %edi
  101db4:	56                   	push   %esi
  101db5:	53                   	push   %ebx
  101db6:	89 c3                	mov    %eax,%ebx
  101db8:	83 ec 2c             	sub    $0x2c,%esp
  101dbb:	89 55 e0             	mov    %edx,-0x20(%ebp)
  101dbe:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
  101dc1:	80 38 2f             	cmpb   $0x2f,(%eax)
  101dc4:	0f 84 3b 01 00 00    	je     101f05 <_namei+0x155>
    ip = iget(ROOTDEV, 1);
  else
    ip = idup(cp->cwd);
  101dca:	e8 b1 15 00 00       	call   103380 <curproc>
  101dcf:	8b 40 60             	mov    0x60(%eax),%eax
  101dd2:	89 04 24             	mov    %eax,(%esp)
  101dd5:	e8 96 f3 ff ff       	call   101170 <idup>
  101dda:	89 c7                	mov    %eax,%edi
  101ddc:	eb 05                	jmp    101de3 <_namei+0x33>
  101dde:	66 90                	xchg   %ax,%ax
{
  char *s;
  int len;

  while(*path == '/')
    path++;
  101de0:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
  101de3:	0f b6 03             	movzbl (%ebx),%eax
  101de6:	3c 2f                	cmp    $0x2f,%al
  101de8:	74 f6                	je     101de0 <_namei+0x30>
    path++;
  if(*path == 0)
  101dea:	84 c0                	test   %al,%al
  101dec:	75 1a                	jne    101e08 <_namei+0x58>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
  101dee:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  101df1:	85 c9                	test   %ecx,%ecx
  101df3:	0f 85 34 01 00 00    	jne    101f2d <_namei+0x17d>
    iput(ip);
    return 0;
  }
  return ip;
}
  101df9:	83 c4 2c             	add    $0x2c,%esp
  101dfc:	89 f8                	mov    %edi,%eax
  101dfe:	5b                   	pop    %ebx
  101dff:	5e                   	pop    %esi
  101e00:	5f                   	pop    %edi
  101e01:	5d                   	pop    %ebp
  101e02:	c3                   	ret    
  101e03:	90                   	nop
  101e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101e08:	3c 2f                	cmp    $0x2f,%al
  101e0a:	0f 84 db 00 00 00    	je     101eeb <_namei+0x13b>
  101e10:	89 de                	mov    %ebx,%esi
    path++;
  101e12:	83 c6 01             	add    $0x1,%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101e15:	0f b6 06             	movzbl (%esi),%eax
  101e18:	84 c0                	test   %al,%al
  101e1a:	0f 85 90 00 00 00    	jne    101eb0 <_namei+0x100>
  101e20:	89 f2                	mov    %esi,%edx
  101e22:	29 da                	sub    %ebx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
  101e24:	83 fa 0d             	cmp    $0xd,%edx
  101e27:	0f 8e 99 00 00 00    	jle    101ec6 <_namei+0x116>
  101e2d:	8d 76 00             	lea    0x0(%esi),%esi
    memmove(name, s, DIRSIZ);
  101e30:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
  101e37:	00 
  101e38:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101e3c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101e3f:	89 04 24             	mov    %eax,(%esp)
  101e42:	e8 49 22 00 00       	call   104090 <memmove>
  101e47:	eb 0a                	jmp    101e53 <_namei+0xa3>
  101e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
    path++;
  101e50:	83 c6 01             	add    $0x1,%esi
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
  101e53:	80 3e 2f             	cmpb   $0x2f,(%esi)
  101e56:	74 f8                	je     101e50 <_namei+0xa0>
  if(*path == '/')
    ip = iget(ROOTDEV, 1);
  else
    ip = idup(cp->cwd);

  while((path = skipelem(path, name)) != 0){
  101e58:	85 f6                	test   %esi,%esi
  101e5a:	74 92                	je     101dee <_namei+0x3e>
    ilock(ip);
  101e5c:	89 3c 24             	mov    %edi,(%esp)
  101e5f:	e8 3c fe ff ff       	call   101ca0 <ilock>
    if(ip->type != T_DIR){
  101e64:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
  101e69:	0f 85 82 00 00 00    	jne    101ef1 <_namei+0x141>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
  101e6f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  101e72:	85 db                	test   %ebx,%ebx
  101e74:	74 09                	je     101e7f <_namei+0xcf>
  101e76:	80 3e 00             	cmpb   $0x0,(%esi)
  101e79:	0f 84 9c 00 00 00    	je     101f1b <_namei+0x16b>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
  101e7f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  101e86:	00 
  101e87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101e8a:	89 3c 24             	mov    %edi,(%esp)
  101e8d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e91:	e8 ca f8 ff ff       	call   101760 <dirlookup>
  101e96:	85 c0                	test   %eax,%eax
  101e98:	89 c3                	mov    %eax,%ebx
  101e9a:	74 55                	je     101ef1 <_namei+0x141>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
  101e9c:	89 3c 24             	mov    %edi,(%esp)
  101e9f:	89 df                	mov    %ebx,%edi
  101ea1:	89 f3                	mov    %esi,%ebx
  101ea3:	e8 d8 fd ff ff       	call   101c80 <iunlockput>
  101ea8:	e9 36 ff ff ff       	jmp    101de3 <_namei+0x33>
  101ead:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
  101eb0:	3c 2f                	cmp    $0x2f,%al
  101eb2:	0f 85 5a ff ff ff    	jne    101e12 <_namei+0x62>
  101eb8:	89 f2                	mov    %esi,%edx
  101eba:	29 da                	sub    %ebx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
  101ebc:	83 fa 0d             	cmp    $0xd,%edx
  101ebf:	90                   	nop
  101ec0:	0f 8f 6a ff ff ff    	jg     101e30 <_namei+0x80>
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
  101ec6:	89 54 24 08          	mov    %edx,0x8(%esp)
  101eca:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  101ece:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101ed1:	89 04 24             	mov    %eax,(%esp)
  101ed4:	89 55 dc             	mov    %edx,-0x24(%ebp)
  101ed7:	e8 b4 21 00 00       	call   104090 <memmove>
    name[len] = 0;
  101edc:	8b 55 dc             	mov    -0x24(%ebp),%edx
  101edf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101ee2:	c6 04 10 00          	movb   $0x0,(%eax,%edx,1)
  101ee6:	e9 68 ff ff ff       	jmp    101e53 <_namei+0xa3>
  }
  while(*path == '/')
  101eeb:	89 de                	mov    %ebx,%esi
  101eed:	31 d2                	xor    %edx,%edx
  101eef:	eb d5                	jmp    101ec6 <_namei+0x116>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
  101ef1:	89 3c 24             	mov    %edi,(%esp)
  101ef4:	31 ff                	xor    %edi,%edi
  101ef6:	e8 85 fd ff ff       	call   101c80 <iunlockput>
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101efb:	83 c4 2c             	add    $0x2c,%esp
  101efe:	89 f8                	mov    %edi,%eax
  101f00:	5b                   	pop    %ebx
  101f01:	5e                   	pop    %esi
  101f02:	5f                   	pop    %edi
  101f03:	5d                   	pop    %ebp
  101f04:	c3                   	ret    
_namei(char *path, int parent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, 1);
  101f05:	ba 01 00 00 00       	mov    $0x1,%edx
  101f0a:	b8 01 00 00 00       	mov    $0x1,%eax
  101f0f:	e8 8c f2 ff ff       	call   1011a0 <iget>
  101f14:	89 c7                	mov    %eax,%edi
  101f16:	e9 c8 fe ff ff       	jmp    101de3 <_namei+0x33>
      iunlockput(ip);
      return 0;
    }
    if(parent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
  101f1b:	89 3c 24             	mov    %edi,(%esp)
  101f1e:	e8 0d fd ff ff       	call   101c30 <iunlock>
  if(parent){
    iput(ip);
    return 0;
  }
  return ip;
}
  101f23:	83 c4 2c             	add    $0x2c,%esp
  101f26:	89 f8                	mov    %edi,%eax
  101f28:	5b                   	pop    %ebx
  101f29:	5e                   	pop    %esi
  101f2a:	5f                   	pop    %edi
  101f2b:	5d                   	pop    %ebp
  101f2c:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(parent){
    iput(ip);
  101f2d:	89 3c 24             	mov    %edi,(%esp)
  101f30:	31 ff                	xor    %edi,%edi
  101f32:	e8 b9 fa ff ff       	call   1019f0 <iput>
    return 0;
  101f37:	e9 bd fe ff ff       	jmp    101df9 <_namei+0x49>
  101f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00101f40 <nameiparent>:
  return _namei(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101f40:	55                   	push   %ebp
  return _namei(path, 1, name);
  101f41:	ba 01 00 00 00       	mov    $0x1,%edx
  return _namei(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
  101f46:	89 e5                	mov    %esp,%ebp
  101f48:	83 ec 08             	sub    $0x8,%esp
  return _namei(path, 1, name);
  101f4b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  101f4e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  101f51:	c9                   	leave  
}

struct inode*
nameiparent(char *path, char *name)
{
  return _namei(path, 1, name);
  101f52:	e9 59 fe ff ff       	jmp    101db0 <_namei>
  101f57:	89 f6                	mov    %esi,%esi
  101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101f60 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
  101f60:	55                   	push   %ebp
  char name[DIRSIZ];
  return _namei(path, 0, name);
  101f61:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
  101f63:	89 e5                	mov    %esp,%ebp
  101f65:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return _namei(path, 0, name);
  101f68:	8b 45 08             	mov    0x8(%ebp),%eax
  101f6b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
  101f6e:	e8 3d fe ff ff       	call   101db0 <_namei>
}
  101f73:	c9                   	leave  
  101f74:	c3                   	ret    
  101f75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  101f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00101f80 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
  101f80:	55                   	push   %ebp
  101f81:	89 e5                	mov    %esp,%ebp
  101f83:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache.lock");
  101f86:	c7 44 24 04 c6 60 10 	movl   $0x1060c6,0x4(%esp)
  101f8d:	00 
  101f8e:	c7 04 24 80 9a 10 00 	movl   $0x109a80,(%esp)
  101f95:	e8 36 1e 00 00       	call   103dd0 <initlock>
}
  101f9a:	c9                   	leave  
  101f9b:	c3                   	ret    
  101f9c:	90                   	nop
  101f9d:	90                   	nop
  101f9e:	90                   	nop
  101f9f:	90                   	nop

00101fa0 <getticks>:
#include "defs.h"
//#include "user.h"

int ticks;

int getticks(){
  101fa0:	55                   	push   %ebp
  int i = ticks;
  return i;
}
  101fa1:	a1 54 aa 10 00       	mov    0x10aa54,%eax
#include "defs.h"
//#include "user.h"

int ticks;

int getticks(){
  101fa6:	89 e5                	mov    %esp,%ebp
  int i = ticks;
  return i;
}
  101fa8:	5d                   	pop    %ebp
  101fa9:	c3                   	ret    
  101faa:	90                   	nop
  101fab:	90                   	nop
  101fac:	90                   	nop
  101fad:	90                   	nop
  101fae:	90                   	nop
  101faf:	90                   	nop

00101fb0 <ide_start_request>:
}

// Start the request for b.  Caller must hold ide_lock.
static void
ide_start_request(struct buf *b)
{
  101fb0:	55                   	push   %ebp
  101fb1:	89 c1                	mov    %eax,%ecx
  101fb3:	89 e5                	mov    %esp,%ebp
  101fb5:	56                   	push   %esi
  101fb6:	83 ec 14             	sub    $0x14,%esp
  if(b == 0)
  101fb9:	85 c0                	test   %eax,%eax
  101fbb:	0f 84 89 00 00 00    	je     10204a <ide_start_request+0x9a>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  101fc1:	ba f7 01 00 00       	mov    $0x1f7,%edx
  101fc6:	66 90                	xchg   %ax,%ax
  101fc8:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  101fc9:	0f b6 c0             	movzbl %al,%eax
  101fcc:	84 c0                	test   %al,%al
  101fce:	78 f8                	js     101fc8 <ide_start_request+0x18>
  101fd0:	a8 40                	test   $0x40,%al
  101fd2:	74 f4                	je     101fc8 <ide_start_request+0x18>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  101fd4:	ba f6 03 00 00       	mov    $0x3f6,%edx
  101fd9:	31 c0                	xor    %eax,%eax
  101fdb:	ee                   	out    %al,(%dx)
  101fdc:	ba f2 01 00 00       	mov    $0x1f2,%edx
  101fe1:	b8 01 00 00 00       	mov    $0x1,%eax
  101fe6:	ee                   	out    %al,(%dx)
    panic("ide_start_request");

  ide_wait_ready(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, 1);  // number of sectors
  outb(0x1f3, b->sector & 0xff);
  101fe7:	8b 71 08             	mov    0x8(%ecx),%esi
  101fea:	b2 f3                	mov    $0xf3,%dl
  101fec:	89 f0                	mov    %esi,%eax
  101fee:	ee                   	out    %al,(%dx)
  101fef:	89 f0                	mov    %esi,%eax
  101ff1:	b2 f4                	mov    $0xf4,%dl
  101ff3:	c1 e8 08             	shr    $0x8,%eax
  101ff6:	ee                   	out    %al,(%dx)
  101ff7:	89 f0                	mov    %esi,%eax
  101ff9:	b2 f5                	mov    $0xf5,%dl
  101ffb:	c1 e8 10             	shr    $0x10,%eax
  101ffe:	ee                   	out    %al,(%dx)
  101fff:	8b 41 04             	mov    0x4(%ecx),%eax
  102002:	c1 ee 18             	shr    $0x18,%esi
  102005:	b2 f6                	mov    $0xf6,%dl
  102007:	83 e6 0f             	and    $0xf,%esi
  10200a:	83 e0 01             	and    $0x1,%eax
  10200d:	c1 e0 04             	shl    $0x4,%eax
  102010:	09 f0                	or     %esi,%eax
  102012:	83 c8 e0             	or     $0xffffffe0,%eax
  102015:	ee                   	out    %al,(%dx)
  outb(0x1f4, (b->sector >> 8) & 0xff);
  outb(0x1f5, (b->sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
  102016:	f6 01 04             	testb  $0x4,(%ecx)
  102019:	75 11                	jne    10202c <ide_start_request+0x7c>
  10201b:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102020:	b8 20 00 00 00       	mov    $0x20,%eax
  102025:	ee                   	out    %al,(%dx)
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
  102026:	83 c4 14             	add    $0x14,%esp
  102029:	5e                   	pop    %esi
  10202a:	5d                   	pop    %ebp
  10202b:	c3                   	ret    
  10202c:	b2 f7                	mov    $0xf7,%dl
  10202e:	b8 30 00 00 00       	mov    $0x30,%eax
  102033:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\toutsl"    :
  102034:	ba f0 01 00 00       	mov    $0x1f0,%edx
  102039:	8d 71 18             	lea    0x18(%ecx),%esi
  10203c:	b9 80 00 00 00       	mov    $0x80,%ecx
  102041:	fc                   	cld    
  102042:	f2 6f                	repnz outsl %ds:(%esi),(%dx)
  102044:	83 c4 14             	add    $0x14,%esp
  102047:	5e                   	pop    %esi
  102048:	5d                   	pop    %ebp
  102049:	c3                   	ret    
// Start the request for b.  Caller must hold ide_lock.
static void
ide_start_request(struct buf *b)
{
  if(b == 0)
    panic("ide_start_request");
  10204a:	c7 04 24 d2 60 10 00 	movl   $0x1060d2,(%esp)
  102051:	e8 ca e8 ff ff       	call   100920 <panic>
  102056:	8d 76 00             	lea    0x0(%esi),%esi
  102059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102060 <ide_rw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
ide_rw(struct buf *b)
{
  102060:	55                   	push   %ebp
  102061:	89 e5                	mov    %esp,%ebp
  102063:	53                   	push   %ebx
  102064:	83 ec 14             	sub    $0x14,%esp
  102067:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
  10206a:	8b 03                	mov    (%ebx),%eax
  10206c:	a8 01                	test   $0x1,%al
  10206e:	0f 84 90 00 00 00    	je     102104 <ide_rw+0xa4>
    panic("ide_rw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
  102074:	83 e0 06             	and    $0x6,%eax
  102077:	83 f8 02             	cmp    $0x2,%eax
  10207a:	0f 84 9c 00 00 00    	je     10211c <ide_rw+0xbc>
    panic("ide_rw: nothing to do");
  if(b->dev != 0 && !disk_1_present)
  102080:	8b 53 04             	mov    0x4(%ebx),%edx
  102083:	85 d2                	test   %edx,%edx
  102085:	74 0d                	je     102094 <ide_rw+0x34>
  102087:	a1 38 78 10 00       	mov    0x107838,%eax
  10208c:	85 c0                	test   %eax,%eax
  10208e:	0f 84 7c 00 00 00    	je     102110 <ide_rw+0xb0>
    panic("ide disk 1 not present");

  acquire(&ide_lock);
  102094:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  10209b:	e8 f0 1e 00 00       	call   103f90 <acquire>

  // Append b to ide_queue.
  b->qnext = 0;
  1020a0:	a1 34 78 10 00       	mov    0x107834,%eax
  for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
  1020a5:	ba 34 78 10 00       	mov    $0x107834,%edx
    panic("ide disk 1 not present");

  acquire(&ide_lock);

  // Append b to ide_queue.
  b->qnext = 0;
  1020aa:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
  1020b1:	85 c0                	test   %eax,%eax
  1020b3:	74 0d                	je     1020c2 <ide_rw+0x62>
  1020b5:	8d 76 00             	lea    0x0(%esi),%esi
  1020b8:	8d 50 14             	lea    0x14(%eax),%edx
  1020bb:	8b 40 14             	mov    0x14(%eax),%eax
  1020be:	85 c0                	test   %eax,%eax
  1020c0:	75 f6                	jne    1020b8 <ide_rw+0x58>
    ;
  *pp = b;
  1020c2:	89 1a                	mov    %ebx,(%edx)
  
  // Start disk if necessary.
  if(ide_queue == b)
  1020c4:	39 1d 34 78 10 00    	cmp    %ebx,0x107834
  1020ca:	75 14                	jne    1020e0 <ide_rw+0x80>
  1020cc:	eb 2d                	jmp    1020fb <ide_rw+0x9b>
  1020ce:	66 90                	xchg   %ax,%ax
    ide_start_request(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &ide_lock);
  1020d0:	c7 44 24 04 00 78 10 	movl   $0x107800,0x4(%esp)
  1020d7:	00 
  1020d8:	89 1c 24             	mov    %ebx,(%esp)
  1020db:	e8 00 15 00 00       	call   1035e0 <sleep>
  if(ide_queue == b)
    ide_start_request(b);
  
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
  1020e0:	8b 03                	mov    (%ebx),%eax
  1020e2:	83 e0 06             	and    $0x6,%eax
  1020e5:	83 f8 02             	cmp    $0x2,%eax
  1020e8:	75 e6                	jne    1020d0 <ide_rw+0x70>
    sleep(b, &ide_lock);

  release(&ide_lock);
  1020ea:	c7 45 08 00 78 10 00 	movl   $0x107800,0x8(%ebp)
}
  1020f1:	83 c4 14             	add    $0x14,%esp
  1020f4:	5b                   	pop    %ebx
  1020f5:	5d                   	pop    %ebp
  // Wait for request to finish.
  // Assuming will not sleep too long: ignore cp->killed.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
    sleep(b, &ide_lock);

  release(&ide_lock);
  1020f6:	e9 55 1e 00 00       	jmp    103f50 <release>
    ;
  *pp = b;
  
  // Start disk if necessary.
  if(ide_queue == b)
    ide_start_request(b);
  1020fb:	89 d8                	mov    %ebx,%eax
  1020fd:	e8 ae fe ff ff       	call   101fb0 <ide_start_request>
  102102:	eb dc                	jmp    1020e0 <ide_rw+0x80>
ide_rw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("ide_rw: buf not busy");
  102104:	c7 04 24 e4 60 10 00 	movl   $0x1060e4,(%esp)
  10210b:	e8 10 e8 ff ff       	call   100920 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("ide_rw: nothing to do");
  if(b->dev != 0 && !disk_1_present)
    panic("ide disk 1 not present");
  102110:	c7 04 24 0f 61 10 00 	movl   $0x10610f,(%esp)
  102117:	e8 04 e8 ff ff       	call   100920 <panic>
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("ide_rw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("ide_rw: nothing to do");
  10211c:	c7 04 24 f9 60 10 00 	movl   $0x1060f9,(%esp)
  102123:	e8 f8 e7 ff ff       	call   100920 <panic>
  102128:	90                   	nop
  102129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102130 <ide_intr>:
}

// Interrupt handler.
void
ide_intr(void)
{
  102130:	55                   	push   %ebp
  102131:	89 e5                	mov    %esp,%ebp
  102133:	57                   	push   %edi
  102134:	53                   	push   %ebx
  102135:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  acquire(&ide_lock);
  102138:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  10213f:	e8 4c 1e 00 00       	call   103f90 <acquire>
  if((b = ide_queue) == 0){
  102144:	8b 1d 34 78 10 00    	mov    0x107834,%ebx
  10214a:	85 db                	test   %ebx,%ebx
  10214c:	74 28                	je     102176 <ide_intr+0x46>
    release(&ide_lock);
    return;
  }

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && ide_wait_ready(1) >= 0)
  10214e:	8b 0b                	mov    (%ebx),%ecx
  102150:	f6 c1 04             	test   $0x4,%cl
  102153:	74 3b                	je     102190 <ide_intr+0x60>
    insl(0x1f0, b->data, 512/4);
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
  102155:	83 c9 02             	or     $0x2,%ecx
  102158:	83 e1 fb             	and    $0xfffffffb,%ecx
  10215b:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
  10215d:	89 1c 24             	mov    %ebx,(%esp)
  102160:	e8 9b 11 00 00       	call   103300 <wakeup>
  
  // Start disk on next buf in queue.
  if((ide_queue = b->qnext) != 0)
  102165:	8b 43 14             	mov    0x14(%ebx),%eax
  102168:	85 c0                	test   %eax,%eax
  10216a:	a3 34 78 10 00       	mov    %eax,0x107834
  10216f:	74 05                	je     102176 <ide_intr+0x46>
    ide_start_request(ide_queue);
  102171:	e8 3a fe ff ff       	call   101fb0 <ide_start_request>

  release(&ide_lock);
  102176:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  10217d:	e8 ce 1d 00 00       	call   103f50 <release>
}
  102182:	83 c4 10             	add    $0x10,%esp
  102185:	5b                   	pop    %ebx
  102186:	5f                   	pop    %edi
  102187:	5d                   	pop    %ebp
  102188:	c3                   	ret    
  102189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102190:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102195:	8d 76 00             	lea    0x0(%esi),%esi
  102198:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  102199:	0f b6 c0             	movzbl %al,%eax
  10219c:	84 c0                	test   %al,%al
  10219e:	78 f8                	js     102198 <ide_intr+0x68>
  1021a0:	a8 40                	test   $0x40,%al
  1021a2:	74 f4                	je     102198 <ide_intr+0x68>
    ;
  if(check_error && (r & (IDE_DF|IDE_ERR)) != 0)
  1021a4:	a8 21                	test   $0x21,%al
  1021a6:	75 ad                	jne    102155 <ide_intr+0x25>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\tinsl"     :
  1021a8:	8d 7b 18             	lea    0x18(%ebx),%edi
  1021ab:	b9 80 00 00 00       	mov    $0x80,%ecx
  1021b0:	ba f0 01 00 00       	mov    $0x1f0,%edx
  1021b5:	fc                   	cld    
  1021b6:	f2 6d                	repnz insl (%dx),%es:(%edi)
  1021b8:	8b 0b                	mov    (%ebx),%ecx
  1021ba:	eb 99                	jmp    102155 <ide_intr+0x25>
  1021bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001021c0 <ide_init>:
  return 0;
}

void
ide_init(void)
{
  1021c0:	55                   	push   %ebp
  1021c1:	89 e5                	mov    %esp,%ebp
  1021c3:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&ide_lock, "ide");
  1021c6:	c7 44 24 04 26 61 10 	movl   $0x106126,0x4(%esp)
  1021cd:	00 
  1021ce:	c7 04 24 00 78 10 00 	movl   $0x107800,(%esp)
  1021d5:	e8 f6 1b 00 00       	call   103dd0 <initlock>
  pic_enable(IRQ_IDE);
  1021da:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  1021e1:	e8 7a 0b 00 00       	call   102d60 <pic_enable>
  ioapic_enable(IRQ_IDE, ncpu - 1);
  1021e6:	a1 20 b1 10 00       	mov    0x10b120,%eax
  1021eb:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
  1021f2:	83 e8 01             	sub    $0x1,%eax
  1021f5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1021f9:	e8 52 00 00 00       	call   102250 <ioapic_enable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  1021fe:	ba f7 01 00 00       	mov    $0x1f7,%edx
  102203:	90                   	nop
  102204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102208:	ec                   	in     (%dx),%al
static int
ide_wait_ready(int check_error)
{
  int r;

  while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
  102209:	0f b6 c0             	movzbl %al,%eax
  10220c:	84 c0                	test   %al,%al
  10220e:	78 f8                	js     102208 <ide_init+0x48>
  102210:	a8 40                	test   $0x40,%al
  102212:	74 f4                	je     102208 <ide_init+0x48>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102214:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102219:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
  10221e:	ee                   	out    %al,(%dx)
  10221f:	31 c9                	xor    %ecx,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102221:	b2 f7                	mov    $0xf7,%dl
  102223:	eb 0e                	jmp    102233 <ide_init+0x73>
  102225:	8d 76 00             	lea    0x0(%esi),%esi
  ioapic_enable(IRQ_IDE, ncpu - 1);
  ide_wait_ready(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
  102228:	83 c1 01             	add    $0x1,%ecx
  10222b:	81 f9 e8 03 00 00    	cmp    $0x3e8,%ecx
  102231:	74 0f                	je     102242 <ide_init+0x82>
  102233:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
  102234:	84 c0                	test   %al,%al
  102236:	74 f0                	je     102228 <ide_init+0x68>
      disk_1_present = 1;
  102238:	c7 05 38 78 10 00 01 	movl   $0x1,0x107838
  10223f:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102242:	ba f6 01 00 00       	mov    $0x1f6,%edx
  102247:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
  10224c:	ee                   	out    %al,(%dx)
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
  10224d:	c9                   	leave  
  10224e:	c3                   	ret    
  10224f:	90                   	nop

00102250 <ioapic_enable>:
}

void
ioapic_enable(int irq, int cpunum)
{
  if(!ismp)
  102250:	8b 15 a0 aa 10 00    	mov    0x10aaa0,%edx
  }
}

void
ioapic_enable(int irq, int cpunum)
{
  102256:	55                   	push   %ebp
  102257:	89 e5                	mov    %esp,%ebp
  102259:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
  10225c:	85 d2                	test   %edx,%edx
  10225e:	74 1f                	je     10227f <ioapic_enable+0x2f>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  102260:	8d 48 20             	lea    0x20(%eax),%ecx
  102263:	8d 54 00 10          	lea    0x10(%eax,%eax,1),%edx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  102267:	a1 58 aa 10 00       	mov    0x10aa58,%eax
  10226c:	89 10                	mov    %edx,(%eax)
  10226e:	83 c2 01             	add    $0x1,%edx
  ioapic->data = data;
  102271:	89 48 10             	mov    %ecx,0x10(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  102274:	8b 4d 0c             	mov    0xc(%ebp),%ecx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  102277:	89 10                	mov    %edx,(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
  102279:	c1 e1 18             	shl    $0x18,%ecx

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
  10227c:	89 48 10             	mov    %ecx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
  ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
}
  10227f:	5d                   	pop    %ebp
  102280:	c3                   	ret    
  102281:	eb 0d                	jmp    102290 <ioapic_init>
  102283:	90                   	nop
  102284:	90                   	nop
  102285:	90                   	nop
  102286:	90                   	nop
  102287:	90                   	nop
  102288:	90                   	nop
  102289:	90                   	nop
  10228a:	90                   	nop
  10228b:	90                   	nop
  10228c:	90                   	nop
  10228d:	90                   	nop
  10228e:	90                   	nop
  10228f:	90                   	nop

00102290 <ioapic_init>:
  ioapic->data = data;
}

void
ioapic_init(void)
{
  102290:	55                   	push   %ebp
  102291:	89 e5                	mov    %esp,%ebp
  102293:	56                   	push   %esi
  102294:	53                   	push   %ebx
  102295:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  if(!ismp)
  102298:	8b 0d a0 aa 10 00    	mov    0x10aaa0,%ecx
  10229e:	85 c9                	test   %ecx,%ecx
  1022a0:	0f 84 86 00 00 00    	je     10232c <ioapic_init+0x9c>
};

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  1022a6:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
  1022ad:	00 00 00 
  return ioapic->data;
  1022b0:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  1022b6:	b8 00 00 c0 fe       	mov    $0xfec00000,%eax
};

static uint
ioapic_read(int reg)
{
  ioapic->reg = reg;
  1022bb:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
  1022c2:	00 00 00 
  return ioapic->data;
  1022c5:	8b 15 10 00 c0 fe    	mov    0xfec00010,%edx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  1022cb:	0f b6 0d a4 aa 10 00 	movzbl 0x10aaa4,%ecx
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  1022d2:	c7 05 58 aa 10 00 00 	movl   $0xfec00000,0x10aa58
  1022d9:	00 c0 fe 
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  1022dc:	c1 ee 10             	shr    $0x10,%esi
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  1022df:	c1 ea 18             	shr    $0x18,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
  1022e2:	81 e6 ff 00 00 00    	and    $0xff,%esi
  id = ioapic_read(REG_ID) >> 24;
  if(id != ioapic_id)
  1022e8:	39 d1                	cmp    %edx,%ecx
  1022ea:	74 11                	je     1022fd <ioapic_init+0x6d>
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");
  1022ec:	c7 04 24 2c 61 10 00 	movl   $0x10612c,(%esp)
  1022f3:	e8 88 e4 ff ff       	call   100780 <cprintf>
  1022f8:	a1 58 aa 10 00       	mov    0x10aa58,%eax
  1022fd:	b9 10 00 00 00       	mov    $0x10,%ecx
  102302:	31 d2                	xor    %edx,%edx
  102304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
  102308:	8d 5a 20             	lea    0x20(%edx),%ebx
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10230b:	83 c2 01             	add    $0x1,%edx
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
  10230e:	81 cb 00 00 01 00    	or     $0x10000,%ebx
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  102314:	89 08                	mov    %ecx,(%eax)
  ioapic->data = data;
  102316:	89 58 10             	mov    %ebx,0x10(%eax)
  102319:	8d 59 01             	lea    0x1(%ecx),%ebx
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10231c:	83 c1 02             	add    $0x2,%ecx
  10231f:	39 d6                	cmp    %edx,%esi
}

static void
ioapic_write(int reg, uint data)
{
  ioapic->reg = reg;
  102321:	89 18                	mov    %ebx,(%eax)
  ioapic->data = data;
  102323:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
  if(id != ioapic_id)
    cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
  10232a:	7d dc                	jge    102308 <ioapic_init+0x78>
    ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
    ioapic_write(REG_TABLE+2*i+1, 0);
  }
}
  10232c:	83 c4 10             	add    $0x10,%esp
  10232f:	5b                   	pop    %ebx
  102330:	5e                   	pop    %esi
  102331:	5d                   	pop    %ebp
  102332:	c3                   	ret    
  102333:	90                   	nop
  102334:	90                   	nop
  102335:	90                   	nop
  102336:	90                   	nop
  102337:	90                   	nop
  102338:	90                   	nop
  102339:	90                   	nop
  10233a:	90                   	nop
  10233b:	90                   	nop
  10233c:	90                   	nop
  10233d:	90                   	nop
  10233e:	90                   	nop
  10233f:	90                   	nop

00102340 <kalloc>:
// Allocate n bytes of physical memory.
// Returns a kernel-segment pointer.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(int n)
{
  102340:	55                   	push   %ebp
  102341:	89 e5                	mov    %esp,%ebp
  102343:	56                   	push   %esi
  102344:	53                   	push   %ebx
  102345:	83 ec 10             	sub    $0x10,%esp
  102348:	8b 75 08             	mov    0x8(%ebp),%esi
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
  10234b:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
  102351:	74 0d                	je     102360 <kalloc+0x20>
    panic("kalloc");
  102353:	c7 04 24 60 61 10 00 	movl   $0x106160,(%esp)
  10235a:	e8 c1 e5 ff ff       	call   100920 <panic>
  10235f:	90                   	nop
kalloc(int n)
{
  char *p;
  struct run *r, **rp;

  if(n % PAGE || n <= 0)
  102360:	85 f6                	test   %esi,%esi
  102362:	7e ef                	jle    102353 <kalloc+0x13>
    panic("kalloc");

  acquire(&kalloc_lock);
  102364:	c7 04 24 60 aa 10 00 	movl   $0x10aa60,(%esp)
  10236b:	e8 20 1c 00 00       	call   103f90 <acquire>
  102370:	8b 1d 94 aa 10 00    	mov    0x10aa94,%ebx
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  102376:	85 db                	test   %ebx,%ebx
  102378:	74 3e                	je     1023b8 <kalloc+0x78>
    if(r->len == n){
  10237a:	8b 43 04             	mov    0x4(%ebx),%eax
  10237d:	ba 94 aa 10 00       	mov    $0x10aa94,%edx
  102382:	39 f0                	cmp    %esi,%eax
  102384:	75 11                	jne    102397 <kalloc+0x57>
  102386:	eb 58                	jmp    1023e0 <kalloc+0xa0>

  if(n % PAGE || n <= 0)
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
  102388:	89 da                	mov    %ebx,%edx
  10238a:	8b 1b                	mov    (%ebx),%ebx
  10238c:	85 db                	test   %ebx,%ebx
  10238e:	74 28                	je     1023b8 <kalloc+0x78>
    if(r->len == n){
  102390:	8b 43 04             	mov    0x4(%ebx),%eax
  102393:	39 f0                	cmp    %esi,%eax
  102395:	74 49                	je     1023e0 <kalloc+0xa0>
      *rp = r->next;
      release(&kalloc_lock);
      return (char*)r;
    }
    if(r->len > n){
  102397:	39 c6                	cmp    %eax,%esi
  102399:	7d ed                	jge    102388 <kalloc+0x48>
      r->len -= n;
  10239b:	29 f0                	sub    %esi,%eax
  10239d:	89 43 04             	mov    %eax,0x4(%ebx)
      p = (char*)r + r->len;
  1023a0:	01 c3                	add    %eax,%ebx
      release(&kalloc_lock);
  1023a2:	c7 04 24 60 aa 10 00 	movl   $0x10aa60,(%esp)
  1023a9:	e8 a2 1b 00 00       	call   103f50 <release>
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  1023ae:	83 c4 10             	add    $0x10,%esp
  1023b1:	89 d8                	mov    %ebx,%eax
  1023b3:	5b                   	pop    %ebx
  1023b4:	5e                   	pop    %esi
  1023b5:	5d                   	pop    %ebp
  1023b6:	c3                   	ret    
  1023b7:	90                   	nop
      return p;
    }
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  1023b8:	31 db                	xor    %ebx,%ebx
      p = (char*)r + r->len;
      release(&kalloc_lock);
      return p;
    }
  }
  release(&kalloc_lock);
  1023ba:	c7 04 24 60 aa 10 00 	movl   $0x10aa60,(%esp)
  1023c1:	e8 8a 1b 00 00       	call   103f50 <release>

  cprintf("kalloc: out of memory\n");
  1023c6:	c7 04 24 67 61 10 00 	movl   $0x106167,(%esp)
  1023cd:	e8 ae e3 ff ff       	call   100780 <cprintf>
  return 0;
}
  1023d2:	83 c4 10             	add    $0x10,%esp
  1023d5:	89 d8                	mov    %ebx,%eax
  1023d7:	5b                   	pop    %ebx
  1023d8:	5e                   	pop    %esi
  1023d9:	5d                   	pop    %ebp
  1023da:	c3                   	ret    
  1023db:	90                   	nop
  1023dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("kalloc");

  acquire(&kalloc_lock);
  for(rp=&freelist; (r=*rp) != 0; rp=&r->next){
    if(r->len == n){
      *rp = r->next;
  1023e0:	8b 03                	mov    (%ebx),%eax
  1023e2:	89 02                	mov    %eax,(%edx)
      release(&kalloc_lock);
  1023e4:	c7 04 24 60 aa 10 00 	movl   $0x10aa60,(%esp)
  1023eb:	e8 60 1b 00 00       	call   103f50 <release>
  }
  release(&kalloc_lock);

  cprintf("kalloc: out of memory\n");
  return 0;
}
  1023f0:	83 c4 10             	add    $0x10,%esp
  1023f3:	89 d8                	mov    %ebx,%eax
  1023f5:	5b                   	pop    %ebx
  1023f6:	5e                   	pop    %esi
  1023f7:	5d                   	pop    %ebp
  1023f8:	c3                   	ret    
  1023f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102400 <kfree>:
// which normally should have been returned by a
// call to kalloc(len).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int len)
{
  102400:	55                   	push   %ebp
  102401:	89 e5                	mov    %esp,%ebp
  102403:	57                   	push   %edi
  102404:	56                   	push   %esi
  102405:	53                   	push   %ebx
  102406:	83 ec 2c             	sub    $0x2c,%esp
  102409:	8b 45 0c             	mov    0xc(%ebp),%eax
  10240c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
  10240f:	85 c0                	test   %eax,%eax
// which normally should have been returned by a
// call to kalloc(len).  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v, int len)
{
  102411:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
  102414:	0f 8e e9 00 00 00    	jle    102503 <kfree+0x103>
  10241a:	a9 ff 0f 00 00       	test   $0xfff,%eax
  10241f:	0f 85 de 00 00 00    	jne    102503 <kfree+0x103>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, len);
  102425:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102428:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10242f:	00 
  102430:	89 1c 24             	mov    %ebx,(%esp)
  102433:	89 54 24 08          	mov    %edx,0x8(%esp)
  102437:	e8 c4 1b 00 00       	call   104000 <memset>

  acquire(&kalloc_lock);
  10243c:	c7 04 24 60 aa 10 00 	movl   $0x10aa60,(%esp)
  102443:	e8 48 1b 00 00       	call   103f90 <acquire>
  p = (struct run*)v;
  102448:	a1 94 aa 10 00       	mov    0x10aa94,%eax
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  10244d:	85 c0                	test   %eax,%eax
  10244f:	74 61                	je     1024b2 <kfree+0xb2>
  // Fill with junk to catch dangling refs.
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  102451:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102454:	8d 0c 13             	lea    (%ebx,%edx,1),%ecx
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  102457:	39 c1                	cmp    %eax,%ecx
  102459:	72 57                	jb     1024b2 <kfree+0xb2>
    rend = (struct run*)((char*)r + r->len);
  10245b:	8b 70 04             	mov    0x4(%eax),%esi
  10245e:	8d 14 30             	lea    (%eax,%esi,1),%edx
    if(r <= p && p < rend)
  102461:	39 d3                	cmp    %edx,%ebx
  102463:	72 73                	jb     1024d8 <kfree+0xd8>
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  102465:	39 c1                	cmp    %eax,%ecx
  102467:	0f 84 8f 00 00 00    	je     1024fc <kfree+0xfc>
  10246d:	8d 76 00             	lea    0x0(%esi),%esi
      p->len = len + r->len;
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
  102470:	39 da                	cmp    %ebx,%edx
  102472:	74 6c                	je     1024e0 <kfree+0xe0>
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  102474:	89 c7                	mov    %eax,%edi
  102476:	8b 00                	mov    (%eax),%eax
  102478:	85 c0                	test   %eax,%eax
  10247a:	74 3c                	je     1024b8 <kfree+0xb8>
  10247c:	39 c1                	cmp    %eax,%ecx
  10247e:	72 38                	jb     1024b8 <kfree+0xb8>
    rend = (struct run*)((char*)r + r->len);
  102480:	8b 70 04             	mov    0x4(%eax),%esi
  102483:	8d 14 30             	lea    (%eax,%esi,1),%edx
    if(r <= p && p < rend)
  102486:	39 d3                	cmp    %edx,%ebx
  102488:	73 16                	jae    1024a0 <kfree+0xa0>
  10248a:	39 c3                	cmp    %eax,%ebx
  10248c:	72 12                	jb     1024a0 <kfree+0xa0>
      panic("freeing free page");
  10248e:	c7 04 24 84 61 10 00 	movl   $0x106184,(%esp)
  102495:	e8 86 e4 ff ff       	call   100920 <panic>
  10249a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pend == r){  // p next to r: replace r with p
  1024a0:	39 c1                	cmp    %eax,%ecx
  1024a2:	75 cc                	jne    102470 <kfree+0x70>
      p->len = len + r->len;
      p->next = r->next;
  1024a4:	8b 01                	mov    (%ecx),%eax
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->len = len + r->len;
  1024a6:	03 75 e4             	add    -0x1c(%ebp),%esi
      p->next = r->next;
  1024a9:	89 03                	mov    %eax,(%ebx)
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
      p->len = len + r->len;
  1024ab:	89 73 04             	mov    %esi,0x4(%ebx)
      p->next = r->next;
      *rp = p;
  1024ae:	89 1f                	mov    %ebx,(%edi)
      goto out;
  1024b0:	eb 10                	jmp    1024c2 <kfree+0xc2>
  memset(v, 1, len);

  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
  1024b2:	bf 94 aa 10 00       	mov    $0x10aa94,%edi
  1024b7:	90                   	nop
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->len = len;
  1024b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  p->next = r;
  1024bb:	89 03                	mov    %eax,(%ebx)
  *rp = p;
  1024bd:	89 1f                	mov    %ebx,(%edi)
      }
      goto out;
    }
  }
  // Insert p before r in list.
  p->len = len;
  1024bf:	89 53 04             	mov    %edx,0x4(%ebx)
  p->next = r;
  *rp = p;

 out:
  release(&kalloc_lock);
  1024c2:	c7 45 08 60 aa 10 00 	movl   $0x10aa60,0x8(%ebp)
}
  1024c9:	83 c4 2c             	add    $0x2c,%esp
  1024cc:	5b                   	pop    %ebx
  1024cd:	5e                   	pop    %esi
  1024ce:	5f                   	pop    %edi
  1024cf:	5d                   	pop    %ebp
  p->len = len;
  p->next = r;
  *rp = p;

 out:
  release(&kalloc_lock);
  1024d0:	e9 7b 1a 00 00       	jmp    103f50 <release>
  1024d5:	8d 76 00             	lea    0x0(%esi),%esi
  acquire(&kalloc_lock);
  p = (struct run*)v;
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
  1024d8:	39 c3                	cmp    %eax,%ebx
  1024da:	73 b2                	jae    10248e <kfree+0x8e>
  1024dc:	eb 87                	jmp    102465 <kfree+0x65>
  1024de:	66 90                	xchg   %ax,%ax
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
  1024e0:	8b 10                	mov    (%eax),%edx
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
  1024e2:	03 75 e4             	add    -0x1c(%ebp),%esi
      if(r->next && r->next == pend){  // r now next to r->next?
  1024e5:	85 d2                	test   %edx,%edx
      p->next = r->next;
      *rp = p;
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
  1024e7:	89 70 04             	mov    %esi,0x4(%eax)
      if(r->next && r->next == pend){  // r now next to r->next?
  1024ea:	74 d6                	je     1024c2 <kfree+0xc2>
  1024ec:	39 d1                	cmp    %edx,%ecx
  1024ee:	75 d2                	jne    1024c2 <kfree+0xc2>
        r->len += r->next->len;
        r->next = r->next->next;
  1024f0:	8b 11                	mov    (%ecx),%edx
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
        r->len += r->next->len;
  1024f2:	03 71 04             	add    0x4(%ecx),%esi
        r->next = r->next->next;
  1024f5:	89 10                	mov    %edx,(%eax)
      goto out;
    }
    if(rend == p){  // r next to p: replace p with r
      r->len += len;
      if(r->next && r->next == pend){  // r now next to r->next?
        r->len += r->next->len;
  1024f7:	89 70 04             	mov    %esi,0x4(%eax)
  1024fa:	eb c6                	jmp    1024c2 <kfree+0xc2>
  pend = (struct run*)(v + len);
  for(rp=&freelist; (r=*rp) != 0 && r <= pend; rp=&r->next){
    rend = (struct run*)((char*)r + r->len);
    if(r <= p && p < rend)
      panic("freeing free page");
    if(pend == r){  // p next to r: replace r with p
  1024fc:	bf 94 aa 10 00       	mov    $0x10aa94,%edi
  102501:	eb a1                	jmp    1024a4 <kfree+0xa4>
kfree(char *v, int len)
{
  struct run *r, *rend, **rp, *p, *pend;

  if(len <= 0 || len % PAGE)
    panic("kfree");
  102503:	c7 04 24 7e 61 10 00 	movl   $0x10617e,(%esp)
  10250a:	e8 11 e4 ff ff       	call   100920 <panic>
  10250f:	90                   	nop

00102510 <kinit>:
// This code cheats by just considering one megabyte of
// pages after _end.  Real systems would determine the
// amount of memory available in the system and use it all.
void
kinit(void)
{
  102510:	55                   	push   %ebp
  102511:	89 e5                	mov    %esp,%ebp
  102513:	83 ec 18             	sub    $0x18,%esp
  extern int end;
  uint mem;
  char *start;

  initlock(&kalloc_lock, "kalloc");
  102516:	c7 44 24 04 60 61 10 	movl   $0x106160,0x4(%esp)
  10251d:	00 
  10251e:	c7 04 24 60 aa 10 00 	movl   $0x10aa60,(%esp)
  102525:	e8 a6 18 00 00       	call   103dd0 <initlock>
  start = (char*) &end;
  start = (char*) (((uint)start + PAGE) & ~(PAGE-1));
  mem = 256; // assume computer has 256 pages of RAM
  cprintf("mem = %d\n", mem * PAGE);
  10252a:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  102531:	00 
  102532:	c7 04 24 96 61 10 00 	movl   $0x106196,(%esp)
  102539:	e8 42 e2 ff ff       	call   100780 <cprintf>
  kfree(start, mem * PAGE);
  10253e:	b8 c0 ef 10 00       	mov    $0x10efc0,%eax
  102543:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  102548:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10254f:	00 
  102550:	89 04 24             	mov    %eax,(%esp)
  102553:	e8 a8 fe ff ff       	call   102400 <kfree>
}
  102558:	c9                   	leave  
  102559:	c3                   	ret    
  10255a:	90                   	nop
  10255b:	90                   	nop
  10255c:	90                   	nop
  10255d:	90                   	nop
  10255e:	90                   	nop
  10255f:	90                   	nop

00102560 <kbd_getc>:
#include "defs.h"
#include "kbd.h"

int
kbd_getc(void)
{
  102560:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102561:	ba 64 00 00 00       	mov    $0x64,%edx
  102566:	89 e5                	mov    %esp,%ebp
  102568:	ec                   	in     (%dx),%al
  102569:	89 c2                	mov    %eax,%edx
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
  10256b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102570:	83 e2 01             	and    $0x1,%edx
  102573:	74 3e                	je     1025b3 <kbd_getc+0x53>
  102575:	ba 60 00 00 00       	mov    $0x60,%edx
  10257a:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
  10257b:	0f b6 c0             	movzbl %al,%eax

  if(data == 0xE0){
  10257e:	3d e0 00 00 00       	cmp    $0xe0,%eax
  102583:	0f 84 7f 00 00 00    	je     102608 <kbd_getc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
  102589:	84 c0                	test   %al,%al
  10258b:	79 2b                	jns    1025b8 <kbd_getc+0x58>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
  10258d:	8b 15 3c 78 10 00    	mov    0x10783c,%edx
  102593:	f6 c2 40             	test   $0x40,%dl
  102596:	75 03                	jne    10259b <kbd_getc+0x3b>
  102598:	83 e0 7f             	and    $0x7f,%eax
    shift &= ~(shiftcode[data] | E0ESC);
  10259b:	0f b6 80 a0 61 10 00 	movzbl 0x1061a0(%eax),%eax
  1025a2:	83 c8 40             	or     $0x40,%eax
  1025a5:	0f b6 c0             	movzbl %al,%eax
  1025a8:	f7 d0                	not    %eax
  1025aa:	21 d0                	and    %edx,%eax
  1025ac:	a3 3c 78 10 00       	mov    %eax,0x10783c
  1025b1:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  1025b3:	5d                   	pop    %ebp
  1025b4:	c3                   	ret    
  1025b5:	8d 76 00             	lea    0x0(%esi),%esi
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
  1025b8:	8b 0d 3c 78 10 00    	mov    0x10783c,%ecx
  1025be:	f6 c1 40             	test   $0x40,%cl
  1025c1:	74 05                	je     1025c8 <kbd_getc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
  1025c3:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
  1025c5:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1025c8:	0f b6 90 a0 61 10 00 	movzbl 0x1061a0(%eax),%edx
  1025cf:	09 ca                	or     %ecx,%edx
  1025d1:	0f b6 88 a0 62 10 00 	movzbl 0x1062a0(%eax),%ecx
  1025d8:	31 ca                	xor    %ecx,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
  1025da:	89 d1                	mov    %edx,%ecx
  1025dc:	83 e1 03             	and    $0x3,%ecx
  1025df:	8b 0c 8d a0 63 10 00 	mov    0x1063a0(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  1025e6:	89 15 3c 78 10 00    	mov    %edx,0x10783c
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
  1025ec:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  1025ef:	0f b6 04 01          	movzbl (%ecx,%eax,1),%eax
  if(shift & CAPSLOCK){
  1025f3:	74 be                	je     1025b3 <kbd_getc+0x53>
    if('a' <= c && c <= 'z')
  1025f5:	8d 50 9f             	lea    -0x61(%eax),%edx
  1025f8:	83 fa 19             	cmp    $0x19,%edx
  1025fb:	77 1b                	ja     102618 <kbd_getc+0xb8>
      c += 'A' - 'a';
  1025fd:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102600:	5d                   	pop    %ebp
  102601:	c3                   	ret    
  102602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
  102608:	30 c0                	xor    %al,%al
  10260a:	83 0d 3c 78 10 00 40 	orl    $0x40,0x10783c
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
  102611:	5d                   	pop    %ebp
  102612:	c3                   	ret    
  102613:	90                   	nop
  102614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
  102618:	8d 50 bf             	lea    -0x41(%eax),%edx
  10261b:	83 fa 19             	cmp    $0x19,%edx
  10261e:	77 93                	ja     1025b3 <kbd_getc+0x53>
      c += 'a' - 'A';
  102620:	83 c0 20             	add    $0x20,%eax
  }
  return c;
}
  102623:	5d                   	pop    %ebp
  102624:	c3                   	ret    
  102625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102630 <kbd_intr>:

void
kbd_intr(void)
{
  102630:	55                   	push   %ebp
  102631:	89 e5                	mov    %esp,%ebp
  102633:	83 ec 18             	sub    $0x18,%esp
  console_intr(kbd_getc);
  102636:	c7 04 24 60 25 10 00 	movl   $0x102560,(%esp)
  10263d:	e8 be de ff ff       	call   100500 <console_intr>
}
  102642:	c9                   	leave  
  102643:	c3                   	ret    
  102644:	90                   	nop
  102645:	90                   	nop
  102646:	90                   	nop
  102647:	90                   	nop
  102648:	90                   	nop
  102649:	90                   	nop
  10264a:	90                   	nop
  10264b:	90                   	nop
  10264c:	90                   	nop
  10264d:	90                   	nop
  10264e:	90                   	nop
  10264f:	90                   	nop

00102650 <lapic_init>:
}

void
lapic_init(int c)
{
  if(!lapic) 
  102650:	a1 98 aa 10 00       	mov    0x10aa98,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapic_init(int c)
{
  102655:	55                   	push   %ebp
  102656:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
  102658:	85 c0                	test   %eax,%eax
  10265a:	0f 84 c4 00 00 00    	je     102724 <lapic_init+0xd4>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102660:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
  102667:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10266a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10266d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
  102674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102677:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10267a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
  102681:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
  102684:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102687:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
  10268e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
  102691:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102694:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
  10269b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  10269e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
  1026a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  1026ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
  1026ae:	8b 50 30             	mov    0x30(%eax),%edx
  1026b1:	c1 ea 10             	shr    $0x10,%edx
  1026b4:	80 fa 03             	cmp    $0x3,%dl
  1026b7:	77 6f                	ja     102728 <lapic_init+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
  1026c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026c3:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026c6:	8d 88 00 03 00 00    	lea    0x300(%eax),%ecx
  1026cc:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1026d3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026d6:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026d9:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
  1026e0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026e3:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026e6:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1026ed:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026f0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1026f3:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
  1026fa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  1026fd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102700:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
  102707:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
  10270a:	8b 50 20             	mov    0x20(%eax),%edx
  10270d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
  102710:	8b 11                	mov    (%ecx),%edx
  102712:	80 e6 10             	and    $0x10,%dh
  102715:	75 f9                	jne    102710 <lapic_init+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102717:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
  10271e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102721:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
  102724:	5d                   	pop    %ebp
  102725:	c3                   	ret    
  102726:	66 90                	xchg   %ax,%ax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102728:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
  10272f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
  102732:	8b 50 20             	mov    0x20(%eax),%edx
  102735:	eb 82                	jmp    1026b9 <lapic_init+0x69>
  102737:	89 f6                	mov    %esi,%esi
  102739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102740 <lapic_eoi>:

// Acknowledge interrupt.
void
lapic_eoi(void)
{
  if(lapic)
  102740:	a1 98 aa 10 00       	mov    0x10aa98,%eax
}

// Acknowledge interrupt.
void
lapic_eoi(void)
{
  102745:	55                   	push   %ebp
  102746:	89 e5                	mov    %esp,%ebp
  if(lapic)
  102748:	85 c0                	test   %eax,%eax
  10274a:	74 0d                	je     102759 <lapic_eoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10274c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  102753:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
  102756:	8b 40 20             	mov    0x20(%eax),%eax
void
lapic_eoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
  102759:	5d                   	pop    %ebp
  10275a:	c3                   	ret    
  10275b:	90                   	nop
  10275c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00102760 <lapic_startap>:

// Start additional processor running bootstrap code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapic_startap(uchar apicid, uint addr)
{
  102760:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102761:	ba 70 00 00 00       	mov    $0x70,%edx
  102766:	89 e5                	mov    %esp,%ebp
  102768:	b8 0f 00 00 00       	mov    $0xf,%eax
  10276d:	57                   	push   %edi
  10276e:	56                   	push   %esi
  10276f:	53                   	push   %ebx
  102770:	83 ec 18             	sub    $0x18,%esp
  102773:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
  102777:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  10277a:	ee                   	out    %al,(%dx)
  10277b:	b8 0a 00 00 00       	mov    $0xa,%eax
  102780:	b2 71                	mov    $0x71,%dl
  102782:	ee                   	out    %al,(%dx)
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102783:	8b 15 98 aa 10 00    	mov    0x10aa98,%edx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  102789:	89 d8                	mov    %ebx,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  10278b:	89 cf                	mov    %ecx,%edi
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
  10278d:	c1 e8 04             	shr    $0x4,%eax
  102790:	66 a3 69 04 00 00    	mov    %ax,0x469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102796:	c1 e7 18             	shl    $0x18,%edi
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
  outb(IO_RTC+1, 0x0A);
  wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
  wrv[0] = 0;
  102799:	66 c7 05 67 04 00 00 	movw   $0x0,0x467
  1027a0:	00 00 
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1027a2:	8d 82 10 03 00 00    	lea    0x310(%edx),%eax
  1027a8:	89 ba 10 03 00 00    	mov    %edi,0x310(%edx)
  lapic[ID];  // wait for write to finish, by reading
  1027ae:	8d 72 20             	lea    0x20(%edx),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1027b1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  lapic[ID];  // wait for write to finish, by reading
  1027b4:	8b 42 20             	mov    0x20(%edx),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  1027b7:	8d 82 00 03 00 00    	lea    0x300(%edx),%eax
  1027bd:	c7 82 00 03 00 00 00 	movl   $0xc500,0x300(%edx)
  1027c4:	c5 00 00 
  1027c7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  lapic[ID];  // wait for write to finish, by reading
  1027ca:	8b 42 20             	mov    0x20(%edx),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  1027cd:	b8 c7 00 00 00       	mov    $0xc7,%eax
  1027d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  1027d9:	eb 0c                	jmp    1027e7 <lapic_startap+0x87>
  1027db:	90                   	nop
  1027dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  while(us-- > 0)
  1027e0:	85 c0                	test   %eax,%eax
  1027e2:	74 2d                	je     102811 <lapic_startap+0xb1>
  1027e4:	83 e8 01             	sub    $0x1,%eax
    for(j=0; j<10000; j++);
  1027e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  1027ee:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  1027f1:	81 f9 0f 27 00 00    	cmp    $0x270f,%ecx
  1027f7:	7f e7                	jg     1027e0 <lapic_startap+0x80>
  1027f9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  1027fc:	83 c1 01             	add    $0x1,%ecx
  1027ff:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  102802:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102805:	81 f9 0f 27 00 00    	cmp    $0x270f,%ecx
  10280b:	7e ec                	jle    1027f9 <lapic_startap+0x99>
static void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  10280d:	85 c0                	test   %eax,%eax
  10280f:	75 d3                	jne    1027e4 <lapic_startap+0x84>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102811:	c7 82 00 03 00 00 00 	movl   $0x8500,0x300(%edx)
  102818:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
  10281b:	8b 42 20             	mov    0x20(%edx),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  10281e:	b8 63 00 00 00       	mov    $0x63,%eax
  102823:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  10282a:	eb 0b                	jmp    102837 <lapic_startap+0xd7>
  10282c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  while(us-- > 0)
  102830:	85 c0                	test   %eax,%eax
  102832:	74 2d                	je     102861 <lapic_startap+0x101>
  102834:	83 e8 01             	sub    $0x1,%eax
    for(j=0; j<10000; j++);
  102837:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  10283e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102841:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  102847:	7f e7                	jg     102830 <lapic_startap+0xd0>
  102849:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10284c:	83 c2 01             	add    $0x1,%edx
  10284f:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102852:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102855:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  10285b:	7e ec                	jle    102849 <lapic_startap+0xe9>
static void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  10285d:	85 c0                	test   %eax,%eax
  10285f:	75 d3                	jne    102834 <lapic_startap+0xd4>
  102861:	c1 eb 0c             	shr    $0xc,%ebx
  102864:	31 c9                	xor    %ecx,%ecx
  102866:	80 cf 06             	or     $0x6,%bh
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102869:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10286c:	89 38                	mov    %edi,(%eax)
  lapic[ID];  // wait for write to finish, by reading
  10286e:	8b 06                	mov    (%esi),%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
  102870:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102873:	89 18                	mov    %ebx,(%eax)
  lapic[ID];  // wait for write to finish, by reading
  102875:	8b 06                	mov    (%esi),%eax
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
static void
microdelay(int us)
{
  volatile int j = 0;
  102877:	b8 c7 00 00 00       	mov    $0xc7,%eax
  10287c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102883:	eb 0a                	jmp    10288f <lapic_startap+0x12f>
  102885:	8d 76 00             	lea    0x0(%esi),%esi
  
  while(us-- > 0)
  102888:	85 c0                	test   %eax,%eax
  10288a:	74 34                	je     1028c0 <lapic_startap+0x160>
  10288c:	83 e8 01             	sub    $0x1,%eax
    for(j=0; j<10000; j++);
  10288f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  102896:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102899:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  10289f:	7f e7                	jg     102888 <lapic_startap+0x128>
  1028a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1028a4:	83 c2 01             	add    $0x1,%edx
  1028a7:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1028aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1028ad:	81 fa 0f 27 00 00    	cmp    $0x270f,%edx
  1028b3:	7e ec                	jle    1028a1 <lapic_startap+0x141>
static void
microdelay(int us)
{
  volatile int j = 0;
  
  while(us-- > 0)
  1028b5:	85 c0                	test   %eax,%eax
  1028b7:	75 d3                	jne    10288c <lapic_startap+0x12c>
  1028b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  // Send startup IPI (twice!) to enter bootstrap code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
  1028c0:	83 c1 01             	add    $0x1,%ecx
  1028c3:	83 f9 02             	cmp    $0x2,%ecx
  1028c6:	75 a1                	jne    102869 <lapic_startap+0x109>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
  1028c8:	83 c4 18             	add    $0x18,%esp
  1028cb:	5b                   	pop    %ebx
  1028cc:	5e                   	pop    %esi
  1028cd:	5f                   	pop    %edi
  1028ce:	5d                   	pop    %ebp
  1028cf:	c3                   	ret    

001028d0 <cpu>:
  lapicw(TPR, 0);
}

int
cpu(void)
{
  1028d0:	55                   	push   %ebp
  1028d1:	89 e5                	mov    %esp,%ebp
  1028d3:	83 ec 18             	sub    $0x18,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  1028d6:	9c                   	pushf  
  1028d7:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // everything, including cprintf, calls cpu, at least indirectly
  // through acquire and release.
  if(read_eflags()&FL_IF){
  1028d8:	f6 c4 02             	test   $0x2,%ah
  1028db:	74 12                	je     1028ef <cpu+0x1f>
    static int n;
    if(n++ == 0)
  1028dd:	a1 40 78 10 00       	mov    0x107840,%eax
  1028e2:	8d 50 01             	lea    0x1(%eax),%edx
  1028e5:	85 c0                	test   %eax,%eax
  1028e7:	89 15 40 78 10 00    	mov    %edx,0x107840
  1028ed:	74 19                	je     102908 <cpu+0x38>
      cprintf("cpu called from %x with interrupts enabled\n",
        ((uint*)read_ebp())[1]);
  }

  if(lapic)
  1028ef:	8b 15 98 aa 10 00    	mov    0x10aa98,%edx
  1028f5:	31 c0                	xor    %eax,%eax
  1028f7:	85 d2                	test   %edx,%edx
  1028f9:	74 06                	je     102901 <cpu+0x31>
    return lapic[ID]>>24;
  1028fb:	8b 42 20             	mov    0x20(%edx),%eax
  1028fe:	c1 e8 18             	shr    $0x18,%eax
  return 0;
}
  102901:	c9                   	leave  
  102902:	c3                   	ret    
  102903:	90                   	nop
  102904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uint
read_ebp(void)
{
  uint ebp;
  
  asm volatile("movl %%ebp, %0" : "=a" (ebp));
  102908:	89 e8                	mov    %ebp,%eax
  // everything, including cprintf, calls cpu, at least indirectly
  // through acquire and release.
  if(read_eflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
  10290a:	8b 40 04             	mov    0x4(%eax),%eax
  10290d:	c7 04 24 b0 63 10 00 	movl   $0x1063b0,(%esp)
  102914:	89 44 24 04          	mov    %eax,0x4(%esp)
  102918:	e8 63 de ff ff       	call   100780 <cprintf>
  10291d:	eb d0                	jmp    1028ef <cpu+0x1f>
  10291f:	90                   	nop

00102920 <mpmain>:

// Bootstrap processor gets here after setting up the hardware.
// Additional processors start here.
static void
mpmain(void)
{
  102920:	55                   	push   %ebp
  102921:	89 e5                	mov    %esp,%ebp
  102923:	53                   	push   %ebx
  102924:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: mpmain\n", cpu());
  102927:	e8 a4 ff ff ff       	call   1028d0 <cpu>
  10292c:	c7 04 24 dc 63 10 00 	movl   $0x1063dc,(%esp)
  102933:	89 44 24 04          	mov    %eax,0x4(%esp)
  102937:	e8 44 de ff ff       	call   100780 <cprintf>
  idtinit();
  10293c:	e8 8f 28 00 00       	call   1051d0 <idtinit>
  if(cpu() != mp_bcpu())
  102941:	e8 8a ff ff ff       	call   1028d0 <cpu>
  102946:	89 c3                	mov    %eax,%ebx
  102948:	e8 b3 01 00 00       	call   102b00 <mp_bcpu>
  10294d:	39 c3                	cmp    %eax,%ebx
  10294f:	74 0d                	je     10295e <mpmain+0x3e>
    lapic_init(cpu());
  102951:	e8 7a ff ff ff       	call   1028d0 <cpu>
  102956:	89 04 24             	mov    %eax,(%esp)
  102959:	e8 f2 fc ff ff       	call   102650 <lapic_init>
  setupsegs(0);
  10295e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  102965:	e8 96 0e 00 00       	call   103800 <setupsegs>
  xchg(&cpus[cpu()].booted, 1);
  10296a:	e8 61 ff ff ff       	call   1028d0 <cpu>
  10296f:	69 d0 cc 00 00 00    	imul   $0xcc,%eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  102975:	b8 01 00 00 00       	mov    $0x1,%eax
  10297a:	81 c2 c0 00 00 00    	add    $0xc0,%edx
  102980:	f0 87 82 c0 aa 10 00 	lock xchg %eax,0x10aac0(%edx)

  cprintf("cpu%d: scheduling\n");
  102987:	c7 04 24 eb 63 10 00 	movl   $0x1063eb,(%esp)
  10298e:	e8 ed dd ff ff       	call   100780 <cprintf>
  scheduler();
  102993:	e8 48 10 00 00       	call   1039e0 <scheduler>
  102998:	90                   	nop
  102999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001029a0 <main>:
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  1029a0:	55                   	push   %ebp
  extern char edata[], end[];

  // clear BSS
  memset(edata, 0, end - edata);
  1029a1:	b8 c0 df 10 00       	mov    $0x10dfc0,%eax
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  1029a6:	89 e5                	mov    %esp,%ebp
  1029a8:	83 e4 f0             	and    $0xfffffff0,%esp
  1029ab:	53                   	push   %ebx
  extern char edata[], end[];

  // clear BSS
  memset(edata, 0, end - edata);
  1029ac:	2d 8e 77 10 00       	sub    $0x10778e,%eax
static void mpmain(void) __attribute__((noreturn));

// Bootstrap processor starts running C code here.
int
main(void)
{
  1029b1:	83 ec 1c             	sub    $0x1c,%esp
  extern char edata[], end[];

  // clear BSS
  memset(edata, 0, end - edata);
  1029b4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1029b8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1029bf:	00 
  1029c0:	c7 04 24 8e 77 10 00 	movl   $0x10778e,(%esp)
  1029c7:	e8 34 16 00 00       	call   104000 <memset>

  mp_init(); // collect info about this machine
  1029cc:	e8 bf 01 00 00       	call   102b90 <mp_init>
  lapic_init(mp_bcpu());
  1029d1:	e8 2a 01 00 00       	call   102b00 <mp_bcpu>
  1029d6:	89 04 24             	mov    %eax,(%esp)
  1029d9:	e8 72 fc ff ff       	call   102650 <lapic_init>
  cprintf("\ncpu%d: starting xv6\n\n", cpu());
  1029de:	e8 ed fe ff ff       	call   1028d0 <cpu>
  1029e3:	c7 04 24 fe 63 10 00 	movl   $0x1063fe,(%esp)
  1029ea:	89 44 24 04          	mov    %eax,0x4(%esp)
  1029ee:	e8 8d dd ff ff       	call   100780 <cprintf>

  pinit();         // process table
  1029f3:	e8 b8 13 00 00       	call   103db0 <pinit>
  binit();         // buffer cache
  1029f8:	e8 93 d7 ff ff       	call   100190 <binit>
  1029fd:	8d 76 00             	lea    0x0(%esi),%esi
  pic_init();      // interrupt controller
  102a00:	e8 8b 03 00 00       	call   102d90 <pic_init>
  ioapic_init();   // another interrupt controller
  102a05:	e8 86 f8 ff ff       	call   102290 <ioapic_init>
  kinit();         // physical memory allocator
  102a0a:	e8 01 fb ff ff       	call   102510 <kinit>
  102a0f:	90                   	nop
  tvinit();        // trap vectors
  102a10:	e8 6b 2a 00 00       	call   105480 <tvinit>
  fileinit();      // file table
  102a15:	e8 06 e7 ff ff       	call   101120 <fileinit>
  iinit();         // inode cache
  102a1a:	e8 61 f5 ff ff       	call   101f80 <iinit>
  102a1f:	90                   	nop
  console_init();  // I/O devices & their interrupts
  102a20:	e8 db d7 ff ff       	call   100200 <console_init>
  ide_init();      // disk
  102a25:	e8 96 f7 ff ff       	call   1021c0 <ide_init>
  if(!ismp)
  102a2a:	a1 a0 aa 10 00       	mov    0x10aaa0,%eax
  102a2f:	85 c0                	test   %eax,%eax
  102a31:	0f 84 b1 00 00 00    	je     102ae8 <main+0x148>
    timer_init();  // uniprocessor timer
  userinit();      // first user process
  102a37:	e8 84 12 00 00       	call   103cc0 <userinit>
  struct cpu *c;
  char *stack;

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
  102a3c:	c7 44 24 08 5a 00 00 	movl   $0x5a,0x8(%esp)
  102a43:	00 
  102a44:	c7 44 24 04 34 77 10 	movl   $0x107734,0x4(%esp)
  102a4b:	00 
  102a4c:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
  102a53:	e8 38 16 00 00       	call   104090 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
  102a58:	69 05 20 b1 10 00 cc 	imul   $0xcc,0x10b120,%eax
  102a5f:	00 00 00 
  102a62:	05 c0 aa 10 00       	add    $0x10aac0,%eax
  102a67:	3d c0 aa 10 00       	cmp    $0x10aac0,%eax
  102a6c:	76 75                	jbe    102ae3 <main+0x143>
  102a6e:	bb c0 aa 10 00       	mov    $0x10aac0,%ebx
  102a73:	90                   	nop
  102a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == cpus+cpu())  // We've started already.
  102a78:	e8 53 fe ff ff       	call   1028d0 <cpu>
  102a7d:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  102a83:	05 c0 aa 10 00       	add    $0x10aac0,%eax
  102a88:	39 c3                	cmp    %eax,%ebx
  102a8a:	74 3e                	je     102aca <main+0x12a>
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
  102a8c:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  102a93:	e8 a8 f8 ff ff       	call   102340 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpmain;
  102a98:	c7 05 f8 6f 00 00 20 	movl   $0x102920,0x6ff8
  102a9f:	29 10 00 
    if(c == cpus+cpu())  // We've started already.
      continue;

    // Fill in %esp, %eip and start code on cpu.
    stack = kalloc(KSTACKSIZE);
    *(void**)(code-4) = stack + KSTACKSIZE;
  102aa2:	05 00 10 00 00       	add    $0x1000,%eax
  102aa7:	a3 fc 6f 00 00       	mov    %eax,0x6ffc
    *(void**)(code-8) = mpmain;
    lapic_startap(c->apicid, (uint)code);
  102aac:	0f b6 03             	movzbl (%ebx),%eax
  102aaf:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
  102ab6:	00 
  102ab7:	89 04 24             	mov    %eax,(%esp)
  102aba:	e8 a1 fc ff ff       	call   102760 <lapic_startap>
  102abf:	90                   	nop

    // Wait for cpu to get through bootstrap.
    while(c->booted == 0)
  102ac0:	8b 83 c0 00 00 00    	mov    0xc0(%ebx),%eax
  102ac6:	85 c0                	test   %eax,%eax
  102ac8:	74 f6                	je     102ac0 <main+0x120>

  // Write bootstrap code to unused memory at 0x7000.
  code = (uchar*)0x7000;
  memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);

  for(c = cpus; c < cpus+ncpu; c++){
  102aca:	69 05 20 b1 10 00 cc 	imul   $0xcc,0x10b120,%eax
  102ad1:	00 00 00 
  102ad4:	81 c3 cc 00 00 00    	add    $0xcc,%ebx
  102ada:	05 c0 aa 10 00       	add    $0x10aac0,%eax
  102adf:	39 c3                	cmp    %eax,%ebx
  102ae1:	72 95                	jb     102a78 <main+0xd8>
    timer_init();  // uniprocessor timer
  userinit();      // first user process
  bootothers();    // start other processors

  // Finish setting up this processor in mpmain.
  mpmain();
  102ae3:	e8 38 fe ff ff       	call   102920 <mpmain>
  fileinit();      // file table
  iinit();         // inode cache
  console_init();  // I/O devices & their interrupts
  ide_init();      // disk
  if(!ismp)
    timer_init();  // uniprocessor timer
  102ae8:	e8 83 26 00 00       	call   105170 <timer_init>
  102aed:	8d 76 00             	lea    0x0(%esi),%esi
  102af0:	e9 42 ff ff ff       	jmp    102a37 <main+0x97>
  102af5:	90                   	nop
  102af6:	90                   	nop
  102af7:	90                   	nop
  102af8:	90                   	nop
  102af9:	90                   	nop
  102afa:	90                   	nop
  102afb:	90                   	nop
  102afc:	90                   	nop
  102afd:	90                   	nop
  102afe:	90                   	nop
  102aff:	90                   	nop

00102b00 <mp_bcpu>:
int ncpu;
uchar ioapic_id;

int
mp_bcpu(void)
{
  102b00:	a1 44 78 10 00       	mov    0x107844,%eax
  102b05:	55                   	push   %ebp
  102b06:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
}
  102b08:	5d                   	pop    %ebp
int ncpu;
uchar ioapic_id;

int
mp_bcpu(void)
{
  102b09:	2d c0 aa 10 00       	sub    $0x10aac0,%eax
  102b0e:	c1 f8 02             	sar    $0x2,%eax
  102b11:	69 c0 fb fa fa fa    	imul   $0xfafafafb,%eax,%eax
  return bcpu-cpus;
}
  102b17:	c3                   	ret    
  102b18:	90                   	nop
  102b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102b20 <mp_search1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mp_search1(uchar *addr, int len)
{
  102b20:	55                   	push   %ebp
  102b21:	89 e5                	mov    %esp,%ebp
  102b23:	56                   	push   %esi
  102b24:	53                   	push   %ebx
  uchar *e, *p;

  e = addr+len;
  102b25:	8d 34 10             	lea    (%eax,%edx,1),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mp_search1(uchar *addr, int len)
{
  102b28:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102b2b:	39 f0                	cmp    %esi,%eax
  102b2d:	73 42                	jae    102b71 <mp_search1+0x51>
  102b2f:	89 c3                	mov    %eax,%ebx
  102b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102b38:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102b3f:	00 
  102b40:	c7 44 24 04 15 64 10 	movl   $0x106415,0x4(%esp)
  102b47:	00 
  102b48:	89 1c 24             	mov    %ebx,(%esp)
  102b4b:	e8 e0 14 00 00       	call   104030 <memcmp>
  102b50:	85 c0                	test   %eax,%eax
  102b52:	75 16                	jne    102b6a <mp_search1+0x4a>
  102b54:	31 d2                	xor    %edx,%edx
  102b56:	66 90                	xchg   %ax,%ax
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
  102b58:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102b5c:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  102b5f:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102b61:	83 f8 10             	cmp    $0x10,%eax
  102b64:	75 f2                	jne    102b58 <mp_search1+0x38>
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
  102b66:	84 d2                	test   %dl,%dl
  102b68:	74 10                	je     102b7a <mp_search1+0x5a>
mp_search1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102b6a:	83 c3 10             	add    $0x10,%ebx
  102b6d:	39 de                	cmp    %ebx,%esi
  102b6f:	77 c7                	ja     102b38 <mp_search1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  102b71:	83 c4 10             	add    $0x10,%esp
mp_search1(uchar *addr, int len)
{
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
  102b74:	31 c0                	xor    %eax,%eax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
  102b76:	5b                   	pop    %ebx
  102b77:	5e                   	pop    %esi
  102b78:	5d                   	pop    %ebp
  102b79:	c3                   	ret    
  102b7a:	83 c4 10             	add    $0x10,%esp
  uchar *e, *p;

  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  102b7d:	89 d8                	mov    %ebx,%eax
  return 0;
}
  102b7f:	5b                   	pop    %ebx
  102b80:	5e                   	pop    %esi
  102b81:	5d                   	pop    %ebp
  102b82:	c3                   	ret    
  102b83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102b90 <mp_init>:
  return conf;
}

void
mp_init(void)
{
  102b90:	55                   	push   %ebp
  102b91:	89 e5                	mov    %esp,%ebp
  102b93:	57                   	push   %edi
  102b94:	56                   	push   %esi
  102b95:	53                   	push   %ebx
  102b96:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102b99:	0f b6 15 0e 04 00 00 	movzbl 0x40e,%edx
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[ncpu];
  102ba0:	69 05 20 b1 10 00 cc 	imul   $0xcc,0x10b120,%eax
  102ba7:	00 00 00 
  102baa:	05 c0 aa 10 00       	add    $0x10aac0,%eax
  102baf:	a3 44 78 10 00       	mov    %eax,0x107844
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar*)0x400;
  if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
  102bb4:	0f b6 05 0f 04 00 00 	movzbl 0x40f,%eax
  102bbb:	c1 e0 08             	shl    $0x8,%eax
  102bbe:	09 d0                	or     %edx,%eax
  102bc0:	c1 e0 04             	shl    $0x4,%eax
  102bc3:	85 c0                	test   %eax,%eax
  102bc5:	75 1b                	jne    102be2 <mp_init+0x52>
    if((mp = mp_search1((uchar*)p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
  102bc7:	0f b6 05 14 04 00 00 	movzbl 0x414,%eax
  102bce:	0f b6 15 13 04 00 00 	movzbl 0x413,%edx
  102bd5:	c1 e0 08             	shl    $0x8,%eax
  102bd8:	09 d0                	or     %edx,%eax
  102bda:	c1 e0 0a             	shl    $0xa,%eax
  102bdd:	2d 00 04 00 00       	sub    $0x400,%eax
  102be2:	ba 00 04 00 00       	mov    $0x400,%edx
  102be7:	e8 34 ff ff ff       	call   102b20 <mp_search1>
  102bec:	85 c0                	test   %eax,%eax
  102bee:	89 c3                	mov    %eax,%ebx
  102bf0:	0f 84 b2 00 00 00    	je     102ca8 <mp_init+0x118>
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102bf6:	8b 73 04             	mov    0x4(%ebx),%esi
  102bf9:	85 f6                	test   %esi,%esi
  102bfb:	75 0b                	jne    102c08 <mp_init+0x78>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102bfd:	83 c4 2c             	add    $0x2c,%esp
  102c00:	5b                   	pop    %ebx
  102c01:	5e                   	pop    %esi
  102c02:	5f                   	pop    %edi
  102c03:	5d                   	pop    %ebp
  102c04:	c3                   	ret    
  102c05:	8d 76 00             	lea    0x0(%esi),%esi
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
  102c08:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  102c0f:	00 
  102c10:	c7 44 24 04 1a 64 10 	movl   $0x10641a,0x4(%esp)
  102c17:	00 
  102c18:	89 34 24             	mov    %esi,(%esp)
  102c1b:	e8 10 14 00 00       	call   104030 <memcmp>
  102c20:	85 c0                	test   %eax,%eax
  102c22:	75 d9                	jne    102bfd <mp_init+0x6d>
    return 0;
  if(conf->version != 1 && conf->version != 4)
  102c24:	0f b6 46 06          	movzbl 0x6(%esi),%eax
  102c28:	3c 04                	cmp    $0x4,%al
  102c2a:	74 06                	je     102c32 <mp_init+0xa2>
  102c2c:	3c 01                	cmp    $0x1,%al
  102c2e:	66 90                	xchg   %ax,%ax
  102c30:	75 cb                	jne    102bfd <mp_init+0x6d>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102c32:	0f b7 56 04          	movzwl 0x4(%esi),%edx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102c36:	85 d2                	test   %edx,%edx
  102c38:	74 15                	je     102c4f <mp_init+0xbf>
  102c3a:	31 c9                	xor    %ecx,%ecx
  102c3c:	31 c0                	xor    %eax,%eax
    sum += addr[i];
  102c3e:	0f b6 3c 06          	movzbl (%esi,%eax,1),%edi
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102c42:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
  102c45:	01 f9                	add    %edi,%ecx
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
  102c47:	39 c2                	cmp    %eax,%edx
  102c49:	7f f3                	jg     102c3e <mp_init+0xae>
  conf = (struct mpconf*)mp->physaddr;
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
  102c4b:	84 c9                	test   %cl,%cl
  102c4d:	75 ae                	jne    102bfd <mp_init+0x6d>
  bcpu = &cpus[ncpu];
  if((conf = mp_config(&mp)) == 0)
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  102c4f:	8b 46 24             	mov    0x24(%esi),%eax

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102c52:	8d 14 16             	lea    (%esi,%edx,1),%edx

  bcpu = &cpus[ncpu];
  if((conf = mp_config(&mp)) == 0)
    return;

  ismp = 1;
  102c55:	c7 05 a0 aa 10 00 01 	movl   $0x1,0x10aaa0
  102c5c:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
  102c5f:	a3 98 aa 10 00       	mov    %eax,0x10aa98

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102c64:	8d 46 2c             	lea    0x2c(%esi),%eax
  102c67:	39 d0                	cmp    %edx,%eax
  102c69:	0f 83 81 00 00 00    	jae    102cf0 <mp_init+0x160>
  102c6f:	8b 35 44 78 10 00    	mov    0x107844,%esi
  102c75:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
    switch(*p){
  102c78:	0f b6 08             	movzbl (%eax),%ecx
  102c7b:	80 f9 04             	cmp    $0x4,%cl
  102c7e:	76 50                	jbe    102cd0 <mp_init+0x140>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      cprintf("mp_init: unknown config type %x\n", *p);
  102c80:	0f b6 c9             	movzbl %cl,%ecx
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
  102c83:	89 35 44 78 10 00    	mov    %esi,0x107844
    default:
      cprintf("mp_init: unknown config type %x\n", *p);
  102c89:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  102c8d:	c7 04 24 28 64 10 00 	movl   $0x106428,(%esp)
  102c94:	e8 e7 da ff ff       	call   100780 <cprintf>
      panic("mp_init");
  102c99:	c7 04 24 1f 64 10 00 	movl   $0x10641f,(%esp)
  102ca0:	e8 7b dc ff ff       	call   100920 <panic>
  102ca5:	8d 76 00             	lea    0x0(%esi),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mp_search1((uchar*)0xF0000, 0x10000);
  102ca8:	ba 00 00 01 00       	mov    $0x10000,%edx
  102cad:	b8 00 00 0f 00       	mov    $0xf0000,%eax
  102cb2:	e8 69 fe ff ff       	call   102b20 <mp_search1>
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102cb7:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mp_search1((uchar*)p-1024, 1024)))
      return mp;
  }
  return mp_search1((uchar*)0xF0000, 0x10000);
  102cb9:	89 c3                	mov    %eax,%ebx
mp_config(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mp_search()) == 0 || mp->physaddr == 0)
  102cbb:	0f 85 35 ff ff ff    	jne    102bf6 <mp_init+0x66>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
  102cc1:	83 c4 2c             	add    $0x2c,%esp
  102cc4:	5b                   	pop    %ebx
  102cc5:	5e                   	pop    %esi
  102cc6:	5f                   	pop    %edi
  102cc7:	5d                   	pop    %ebp
  102cc8:	c3                   	ret    
  102cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
  102cd0:	0f b6 c9             	movzbl %cl,%ecx
  102cd3:	ff 24 8d 4c 64 10 00 	jmp    *0x10644c(,%ecx,4)
  102cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
  102ce0:	83 c0 08             	add    $0x8,%eax
    return;

  ismp = 1;
  lapic = (uint*)conf->lapicaddr;

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
  102ce3:	39 c2                	cmp    %eax,%edx
  102ce5:	77 91                	ja     102c78 <mp_init+0xe8>
  102ce7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  102cea:	89 35 44 78 10 00    	mov    %esi,0x107844
      cprintf("mp_init: unknown config type %x\n", *p);
      panic("mp_init");
    }
  }

  if(mp->imcrp){
  102cf0:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
  102cf4:	0f 84 03 ff ff ff    	je     102bfd <mp_init+0x6d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102cfa:	ba 22 00 00 00       	mov    $0x22,%edx
  102cff:	b8 70 00 00 00       	mov    $0x70,%eax
  102d04:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
  102d05:	b2 23                	mov    $0x23,%dl
  102d07:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  102d08:	83 c8 01             	or     $0x1,%eax
  102d0b:	ee                   	out    %al,(%dx)
  102d0c:	e9 ec fe ff ff       	jmp    102bfd <mp_init+0x6d>
  102d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapic_id = ioapic->apicno;
  102d18:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
  102d1c:	83 c0 08             	add    $0x8,%eax
      ncpu++;
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapic_id = ioapic->apicno;
  102d1f:	88 0d a4 aa 10 00    	mov    %cl,0x10aaa4
      p += sizeof(struct mpioapic);
      continue;
  102d25:	eb bc                	jmp    102ce3 <mp_init+0x153>
  102d27:	90                   	nop

  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
  102d28:	8b 0d 20 b1 10 00    	mov    0x10b120,%ecx
  102d2e:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
  102d32:	69 f9 cc 00 00 00    	imul   $0xcc,%ecx,%edi
  102d38:	88 9f c0 aa 10 00    	mov    %bl,0x10aac0(%edi)
      if(proc->flags & MPBOOT)
  102d3e:	f6 40 03 02          	testb  $0x2,0x3(%eax)
  102d42:	74 06                	je     102d4a <mp_init+0x1ba>
        bcpu = &cpus[ncpu];
  102d44:	8d b7 c0 aa 10 00    	lea    0x10aac0(%edi),%esi
      ncpu++;
  102d4a:	83 c1 01             	add    $0x1,%ecx
      p += sizeof(struct mpproc);
  102d4d:	83 c0 14             	add    $0x14,%eax
    case MPPROC:
      proc = (struct mpproc*)p;
      cpus[ncpu].apicid = proc->apicid;
      if(proc->flags & MPBOOT)
        bcpu = &cpus[ncpu];
      ncpu++;
  102d50:	89 0d 20 b1 10 00    	mov    %ecx,0x10b120
      p += sizeof(struct mpproc);
      continue;
  102d56:	eb 8b                	jmp    102ce3 <mp_init+0x153>
  102d58:	90                   	nop
  102d59:	90                   	nop
  102d5a:	90                   	nop
  102d5b:	90                   	nop
  102d5c:	90                   	nop
  102d5d:	90                   	nop
  102d5e:	90                   	nop
  102d5f:	90                   	nop

00102d60 <pic_enable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
pic_enable(int irq)
{
  102d60:	55                   	push   %ebp
  pic_setmask(irqmask & ~(1<<irq));
  102d61:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
pic_enable(int irq)
{
  102d66:	89 e5                	mov    %esp,%ebp
  102d68:	ba 21 00 00 00       	mov    $0x21,%edx
  pic_setmask(irqmask & ~(1<<irq));
  102d6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  102d70:	d3 c0                	rol    %cl,%eax
  102d72:	66 23 05 00 73 10 00 	and    0x107300,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
pic_setmask(ushort mask)
{
  irqmask = mask;
  102d79:	66 a3 00 73 10 00    	mov    %ax,0x107300
  102d7f:	ee                   	out    %al,(%dx)
  102d80:	66 c1 e8 08          	shr    $0x8,%ax
  102d84:	b2 a1                	mov    $0xa1,%dl
  102d86:	ee                   	out    %al,(%dx)

void
pic_enable(int irq)
{
  pic_setmask(irqmask & ~(1<<irq));
}
  102d87:	5d                   	pop    %ebp
  102d88:	c3                   	ret    
  102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00102d90 <pic_init>:

// Initialize the 8259A interrupt controllers.
void
pic_init(void)
{
  102d90:	55                   	push   %ebp
  102d91:	b9 21 00 00 00       	mov    $0x21,%ecx
  102d96:	89 e5                	mov    %esp,%ebp
  102d98:	83 ec 0c             	sub    $0xc,%esp
  102d9b:	89 1c 24             	mov    %ebx,(%esp)
  102d9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  102da3:	89 ca                	mov    %ecx,%edx
  102da5:	89 74 24 04          	mov    %esi,0x4(%esp)
  102da9:	89 7c 24 08          	mov    %edi,0x8(%esp)
  102dad:	ee                   	out    %al,(%dx)
  102dae:	bb a1 00 00 00       	mov    $0xa1,%ebx
  102db3:	89 da                	mov    %ebx,%edx
  102db5:	ee                   	out    %al,(%dx)
  102db6:	be 11 00 00 00       	mov    $0x11,%esi
  102dbb:	b2 20                	mov    $0x20,%dl
  102dbd:	89 f0                	mov    %esi,%eax
  102dbf:	ee                   	out    %al,(%dx)
  102dc0:	b8 20 00 00 00       	mov    $0x20,%eax
  102dc5:	89 ca                	mov    %ecx,%edx
  102dc7:	ee                   	out    %al,(%dx)
  102dc8:	b8 04 00 00 00       	mov    $0x4,%eax
  102dcd:	ee                   	out    %al,(%dx)
  102dce:	bf 03 00 00 00       	mov    $0x3,%edi
  102dd3:	89 f8                	mov    %edi,%eax
  102dd5:	ee                   	out    %al,(%dx)
  102dd6:	b1 a0                	mov    $0xa0,%cl
  102dd8:	89 f0                	mov    %esi,%eax
  102dda:	89 ca                	mov    %ecx,%edx
  102ddc:	ee                   	out    %al,(%dx)
  102ddd:	b8 28 00 00 00       	mov    $0x28,%eax
  102de2:	89 da                	mov    %ebx,%edx
  102de4:	ee                   	out    %al,(%dx)
  102de5:	b8 02 00 00 00       	mov    $0x2,%eax
  102dea:	ee                   	out    %al,(%dx)
  102deb:	89 f8                	mov    %edi,%eax
  102ded:	ee                   	out    %al,(%dx)
  102dee:	be 68 00 00 00       	mov    $0x68,%esi
  102df3:	b2 20                	mov    $0x20,%dl
  102df5:	89 f0                	mov    %esi,%eax
  102df7:	ee                   	out    %al,(%dx)
  102df8:	bb 0a 00 00 00       	mov    $0xa,%ebx
  102dfd:	89 d8                	mov    %ebx,%eax
  102dff:	ee                   	out    %al,(%dx)
  102e00:	89 f0                	mov    %esi,%eax
  102e02:	89 ca                	mov    %ecx,%edx
  102e04:	ee                   	out    %al,(%dx)
  102e05:	89 d8                	mov    %ebx,%eax
  102e07:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
  102e08:	0f b7 05 00 73 10 00 	movzwl 0x107300,%eax
  102e0f:	66 83 f8 ff          	cmp    $0xffffffff,%ax
  102e13:	74 0a                	je     102e1f <pic_init+0x8f>
  102e15:	b2 21                	mov    $0x21,%dl
  102e17:	ee                   	out    %al,(%dx)
  102e18:	66 c1 e8 08          	shr    $0x8,%ax
  102e1c:	b2 a1                	mov    $0xa1,%dl
  102e1e:	ee                   	out    %al,(%dx)
    pic_setmask(irqmask);
}
  102e1f:	8b 1c 24             	mov    (%esp),%ebx
  102e22:	8b 74 24 04          	mov    0x4(%esp),%esi
  102e26:	8b 7c 24 08          	mov    0x8(%esp),%edi
  102e2a:	89 ec                	mov    %ebp,%esp
  102e2c:	5d                   	pop    %ebp
  102e2d:	c3                   	ret    
  102e2e:	90                   	nop
  102e2f:	90                   	nop

00102e30 <piperead>:
  return i;
}

int
piperead(struct pipe *p, char *addr, int n)
{
  102e30:	55                   	push   %ebp
  102e31:	89 e5                	mov    %esp,%ebp
  102e33:	57                   	push   %edi
  102e34:	56                   	push   %esi
  102e35:	53                   	push   %ebx
  102e36:	83 ec 2c             	sub    $0x2c,%esp
  102e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
  102e3c:	8d 73 10             	lea    0x10(%ebx),%esi
  102e3f:	89 34 24             	mov    %esi,(%esp)
  102e42:	e8 49 11 00 00       	call   103f90 <acquire>
  while(p->readp == p->writep && p->writeopen){
  102e47:	8b 53 0c             	mov    0xc(%ebx),%edx
  102e4a:	3b 53 08             	cmp    0x8(%ebx),%edx
  102e4d:	75 51                	jne    102ea0 <piperead+0x70>
  102e4f:	8b 4b 04             	mov    0x4(%ebx),%ecx
  102e52:	85 c9                	test   %ecx,%ecx
  102e54:	74 4a                	je     102ea0 <piperead+0x70>
    if(cp->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  102e56:	8d 7b 0c             	lea    0xc(%ebx),%edi
  102e59:	eb 20                	jmp    102e7b <piperead+0x4b>
  102e5b:	90                   	nop
  102e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  102e60:	89 74 24 04          	mov    %esi,0x4(%esp)
  102e64:	89 3c 24             	mov    %edi,(%esp)
  102e67:	e8 74 07 00 00       	call   1035e0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->readp == p->writep && p->writeopen){
  102e6c:	8b 53 0c             	mov    0xc(%ebx),%edx
  102e6f:	3b 53 08             	cmp    0x8(%ebx),%edx
  102e72:	75 2c                	jne    102ea0 <piperead+0x70>
  102e74:	8b 43 04             	mov    0x4(%ebx),%eax
  102e77:	85 c0                	test   %eax,%eax
  102e79:	74 25                	je     102ea0 <piperead+0x70>
    if(cp->killed){
  102e7b:	e8 00 05 00 00       	call   103380 <curproc>
  102e80:	8b 40 1c             	mov    0x1c(%eax),%eax
  102e83:	85 c0                	test   %eax,%eax
  102e85:	74 d9                	je     102e60 <piperead+0x30>
      release(&p->lock);
  102e87:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  102e8c:	89 34 24             	mov    %esi,(%esp)
  102e8f:	e8 bc 10 00 00       	call   103f50 <release>
    p->readp = (p->readp + 1) % PIPESIZE;
  }
  wakeup(&p->writep);
  release(&p->lock);
  return i;
}
  102e94:	83 c4 2c             	add    $0x2c,%esp
  102e97:	89 f8                	mov    %edi,%eax
  102e99:	5b                   	pop    %ebx
  102e9a:	5e                   	pop    %esi
  102e9b:	5f                   	pop    %edi
  102e9c:	5d                   	pop    %ebp
  102e9d:	c3                   	ret    
  102e9e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102ea0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  102ea3:	85 c9                	test   %ecx,%ecx
  102ea5:	7e 68                	jle    102f0f <piperead+0xdf>
    if(p->readp == p->writep)
  102ea7:	31 ff                	xor    %edi,%edi
  102ea9:	3b 53 08             	cmp    0x8(%ebx),%edx
  102eac:	74 61                	je     102f0f <piperead+0xdf>
  102eae:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  102eb1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  102eb4:	8b 75 10             	mov    0x10(%ebp),%esi
  102eb7:	eb 0c                	jmp    102ec5 <piperead+0x95>
  102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  102ec0:	39 53 08             	cmp    %edx,0x8(%ebx)
  102ec3:	74 2a                	je     102eef <piperead+0xbf>
      break;
    addr[i] = p->data[p->readp];
  102ec5:	0f b6 44 13 44       	movzbl 0x44(%ebx,%edx,1),%eax
  102eca:	88 04 39             	mov    %al,(%ecx,%edi,1)
    p->readp = (p->readp + 1) % PIPESIZE;
  102ecd:	8b 53 0c             	mov    0xc(%ebx),%edx
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102ed0:	83 c7 01             	add    $0x1,%edi
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  102ed3:	83 c2 01             	add    $0x1,%edx
  102ed6:	89 d0                	mov    %edx,%eax
  102ed8:	c1 f8 1f             	sar    $0x1f,%eax
  102edb:	c1 e8 17             	shr    $0x17,%eax
  102ede:	01 c2                	add    %eax,%edx
  102ee0:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  102ee6:	29 c2                	sub    %eax,%edx
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102ee8:	39 fe                	cmp    %edi,%esi
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  102eea:	89 53 0c             	mov    %edx,0xc(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102eed:	7f d1                	jg     102ec0 <piperead+0x90>
  102eef:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    if(p->readp == p->writep)
      break;
    addr[i] = p->data[p->readp];
    p->readp = (p->readp + 1) % PIPESIZE;
  }
  wakeup(&p->writep);
  102ef2:	83 c3 08             	add    $0x8,%ebx
  102ef5:	89 1c 24             	mov    %ebx,(%esp)
  102ef8:	e8 03 04 00 00       	call   103300 <wakeup>
  release(&p->lock);
  102efd:	89 34 24             	mov    %esi,(%esp)
  102f00:	e8 4b 10 00 00       	call   103f50 <release>
  return i;
}
  102f05:	83 c4 2c             	add    $0x2c,%esp
  102f08:	89 f8                	mov    %edi,%eax
  102f0a:	5b                   	pop    %ebx
  102f0b:	5e                   	pop    %esi
  102f0c:	5f                   	pop    %edi
  102f0d:	5d                   	pop    %ebp
  102f0e:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->readp, &p->lock);
  }
  for(i = 0; i < n; i++){
  102f0f:	31 ff                	xor    %edi,%edi
  102f11:	eb df                	jmp    102ef2 <piperead+0xc2>
  102f13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  102f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00102f20 <pipewrite>:
    kfree((char*)p, PAGE);
}

int
pipewrite(struct pipe *p, char *addr, int n)
{
  102f20:	55                   	push   %ebp
  102f21:	89 e5                	mov    %esp,%ebp
  102f23:	57                   	push   %edi
  102f24:	56                   	push   %esi
  102f25:	53                   	push   %ebx
  102f26:	83 ec 3c             	sub    $0x3c,%esp
  102f29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
  102f2c:	8d 73 10             	lea    0x10(%ebx),%esi
  102f2f:	89 34 24             	mov    %esi,(%esp)
  102f32:	e8 59 10 00 00       	call   103f90 <acquire>
  for(i = 0; i < n; i++){
  102f37:	8b 55 10             	mov    0x10(%ebp),%edx
  102f3a:	85 d2                	test   %edx,%edx
  102f3c:	0f 8e d8 00 00 00    	jle    10301a <pipewrite+0xfa>
  102f42:	8b 4b 08             	mov    0x8(%ebx),%ecx
    while(((p->writep + 1) % PIPESIZE) == p->readp){
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  102f45:	8d 43 0c             	lea    0xc(%ebx),%eax
      sleep(&p->writep, &p->lock);
  102f48:	8d 53 08             	lea    0x8(%ebx),%edx
    while(((p->writep + 1) % PIPESIZE) == p->readp){
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  102f4b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      sleep(&p->writep, &p->lock);
  102f4e:	89 55 e0             	mov    %edx,-0x20(%ebp)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102f51:	89 cf                	mov    %ecx,%edi
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
  102f53:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
  102f5a:	8d 47 01             	lea    0x1(%edi),%eax
  102f5d:	eb 3d                	jmp    102f9c <pipewrite+0x7c>
  102f5f:	90                   	nop
      if(p->readopen == 0 || cp->killed){
  102f60:	8b 03                	mov    (%ebx),%eax
  102f62:	85 c0                	test   %eax,%eax
  102f64:	0f 84 96 00 00 00    	je     103000 <pipewrite+0xe0>
  102f6a:	e8 11 04 00 00       	call   103380 <curproc>
  102f6f:	8b 78 1c             	mov    0x1c(%eax),%edi
  102f72:	85 ff                	test   %edi,%edi
  102f74:	0f 85 86 00 00 00    	jne    103000 <pipewrite+0xe0>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->readp);
  102f7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102f7d:	89 04 24             	mov    %eax,(%esp)
  102f80:	e8 7b 03 00 00       	call   103300 <wakeup>
      sleep(&p->writep, &p->lock);
  102f85:	8b 55 e0             	mov    -0x20(%ebp),%edx
  102f88:	89 74 24 04          	mov    %esi,0x4(%esp)
  102f8c:	89 14 24             	mov    %edx,(%esp)
  102f8f:	e8 4c 06 00 00       	call   1035e0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
  102f94:	8b 4b 08             	mov    0x8(%ebx),%ecx
  102f97:	89 cf                	mov    %ecx,%edi
  102f99:	8d 41 01             	lea    0x1(%ecx),%eax
  102f9c:	89 c2                	mov    %eax,%edx
  102f9e:	c1 fa 1f             	sar    $0x1f,%edx
  102fa1:	c1 ea 17             	shr    $0x17,%edx
  102fa4:	01 d0                	add    %edx,%eax
  102fa6:	25 ff 01 00 00       	and    $0x1ff,%eax
  102fab:	29 d0                	sub    %edx,%eax
  102fad:	3b 43 0c             	cmp    0xc(%ebx),%eax
  102fb0:	74 ae                	je     102f60 <pipewrite+0x40>
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
  102fb2:	8b 45 dc             	mov    -0x24(%ebp),%eax
    p->writep = (p->writep + 1) % PIPESIZE;
  102fb5:	83 c1 01             	add    $0x1,%ecx
        return -1;
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
  102fb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  102fbb:	0f b6 04 02          	movzbl (%edx,%eax,1),%eax
  102fbf:	88 44 3b 44          	mov    %al,0x44(%ebx,%edi,1)
    p->writep = (p->writep + 1) % PIPESIZE;
  102fc3:	89 c8                	mov    %ecx,%eax
  102fc5:	c1 f8 1f             	sar    $0x1f,%eax
  102fc8:	c1 e8 17             	shr    $0x17,%eax
  102fcb:	8d 3c 01             	lea    (%ecx,%eax,1),%edi
  102fce:	81 e7 ff 01 00 00    	and    $0x1ff,%edi
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102fd4:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
    p->writep = (p->writep + 1) % PIPESIZE;
  102fd8:	29 c7                	sub    %eax,%edi
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102fda:	8b 45 dc             	mov    -0x24(%ebp),%eax
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
    p->writep = (p->writep + 1) % PIPESIZE;
  102fdd:	89 f9                	mov    %edi,%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102fdf:	39 45 10             	cmp    %eax,0x10(%ebp)
      }
      wakeup(&p->readp);
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
    p->writep = (p->writep + 1) % PIPESIZE;
  102fe2:	89 7b 08             	mov    %edi,0x8(%ebx)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
  102fe5:	0f 8f 6f ff ff ff    	jg     102f5a <pipewrite+0x3a>
      sleep(&p->writep, &p->lock);
    }
    p->data[p->writep] = addr[i];
    p->writep = (p->writep + 1) % PIPESIZE;
  }
  wakeup(&p->readp);
  102feb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102fee:	89 14 24             	mov    %edx,(%esp)
  102ff1:	e8 0a 03 00 00       	call   103300 <wakeup>
  release(&p->lock);
  102ff6:	89 34 24             	mov    %esi,(%esp)
  102ff9:	e8 52 0f 00 00       	call   103f50 <release>
  return i;
  102ffe:	eb 0f                	jmp    10300f <pipewrite+0xef>

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
      if(p->readopen == 0 || cp->killed){
        release(&p->lock);
  103000:	89 34 24             	mov    %esi,(%esp)
  103003:	e8 48 0f 00 00       	call   103f50 <release>
  103008:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
    p->writep = (p->writep + 1) % PIPESIZE;
  }
  wakeup(&p->readp);
  release(&p->lock);
  return i;
}
  10300f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103012:	83 c4 3c             	add    $0x3c,%esp
  103015:	5b                   	pop    %ebx
  103016:	5e                   	pop    %esi
  103017:	5f                   	pop    %edi
  103018:	5d                   	pop    %ebp
  103019:	c3                   	ret    
  10301a:	83 c3 0c             	add    $0xc,%ebx
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(((p->writep + 1) % PIPESIZE) == p->readp){
      if(p->readopen == 0 || cp->killed){
  10301d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  103024:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  103027:	eb c2                	jmp    102feb <pipewrite+0xcb>
  103029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103030 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
  103030:	55                   	push   %ebp
  103031:	89 e5                	mov    %esp,%ebp
  103033:	83 ec 28             	sub    $0x28,%esp
  103036:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  103039:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10303c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10303f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  103042:	89 75 f8             	mov    %esi,-0x8(%ebp)
  acquire(&p->lock);
  103045:	8d 73 10             	lea    0x10(%ebx),%esi
  103048:	89 34 24             	mov    %esi,(%esp)
  10304b:	e8 40 0f 00 00       	call   103f90 <acquire>
  if(writable){
  103050:	85 ff                	test   %edi,%edi
  103052:	74 34                	je     103088 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->readp);
  103054:	8d 43 0c             	lea    0xc(%ebx),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
  103057:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
    wakeup(&p->readp);
  10305e:	89 04 24             	mov    %eax,(%esp)
  103061:	e8 9a 02 00 00       	call   103300 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  }
  release(&p->lock);
  103066:	89 34 24             	mov    %esi,(%esp)
  103069:	e8 e2 0e 00 00       	call   103f50 <release>

  if(p->readopen == 0 && p->writeopen == 0)
  10306e:	8b 33                	mov    (%ebx),%esi
  103070:	85 f6                	test   %esi,%esi
  103072:	75 07                	jne    10307b <pipeclose+0x4b>
  103074:	8b 4b 04             	mov    0x4(%ebx),%ecx
  103077:	85 c9                	test   %ecx,%ecx
  103079:	74 25                	je     1030a0 <pipeclose+0x70>
    kfree((char*)p, PAGE);
}
  10307b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10307e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  103081:	8b 7d fc             	mov    -0x4(%ebp),%edi
  103084:	89 ec                	mov    %ebp,%esp
  103086:	5d                   	pop    %ebp
  103087:	c3                   	ret    
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
    wakeup(&p->writep);
  103088:	8d 43 08             	lea    0x8(%ebx),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->readp);
  } else {
    p->readopen = 0;
  10308b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    wakeup(&p->writep);
  103091:	89 04 24             	mov    %eax,(%esp)
  103094:	e8 67 02 00 00       	call   103300 <wakeup>
  103099:	eb cb                	jmp    103066 <pipeclose+0x36>
  10309b:	90                   	nop
  10309c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  1030a0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
  1030a3:	8b 75 f8             	mov    -0x8(%ebp),%esi
    wakeup(&p->writep);
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  1030a6:	c7 45 0c 00 10 00 00 	movl   $0x1000,0xc(%ebp)
}
  1030ad:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1030b0:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1030b3:	89 ec                	mov    %ebp,%esp
  1030b5:	5d                   	pop    %ebp
    wakeup(&p->writep);
  }
  release(&p->lock);

  if(p->readopen == 0 && p->writeopen == 0)
    kfree((char*)p, PAGE);
  1030b6:	e9 45 f3 ff ff       	jmp    102400 <kfree>
  1030bb:	90                   	nop
  1030bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001030c0 <pipealloc>:
  char data[PIPESIZE];
};

int
pipealloc(struct file **f0, struct file **f1)
{
  1030c0:	55                   	push   %ebp
  1030c1:	89 e5                	mov    %esp,%ebp
  1030c3:	57                   	push   %edi
  1030c4:	56                   	push   %esi
  1030c5:	53                   	push   %ebx
  1030c6:	83 ec 1c             	sub    $0x1c,%esp
  1030c9:	8b 75 08             	mov    0x8(%ebp),%esi
  1030cc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
  1030cf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  1030d5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  1030db:	e8 d0 de ff ff       	call   100fb0 <filealloc>
  1030e0:	85 c0                	test   %eax,%eax
  1030e2:	89 06                	mov    %eax,(%esi)
  1030e4:	0f 84 92 00 00 00    	je     10317c <pipealloc+0xbc>
  1030ea:	e8 c1 de ff ff       	call   100fb0 <filealloc>
  1030ef:	85 c0                	test   %eax,%eax
  1030f1:	89 03                	mov    %eax,(%ebx)
  1030f3:	74 73                	je     103168 <pipealloc+0xa8>
    goto bad;
  if((p = (struct pipe*)kalloc(PAGE)) == 0)
  1030f5:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  1030fc:	e8 3f f2 ff ff       	call   102340 <kalloc>
  103101:	85 c0                	test   %eax,%eax
  103103:	89 c7                	mov    %eax,%edi
  103105:	74 61                	je     103168 <pipealloc+0xa8>
    goto bad;
  p->readopen = 1;
  103107:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  p->writeopen = 1;
  10310d:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
  p->writep = 0;
  103114:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  p->readp = 0;
  10311b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  initlock(&p->lock, "pipe");
  103122:	8d 40 10             	lea    0x10(%eax),%eax
  103125:	89 04 24             	mov    %eax,(%esp)
  103128:	c7 44 24 04 60 64 10 	movl   $0x106460,0x4(%esp)
  10312f:	00 
  103130:	e8 9b 0c 00 00       	call   103dd0 <initlock>
  (*f0)->type = FD_PIPE;
  103135:	8b 06                	mov    (%esi),%eax
  103137:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  (*f0)->readable = 1;
  10313d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
  103141:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
  103145:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
  103148:	8b 03                	mov    (%ebx),%eax
  10314a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  (*f1)->readable = 0;
  103150:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
  103154:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
  103158:	89 78 0c             	mov    %edi,0xc(%eax)
  10315b:	31 c0                	xor    %eax,%eax
  if(*f1){
    (*f1)->type = FD_NONE;
    fileclose(*f1);
  }
  return -1;
}
  10315d:	83 c4 1c             	add    $0x1c,%esp
  103160:	5b                   	pop    %ebx
  103161:	5e                   	pop    %esi
  103162:	5f                   	pop    %edi
  103163:	5d                   	pop    %ebp
  103164:	c3                   	ret    
  103165:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;

 bad:
  if(p)
    kfree((char*)p, PAGE);
  if(*f0){
  103168:	8b 06                	mov    (%esi),%eax
  10316a:	85 c0                	test   %eax,%eax
  10316c:	74 0e                	je     10317c <pipealloc+0xbc>
    (*f0)->type = FD_NONE;
  10316e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    fileclose(*f0);
  103174:	89 04 24             	mov    %eax,(%esp)
  103177:	e8 c4 de ff ff       	call   101040 <fileclose>
  }
  if(*f1){
  10317c:	8b 13                	mov    (%ebx),%edx
  10317e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103183:	85 d2                	test   %edx,%edx
  103185:	74 d6                	je     10315d <pipealloc+0x9d>
    (*f1)->type = FD_NONE;
  103187:	c7 02 01 00 00 00    	movl   $0x1,(%edx)
    fileclose(*f1);
  10318d:	89 14 24             	mov    %edx,(%esp)
  103190:	e8 ab de ff ff       	call   101040 <fileclose>
  103195:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10319a:	eb c1                	jmp    10315d <pipealloc+0x9d>
  10319c:	90                   	nop
  10319d:	90                   	nop
  10319e:	90                   	nop
  10319f:	90                   	nop

001031a0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  1031a0:	55                   	push   %ebp
  1031a1:	89 e5                	mov    %esp,%ebp
  1031a3:	57                   	push   %edi
  1031a4:	56                   	push   %esi
  1031a5:	53                   	push   %ebx
  1031a6:	bb 4c b1 10 00       	mov    $0x10b14c,%ebx
  1031ab:	83 ec 4c             	sub    $0x4c,%esp
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
  1031ae:	8d 7d c0             	lea    -0x40(%ebp),%edi
  1031b1:	eb 50                	jmp    103203 <procdump+0x63>
  1031b3:	90                   	nop
  1031b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  1031b8:	8b 04 85 28 65 10 00 	mov    0x106528(,%eax,4),%eax
  1031bf:	85 c0                	test   %eax,%eax
  1031c1:	74 4e                	je     103211 <procdump+0x71>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
  1031c3:	89 44 24 08          	mov    %eax,0x8(%esp)
  1031c7:	8b 43 04             	mov    0x4(%ebx),%eax
  1031ca:	81 c2 88 00 00 00    	add    $0x88,%edx
  1031d0:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1031d4:	c7 04 24 69 64 10 00 	movl   $0x106469,(%esp)
  1031db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031df:	e8 9c d5 ff ff       	call   100780 <cprintf>
    if(p->state == SLEEPING){
  1031e4:	83 3b 02             	cmpl   $0x2,(%ebx)
  1031e7:	74 2f                	je     103218 <procdump+0x78>
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
        cprintf(" %p", pc[j]);
    }
    cprintf("\n");
  1031e9:	c7 04 24 13 64 10 00 	movl   $0x106413,(%esp)
  1031f0:	e8 8b d5 ff ff       	call   100780 <cprintf>
  1031f5:	81 c3 98 00 00 00    	add    $0x98,%ebx
  int i, j;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(i = 0; i < NPROC; i++){
  1031fb:	81 fb 4c d7 10 00    	cmp    $0x10d74c,%ebx
  103201:	74 55                	je     103258 <procdump+0xb8>
    p = &proc[i];
    if(p->state == UNUSED)
  103203:	8b 03                	mov    (%ebx),%eax

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
  103205:	8d 53 f4             	lea    -0xc(%ebx),%edx
  char *state;
  uint pc[10];
  
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED)
  103208:	85 c0                	test   %eax,%eax
  10320a:	74 e9                	je     1031f5 <procdump+0x55>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
  10320c:	83 f8 05             	cmp    $0x5,%eax
  10320f:	76 a7                	jbe    1031b8 <procdump+0x18>
  103211:	b8 65 64 10 00       	mov    $0x106465,%eax
  103216:	eb ab                	jmp    1031c3 <procdump+0x23>
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
  103218:	8b 43 74             	mov    0x74(%ebx),%eax
  10321b:	31 f6                	xor    %esi,%esi
  10321d:	89 7c 24 04          	mov    %edi,0x4(%esp)
  103221:	83 c0 08             	add    $0x8,%eax
  103224:	89 04 24             	mov    %eax,(%esp)
  103227:	e8 c4 0b 00 00       	call   103df0 <getcallerpcs>
  10322c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(j=0; j<10 && pc[j] != 0; j++)
  103230:	8b 04 b7             	mov    (%edi,%esi,4),%eax
  103233:	85 c0                	test   %eax,%eax
  103235:	74 b2                	je     1031e9 <procdump+0x49>
  103237:	83 c6 01             	add    $0x1,%esi
        cprintf(" %p", pc[j]);
  10323a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10323e:	c7 04 24 d5 5f 10 00 	movl   $0x105fd5,(%esp)
  103245:	e8 36 d5 ff ff       	call   100780 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context.ebp+2, pc);
      for(j=0; j<10 && pc[j] != 0; j++)
  10324a:	83 fe 0a             	cmp    $0xa,%esi
  10324d:	75 e1                	jne    103230 <procdump+0x90>
  10324f:	eb 98                	jmp    1031e9 <procdump+0x49>
  103251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[j]);
    }
    cprintf("\n");
  }
}
  103258:	83 c4 4c             	add    $0x4c,%esp
  10325b:	5b                   	pop    %ebx
  10325c:	5e                   	pop    %esi
  10325d:	5f                   	pop    %edi
  10325e:	5d                   	pop    %ebp
  10325f:	90                   	nop
  103260:	c3                   	ret    
  103261:	eb 0d                	jmp    103270 <kill>
  103263:	90                   	nop
  103264:	90                   	nop
  103265:	90                   	nop
  103266:	90                   	nop
  103267:	90                   	nop
  103268:	90                   	nop
  103269:	90                   	nop
  10326a:	90                   	nop
  10326b:	90                   	nop
  10326c:	90                   	nop
  10326d:	90                   	nop
  10326e:	90                   	nop
  10326f:	90                   	nop

00103270 <kill>:
// Kill the process with the given pid.
// Process won't actually exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  103270:	55                   	push   %ebp
  103271:	89 e5                	mov    %esp,%ebp
  103273:	53                   	push   %ebx
  103274:	83 ec 14             	sub    $0x14,%esp
  103277:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&proc_table_lock);
  10327a:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103281:	e8 0a 0d 00 00       	call   103f90 <acquire>
  for(p = proc; p < &proc[NPROC]; p++){
  103286:	b8 40 d7 10 00       	mov    $0x10d740,%eax
  10328b:	3d 40 b1 10 00       	cmp    $0x10b140,%eax
  103290:	76 56                	jbe    1032e8 <kill+0x78>
    if(p->pid == pid){
  103292:	39 1d 50 b1 10 00    	cmp    %ebx,0x10b150

// Kill the process with the given pid.
// Process won't actually exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
  103298:	b8 40 b1 10 00       	mov    $0x10b140,%eax
{
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
  10329d:	74 12                	je     1032b1 <kill+0x41>
  10329f:	90                   	nop
kill(int pid)
{
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
  1032a0:	05 98 00 00 00       	add    $0x98,%eax
  1032a5:	3d 40 d7 10 00       	cmp    $0x10d740,%eax
  1032aa:	74 3c                	je     1032e8 <kill+0x78>
    if(p->pid == pid){
  1032ac:	39 58 10             	cmp    %ebx,0x10(%eax)
  1032af:	75 ef                	jne    1032a0 <kill+0x30>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  1032b1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&proc_table_lock);
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
  1032b5:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
  1032bc:	74 1a                	je     1032d8 <kill+0x68>
        p->state = RUNNABLE;
      release(&proc_table_lock);
  1032be:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  1032c5:	e8 86 0c 00 00       	call   103f50 <release>
      return 0;
    }
  }
  release(&proc_table_lock);
  return -1;
}
  1032ca:	83 c4 14             	add    $0x14,%esp
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&proc_table_lock);
  1032cd:	31 c0                	xor    %eax,%eax
      return 0;
    }
  }
  release(&proc_table_lock);
  return -1;
}
  1032cf:	5b                   	pop    %ebx
  1032d0:	5d                   	pop    %ebp
  1032d1:	c3                   	ret    
  1032d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
  1032d8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  1032df:	eb dd                	jmp    1032be <kill+0x4e>
  1032e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&proc_table_lock);
      return 0;
    }
  }
  release(&proc_table_lock);
  1032e8:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  1032ef:	e8 5c 0c 00 00       	call   103f50 <release>
  return -1;
}
  1032f4:	83 c4 14             	add    $0x14,%esp
        p->state = RUNNABLE;
      release(&proc_table_lock);
      return 0;
    }
  }
  release(&proc_table_lock);
  1032f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return -1;
}
  1032fc:	5b                   	pop    %ebx
  1032fd:	5d                   	pop    %ebp
  1032fe:	c3                   	ret    
  1032ff:	90                   	nop

00103300 <wakeup>:

// Wake up all processes sleeping on chan.
// Proc_table_lock is acquired and released.
void
wakeup(void *chan)
{
  103300:	55                   	push   %ebp
  103301:	89 e5                	mov    %esp,%ebp
  103303:	53                   	push   %ebx
  103304:	83 ec 14             	sub    $0x14,%esp
  103307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&proc_table_lock);
  10330a:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103311:	e8 7a 0c 00 00       	call   103f90 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103316:	b8 40 d7 10 00       	mov    $0x10d740,%eax
  10331b:	3d 40 b1 10 00       	cmp    $0x10b140,%eax
  103320:	76 3e                	jbe    103360 <wakeup+0x60>
}

// Wake up all processes sleeping on chan.
// Proc_table_lock is acquired and released.
void
wakeup(void *chan)
  103322:	b8 40 b1 10 00       	mov    $0x10b140,%eax
  103327:	eb 13                	jmp    10333c <wakeup+0x3c>
  103329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103330:	05 98 00 00 00       	add    $0x98,%eax
  103335:	3d 40 d7 10 00       	cmp    $0x10d740,%eax
  10333a:	74 24                	je     103360 <wakeup+0x60>
    if(p->state == SLEEPING && p->chan == chan)
  10333c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103340:	75 ee                	jne    103330 <wakeup+0x30>
  103342:	3b 58 18             	cmp    0x18(%eax),%ebx
  103345:	75 e9                	jne    103330 <wakeup+0x30>
      p->state = RUNNABLE;
  103347:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  10334e:	05 98 00 00 00       	add    $0x98,%eax
  103353:	3d 40 d7 10 00       	cmp    $0x10d740,%eax
  103358:	75 e2                	jne    10333c <wakeup+0x3c>
  10335a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
wakeup(void *chan)
{
  acquire(&proc_table_lock);
  wakeup1(chan);
  release(&proc_table_lock);
  103360:	c7 45 08 40 d7 10 00 	movl   $0x10d740,0x8(%ebp)
}
  103367:	83 c4 14             	add    $0x14,%esp
  10336a:	5b                   	pop    %ebx
  10336b:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&proc_table_lock);
  wakeup1(chan);
  release(&proc_table_lock);
  10336c:	e9 df 0b 00 00       	jmp    103f50 <release>
  103371:	eb 0d                	jmp    103380 <curproc>
  103373:	90                   	nop
  103374:	90                   	nop
  103375:	90                   	nop
  103376:	90                   	nop
  103377:	90                   	nop
  103378:	90                   	nop
  103379:	90                   	nop
  10337a:	90                   	nop
  10337b:	90                   	nop
  10337c:	90                   	nop
  10337d:	90                   	nop
  10337e:	90                   	nop
  10337f:	90                   	nop

00103380 <curproc>:
}

// Return currently running process.
struct proc*
curproc(void)
{
  103380:	55                   	push   %ebp
  103381:	89 e5                	mov    %esp,%ebp
  103383:	53                   	push   %ebx
  103384:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;

  pushcli();
  103387:	e8 34 0b 00 00       	call   103ec0 <pushcli>
  p = cpus[cpu()].curproc;
  10338c:	e8 3f f5 ff ff       	call   1028d0 <cpu>
  103391:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103397:	8b 98 c4 aa 10 00    	mov    0x10aac4(%eax),%ebx
  popcli();
  10339d:	e8 9e 0a 00 00       	call   103e40 <popcli>
  return p;
}
  1033a2:	83 c4 04             	add    $0x4,%esp
  1033a5:	89 d8                	mov    %ebx,%eax
  1033a7:	5b                   	pop    %ebx
  1033a8:	5d                   	pop    %ebp
  1033a9:	c3                   	ret    
  1033aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001033b0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  1033b0:	55                   	push   %ebp
  1033b1:	89 e5                	mov    %esp,%ebp
  1033b3:	83 ec 18             	sub    $0x18,%esp
  // Still holding proc_table_lock from scheduler.
  release(&proc_table_lock);
  1033b6:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  1033bd:	e8 8e 0b 00 00       	call   103f50 <release>

  // Jump into assembly, never to return.
  forkret1(cp->tf);
  1033c2:	e8 b9 ff ff ff       	call   103380 <curproc>
  1033c7:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  1033cd:	89 04 24             	mov    %eax,(%esp)
  1033d0:	e8 e7 1d 00 00       	call   1051bc <forkret1>
}
  1033d5:	c9                   	leave  
  1033d6:	c3                   	ret    
  1033d7:	89 f6                	mov    %esi,%esi
  1033d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001033e0 <sched>:

// Enter scheduler.  Must already hold proc_table_lock
// and have changed curproc[cpu()]->state.
void
sched(void)
{
  1033e0:	55                   	push   %ebp
  1033e1:	89 e5                	mov    %esp,%ebp
  1033e3:	53                   	push   %ebx
  1033e4:	83 ec 14             	sub    $0x14,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  1033e7:	9c                   	pushf  
  1033e8:	58                   	pop    %eax
  if(read_eflags()&FL_IF)
  1033e9:	f6 c4 02             	test   $0x2,%ah
  1033ec:	75 5c                	jne    10344a <sched+0x6a>
    panic("sched interruptible");
  if(cp->state == RUNNING)
  1033ee:	e8 8d ff ff ff       	call   103380 <curproc>
  1033f3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  1033f7:	74 75                	je     10346e <sched+0x8e>
    panic("sched running");
  if(!holding(&proc_table_lock))
  1033f9:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103400:	e8 0b 0b 00 00       	call   103f10 <holding>
  103405:	85 c0                	test   %eax,%eax
  103407:	74 59                	je     103462 <sched+0x82>
    panic("sched proc_table_lock");
  if(cpus[cpu()].ncli != 1)
  103409:	e8 c2 f4 ff ff       	call   1028d0 <cpu>
  10340e:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103414:	83 b8 84 ab 10 00 01 	cmpl   $0x1,0x10ab84(%eax)
  10341b:	75 39                	jne    103456 <sched+0x76>
    panic("sched locks");

  swtch(&cp->context, &cpus[cpu()].context);
  10341d:	e8 ae f4 ff ff       	call   1028d0 <cpu>
  103422:	89 c3                	mov    %eax,%ebx
  103424:	e8 57 ff ff ff       	call   103380 <curproc>
  103429:	69 db cc 00 00 00    	imul   $0xcc,%ebx,%ebx
  10342f:	81 c3 c8 aa 10 00    	add    $0x10aac8,%ebx
  103435:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  103439:	83 c0 64             	add    $0x64,%eax
  10343c:	89 04 24             	mov    %eax,(%esp)
  10343f:	e8 b8 0d 00 00       	call   1041fc <swtch>
}
  103444:	83 c4 14             	add    $0x14,%esp
  103447:	5b                   	pop    %ebx
  103448:	5d                   	pop    %ebp
  103449:	c3                   	ret    
// and have changed curproc[cpu()]->state.
void
sched(void)
{
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  10344a:	c7 04 24 72 64 10 00 	movl   $0x106472,(%esp)
  103451:	e8 ca d4 ff ff       	call   100920 <panic>
  if(cp->state == RUNNING)
    panic("sched running");
  if(!holding(&proc_table_lock))
    panic("sched proc_table_lock");
  if(cpus[cpu()].ncli != 1)
    panic("sched locks");
  103456:	c7 04 24 aa 64 10 00 	movl   $0x1064aa,(%esp)
  10345d:	e8 be d4 ff ff       	call   100920 <panic>
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  if(cp->state == RUNNING)
    panic("sched running");
  if(!holding(&proc_table_lock))
    panic("sched proc_table_lock");
  103462:	c7 04 24 94 64 10 00 	movl   $0x106494,(%esp)
  103469:	e8 b2 d4 ff ff       	call   100920 <panic>
sched(void)
{
  if(read_eflags()&FL_IF)
    panic("sched interruptible");
  if(cp->state == RUNNING)
    panic("sched running");
  10346e:	c7 04 24 86 64 10 00 	movl   $0x106486,(%esp)
  103475:	e8 a6 d4 ff ff       	call   100920 <panic>
  10347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103480 <exit>:
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  103480:	55                   	push   %ebp
  103481:	89 e5                	mov    %esp,%ebp
  103483:	56                   	push   %esi
  103484:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(cp == initproc)
    panic("init exiting");
  103485:	31 db                	xor    %ebx,%ebx
// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
{
  103487:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int fd;

  if(cp == initproc)
  10348a:	e8 f1 fe ff ff       	call   103380 <curproc>
  10348f:	3b 05 48 78 10 00    	cmp    0x107848,%eax
  103495:	0f 84 36 01 00 00    	je     1035d1 <exit+0x151>
  10349b:	90                   	nop
  10349c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd]){
  1034a0:	e8 db fe ff ff       	call   103380 <curproc>
  1034a5:	8d 73 08             	lea    0x8(%ebx),%esi
  1034a8:	8b 04 b0             	mov    (%eax,%esi,4),%eax
  1034ab:	85 c0                	test   %eax,%eax
  1034ad:	74 1c                	je     1034cb <exit+0x4b>
      fileclose(cp->ofile[fd]);
  1034af:	e8 cc fe ff ff       	call   103380 <curproc>
  1034b4:	8b 04 b0             	mov    (%eax,%esi,4),%eax
  1034b7:	89 04 24             	mov    %eax,(%esp)
  1034ba:	e8 81 db ff ff       	call   101040 <fileclose>
      cp->ofile[fd] = 0;
  1034bf:	e8 bc fe ff ff       	call   103380 <curproc>
  1034c4:	c7 04 b0 00 00 00 00 	movl   $0x0,(%eax,%esi,4)

  if(cp == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
  1034cb:	83 c3 01             	add    $0x1,%ebx
  1034ce:	83 fb 10             	cmp    $0x10,%ebx
  1034d1:	75 cd                	jne    1034a0 <exit+0x20>
      fileclose(cp->ofile[fd]);
      cp->ofile[fd] = 0;
    }
  }

  iput(cp->cwd);
  1034d3:	e8 a8 fe ff ff       	call   103380 <curproc>
  1034d8:	8b 40 60             	mov    0x60(%eax),%eax
  1034db:	89 04 24             	mov    %eax,(%esp)
  1034de:	e8 0d e5 ff ff       	call   1019f0 <iput>
  cp->cwd = 0;
  1034e3:	e8 98 fe ff ff       	call   103380 <curproc>
  1034e8:	c7 40 60 00 00 00 00 	movl   $0x0,0x60(%eax)

  acquire(&proc_table_lock);
  1034ef:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  1034f6:	e8 95 0a 00 00       	call   103f90 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);
  1034fb:	e8 80 fe ff ff       	call   103380 <curproc>
  103500:	8b 50 14             	mov    0x14(%eax),%edx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103503:	b8 40 d7 10 00       	mov    $0x10d740,%eax
  103508:	3d 40 b1 10 00       	cmp    $0x10b140,%eax
  10350d:	0f 86 95 00 00 00    	jbe    1035a8 <exit+0x128>

// Exit the current process.  Does not return.
// Exited processes remain in the zombie state
// until their parent calls wait() to find out they exited.
void
exit(void)
  103513:	b8 40 b1 10 00       	mov    $0x10b140,%eax
  103518:	eb 12                	jmp    10352c <exit+0xac>
  10351a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103520:	05 98 00 00 00       	add    $0x98,%eax
  103525:	3d 40 d7 10 00       	cmp    $0x10d740,%eax
  10352a:	74 1e                	je     10354a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
  10352c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103530:	75 ee                	jne    103520 <exit+0xa0>
  103532:	3b 50 18             	cmp    0x18(%eax),%edx
  103535:	75 e9                	jne    103520 <exit+0xa0>
      p->state = RUNNABLE;
  103537:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  10353e:	05 98 00 00 00       	add    $0x98,%eax
  103543:	3d 40 d7 10 00       	cmp    $0x10d740,%eax
  103548:	75 e2                	jne    10352c <exit+0xac>
  10354a:	bb 40 b1 10 00       	mov    $0x10b140,%ebx
  10354f:	eb 15                	jmp    103566 <exit+0xe6>
  103551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = proc; p < &proc[NPROC]; p++){
  103558:	81 c3 98 00 00 00    	add    $0x98,%ebx
  10355e:	81 fb 40 d7 10 00    	cmp    $0x10d740,%ebx
  103564:	74 42                	je     1035a8 <exit+0x128>
    if(p->parent == cp){
  103566:	8b 73 14             	mov    0x14(%ebx),%esi
  103569:	e8 12 fe ff ff       	call   103380 <curproc>
  10356e:	39 c6                	cmp    %eax,%esi
  103570:	75 e6                	jne    103558 <exit+0xd8>
      p->parent = initproc;
  103572:	8b 15 48 78 10 00    	mov    0x107848,%edx
      if(p->state == ZOMBIE)
  103578:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
  wakeup1(cp->parent);

  // Pass abandoned children to init.
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->parent == cp){
      p->parent = initproc;
  10357c:	89 53 14             	mov    %edx,0x14(%ebx)
      if(p->state == ZOMBIE)
  10357f:	75 d7                	jne    103558 <exit+0xd8>
  103581:	b8 40 b1 10 00       	mov    $0x10b140,%eax
  103586:	eb 0c                	jmp    103594 <exit+0x114>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++)
  103588:	05 98 00 00 00       	add    $0x98,%eax
  10358d:	3d 40 d7 10 00       	cmp    $0x10d740,%eax
  103592:	74 c4                	je     103558 <exit+0xd8>
    if(p->state == SLEEPING && p->chan == chan)
  103594:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  103598:	75 ee                	jne    103588 <exit+0x108>
  10359a:	3b 50 18             	cmp    0x18(%eax),%edx
  10359d:	75 e9                	jne    103588 <exit+0x108>
      p->state = RUNNABLE;
  10359f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  1035a6:	eb e0                	jmp    103588 <exit+0x108>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  cp->killed = 0;
  1035a8:	e8 d3 fd ff ff       	call   103380 <curproc>
  1035ad:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  cp->state = ZOMBIE;
  1035b4:	e8 c7 fd ff ff       	call   103380 <curproc>
  1035b9:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
  1035c0:	e8 1b fe ff ff       	call   1033e0 <sched>
  panic("zombie exit");
  1035c5:	c7 04 24 c3 64 10 00 	movl   $0x1064c3,(%esp)
  1035cc:	e8 4f d3 ff ff       	call   100920 <panic>
{
  struct proc *p;
  int fd;

  if(cp == initproc)
    panic("init exiting");
  1035d1:	c7 04 24 b6 64 10 00 	movl   $0x1064b6,(%esp)
  1035d8:	e8 43 d3 ff ff       	call   100920 <panic>
  1035dd:	8d 76 00             	lea    0x0(%esi),%esi

001035e0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  1035e0:	55                   	push   %ebp
  1035e1:	89 e5                	mov    %esp,%ebp
  1035e3:	56                   	push   %esi
  1035e4:	53                   	push   %ebx
  1035e5:	83 ec 10             	sub    $0x10,%esp
  1035e8:	8b 75 08             	mov    0x8(%ebp),%esi
  1035eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(cp == 0)
  1035ee:	e8 8d fd ff ff       	call   103380 <curproc>
  1035f3:	85 c0                	test   %eax,%eax
  1035f5:	0f 84 9d 00 00 00    	je     103698 <sleep+0xb8>
    panic("sleep");

  if(lk == 0)
  1035fb:	85 db                	test   %ebx,%ebx
  1035fd:	0f 84 89 00 00 00    	je     10368c <sleep+0xac>
  // change p->state and then call sched.
  // Once we hold proc_table_lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with proc_table_lock locked),
  // so it's okay to release lk.
  if(lk != &proc_table_lock){
  103603:	81 fb 40 d7 10 00    	cmp    $0x10d740,%ebx
  103609:	74 55                	je     103660 <sleep+0x80>
    acquire(&proc_table_lock);
  10360b:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103612:	e8 79 09 00 00       	call   103f90 <acquire>
    release(lk);
  103617:	89 1c 24             	mov    %ebx,(%esp)
  10361a:	e8 31 09 00 00       	call   103f50 <release>
  }

  // Go to sleep.
  cp->chan = chan;
  10361f:	e8 5c fd ff ff       	call   103380 <curproc>
  103624:	89 70 18             	mov    %esi,0x18(%eax)
  cp->state = SLEEPING;
  103627:	e8 54 fd ff ff       	call   103380 <curproc>
  10362c:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103633:	e8 a8 fd ff ff       	call   1033e0 <sched>

  // Tidy up.
  cp->chan = 0;
  103638:	e8 43 fd ff ff       	call   103380 <curproc>
  10363d:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)

  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
  103644:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  10364b:	e8 00 09 00 00       	call   103f50 <release>
    acquire(lk);
  103650:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
  103653:	83 c4 10             	add    $0x10,%esp
  103656:	5b                   	pop    %ebx
  103657:	5e                   	pop    %esi
  103658:	5d                   	pop    %ebp
  cp->chan = 0;

  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
    acquire(lk);
  103659:	e9 32 09 00 00       	jmp    103f90 <acquire>
  10365e:	66 90                	xchg   %ax,%ax
    acquire(&proc_table_lock);
    release(lk);
  }

  // Go to sleep.
  cp->chan = chan;
  103660:	e8 1b fd ff ff       	call   103380 <curproc>
  103665:	89 70 18             	mov    %esi,0x18(%eax)
  cp->state = SLEEPING;
  103668:	e8 13 fd ff ff       	call   103380 <curproc>
  10366d:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
  103674:	e8 67 fd ff ff       	call   1033e0 <sched>

  // Tidy up.
  cp->chan = 0;
  103679:	e8 02 fd ff ff       	call   103380 <curproc>
  10367e:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  // Reacquire original lock.
  if(lk != &proc_table_lock){
    release(&proc_table_lock);
    acquire(lk);
  }
}
  103685:	83 c4 10             	add    $0x10,%esp
  103688:	5b                   	pop    %ebx
  103689:	5e                   	pop    %esi
  10368a:	5d                   	pop    %ebp
  10368b:	c3                   	ret    
{
  if(cp == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
  10368c:	c7 04 24 d5 64 10 00 	movl   $0x1064d5,(%esp)
  103693:	e8 88 d2 ff ff       	call   100920 <panic>
// Reacquires lock when reawakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(cp == 0)
    panic("sleep");
  103698:	c7 04 24 cf 64 10 00 	movl   $0x1064cf,(%esp)
  10369f:	e8 7c d2 ff ff       	call   100920 <panic>
  1036a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1036aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001036b0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  1036b0:	55                   	push   %ebp
  1036b1:	89 e5                	mov    %esp,%ebp
  1036b3:	57                   	push   %edi
  struct proc *p;
  int i, havekids, pid;

  acquire(&proc_table_lock);
  1036b4:	31 ff                	xor    %edi,%edi

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  1036b6:	56                   	push   %esi
  1036b7:	53                   	push   %ebx
  struct proc *p;
  int i, havekids, pid;

  acquire(&proc_table_lock);
  1036b8:	31 db                	xor    %ebx,%ebx

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  1036ba:	83 ec 2c             	sub    $0x2c,%esp
  struct proc *p;
  int i, havekids, pid;

  acquire(&proc_table_lock);
  1036bd:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  1036c4:	e8 c7 08 00 00       	call   103f90 <acquire>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  1036c9:	83 fb 3f             	cmp    $0x3f,%ebx
  1036cc:	7e 2f                	jle    1036fd <wait+0x4d>
  1036ce:	66 90                	xchg   %ax,%ax
        havekids = 1;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
  1036d0:	85 ff                	test   %edi,%edi
  1036d2:	74 74                	je     103748 <wait+0x98>
  1036d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1036d8:	e8 a3 fc ff ff       	call   103380 <curproc>
  1036dd:	8b 50 1c             	mov    0x1c(%eax),%edx
  1036e0:	85 d2                	test   %edx,%edx
  1036e2:	75 64                	jne    103748 <wait+0x98>
      release(&proc_table_lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  1036e4:	e8 97 fc ff ff       	call   103380 <curproc>
  1036e9:	31 ff                	xor    %edi,%edi
  1036eb:	31 db                	xor    %ebx,%ebx
  1036ed:	c7 44 24 04 40 d7 10 	movl   $0x10d740,0x4(%esp)
  1036f4:	00 
  1036f5:	89 04 24             	mov    %eax,(%esp)
  1036f8:	e8 e3 fe ff ff       	call   1035e0 <sleep>
  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
      p = &proc[i];
  1036fd:	69 f3 98 00 00 00    	imul   $0x98,%ebx,%esi
  103703:	81 c6 40 b1 10 00    	add    $0x10b140,%esi
      if(p->state == UNUSED)
  103709:	8b 4e 0c             	mov    0xc(%esi),%ecx
  10370c:	85 c9                	test   %ecx,%ecx
  10370e:	75 10                	jne    103720 <wait+0x70>

  acquire(&proc_table_lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(i = 0; i < NPROC; i++){
  103710:	83 c3 01             	add    $0x1,%ebx
  103713:	83 fb 3f             	cmp    $0x3f,%ebx
  103716:	7e e5                	jle    1036fd <wait+0x4d>
  103718:	eb b6                	jmp    1036d0 <wait+0x20>
  10371a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      p = &proc[i];
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
  103720:	8b 46 14             	mov    0x14(%esi),%eax
  103723:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103726:	e8 55 fc ff ff       	call   103380 <curproc>
  10372b:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  10372e:	66 90                	xchg   %ax,%ax
  103730:	75 de                	jne    103710 <wait+0x60>
        if(p->state == ZOMBIE){
  103732:	83 7e 0c 05          	cmpl   $0x5,0xc(%esi)
  103736:	74 29                	je     103761 <wait+0xb1>
          p->state = UNUSED;
          p->pid = 0;
          p->parent = 0;
          p->name[0] = 0;
          release(&proc_table_lock);
          return pid;
  103738:	bf 01 00 00 00       	mov    $0x1,%edi
  10373d:	8d 76 00             	lea    0x0(%esi),%esi
  103740:	eb ce                	jmp    103710 <wait+0x60>
  103742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || cp->killed){
      release(&proc_table_lock);
  103748:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  10374f:	e8 fc 07 00 00       	call   103f50 <release>
  103754:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(cp, &proc_table_lock);
  }
}
  103759:	83 c4 2c             	add    $0x2c,%esp
  10375c:	5b                   	pop    %ebx
  10375d:	5e                   	pop    %esi
  10375e:	5f                   	pop    %edi
  10375f:	5d                   	pop    %ebp
  103760:	c3                   	ret    
      if(p->state == UNUSED)
        continue;
      if(p->parent == cp){
        if(p->state == ZOMBIE){
          // Found one.
          kfree(p->mem, p->sz);
  103761:	8b 46 04             	mov    0x4(%esi),%eax
  103764:	89 44 24 04          	mov    %eax,0x4(%esp)
  103768:	8b 06                	mov    (%esi),%eax
  10376a:	89 04 24             	mov    %eax,(%esp)
  10376d:	e8 8e ec ff ff       	call   102400 <kfree>
          kfree(p->kstack, KSTACKSIZE);
  103772:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103779:	00 
  10377a:	8b 46 08             	mov    0x8(%esi),%eax
  10377d:	89 04 24             	mov    %eax,(%esp)
  103780:	e8 7b ec ff ff       	call   102400 <kfree>
          pid = p->pid;
  103785:	8b 46 10             	mov    0x10(%esi),%eax
          p->state = UNUSED;
          p->pid = 0;
          p->parent = 0;
          p->name[0] = 0;
  103788:	c6 86 88 00 00 00 00 	movb   $0x0,0x88(%esi)
        if(p->state == ZOMBIE){
          // Found one.
          kfree(p->mem, p->sz);
          kfree(p->kstack, KSTACKSIZE);
          pid = p->pid;
          p->state = UNUSED;
  10378f:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
          p->pid = 0;
  103796:	c7 46 10 00 00 00 00 	movl   $0x0,0x10(%esi)
          p->parent = 0;
  10379d:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
          p->name[0] = 0;
          release(&proc_table_lock);
  1037a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1037a7:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  1037ae:	e8 9d 07 00 00       	call   103f50 <release>
          return pid;
  1037b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1037b6:	eb a1                	jmp    103759 <wait+0xa9>
  1037b8:	90                   	nop
  1037b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001037c0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  1037c0:	55                   	push   %ebp
  1037c1:	89 e5                	mov    %esp,%ebp
  1037c3:	83 ec 18             	sub    $0x18,%esp
  acquire(&proc_table_lock);
  1037c6:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  1037cd:	e8 be 07 00 00       	call   103f90 <acquire>
  cp->state = RUNNABLE;
  1037d2:	e8 a9 fb ff ff       	call   103380 <curproc>
  1037d7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
  1037de:	e8 fd fb ff ff       	call   1033e0 <sched>
  release(&proc_table_lock);
  1037e3:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  1037ea:	e8 61 07 00 00       	call   103f50 <release>
}
  1037ef:	c9                   	leave  
  1037f0:	c3                   	ret    
  1037f1:	eb 0d                	jmp    103800 <setupsegs>
  1037f3:	90                   	nop
  1037f4:	90                   	nop
  1037f5:	90                   	nop
  1037f6:	90                   	nop
  1037f7:	90                   	nop
  1037f8:	90                   	nop
  1037f9:	90                   	nop
  1037fa:	90                   	nop
  1037fb:	90                   	nop
  1037fc:	90                   	nop
  1037fd:	90                   	nop
  1037fe:	90                   	nop
  1037ff:	90                   	nop

00103800 <setupsegs>:

// Set up CPU's segment descriptors and task state for a given process.
// If p==0, set up for "idle" state for when scheduler() is running.
void
setupsegs(struct proc *p)
{
  103800:	55                   	push   %ebp
  103801:	89 e5                	mov    %esp,%ebp
  103803:	57                   	push   %edi
  103804:	56                   	push   %esi
  103805:	53                   	push   %ebx
  103806:	83 ec 2c             	sub    $0x2c,%esp
  103809:	8b 75 08             	mov    0x8(%ebp),%esi
  struct cpu *c;
  
  pushcli();
  10380c:	e8 af 06 00 00       	call   103ec0 <pushcli>
  c = &cpus[cpu()];
  103811:	e8 ba f0 ff ff       	call   1028d0 <cpu>
  103816:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  10381c:	05 c0 aa 10 00       	add    $0x10aac0,%eax
  c->ts.ss0 = SEG_KDATA << 3;
  if(p)
  103821:	85 f6                	test   %esi,%esi
{
  struct cpu *c;
  
  pushcli();
  c = &cpus[cpu()];
  c->ts.ss0 = SEG_KDATA << 3;
  103823:	66 c7 40 30 10 00    	movw   $0x10,0x30(%eax)
  if(p)
  103829:	0f 84 a1 01 00 00    	je     1039d0 <setupsegs+0x1d0>
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  10382f:	8b 56 08             	mov    0x8(%esi),%edx
  103832:	81 c2 00 10 00 00    	add    $0x1000,%edx
  103838:	89 50 2c             	mov    %edx,0x2c(%eax)
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  10383b:	8d 50 28             	lea    0x28(%eax),%edx
  10383e:	89 d1                	mov    %edx,%ecx
  103840:	c1 e9 10             	shr    $0x10,%ecx
  103843:	66 89 90 ba 00 00 00 	mov    %dx,0xba(%eax)
  10384a:	c1 ea 18             	shr    $0x18,%edx
  c->gdt[SEG_TSS].s = 0;
  if(p){
  10384d:	85 f6                	test   %esi,%esi
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;

  c->gdt[0] = SEG_NULL;
  10384f:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
  103856:	00 00 00 
  103859:	c7 80 94 00 00 00 00 	movl   $0x0,0x94(%eax)
  103860:	00 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  103863:	66 c7 80 98 00 00 00 	movw   $0x10f,0x98(%eax)
  10386a:	0f 01 
  10386c:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
  103873:	00 00 
  103875:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
  10387c:	c6 80 9d 00 00 00 9a 	movb   $0x9a,0x9d(%eax)
  103883:	c6 80 9e 00 00 00 c0 	movb   $0xc0,0x9e(%eax)
  10388a:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  103891:	66 c7 80 a0 00 00 00 	movw   $0xffff,0xa0(%eax)
  103898:	ff ff 
  10389a:	66 c7 80 a2 00 00 00 	movw   $0x0,0xa2(%eax)
  1038a1:	00 00 
  1038a3:	c6 80 a4 00 00 00 00 	movb   $0x0,0xa4(%eax)
  1038aa:	c6 80 a5 00 00 00 92 	movb   $0x92,0xa5(%eax)
  1038b1:	c6 80 a6 00 00 00 cf 	movb   $0xcf,0xa6(%eax)
  1038b8:	c6 80 a7 00 00 00 00 	movb   $0x0,0xa7(%eax)
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  1038bf:	66 c7 80 b8 00 00 00 	movw   $0x67,0xb8(%eax)
  1038c6:	67 00 
  1038c8:	88 88 bc 00 00 00    	mov    %cl,0xbc(%eax)
  1038ce:	c6 80 be 00 00 00 40 	movb   $0x40,0xbe(%eax)
  1038d5:	88 90 bf 00 00 00    	mov    %dl,0xbf(%eax)
  c->gdt[SEG_TSS].s = 0;
  1038db:	c6 80 bd 00 00 00 89 	movb   $0x89,0xbd(%eax)
  if(p){
  1038e2:	0f 84 b8 00 00 00    	je     1039a0 <setupsegs+0x1a0>
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  1038e8:	8b 16                	mov    (%esi),%edx
  1038ea:	8b 5e 04             	mov    0x4(%esi),%ebx
  1038ed:	89 d6                	mov    %edx,%esi
  1038ef:	8d 4b ff             	lea    -0x1(%ebx),%ecx
  1038f2:	89 d3                	mov    %edx,%ebx
  1038f4:	c1 ee 10             	shr    $0x10,%esi
  1038f7:	89 cf                	mov    %ecx,%edi
  1038f9:	c1 eb 18             	shr    $0x18,%ebx
  1038fc:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
  1038ff:	89 f3                	mov    %esi,%ebx
  103901:	88 98 ac 00 00 00    	mov    %bl,0xac(%eax)
  103907:	89 cb                	mov    %ecx,%ebx
  103909:	c1 eb 1c             	shr    $0x1c,%ebx
  10390c:	89 d9                	mov    %ebx,%ecx
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  10390e:	83 cb c0             	or     $0xffffffc0,%ebx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  c->gdt[SEG_TSS].s = 0;
  if(p){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  103911:	83 c9 c0             	or     $0xffffffc0,%ecx
  103914:	c6 80 ad 00 00 00 fa 	movb   $0xfa,0xad(%eax)
  10391b:	c1 ef 0c             	shr    $0xc,%edi
  10391e:	88 88 ae 00 00 00    	mov    %cl,0xae(%eax)
  103924:	0f b6 4d d4          	movzbl -0x2c(%ebp),%ecx
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  103928:	c6 80 b5 00 00 00 f2 	movb   $0xf2,0xb5(%eax)
  10392f:	88 98 b6 00 00 00    	mov    %bl,0xb6(%eax)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  c->gdt[SEG_TSS].s = 0;
  if(p){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  103935:	66 89 90 aa 00 00 00 	mov    %dx,0xaa(%eax)
  10393c:	88 88 af 00 00 00    	mov    %cl,0xaf(%eax)
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  103942:	0f b6 4d d4          	movzbl -0x2c(%ebp),%ecx
  103946:	66 89 90 b2 00 00 00 	mov    %dx,0xb2(%eax)
  10394d:	89 f2                	mov    %esi,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
  c->gdt[SEG_TSS].s = 0;
  if(p){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
  10394f:	66 89 b8 a8 00 00 00 	mov    %di,0xa8(%eax)
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  103956:	66 89 b8 b0 00 00 00 	mov    %di,0xb0(%eax)
  10395d:	88 90 b4 00 00 00    	mov    %dl,0xb4(%eax)
  103963:	88 88 b7 00 00 00    	mov    %cl,0xb7(%eax)
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
    c->gdt[SEG_UDATA] = SEG_NULL;
  }

  lgdt(c->gdt, sizeof(c->gdt));
  103969:	05 90 00 00 00       	add    $0x90,%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  10396e:	66 c7 45 e2 2f 00    	movw   $0x2f,-0x1e(%ebp)
  pd[1] = (uint)p;
  103974:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  pd[2] = (uint)p >> 16;
  103978:	c1 e8 10             	shr    $0x10,%eax
  10397b:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
  10397f:	8d 45 e2             	lea    -0x1e(%ebp),%eax
  103982:	0f 01 10             	lgdtl  (%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
  103985:	b8 28 00 00 00       	mov    $0x28,%eax
  10398a:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  popcli();
  10398d:	e8 ae 04 00 00       	call   103e40 <popcli>
}
  103992:	83 c4 2c             	add    $0x2c,%esp
  103995:	5b                   	pop    %ebx
  103996:	5e                   	pop    %esi
  103997:	5f                   	pop    %edi
  103998:	5d                   	pop    %ebp
  103999:	c3                   	ret    
  10399a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c->gdt[SEG_TSS].s = 0;
  if(p){
    c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
    c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
  } else {
    c->gdt[SEG_UCODE] = SEG_NULL;
  1039a0:	c7 80 a8 00 00 00 00 	movl   $0x0,0xa8(%eax)
  1039a7:	00 00 00 
  1039aa:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
  1039b1:	00 00 00 
    c->gdt[SEG_UDATA] = SEG_NULL;
  1039b4:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
  1039bb:	00 00 00 
  1039be:	c7 80 b4 00 00 00 00 	movl   $0x0,0xb4(%eax)
  1039c5:	00 00 00 
  1039c8:	eb 9f                	jmp    103969 <setupsegs+0x169>
  1039ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c = &cpus[cpu()];
  c->ts.ss0 = SEG_KDATA << 3;
  if(p)
    c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
  else
    c->ts.esp0 = 0xffffffff;
  1039d0:	c7 40 2c ff ff ff ff 	movl   $0xffffffff,0x2c(%eax)
  1039d7:	e9 5f fe ff ff       	jmp    10383b <setupsegs+0x3b>
  1039dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001039e0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  1039e0:	55                   	push   %ebp
  1039e1:	89 e5                	mov    %esp,%ebp
  1039e3:	57                   	push   %edi
  1039e4:	56                   	push   %esi
  1039e5:	53                   	push   %ebx
  1039e6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c;
  int i;

  c = &cpus[cpu()];
  1039e9:	e8 e2 ee ff ff       	call   1028d0 <cpu>
  1039ee:	69 f0 cc 00 00 00    	imul   $0xcc,%eax,%esi
  1039f4:	81 c6 c0 aa 10 00    	add    $0x10aac0,%esi
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
      setupsegs(p);
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  1039fa:	8d 7e 08             	lea    0x8(%esi),%edi
  1039fd:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
  103a00:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
  103a01:	bb 4c b1 10 00       	mov    $0x10b14c,%ebx
  103a06:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103a0d:	e8 7e 05 00 00       	call   103f90 <acquire>
  103a12:	eb 12                	jmp    103a26 <scheduler+0x46>
  103a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      swtch(&c->context, &p->context);

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
      setupsegs(0);
  103a18:	81 c3 98 00 00 00    	add    $0x98,%ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
  103a1e:	81 fb 4c d7 10 00    	cmp    $0x10d74c,%ebx
  103a24:	74 4a                	je     103a70 <scheduler+0x90>
      p = &proc[i];
      if(p->state != RUNNABLE)
  103a26:	83 3b 03             	cmpl   $0x3,(%ebx)
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
  103a29:	8d 43 f4             	lea    -0xc(%ebx),%eax

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
      p = &proc[i];
      if(p->state != RUNNABLE)
  103a2c:	75 ea                	jne    103a18 <scheduler+0x38>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
  103a2e:	89 46 04             	mov    %eax,0x4(%esi)
      setupsegs(p);
  103a31:	89 04 24             	mov    %eax,(%esp)
  103a34:	e8 c7 fd ff ff       	call   103800 <setupsegs>
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  103a39:	8d 43 58             	lea    0x58(%ebx),%eax
      // Switch to chosen process.  It is the process's job
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
      setupsegs(p);
      p->state = RUNNING;
  103a3c:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
      swtch(&c->context, &p->context);

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
      setupsegs(0);
  103a42:	81 c3 98 00 00 00    	add    $0x98,%ebx
      // to release proc_table_lock and then reacquire it
      // before jumping back to us.
      c->curproc = p;
      setupsegs(p);
      p->state = RUNNING;
      swtch(&c->context, &p->context);
  103a48:	89 44 24 04          	mov    %eax,0x4(%esp)
  103a4c:	89 3c 24             	mov    %edi,(%esp)
  103a4f:	e8 a8 07 00 00       	call   1041fc <swtch>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
  103a54:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
      setupsegs(0);
  103a5b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103a62:	e8 99 fd ff ff       	call   103800 <setupsegs>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&proc_table_lock);
    for(i = 0; i < NPROC; i++){
  103a67:	81 fb 4c d7 10 00    	cmp    $0x10d74c,%ebx
  103a6d:	75 b7                	jne    103a26 <scheduler+0x46>
  103a6f:	90                   	nop
      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->curproc = 0;
      setupsegs(0);
    }
    release(&proc_table_lock);
  103a70:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103a77:	e8 d4 04 00 00       	call   103f50 <release>

  }
  103a7c:	eb 82                	jmp    103a00 <scheduler+0x20>
  103a7e:	66 90                	xchg   %ax,%ax

00103a80 <growproc>:

// Grow current process's memory by n bytes.
// Return old size on success, -1 on failure.
int
growproc(int n)
{
  103a80:	55                   	push   %ebp
  103a81:	89 e5                	mov    %esp,%ebp
  103a83:	57                   	push   %edi
  103a84:	56                   	push   %esi
  103a85:	53                   	push   %ebx
  103a86:	83 ec 1c             	sub    $0x1c,%esp
  103a89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *newmem, *oldmem;

  newmem = kalloc(cp->sz + n);
  103a8c:	e8 ef f8 ff ff       	call   103380 <curproc>
  103a91:	8b 50 04             	mov    0x4(%eax),%edx
  103a94:	8d 04 13             	lea    (%ebx,%edx,1),%eax
  103a97:	89 04 24             	mov    %eax,(%esp)
  103a9a:	e8 a1 e8 ff ff       	call   102340 <kalloc>
  103a9f:	89 c6                	mov    %eax,%esi
  if(newmem == 0)
  103aa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  103aa6:	85 f6                	test   %esi,%esi
  103aa8:	74 7f                	je     103b29 <growproc+0xa9>
    return -1;
  memmove(newmem, cp->mem, cp->sz);
  103aaa:	e8 d1 f8 ff ff       	call   103380 <curproc>
  103aaf:	8b 78 04             	mov    0x4(%eax),%edi
  103ab2:	e8 c9 f8 ff ff       	call   103380 <curproc>
  103ab7:	89 7c 24 08          	mov    %edi,0x8(%esp)
  103abb:	8b 00                	mov    (%eax),%eax
  103abd:	89 34 24             	mov    %esi,(%esp)
  103ac0:	89 44 24 04          	mov    %eax,0x4(%esp)
  103ac4:	e8 c7 05 00 00       	call   104090 <memmove>
  memset(newmem + cp->sz, 0, n);
  103ac9:	e8 b2 f8 ff ff       	call   103380 <curproc>
  103ace:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  103ad2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103ad9:	00 
  103ada:	8b 50 04             	mov    0x4(%eax),%edx
  103add:	8d 04 16             	lea    (%esi,%edx,1),%eax
  103ae0:	89 04 24             	mov    %eax,(%esp)
  103ae3:	e8 18 05 00 00       	call   104000 <memset>
  oldmem = cp->mem;
  103ae8:	e8 93 f8 ff ff       	call   103380 <curproc>
  103aed:	8b 38                	mov    (%eax),%edi
  cp->mem = newmem;
  103aef:	e8 8c f8 ff ff       	call   103380 <curproc>
  103af4:	89 30                	mov    %esi,(%eax)
  kfree(oldmem, cp->sz);
  103af6:	e8 85 f8 ff ff       	call   103380 <curproc>
  103afb:	8b 40 04             	mov    0x4(%eax),%eax
  103afe:	89 3c 24             	mov    %edi,(%esp)
  103b01:	89 44 24 04          	mov    %eax,0x4(%esp)
  103b05:	e8 f6 e8 ff ff       	call   102400 <kfree>
  cp->sz += n;
  103b0a:	e8 71 f8 ff ff       	call   103380 <curproc>
  103b0f:	01 58 04             	add    %ebx,0x4(%eax)
  setupsegs(cp);
  103b12:	e8 69 f8 ff ff       	call   103380 <curproc>
  103b17:	89 04 24             	mov    %eax,(%esp)
  103b1a:	e8 e1 fc ff ff       	call   103800 <setupsegs>
  return cp->sz - n;
  103b1f:	e8 5c f8 ff ff       	call   103380 <curproc>
  103b24:	8b 40 04             	mov    0x4(%eax),%eax
  103b27:	29 d8                	sub    %ebx,%eax
}
  103b29:	83 c4 1c             	add    $0x1c,%esp
  103b2c:	5b                   	pop    %ebx
  103b2d:	5e                   	pop    %esi
  103b2e:	5f                   	pop    %edi
  103b2f:	5d                   	pop    %ebp
  103b30:	c3                   	ret    
  103b31:	eb 0d                	jmp    103b40 <copyproc>
  103b33:	90                   	nop
  103b34:	90                   	nop
  103b35:	90                   	nop
  103b36:	90                   	nop
  103b37:	90                   	nop
  103b38:	90                   	nop
  103b39:	90                   	nop
  103b3a:	90                   	nop
  103b3b:	90                   	nop
  103b3c:	90                   	nop
  103b3d:	90                   	nop
  103b3e:	90                   	nop
  103b3f:	90                   	nop

00103b40 <copyproc>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
{
  103b40:	55                   	push   %ebp
  103b41:	89 e5                	mov    %esp,%ebp
  103b43:	57                   	push   %edi
  103b44:	56                   	push   %esi
  103b45:	53                   	push   %ebx
allocproc(void)
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  103b46:	bb 40 b1 10 00       	mov    $0x10b140,%ebx
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
struct proc*
copyproc(struct proc *p)
{
  103b4b:	83 ec 1c             	sub    $0x1c,%esp
  103b4e:	8b 7d 08             	mov    0x8(%ebp),%edi
allocproc(void)
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  103b51:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103b58:	e8 33 04 00 00       	call   103f90 <acquire>
  103b5d:	eb 13                	jmp    103b72 <copyproc+0x32>
  103b5f:	90                   	nop
{
  int i;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  103b60:	81 c3 98 00 00 00    	add    $0x98,%ebx
{
  int i;
  struct proc *p;

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
  103b66:	81 fb 40 d7 10 00    	cmp    $0x10d740,%ebx
  103b6c:	0f 84 0e 01 00 00    	je     103c80 <copyproc+0x140>
    p = &proc[i];
    if(p->state == UNUSED){
  103b72:	8b 73 0c             	mov    0xc(%ebx),%esi
  103b75:	85 f6                	test   %esi,%esi
  103b77:	75 e7                	jne    103b60 <copyproc+0x20>
      p->state = EMBRYO;
      p->pid = nextpid++;
  103b79:	a1 04 73 10 00       	mov    0x107304,%eax
  struct proc *p;

  acquire(&proc_table_lock);
  for(i = 0; i < NPROC; i++){
    p = &proc[i];
    if(p->state == UNUSED){
  103b7e:	89 de                	mov    %ebx,%esi
      p->state = EMBRYO;
  103b80:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
      p->pid = nextpid++;
  103b87:	89 43 10             	mov    %eax,0x10(%ebx)
  103b8a:	83 c0 01             	add    $0x1,%eax
  103b8d:	a3 04 73 10 00       	mov    %eax,0x107304
      release(&proc_table_lock);
  103b92:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103b99:	e8 b2 03 00 00       	call   103f50 <release>
{
  int i;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
  103b9e:	85 db                	test   %ebx,%ebx
  103ba0:	0f 84 d0 00 00 00    	je     103c76 <copyproc+0x136>
    return 0;

  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
  103ba6:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  103bad:	e8 8e e7 ff ff       	call   102340 <kalloc>
  103bb2:	85 c0                	test   %eax,%eax
  103bb4:	89 43 08             	mov    %eax,0x8(%ebx)
  103bb7:	0f 84 f5 00 00 00    	je     103cb2 <copyproc+0x172>
    np->state = UNUSED;
    return 0;
  }
  np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
  103bbd:	05 bc 0f 00 00       	add    $0xfbc,%eax

  if(p){  // Copy process state from p.
  103bc2:	85 ff                	test   %edi,%edi
  // Allocate kernel stack.
  if((np->kstack = kalloc(KSTACKSIZE)) == 0){
    np->state = UNUSED;
    return 0;
  }
  np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
  103bc4:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)

  if(p){  // Copy process state from p.
  103bca:	74 76                	je     103c42 <copyproc+0x102>
    np->parent = p;
  103bcc:	89 7b 14             	mov    %edi,0x14(%ebx)
    memmove(np->tf, p->tf, sizeof(*np->tf));
  103bcf:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  103bd6:	00 
  103bd7:	8b 97 84 00 00 00    	mov    0x84(%edi),%edx
  103bdd:	89 04 24             	mov    %eax,(%esp)
  103be0:	89 54 24 04          	mov    %edx,0x4(%esp)
  103be4:	e8 a7 04 00 00       	call   104090 <memmove>
  
    np->sz = p->sz;
  103be9:	8b 47 04             	mov    0x4(%edi),%eax
  103bec:	89 43 04             	mov    %eax,0x4(%ebx)
    if((np->mem = kalloc(np->sz)) == 0){
  103bef:	89 04 24             	mov    %eax,(%esp)
  103bf2:	e8 49 e7 ff ff       	call   102340 <kalloc>
  103bf7:	85 c0                	test   %eax,%eax
  103bf9:	89 03                	mov    %eax,(%ebx)
  103bfb:	0f 84 97 00 00 00    	je     103c98 <copyproc+0x158>
      kfree(np->kstack, KSTACKSIZE);
      np->kstack = 0;
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);
  103c01:	8b 53 04             	mov    0x4(%ebx),%edx
  103c04:	31 f6                	xor    %esi,%esi
  103c06:	89 54 24 08          	mov    %edx,0x8(%esp)
  103c0a:	8b 17                	mov    (%edi),%edx
  103c0c:	89 04 24             	mov    %eax,(%esp)
  103c0f:	89 54 24 04          	mov    %edx,0x4(%esp)
  103c13:	e8 78 04 00 00       	call   104090 <memmove>

    for(i = 0; i < NOFILE; i++)
      if(p->ofile[i])
  103c18:	8b 44 b7 20          	mov    0x20(%edi,%esi,4),%eax
  103c1c:	85 c0                	test   %eax,%eax
  103c1e:	74 0c                	je     103c2c <copyproc+0xec>
        np->ofile[i] = filedup(p->ofile[i]);
  103c20:	89 04 24             	mov    %eax,(%esp)
  103c23:	e8 38 d3 ff ff       	call   100f60 <filedup>
  103c28:	89 44 b3 20          	mov    %eax,0x20(%ebx,%esi,4)
      np->state = UNUSED;
      return 0;
    }
    memmove(np->mem, p->mem, np->sz);

    for(i = 0; i < NOFILE; i++)
  103c2c:	83 c6 01             	add    $0x1,%esi
  103c2f:	83 fe 10             	cmp    $0x10,%esi
  103c32:	75 e4                	jne    103c18 <copyproc+0xd8>
      if(p->ofile[i])
        np->ofile[i] = filedup(p->ofile[i]);
    np->cwd = idup(p->cwd);
  103c34:	8b 47 60             	mov    0x60(%edi),%eax
  103c37:	89 04 24             	mov    %eax,(%esp)
  103c3a:	e8 31 d5 ff ff       	call   101170 <idup>
  103c3f:	89 43 60             	mov    %eax,0x60(%ebx)
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  103c42:	8d 43 64             	lea    0x64(%ebx),%eax
  np->context.eip = (uint)forkret;
  np->context.esp = (uint)np->tf;

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  103c45:	89 de                	mov    %ebx,%esi
        np->ofile[i] = filedup(p->ofile[i]);
    np->cwd = idup(p->cwd);
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  103c47:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
  103c4e:	00 
  103c4f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103c56:	00 
  103c57:	89 04 24             	mov    %eax,(%esp)
  103c5a:	e8 a1 03 00 00       	call   104000 <memset>
  np->context.eip = (uint)forkret;
  np->context.esp = (uint)np->tf;
  103c5f:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
    np->cwd = idup(p->cwd);
  }

  // Set up new context to start executing at forkret (see below).
  memset(&np->context, 0, sizeof(np->context));
  np->context.eip = (uint)forkret;
  103c65:	c7 43 64 b0 33 10 00 	movl   $0x1033b0,0x64(%ebx)
  np->context.esp = (uint)np->tf;
  103c6c:	89 43 68             	mov    %eax,0x68(%ebx)

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  103c6f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  return np;
}
  103c76:	83 c4 1c             	add    $0x1c,%esp
  103c79:	89 f0                	mov    %esi,%eax
  103c7b:	5b                   	pop    %ebx
  103c7c:	5e                   	pop    %esi
  103c7d:	5f                   	pop    %edi
  103c7e:	5d                   	pop    %ebp
  103c7f:	c3                   	ret    
      p->pid = nextpid++;
      release(&proc_table_lock);
      return p;
    }
  }
  release(&proc_table_lock);
  103c80:	31 f6                	xor    %esi,%esi
  103c82:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103c89:	e8 c2 02 00 00       	call   103f50 <release>
  np->context.esp = (uint)np->tf;

  // Clear %eax so that fork system call returns 0 in child.
  np->tf->eax = 0;
  return np;
}
  103c8e:	83 c4 1c             	add    $0x1c,%esp
  103c91:	89 f0                	mov    %esi,%eax
  103c93:	5b                   	pop    %ebx
  103c94:	5e                   	pop    %esi
  103c95:	5f                   	pop    %edi
  103c96:	5d                   	pop    %ebp
  103c97:	c3                   	ret    
    np->parent = p;
    memmove(np->tf, p->tf, sizeof(*np->tf));
  
    np->sz = p->sz;
    if((np->mem = kalloc(np->sz)) == 0){
      kfree(np->kstack, KSTACKSIZE);
  103c98:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103c9f:	00 
  103ca0:	8b 43 08             	mov    0x8(%ebx),%eax
  103ca3:	89 04 24             	mov    %eax,(%esp)
  103ca6:	e8 55 e7 ff ff       	call   102400 <kfree>
      np->kstack = 0;
  103cab:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
      np->state = UNUSED;
  103cb2:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  103cb9:	31 f6                	xor    %esi,%esi
      return 0;
  103cbb:	eb b9                	jmp    103c76 <copyproc+0x136>
  103cbd:	8d 76 00             	lea    0x0(%esi),%esi

00103cc0 <userinit>:
}

// Set up first user process.
void
userinit(void)
{
  103cc0:	55                   	push   %ebp
  103cc1:	89 e5                	mov    %esp,%ebp
  103cc3:	53                   	push   %ebx
  103cc4:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = copyproc(0);
  103cc7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  103cce:	e8 6d fe ff ff       	call   103b40 <copyproc>
  p->sz = PAGE;
  103cd3:	c7 40 04 00 10 00 00 	movl   $0x1000,0x4(%eax)
userinit(void)
{
  struct proc *p;
  extern uchar _binary_initcode_start[], _binary_initcode_size[];
  
  p = copyproc(0);
  103cda:	89 c3                	mov    %eax,%ebx
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  103cdc:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  103ce3:	e8 58 e6 ff ff       	call   102340 <kalloc>
  103ce8:	89 03                	mov    %eax,(%ebx)
  p->cwd = namei("/");
  103cea:	c7 04 24 e6 64 10 00 	movl   $0x1064e6,(%esp)
  103cf1:	e8 6a e2 ff ff       	call   101f60 <namei>
  103cf6:	89 43 60             	mov    %eax,0x60(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
  103cf9:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  103d00:	00 
  103d01:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103d08:	00 
  103d09:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  103d0f:	89 04 24             	mov    %eax,(%esp)
  103d12:	e8 e9 02 00 00       	call   104000 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  103d17:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  103d1d:	8b 0b                	mov    (%ebx),%ecx
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  103d1f:	c7 40 38 00 02 00 00 	movl   $0x200,0x38(%eax)
  p->tf->esp = p->sz;
  103d26:	8b 53 04             	mov    0x4(%ebx),%edx
  p = copyproc(0);
  p->sz = PAGE;
  p->mem = kalloc(p->sz);
  p->cwd = namei("/");
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  103d29:	66 c7 40 34 1b 00    	movw   $0x1b,0x34(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  103d2f:	66 c7 40 24 23 00    	movw   $0x23,0x24(%eax)
  p->tf->es = p->tf->ds;
  103d35:	66 c7 40 20 23 00    	movw   $0x23,0x20(%eax)
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  103d3b:	89 50 3c             	mov    %edx,0x3c(%eax)
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  103d3e:	83 68 3c 04          	subl   $0x4,0x3c(%eax)
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  103d42:	8b 50 3c             	mov    0x3c(%eax),%edx
  p->cwd = namei("/");
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  103d45:	66 c7 40 40 23 00    	movw   $0x23,0x40(%eax)
  p->tf->eflags = FL_IF;
  p->tf->esp = p->sz;
  
  // Make return address readable; needed for some gcc.
  p->tf->esp -= 4;
  *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
  103d4b:	c7 04 11 ef ef ef ef 	movl   $0xefefefef,(%ecx,%edx,1)

  // On entry to user space, start executing at beginning of initcode.S.
  p->tf->eip = 0;
  103d52:	c7 40 30 00 00 00 00 	movl   $0x0,0x30(%eax)
  memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
  103d59:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
  103d60:	00 
  103d61:	c7 44 24 04 08 77 10 	movl   $0x107708,0x4(%esp)
  103d68:	00 
  103d69:	8b 03                	mov    (%ebx),%eax
  103d6b:	89 04 24             	mov    %eax,(%esp)
  103d6e:	e8 1d 03 00 00       	call   104090 <memmove>
  safestrcpy(p->name, "initcode", sizeof(p->name));
  103d73:	8d 83 88 00 00 00    	lea    0x88(%ebx),%eax
  103d79:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  103d80:	00 
  103d81:	c7 44 24 04 e8 64 10 	movl   $0x1064e8,0x4(%esp)
  103d88:	00 
  103d89:	89 04 24             	mov    %eax,(%esp)
  103d8c:	e8 0f 04 00 00       	call   1041a0 <safestrcpy>
  p->state = RUNNABLE;
  103d91:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  
  initproc = p;
  103d98:	89 1d 48 78 10 00    	mov    %ebx,0x107848
}
  103d9e:	83 c4 14             	add    $0x14,%esp
  103da1:	5b                   	pop    %ebx
  103da2:	5d                   	pop    %ebp
  103da3:	c3                   	ret    
  103da4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  103daa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00103db0 <pinit>:
extern void forkret(void);
extern void forkret1(struct trapframe*);

void
pinit(void)
{
  103db0:	55                   	push   %ebp
  103db1:	89 e5                	mov    %esp,%ebp
  103db3:	83 ec 18             	sub    $0x18,%esp
  initlock(&proc_table_lock, "proc_table");
  103db6:	c7 44 24 04 f1 64 10 	movl   $0x1064f1,0x4(%esp)
  103dbd:	00 
  103dbe:	c7 04 24 40 d7 10 00 	movl   $0x10d740,(%esp)
  103dc5:	e8 06 00 00 00       	call   103dd0 <initlock>
}
  103dca:	c9                   	leave  
  103dcb:	c3                   	ret    
  103dcc:	90                   	nop
  103dcd:	90                   	nop
  103dce:	90                   	nop
  103dcf:	90                   	nop

00103dd0 <initlock>:

extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  103dd0:	55                   	push   %ebp
  103dd1:	89 e5                	mov    %esp,%ebp
  103dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  lock->name = name;
  103dd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lock->locked = 0;
  103dd9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
extern int use_console_lock;

void
initlock(struct spinlock *lock, char *name)
{
  lock->name = name;
  103ddf:	89 50 04             	mov    %edx,0x4(%eax)
  lock->locked = 0;
  lock->cpu = 0xffffffff;
  103de2:	c7 40 08 ff ff ff ff 	movl   $0xffffffff,0x8(%eax)
}
  103de9:	5d                   	pop    %ebp
  103dea:	c3                   	ret    
  103deb:	90                   	nop
  103dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103df0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103df0:	55                   	push   %ebp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103df1:	31 c0                	xor    %eax,%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103df3:	89 e5                	mov    %esp,%ebp
  103df5:	53                   	push   %ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103df6:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
  103df9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  103dfc:	83 ea 08             	sub    $0x8,%edx
  103dff:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp == (uint*)0xffffffff)
  103e00:	8d 4a ff             	lea    -0x1(%edx),%ecx
  103e03:	83 f9 fd             	cmp    $0xfffffffd,%ecx
  103e06:	77 18                	ja     103e20 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
  103e08:	8b 4a 04             	mov    0x4(%edx),%ecx
  103e0b:	89 0c 83             	mov    %ecx,(%ebx,%eax,4)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103e0e:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103e11:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
  103e13:	83 f8 0a             	cmp    $0xa,%eax
  103e16:	75 e8                	jne    103e00 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
  103e18:	5b                   	pop    %ebx
  103e19:	5d                   	pop    %ebp
  103e1a:	c3                   	ret    
  103e1b:	90                   	nop
  103e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103e20:	83 f8 09             	cmp    $0x9,%eax
  103e23:	7f f3                	jg     103e18 <getcallerpcs+0x28>
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  103e25:	8d 14 83             	lea    (%ebx,%eax,4),%edx
  }
  for(; i < 10; i++)
  103e28:	83 c0 01             	add    $0x1,%eax
    pcs[i] = 0;
  103e2b:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
    if(ebp == 0 || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
  103e31:	83 c2 04             	add    $0x4,%edx
  103e34:	83 f8 0a             	cmp    $0xa,%eax
  103e37:	75 ef                	jne    103e28 <getcallerpcs+0x38>
    pcs[i] = 0;
}
  103e39:	5b                   	pop    %ebx
  103e3a:	5d                   	pop    %ebp
  103e3b:	c3                   	ret    
  103e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00103e40 <popcli>:
    cpus[cpu()].intena = eflags & FL_IF;
}

void
popcli(void)
{
  103e40:	55                   	push   %ebp
  103e41:	89 e5                	mov    %esp,%ebp
  103e43:	83 ec 18             	sub    $0x18,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103e46:	9c                   	pushf  
  103e47:	58                   	pop    %eax
  if(read_eflags()&FL_IF)
  103e48:	f6 c4 02             	test   $0x2,%ah
  103e4b:	75 5f                	jne    103eac <popcli+0x6c>
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
  103e4d:	e8 7e ea ff ff       	call   1028d0 <cpu>
  103e52:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103e58:	05 c4 aa 10 00       	add    $0x10aac4,%eax
  103e5d:	8b 90 c0 00 00 00    	mov    0xc0(%eax),%edx
  103e63:	83 ea 01             	sub    $0x1,%edx
  103e66:	85 d2                	test   %edx,%edx
  103e68:	89 90 c0 00 00 00    	mov    %edx,0xc0(%eax)
  103e6e:	78 30                	js     103ea0 <popcli+0x60>
    panic("popcli");
  if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
  103e70:	e8 5b ea ff ff       	call   1028d0 <cpu>
  103e75:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103e7b:	8b 90 84 ab 10 00    	mov    0x10ab84(%eax),%edx
  103e81:	85 d2                	test   %edx,%edx
  103e83:	74 03                	je     103e88 <popcli+0x48>
    sti();
}
  103e85:	c9                   	leave  
  103e86:	c3                   	ret    
  103e87:	90                   	nop
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
    panic("popcli");
  if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
  103e88:	e8 43 ea ff ff       	call   1028d0 <cpu>
  103e8d:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103e93:	8b 80 88 ab 10 00    	mov    0x10ab88(%eax),%eax
  103e99:	85 c0                	test   %eax,%eax
  103e9b:	74 e8                	je     103e85 <popcli+0x45>
}

static inline void
sti(void)
{
  asm volatile("sti");
  103e9d:	fb                   	sti    
    sti();
}
  103e9e:	c9                   	leave  
  103e9f:	c3                   	ret    
popcli(void)
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpus[cpu()].ncli < 0)
    panic("popcli");
  103ea0:	c7 04 24 57 65 10 00 	movl   $0x106557,(%esp)
  103ea7:	e8 74 ca ff ff       	call   100920 <panic>

void
popcli(void)
{
  if(read_eflags()&FL_IF)
    panic("popcli - interruptible");
  103eac:	c7 04 24 40 65 10 00 	movl   $0x106540,(%esp)
  103eb3:	e8 68 ca ff ff       	call   100920 <panic>
  103eb8:	90                   	nop
  103eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00103ec0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
  103ec0:	55                   	push   %ebp
  103ec1:	89 e5                	mov    %esp,%ebp
  103ec3:	53                   	push   %ebx
  103ec4:	83 ec 04             	sub    $0x4,%esp

static inline uint
read_eflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
  103ec7:	9c                   	pushf  
  103ec8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
  103ec9:	fa                   	cli    
  int eflags;
  
  eflags = read_eflags();
  cli();
  if(cpus[cpu()].ncli++ == 0)
  103eca:	e8 01 ea ff ff       	call   1028d0 <cpu>
  103ecf:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103ed5:	05 c4 aa 10 00       	add    $0x10aac4,%eax
  103eda:	8b 90 c0 00 00 00    	mov    0xc0(%eax),%edx
  103ee0:	8d 4a 01             	lea    0x1(%edx),%ecx
  103ee3:	85 d2                	test   %edx,%edx
  103ee5:	89 88 c0 00 00 00    	mov    %ecx,0xc0(%eax)
  103eeb:	75 17                	jne    103f04 <pushcli+0x44>
    cpus[cpu()].intena = eflags & FL_IF;
  103eed:	e8 de e9 ff ff       	call   1028d0 <cpu>
  103ef2:	81 e3 00 02 00 00    	and    $0x200,%ebx
  103ef8:	69 c0 cc 00 00 00    	imul   $0xcc,%eax,%eax
  103efe:	89 98 88 ab 10 00    	mov    %ebx,0x10ab88(%eax)
}
  103f04:	83 c4 04             	add    $0x4,%esp
  103f07:	5b                   	pop    %ebx
  103f08:	5d                   	pop    %ebp
  103f09:	c3                   	ret    
  103f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00103f10 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103f10:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu() + 10;
  103f11:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  103f13:	89 e5                	mov    %esp,%ebp
  103f15:	53                   	push   %ebx
  103f16:	83 ec 04             	sub    $0x4,%esp
  103f19:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu() + 10;
  103f1c:	8b 0a                	mov    (%edx),%ecx
  103f1e:	85 c9                	test   %ecx,%ecx
  103f20:	75 06                	jne    103f28 <holding+0x18>
}
  103f22:	83 c4 04             	add    $0x4,%esp
  103f25:	5b                   	pop    %ebx
  103f26:	5d                   	pop    %ebp
  103f27:	c3                   	ret    

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103f28:	8b 5a 08             	mov    0x8(%edx),%ebx
  103f2b:	e8 a0 e9 ff ff       	call   1028d0 <cpu>
  103f30:	83 c0 0a             	add    $0xa,%eax
  103f33:	39 c3                	cmp    %eax,%ebx
  103f35:	0f 94 c0             	sete   %al
}
  103f38:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu() + 10;
  103f3b:	0f b6 c0             	movzbl %al,%eax
}
  103f3e:	5b                   	pop    %ebx
  103f3f:	5d                   	pop    %ebp
  103f40:	c3                   	ret    
  103f41:	eb 0d                	jmp    103f50 <release>
  103f43:	90                   	nop
  103f44:	90                   	nop
  103f45:	90                   	nop
  103f46:	90                   	nop
  103f47:	90                   	nop
  103f48:	90                   	nop
  103f49:	90                   	nop
  103f4a:	90                   	nop
  103f4b:	90                   	nop
  103f4c:	90                   	nop
  103f4d:	90                   	nop
  103f4e:	90                   	nop
  103f4f:	90                   	nop

00103f50 <release>:
}

// Release the lock.
void
release(struct spinlock *lock)
{
  103f50:	55                   	push   %ebp
  103f51:	89 e5                	mov    %esp,%ebp
  103f53:	53                   	push   %ebx
  103f54:	83 ec 14             	sub    $0x14,%esp
  103f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lock))
  103f5a:	89 1c 24             	mov    %ebx,(%esp)
  103f5d:	e8 ae ff ff ff       	call   103f10 <holding>
  103f62:	85 c0                	test   %eax,%eax
  103f64:	74 1d                	je     103f83 <release+0x33>
    panic("release");

  lock->pcs[0] = 0;
  103f66:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
xchg(volatile uint *addr, uint newval)
{
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
  103f6d:	31 c0                	xor    %eax,%eax
  lock->cpu = 0xffffffff;
  103f6f:	c7 43 08 ff ff ff ff 	movl   $0xffffffff,0x8(%ebx)
  103f76:	f0 87 03             	lock xchg %eax,(%ebx)
  // Intel processors.  The xchg being asm volatile also keeps
  // gcc from delaying the above assignments.)
  xchg(&lock->locked, 0);

  popcli();
}
  103f79:	83 c4 14             	add    $0x14,%esp
  103f7c:	5b                   	pop    %ebx
  103f7d:	5d                   	pop    %ebp
  // by the Intel manuals, but does not happen on current 
  // Intel processors.  The xchg being asm volatile also keeps
  // gcc from delaying the above assignments.)
  xchg(&lock->locked, 0);

  popcli();
  103f7e:	e9 bd fe ff ff       	jmp    103e40 <popcli>
// Release the lock.
void
release(struct spinlock *lock)
{
  if(!holding(lock))
    panic("release");
  103f83:	c7 04 24 5e 65 10 00 	movl   $0x10655e,(%esp)
  103f8a:	e8 91 c9 ff ff       	call   100920 <panic>
  103f8f:	90                   	nop

00103f90 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lock)
{
  103f90:	55                   	push   %ebp
  103f91:	89 e5                	mov    %esp,%ebp
  103f93:	53                   	push   %ebx
  103f94:	83 ec 14             	sub    $0x14,%esp
  pushcli();
  103f97:	e8 24 ff ff ff       	call   103ec0 <pushcli>
  if(holding(lock))
  103f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  103f9f:	89 04 24             	mov    %eax,(%esp)
  103fa2:	e8 69 ff ff ff       	call   103f10 <holding>
  103fa7:	85 c0                	test   %eax,%eax
  103fa9:	75 3d                	jne    103fe8 <acquire+0x58>
    panic("acquire");
  103fab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  103fae:	ba 01 00 00 00       	mov    $0x1,%edx
  103fb3:	90                   	nop
  103fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  103fb8:	89 d0                	mov    %edx,%eax
  103fba:	f0 87 03             	lock xchg %eax,(%ebx)

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it.  
  while(xchg(&lock->locked, 1) == 1)
  103fbd:	83 f8 01             	cmp    $0x1,%eax
  103fc0:	74 f6                	je     103fb8 <acquire+0x28>

  // Record info about lock acquisition for debugging.
  // The +10 is only so that we can tell the difference
  // between forgetting to initialize lock->cpu
  // and holding a lock on cpu 0.
  lock->cpu = cpu() + 10;
  103fc2:	e8 09 e9 ff ff       	call   1028d0 <cpu>
  103fc7:	83 c0 0a             	add    $0xa,%eax
  103fca:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lock, lock->pcs);
  103fcd:	8b 45 08             	mov    0x8(%ebp),%eax
  103fd0:	83 c0 0c             	add    $0xc,%eax
  103fd3:	89 44 24 04          	mov    %eax,0x4(%esp)
  103fd7:	8d 45 08             	lea    0x8(%ebp),%eax
  103fda:	89 04 24             	mov    %eax,(%esp)
  103fdd:	e8 0e fe ff ff       	call   103df0 <getcallerpcs>
}
  103fe2:	83 c4 14             	add    $0x14,%esp
  103fe5:	5b                   	pop    %ebx
  103fe6:	5d                   	pop    %ebp
  103fe7:	c3                   	ret    
void
acquire(struct spinlock *lock)
{
  pushcli();
  if(holding(lock))
    panic("acquire");
  103fe8:	c7 04 24 66 65 10 00 	movl   $0x106566,(%esp)
  103fef:	e8 2c c9 ff ff       	call   100920 <panic>
  103ff4:	90                   	nop
  103ff5:	90                   	nop
  103ff6:	90                   	nop
  103ff7:	90                   	nop
  103ff8:	90                   	nop
  103ff9:	90                   	nop
  103ffa:	90                   	nop
  103ffb:	90                   	nop
  103ffc:	90                   	nop
  103ffd:	90                   	nop
  103ffe:	90                   	nop
  103fff:	90                   	nop

00104000 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
  104000:	55                   	push   %ebp
  104001:	89 e5                	mov    %esp,%ebp
  104003:	8b 4d 10             	mov    0x10(%ebp),%ecx
  104006:	53                   	push   %ebx
  104007:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;

  d = (char*)dst;
  while(n-- > 0)
  10400a:	85 c9                	test   %ecx,%ecx
  10400c:	74 14                	je     104022 <memset+0x22>
  10400e:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
  104012:	31 d2                	xor    %edx,%edx
  104014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
  104018:	88 1c 10             	mov    %bl,(%eax,%edx,1)
  10401b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;

  d = (char*)dst;
  while(n-- > 0)
  10401e:	39 ca                	cmp    %ecx,%edx
  104020:	75 f6                	jne    104018 <memset+0x18>
    *d++ = c;

  return dst;
}
  104022:	5b                   	pop    %ebx
  104023:	5d                   	pop    %ebp
  104024:	c3                   	ret    
  104025:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104030 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
  104030:	55                   	push   %ebp
  104031:	89 e5                	mov    %esp,%ebp
  104033:	57                   	push   %edi
  104034:	56                   	push   %esi
  104035:	53                   	push   %ebx
  104036:	8b 55 10             	mov    0x10(%ebp),%edx
  104039:	8b 75 08             	mov    0x8(%ebp),%esi
  10403c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  10403f:	85 d2                	test   %edx,%edx
  104041:	74 2d                	je     104070 <memcmp+0x40>
    if(*s1 != *s2)
  104043:	0f b6 1e             	movzbl (%esi),%ebx
  104046:	0f b6 0f             	movzbl (%edi),%ecx
  104049:	38 cb                	cmp    %cl,%bl
  10404b:	75 2b                	jne    104078 <memcmp+0x48>
      return *s1 - *s2;
  10404d:	83 ea 01             	sub    $0x1,%edx
  104050:	31 c0                	xor    %eax,%eax
  104052:	eb 18                	jmp    10406c <memcmp+0x3c>
  104054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
  104058:	0f b6 5c 06 01       	movzbl 0x1(%esi,%eax,1),%ebx
  10405d:	83 ea 01             	sub    $0x1,%edx
  104060:	0f b6 4c 07 01       	movzbl 0x1(%edi,%eax,1),%ecx
  104065:	83 c0 01             	add    $0x1,%eax
  104068:	38 cb                	cmp    %cl,%bl
  10406a:	75 0c                	jne    104078 <memcmp+0x48>
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
  10406c:	85 d2                	test   %edx,%edx
  10406e:	75 e8                	jne    104058 <memcmp+0x28>
  104070:	31 c0                	xor    %eax,%eax
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
  104072:	5b                   	pop    %ebx
  104073:	5e                   	pop    %esi
  104074:	5f                   	pop    %edi
  104075:	5d                   	pop    %ebp
  104076:	c3                   	ret    
  104077:	90                   	nop
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
  104078:	0f b6 c3             	movzbl %bl,%eax
  10407b:	0f b6 c9             	movzbl %cl,%ecx
  10407e:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
  104080:	5b                   	pop    %ebx
  104081:	5e                   	pop    %esi
  104082:	5f                   	pop    %edi
  104083:	5d                   	pop    %ebp
  104084:	c3                   	ret    
  104085:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104090 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
  104090:	55                   	push   %ebp
  104091:	89 e5                	mov    %esp,%ebp
  104093:	57                   	push   %edi
  104094:	56                   	push   %esi
  104095:	53                   	push   %ebx
  104096:	8b 45 08             	mov    0x8(%ebp),%eax
  104099:	8b 75 0c             	mov    0xc(%ebp),%esi
  10409c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
  10409f:	39 c6                	cmp    %eax,%esi
  1040a1:	73 2d                	jae    1040d0 <memmove+0x40>
  1040a3:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
  1040a6:	39 f8                	cmp    %edi,%eax
  1040a8:	73 26                	jae    1040d0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
  1040aa:	85 db                	test   %ebx,%ebx
  1040ac:	74 1d                	je     1040cb <memmove+0x3b>

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
  1040ae:	8d 34 18             	lea    (%eax,%ebx,1),%esi
  1040b1:	31 d2                	xor    %edx,%edx
  1040b3:	90                   	nop
  1040b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
      *--d = *--s;
  1040b8:	0f b6 4c 17 ff       	movzbl -0x1(%edi,%edx,1),%ecx
  1040bd:	88 4c 16 ff          	mov    %cl,-0x1(%esi,%edx,1)
  1040c1:	83 ea 01             	sub    $0x1,%edx
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  1040c4:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
  1040c7:	85 c9                	test   %ecx,%ecx
  1040c9:	75 ed                	jne    1040b8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
  1040cb:	5b                   	pop    %ebx
  1040cc:	5e                   	pop    %esi
  1040cd:	5f                   	pop    %edi
  1040ce:	5d                   	pop    %ebp
  1040cf:	c3                   	ret    
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
  1040d0:	31 d2                	xor    %edx,%edx
      *--d = *--s;
  } else
    while(n-- > 0)
  1040d2:	85 db                	test   %ebx,%ebx
  1040d4:	74 f5                	je     1040cb <memmove+0x3b>
  1040d6:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
  1040d8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
  1040dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1040df:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  1040e2:	39 d3                	cmp    %edx,%ebx
  1040e4:	75 f2                	jne    1040d8 <memmove+0x48>
      *d++ = *s++;

  return dst;
}
  1040e6:	5b                   	pop    %ebx
  1040e7:	5e                   	pop    %esi
  1040e8:	5f                   	pop    %edi
  1040e9:	5d                   	pop    %ebp
  1040ea:	c3                   	ret    
  1040eb:	90                   	nop
  1040ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001040f0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
  1040f0:	55                   	push   %ebp
  1040f1:	89 e5                	mov    %esp,%ebp
  1040f3:	57                   	push   %edi
  1040f4:	56                   	push   %esi
  1040f5:	53                   	push   %ebx
  1040f6:	8b 7d 10             	mov    0x10(%ebp),%edi
  1040f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1040fc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
  1040ff:	85 ff                	test   %edi,%edi
  104101:	74 3d                	je     104140 <strncmp+0x50>
  104103:	0f b6 01             	movzbl (%ecx),%eax
  104106:	84 c0                	test   %al,%al
  104108:	75 18                	jne    104122 <strncmp+0x32>
  10410a:	eb 3c                	jmp    104148 <strncmp+0x58>
  10410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104110:	83 ef 01             	sub    $0x1,%edi
  104113:	74 2b                	je     104140 <strncmp+0x50>
    n--, p++, q++;
  104115:	83 c1 01             	add    $0x1,%ecx
  104118:	83 c3 01             	add    $0x1,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  10411b:	0f b6 01             	movzbl (%ecx),%eax
  10411e:	84 c0                	test   %al,%al
  104120:	74 26                	je     104148 <strncmp+0x58>
  104122:	0f b6 33             	movzbl (%ebx),%esi
  104125:	89 f2                	mov    %esi,%edx
  104127:	38 d0                	cmp    %dl,%al
  104129:	74 e5                	je     104110 <strncmp+0x20>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
  10412b:	81 e6 ff 00 00 00    	and    $0xff,%esi
  104131:	0f b6 c0             	movzbl %al,%eax
  104134:	29 f0                	sub    %esi,%eax
}
  104136:	5b                   	pop    %ebx
  104137:	5e                   	pop    %esi
  104138:	5f                   	pop    %edi
  104139:	5d                   	pop    %ebp
  10413a:	c3                   	ret    
  10413b:	90                   	nop
  10413c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  104140:	31 c0                	xor    %eax,%eax
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
  104142:	5b                   	pop    %ebx
  104143:	5e                   	pop    %esi
  104144:	5f                   	pop    %edi
  104145:	5d                   	pop    %ebp
  104146:	c3                   	ret    
  104147:	90                   	nop
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
  104148:	0f b6 33             	movzbl (%ebx),%esi
  10414b:	eb de                	jmp    10412b <strncmp+0x3b>
  10414d:	8d 76 00             	lea    0x0(%esi),%esi

00104150 <strncpy>:
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
{
  104150:	55                   	push   %ebp
  104151:	89 e5                	mov    %esp,%ebp
  104153:	8b 45 08             	mov    0x8(%ebp),%eax
  104156:	56                   	push   %esi
  104157:	8b 4d 10             	mov    0x10(%ebp),%ecx
  10415a:	53                   	push   %ebx
  10415b:	8b 75 0c             	mov    0xc(%ebp),%esi
  10415e:	89 c3                	mov    %eax,%ebx
  104160:	eb 09                	jmp    10416b <strncpy+0x1b>
  104162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  104168:	83 c6 01             	add    $0x1,%esi
  10416b:	83 e9 01             	sub    $0x1,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
  10416e:	8d 51 01             	lea    0x1(%ecx),%edx
{
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
  104171:	85 d2                	test   %edx,%edx
  104173:	7e 0c                	jle    104181 <strncpy+0x31>
  104175:	0f b6 16             	movzbl (%esi),%edx
  104178:	88 13                	mov    %dl,(%ebx)
  10417a:	83 c3 01             	add    $0x1,%ebx
  10417d:	84 d2                	test   %dl,%dl
  10417f:	75 e7                	jne    104168 <strncpy+0x18>
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
  104181:	31 d2                	xor    %edx,%edx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  104183:	85 c9                	test   %ecx,%ecx
  104185:	7e 0c                	jle    104193 <strncpy+0x43>
  104187:	90                   	nop
    *s++ = 0;
  104188:	c6 04 13 00          	movb   $0x0,(%ebx,%edx,1)
  10418c:	83 c2 01             	add    $0x1,%edx
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
  10418f:	39 ca                	cmp    %ecx,%edx
  104191:	75 f5                	jne    104188 <strncpy+0x38>
    *s++ = 0;
  return os;
}
  104193:	5b                   	pop    %ebx
  104194:	5e                   	pop    %esi
  104195:	5d                   	pop    %ebp
  104196:	c3                   	ret    
  104197:	89 f6                	mov    %esi,%esi
  104199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001041a0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
  1041a0:	55                   	push   %ebp
  1041a1:	89 e5                	mov    %esp,%ebp
  1041a3:	8b 55 10             	mov    0x10(%ebp),%edx
  1041a6:	56                   	push   %esi
  1041a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1041aa:	53                   	push   %ebx
  1041ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;
  
  os = s;
  if(n <= 0)
  1041ae:	85 d2                	test   %edx,%edx
  1041b0:	7e 1f                	jle    1041d1 <safestrcpy+0x31>
  1041b2:	89 c1                	mov    %eax,%ecx
  1041b4:	eb 05                	jmp    1041bb <safestrcpy+0x1b>
  1041b6:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
  1041b8:	83 c6 01             	add    $0x1,%esi
  1041bb:	83 ea 01             	sub    $0x1,%edx
  1041be:	85 d2                	test   %edx,%edx
  1041c0:	7e 0c                	jle    1041ce <safestrcpy+0x2e>
  1041c2:	0f b6 1e             	movzbl (%esi),%ebx
  1041c5:	88 19                	mov    %bl,(%ecx)
  1041c7:	83 c1 01             	add    $0x1,%ecx
  1041ca:	84 db                	test   %bl,%bl
  1041cc:	75 ea                	jne    1041b8 <safestrcpy+0x18>
    ;
  *s = 0;
  1041ce:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
  1041d1:	5b                   	pop    %ebx
  1041d2:	5e                   	pop    %esi
  1041d3:	5d                   	pop    %ebp
  1041d4:	c3                   	ret    
  1041d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  1041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001041e0 <strlen>:

int
strlen(const char *s)
{
  1041e0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
  1041e1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
  1041e3:	89 e5                	mov    %esp,%ebp
  1041e5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  1041e8:	80 3a 00             	cmpb   $0x0,(%edx)
  1041eb:	74 0c                	je     1041f9 <strlen+0x19>
  1041ed:	8d 76 00             	lea    0x0(%esi),%esi
  1041f0:	83 c0 01             	add    $0x1,%eax
  1041f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1041f7:	75 f7                	jne    1041f0 <strlen+0x10>
    ;
  return n;
}
  1041f9:	5d                   	pop    %ebp
  1041fa:	c3                   	ret    
  1041fb:	90                   	nop

001041fc <swtch>:
  1041fc:	8b 44 24 04          	mov    0x4(%esp),%eax
  104200:	8f 00                	popl   (%eax)
  104202:	89 60 04             	mov    %esp,0x4(%eax)
  104205:	89 58 08             	mov    %ebx,0x8(%eax)
  104208:	89 48 0c             	mov    %ecx,0xc(%eax)
  10420b:	89 50 10             	mov    %edx,0x10(%eax)
  10420e:	89 70 14             	mov    %esi,0x14(%eax)
  104211:	89 78 18             	mov    %edi,0x18(%eax)
  104214:	89 68 1c             	mov    %ebp,0x1c(%eax)
  104217:	8b 44 24 04          	mov    0x4(%esp),%eax
  10421b:	8b 68 1c             	mov    0x1c(%eax),%ebp
  10421e:	8b 78 18             	mov    0x18(%eax),%edi
  104221:	8b 70 14             	mov    0x14(%eax),%esi
  104224:	8b 50 10             	mov    0x10(%eax),%edx
  104227:	8b 48 0c             	mov    0xc(%eax),%ecx
  10422a:	8b 58 08             	mov    0x8(%eax),%ebx
  10422d:	8b 60 04             	mov    0x4(%eax),%esp
  104230:	ff 30                	pushl  (%eax)
  104232:	c3                   	ret    
  104233:	90                   	nop
  104234:	90                   	nop
  104235:	90                   	nop
  104236:	90                   	nop
  104237:	90                   	nop
  104238:	90                   	nop
  104239:	90                   	nop
  10423a:	90                   	nop
  10423b:	90                   	nop
  10423c:	90                   	nop
  10423d:	90                   	nop
  10423e:	90                   	nop
  10423f:	90                   	nop

00104240 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  104240:	55                   	push   %ebp
  104241:	89 e5                	mov    %esp,%ebp
  104243:	8b 4d 08             	mov    0x8(%ebp),%ecx
  104246:	53                   	push   %ebx
  104247:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(addr >= p->sz || addr+4 > p->sz)
  10424a:	8b 51 04             	mov    0x4(%ecx),%edx
  10424d:	39 c2                	cmp    %eax,%edx
  10424f:	77 0f                	ja     104260 <fetchint+0x20>
    return -1;
  *ip = *(int*)(p->mem + addr);
  return 0;
  104251:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104256:	5b                   	pop    %ebx
  104257:	5d                   	pop    %ebp
  104258:	c3                   	ret    
  104259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  104260:	8d 58 04             	lea    0x4(%eax),%ebx
  104263:	39 da                	cmp    %ebx,%edx
  104265:	72 ea                	jb     104251 <fetchint+0x11>
    return -1;
  *ip = *(int*)(p->mem + addr);
  104267:	8b 11                	mov    (%ecx),%edx
  104269:	8b 14 02             	mov    (%edx,%eax,1),%edx
  10426c:	8b 45 10             	mov    0x10(%ebp),%eax
  10426f:	89 10                	mov    %edx,(%eax)
  104271:	31 c0                	xor    %eax,%eax
  return 0;
  104273:	eb e1                	jmp    104256 <fetchint+0x16>
  104275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104280 <fetchstr>:
// Fetch the nul-terminated string at addr from process p.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  104280:	55                   	push   %ebp
  104281:	89 e5                	mov    %esp,%ebp
  104283:	8b 45 08             	mov    0x8(%ebp),%eax
  104286:	8b 55 0c             	mov    0xc(%ebp),%edx
  104289:	53                   	push   %ebx
  char *s, *ep;

  if(addr >= p->sz)
  10428a:	39 50 04             	cmp    %edx,0x4(%eax)
  10428d:	77 09                	ja     104298 <fetchstr+0x18>
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  10428f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(*s == 0)
      return s - *pp;
  return -1;
}
  104294:	5b                   	pop    %ebx
  104295:	5d                   	pop    %ebp
  104296:	c3                   	ret    
  104297:	90                   	nop
{
  char *s, *ep;

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  104298:	8b 4d 10             	mov    0x10(%ebp),%ecx
  10429b:	03 10                	add    (%eax),%edx
  10429d:	89 11                	mov    %edx,(%ecx)
  ep = p->mem + p->sz;
  10429f:	8b 18                	mov    (%eax),%ebx
  1042a1:	03 58 04             	add    0x4(%eax),%ebx
  for(s = *pp; s < ep; s++)
  1042a4:	39 da                	cmp    %ebx,%edx
  1042a6:	73 e7                	jae    10428f <fetchstr+0xf>
    if(*s == 0)
  1042a8:	31 c0                	xor    %eax,%eax
  1042aa:	89 d1                	mov    %edx,%ecx
  1042ac:	80 3a 00             	cmpb   $0x0,(%edx)
  1042af:	74 e3                	je     104294 <fetchstr+0x14>
  1042b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  1042b8:	83 c1 01             	add    $0x1,%ecx
  1042bb:	39 cb                	cmp    %ecx,%ebx
  1042bd:	76 d0                	jbe    10428f <fetchstr+0xf>
    if(*s == 0)
  1042bf:	80 39 00             	cmpb   $0x0,(%ecx)
  1042c2:	75 f4                	jne    1042b8 <fetchstr+0x38>
  1042c4:	89 c8                	mov    %ecx,%eax
  1042c6:	29 d0                	sub    %edx,%eax
  1042c8:	eb ca                	jmp    104294 <fetchstr+0x14>
  1042ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

001042d0 <argint>:
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  1042d0:	55                   	push   %ebp
  1042d1:	89 e5                	mov    %esp,%ebp
  1042d3:	53                   	push   %ebx
  1042d4:	83 ec 04             	sub    $0x4,%esp
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
  1042d7:	e8 a4 f0 ff ff       	call   103380 <curproc>
  1042dc:	8b 55 08             	mov    0x8(%ebp),%edx
  1042df:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  1042e5:	8b 40 3c             	mov    0x3c(%eax),%eax
  1042e8:	8d 5c 90 04          	lea    0x4(%eax,%edx,4),%ebx
  1042ec:	e8 8f f0 ff ff       	call   103380 <curproc>

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  1042f1:	8b 50 04             	mov    0x4(%eax),%edx
  1042f4:	39 d3                	cmp    %edx,%ebx
  1042f6:	72 10                	jb     104308 <argint+0x38>
    return -1;
  *ip = *(int*)(p->mem + addr);
  1042f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(cp, cp->tf->esp + 4 + 4*n, ip);
}
  1042fd:	83 c4 04             	add    $0x4,%esp
  104300:	5b                   	pop    %ebx
  104301:	5d                   	pop    %ebp
  104302:	c3                   	ret    
  104303:	90                   	nop
  104304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Fetch the int at addr from process p.
int
fetchint(struct proc *p, uint addr, int *ip)
{
  if(addr >= p->sz || addr+4 > p->sz)
  104308:	8d 4b 04             	lea    0x4(%ebx),%ecx
  10430b:	39 ca                	cmp    %ecx,%edx
  10430d:	72 e9                	jb     1042f8 <argint+0x28>
    return -1;
  *ip = *(int*)(p->mem + addr);
  10430f:	8b 00                	mov    (%eax),%eax
  104311:	8b 14 18             	mov    (%eax,%ebx,1),%edx
  104314:	8b 45 0c             	mov    0xc(%ebp),%eax
  104317:	89 10                	mov    %edx,(%eax)
  104319:	31 c0                	xor    %eax,%eax
  10431b:	eb e0                	jmp    1042fd <argint+0x2d>
  10431d:	8d 76 00             	lea    0x0(%esi),%esi

00104320 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  104320:	55                   	push   %ebp
  104321:	89 e5                	mov    %esp,%ebp
  104323:	53                   	push   %ebx
  104324:	83 ec 24             	sub    $0x24,%esp
  int addr;
  if(argint(n, &addr) < 0)
  104327:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10432a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10432e:	8b 45 08             	mov    0x8(%ebp),%eax
  104331:	89 04 24             	mov    %eax,(%esp)
  104334:	e8 97 ff ff ff       	call   1042d0 <argint>
  104339:	85 c0                	test   %eax,%eax
  10433b:	78 3b                	js     104378 <argstr+0x58>
    return -1;
  return fetchstr(cp, addr, pp);
  10433d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104340:	e8 3b f0 ff ff       	call   103380 <curproc>
int
fetchstr(struct proc *p, uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= p->sz)
  104345:	3b 58 04             	cmp    0x4(%eax),%ebx
  104348:	73 2e                	jae    104378 <argstr+0x58>
    return -1;
  *pp = p->mem + addr;
  10434a:	8b 55 0c             	mov    0xc(%ebp),%edx
  10434d:	03 18                	add    (%eax),%ebx
  10434f:	89 1a                	mov    %ebx,(%edx)
  ep = p->mem + p->sz;
  104351:	8b 08                	mov    (%eax),%ecx
  104353:	03 48 04             	add    0x4(%eax),%ecx
  for(s = *pp; s < ep; s++)
  104356:	39 cb                	cmp    %ecx,%ebx
  104358:	73 1e                	jae    104378 <argstr+0x58>
    if(*s == 0)
  10435a:	31 c0                	xor    %eax,%eax
  10435c:	89 da                	mov    %ebx,%edx
  10435e:	80 3b 00             	cmpb   $0x0,(%ebx)
  104361:	75 0a                	jne    10436d <argstr+0x4d>
  104363:	eb 18                	jmp    10437d <argstr+0x5d>
  104365:	8d 76 00             	lea    0x0(%esi),%esi
  104368:	80 3a 00             	cmpb   $0x0,(%edx)
  10436b:	74 1b                	je     104388 <argstr+0x68>

  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
  10436d:	83 c2 01             	add    $0x1,%edx
  104370:	39 d1                	cmp    %edx,%ecx
  104372:	77 f4                	ja     104368 <argstr+0x48>
  104374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  10437d:	83 c4 24             	add    $0x24,%esp
  104380:	5b                   	pop    %ebx
  104381:	5d                   	pop    %ebp
  104382:	c3                   	ret    
  104383:	90                   	nop
  104384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  104388:	89 d0                	mov    %edx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  10438a:	83 c4 24             	add    $0x24,%esp
  if(addr >= p->sz)
    return -1;
  *pp = p->mem + addr;
  ep = p->mem + p->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
  10438d:	29 d8                	sub    %ebx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(cp, addr, pp);
}
  10438f:	5b                   	pop    %ebx
  104390:	5d                   	pop    %ebp
  104391:	c3                   	ret    
  104392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

001043a0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
  1043a0:	55                   	push   %ebp
  1043a1:	89 e5                	mov    %esp,%ebp
  1043a3:	53                   	push   %ebx
  1043a4:	83 ec 24             	sub    $0x24,%esp
  int i;
  
  if(argint(n, &i) < 0)
  1043a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1043aa:	89 44 24 04          	mov    %eax,0x4(%esp)
  1043ae:	8b 45 08             	mov    0x8(%ebp),%eax
  1043b1:	89 04 24             	mov    %eax,(%esp)
  1043b4:	e8 17 ff ff ff       	call   1042d0 <argint>
  1043b9:	85 c0                	test   %eax,%eax
  1043bb:	79 0b                	jns    1043c8 <argptr+0x28>
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
    return -1;
  *pp = cp->mem + i;
  return 0;
  1043bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1043c2:	83 c4 24             	add    $0x24,%esp
  1043c5:	5b                   	pop    %ebx
  1043c6:	5d                   	pop    %ebp
  1043c7:	c3                   	ret    
{
  int i;
  
  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= cp->sz || (uint)i+size >= cp->sz)
  1043c8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1043cb:	e8 b0 ef ff ff       	call   103380 <curproc>
  1043d0:	3b 58 04             	cmp    0x4(%eax),%ebx
  1043d3:	73 e8                	jae    1043bd <argptr+0x1d>
  1043d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
  1043d8:	03 5d f4             	add    -0xc(%ebp),%ebx
  1043db:	e8 a0 ef ff ff       	call   103380 <curproc>
  1043e0:	3b 58 04             	cmp    0x4(%eax),%ebx
  1043e3:	73 d8                	jae    1043bd <argptr+0x1d>
    return -1;
  *pp = cp->mem + i;
  1043e5:	e8 96 ef ff ff       	call   103380 <curproc>
  1043ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  1043ed:	8b 00                	mov    (%eax),%eax
  1043ef:	03 45 f4             	add    -0xc(%ebp),%eax
  1043f2:	89 02                	mov    %eax,(%edx)
  1043f4:	31 c0                	xor    %eax,%eax
  return 0;
  1043f6:	eb ca                	jmp    1043c2 <argptr+0x22>
  1043f8:	90                   	nop
  1043f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104400 <syscall>:
[SYS_getticks] sys_getticks,
};

void
syscall(void)
{
  104400:	55                   	push   %ebp
  104401:	89 e5                	mov    %esp,%ebp
  104403:	83 ec 18             	sub    $0x18,%esp
  104406:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  104409:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int num;
  
  num = cp->tf->eax;
  10440c:	e8 6f ef ff ff       	call   103380 <curproc>
  104411:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  104417:	8b 58 1c             	mov    0x1c(%eax),%ebx
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
  10441a:	83 fb 15             	cmp    $0x15,%ebx
  10441d:	77 29                	ja     104448 <syscall+0x48>
  10441f:	8b 34 9d a0 65 10 00 	mov    0x1065a0(,%ebx,4),%esi
  104426:	85 f6                	test   %esi,%esi
  104428:	74 1e                	je     104448 <syscall+0x48>
    cp->tf->eax = syscalls[num]();
  10442a:	e8 51 ef ff ff       	call   103380 <curproc>
  10442f:	8b 98 84 00 00 00    	mov    0x84(%eax),%ebx
  104435:	ff d6                	call   *%esi
  104437:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  }
}
  10443a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  10443d:	8b 75 fc             	mov    -0x4(%ebp),%esi
  104440:	89 ec                	mov    %ebp,%esp
  104442:	5d                   	pop    %ebp
  104443:	c3                   	ret    
  104444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
            cp->pid, cp->name, num);
  104448:	e8 33 ef ff ff       	call   103380 <curproc>
  10444d:	89 c6                	mov    %eax,%esi
  10444f:	e8 2c ef ff ff       	call   103380 <curproc>
  
  num = cp->tf->eax;
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    cp->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
  104454:	81 c6 88 00 00 00    	add    $0x88,%esi
  10445a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10445e:	89 74 24 08          	mov    %esi,0x8(%esp)
  104462:	8b 40 10             	mov    0x10(%eax),%eax
  104465:	c7 04 24 6e 65 10 00 	movl   $0x10656e,(%esp)
  10446c:	89 44 24 04          	mov    %eax,0x4(%esp)
  104470:	e8 0b c3 ff ff       	call   100780 <cprintf>
            cp->pid, cp->name, num);
    cp->tf->eax = -1;
  104475:	e8 06 ef ff ff       	call   103380 <curproc>
  10447a:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
  104480:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
  104487:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  10448a:	8b 75 fc             	mov    -0x4(%ebp),%esi
  10448d:	89 ec                	mov    %ebp,%esp
  10448f:	5d                   	pop    %ebp
  104490:	c3                   	ret    
  104491:	90                   	nop
  104492:	90                   	nop
  104493:	90                   	nop
  104494:	90                   	nop
  104495:	90                   	nop
  104496:	90                   	nop
  104497:	90                   	nop
  104498:	90                   	nop
  104499:	90                   	nop
  10449a:	90                   	nop
  10449b:	90                   	nop
  10449c:	90                   	nop
  10449d:	90                   	nop
  10449e:	90                   	nop
  10449f:	90                   	nop

001044a0 <sys_getticks>:
  fd[1] = fd1;
  return 0;
}


int sys_getticks(void){
  1044a0:	55                   	push   %ebp
  1044a1:	89 e5                	mov    %esp,%ebp
  1044a3:	83 ec 08             	sub    $0x8,%esp
  int i = getticks();
  return i;
}
  1044a6:	c9                   	leave  
  return 0;
}


int sys_getticks(void){
  int i = getticks();
  1044a7:	e9 f4 da ff ff       	jmp    101fa0 <getticks>
  1044ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001044b0 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  1044b0:	55                   	push   %ebp
  1044b1:	89 e5                	mov    %esp,%ebp
  1044b3:	57                   	push   %edi
  1044b4:	89 c7                	mov    %eax,%edi
  1044b6:	56                   	push   %esi
  1044b7:	53                   	push   %ebx
  1044b8:	31 db                	xor    %ebx,%ebx
  1044ba:	83 ec 0c             	sub    $0xc,%esp
  1044bd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
  1044c0:	e8 bb ee ff ff       	call   103380 <curproc>
  1044c5:	8d 73 08             	lea    0x8(%ebx),%esi
  1044c8:	8b 04 b0             	mov    (%eax,%esi,4),%eax
  1044cb:	85 c0                	test   %eax,%eax
  1044cd:	74 19                	je     1044e8 <fdalloc+0x38>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
  1044cf:	83 c3 01             	add    $0x1,%ebx
  1044d2:	83 fb 10             	cmp    $0x10,%ebx
  1044d5:	75 e9                	jne    1044c0 <fdalloc+0x10>
  1044d7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      cp->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
  1044dc:	83 c4 0c             	add    $0xc,%esp
  1044df:	89 d8                	mov    %ebx,%eax
  1044e1:	5b                   	pop    %ebx
  1044e2:	5e                   	pop    %esi
  1044e3:	5f                   	pop    %edi
  1044e4:	5d                   	pop    %ebp
  1044e5:	c3                   	ret    
  1044e6:	66 90                	xchg   %ax,%ax
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(cp->ofile[fd] == 0){
      cp->ofile[fd] = f;
  1044e8:	e8 93 ee ff ff       	call   103380 <curproc>
  1044ed:	89 3c b0             	mov    %edi,(%eax,%esi,4)
      return fd;
    }
  }
  return -1;
}
  1044f0:	83 c4 0c             	add    $0xc,%esp
  1044f3:	89 d8                	mov    %ebx,%eax
  1044f5:	5b                   	pop    %ebx
  1044f6:	5e                   	pop    %esi
  1044f7:	5f                   	pop    %edi
  1044f8:	5d                   	pop    %ebp
  1044f9:	c3                   	ret    
  1044fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00104500 <sys_pipe>:
  return exec(path, argv);
}

int
sys_pipe(void)
{
  104500:	55                   	push   %ebp
  104501:	89 e5                	mov    %esp,%ebp
  104503:	53                   	push   %ebx
  104504:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
  104507:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10450a:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
  104511:	00 
  104512:	89 44 24 04          	mov    %eax,0x4(%esp)
  104516:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10451d:	e8 7e fe ff ff       	call   1043a0 <argptr>
  104522:	85 c0                	test   %eax,%eax
  104524:	79 12                	jns    104538 <sys_pipe+0x38>
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
  104526:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10452b:	83 c4 24             	add    $0x24,%esp
  10452e:	5b                   	pop    %ebx
  10452f:	5d                   	pop    %ebp
  104530:	c3                   	ret    
  104531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
  104538:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10453b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10453f:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104542:	89 04 24             	mov    %eax,(%esp)
  104545:	e8 76 eb ff ff       	call   1030c0 <pipealloc>
  10454a:	85 c0                	test   %eax,%eax
  10454c:	78 d8                	js     104526 <sys_pipe+0x26>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
  10454e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104551:	e8 5a ff ff ff       	call   1044b0 <fdalloc>
  104556:	85 c0                	test   %eax,%eax
  104558:	89 c3                	mov    %eax,%ebx
  10455a:	78 25                	js     104581 <sys_pipe+0x81>
  10455c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10455f:	e8 4c ff ff ff       	call   1044b0 <fdalloc>
  104564:	85 c0                	test   %eax,%eax
  104566:	78 0c                	js     104574 <sys_pipe+0x74>
      cp->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  104568:	8b 55 f4             	mov    -0xc(%ebp),%edx
  fd[1] = fd1;
  10456b:	89 42 04             	mov    %eax,0x4(%edx)
  10456e:	31 c0                	xor    %eax,%eax
      cp->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  104570:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
  return 0;
  104572:	eb b7                	jmp    10452b <sys_pipe+0x2b>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      cp->ofile[fd0] = 0;
  104574:	e8 07 ee ff ff       	call   103380 <curproc>
  104579:	c7 44 98 20 00 00 00 	movl   $0x0,0x20(%eax,%ebx,4)
  104580:	00 
    fileclose(rf);
  104581:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104584:	89 04 24             	mov    %eax,(%esp)
  104587:	e8 b4 ca ff ff       	call   101040 <fileclose>
    fileclose(wf);
  10458c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10458f:	89 04 24             	mov    %eax,(%esp)
  104592:	e8 a9 ca ff ff       	call   101040 <fileclose>
  104597:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  10459c:	eb 8d                	jmp    10452b <sys_pipe+0x2b>
  10459e:	66 90                	xchg   %ax,%ax

001045a0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
  1045a0:	55                   	push   %ebp
  1045a1:	89 e5                	mov    %esp,%ebp
  1045a3:	81 ec 88 00 00 00    	sub    $0x88,%esp
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  1045a9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
  1045ac:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  1045af:	89 75 f8             	mov    %esi,-0x8(%ebp)
  1045b2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  1045b5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1045b9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1045c0:	e8 5b fd ff ff       	call   104320 <argstr>
  1045c5:	85 c0                	test   %eax,%eax
  1045c7:	79 17                	jns    1045e0 <sys_exec+0x40>
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
  1045c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
  1045ce:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1045d1:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1045d4:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1045d7:	89 ec                	mov    %ebp,%esp
  1045d9:	5d                   	pop    %ebp
  1045da:	c3                   	ret    
  1045db:	90                   	nop
  1045dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *path, *argv[20];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
  1045e0:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1045e3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1045e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1045ee:	e8 dd fc ff ff       	call   1042d0 <argint>
  1045f3:	85 c0                	test   %eax,%eax
  1045f5:	78 d2                	js     1045c9 <sys_exec+0x29>
    return -1;
  memset(argv, 0, sizeof(argv));
  1045f7:	8d 45 8c             	lea    -0x74(%ebp),%eax
  1045fa:	31 ff                	xor    %edi,%edi
  1045fc:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
  104603:	00 
  104604:	31 db                	xor    %ebx,%ebx
  104606:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10460d:	00 
  10460e:	89 04 24             	mov    %eax,(%esp)
  104611:	e8 ea f9 ff ff       	call   104000 <memset>
  104616:	eb 27                	jmp    10463f <sys_exec+0x9f>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
  104618:	e8 63 ed ff ff       	call   103380 <curproc>
  10461d:	8d 54 bd 8c          	lea    -0x74(%ebp,%edi,4),%edx
  104621:	89 54 24 08          	mov    %edx,0x8(%esp)
  104625:	89 74 24 04          	mov    %esi,0x4(%esp)
  104629:	89 04 24             	mov    %eax,(%esp)
  10462c:	e8 4f fc ff ff       	call   104280 <fetchstr>
  104631:	85 c0                	test   %eax,%eax
  104633:	78 94                	js     1045c9 <sys_exec+0x29>
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  104635:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
  104638:	83 fb 14             	cmp    $0x14,%ebx
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0)
    return -1;
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
  10463b:	89 df                	mov    %ebx,%edi
    if(i >= NELEM(argv))
  10463d:	74 8a                	je     1045c9 <sys_exec+0x29>
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
  10463f:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
  104646:	03 75 e0             	add    -0x20(%ebp),%esi
  104649:	e8 32 ed ff ff       	call   103380 <curproc>
  10464e:	8d 55 dc             	lea    -0x24(%ebp),%edx
  104651:	89 54 24 08          	mov    %edx,0x8(%esp)
  104655:	89 74 24 04          	mov    %esi,0x4(%esp)
  104659:	89 04 24             	mov    %eax,(%esp)
  10465c:	e8 df fb ff ff       	call   104240 <fetchint>
  104661:	85 c0                	test   %eax,%eax
  104663:	0f 88 60 ff ff ff    	js     1045c9 <sys_exec+0x29>
      return -1;
    if(uarg == 0){
  104669:	8b 75 dc             	mov    -0x24(%ebp),%esi
  10466c:	85 f6                	test   %esi,%esi
  10466e:	75 a8                	jne    104618 <sys_exec+0x78>
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104670:	8d 45 8c             	lea    -0x74(%ebp),%eax
  104673:	89 44 24 04          	mov    %eax,0x4(%esp)
  104677:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(cp, uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
  10467a:	c7 44 9d 8c 00 00 00 	movl   $0x0,-0x74(%ebp,%ebx,4)
  104681:	00 
      break;
    }
    if(fetchstr(cp, uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
  104682:	89 04 24             	mov    %eax,(%esp)
  104685:	e8 26 c3 ff ff       	call   1009b0 <exec>
  10468a:	e9 3f ff ff ff       	jmp    1045ce <sys_exec+0x2e>
  10468f:	90                   	nop

00104690 <sys_chdir>:
  return 0;
}

int
sys_chdir(void)
{
  104690:	55                   	push   %ebp
  104691:	89 e5                	mov    %esp,%ebp
  104693:	53                   	push   %ebx
  104694:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  104697:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10469a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10469e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1046a5:	e8 76 fc ff ff       	call   104320 <argstr>
  1046aa:	85 c0                	test   %eax,%eax
  1046ac:	79 12                	jns    1046c0 <sys_chdir+0x30>
    return -1;
  }
  iunlock(ip);
  iput(cp->cwd);
  cp->cwd = ip;
  return 0;
  1046ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  1046b3:	83 c4 24             	add    $0x24,%esp
  1046b6:	5b                   	pop    %ebx
  1046b7:	5d                   	pop    %ebp
  1046b8:	c3                   	ret    
  1046b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_chdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
  1046c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1046c3:	89 04 24             	mov    %eax,(%esp)
  1046c6:	e8 95 d8 ff ff       	call   101f60 <namei>
  1046cb:	85 c0                	test   %eax,%eax
  1046cd:	89 c3                	mov    %eax,%ebx
  1046cf:	74 dd                	je     1046ae <sys_chdir+0x1e>
    return -1;
  ilock(ip);
  1046d1:	89 04 24             	mov    %eax,(%esp)
  1046d4:	e8 c7 d5 ff ff       	call   101ca0 <ilock>
  if(ip->type != T_DIR){
  1046d9:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  1046de:	75 24                	jne    104704 <sys_chdir+0x74>
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  1046e0:	89 1c 24             	mov    %ebx,(%esp)
  1046e3:	e8 48 d5 ff ff       	call   101c30 <iunlock>
  iput(cp->cwd);
  1046e8:	e8 93 ec ff ff       	call   103380 <curproc>
  1046ed:	8b 40 60             	mov    0x60(%eax),%eax
  1046f0:	89 04 24             	mov    %eax,(%esp)
  1046f3:	e8 f8 d2 ff ff       	call   1019f0 <iput>
  cp->cwd = ip;
  1046f8:	e8 83 ec ff ff       	call   103380 <curproc>
  1046fd:	89 58 60             	mov    %ebx,0x60(%eax)
  104700:	31 c0                	xor    %eax,%eax
  return 0;
  104702:	eb af                	jmp    1046b3 <sys_chdir+0x23>

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
    return -1;
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
  104704:	89 1c 24             	mov    %ebx,(%esp)
  104707:	e8 74 d5 ff ff       	call   101c80 <iunlockput>
  10470c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  104711:	eb a0                	jmp    1046b3 <sys_chdir+0x23>
  104713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104720 <sys_link>:
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104720:	55                   	push   %ebp
  104721:	89 e5                	mov    %esp,%ebp
  104723:	83 ec 48             	sub    $0x48,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104726:	8d 45 e0             	lea    -0x20(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  104729:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  10472c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10472f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104732:	89 44 24 04          	mov    %eax,0x4(%esp)
  104736:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10473d:	e8 de fb ff ff       	call   104320 <argstr>
  104742:	85 c0                	test   %eax,%eax
  104744:	79 12                	jns    104758 <sys_link+0x38>
    iunlockput(dp);
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return -1;
  104746:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  10474b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10474e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104751:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104754:	89 ec                	mov    %ebp,%esp
  104756:	5d                   	pop    %ebp
  104757:	c3                   	ret    
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
  104758:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  10475b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10475f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104766:	e8 b5 fb ff ff       	call   104320 <argstr>
  10476b:	85 c0                	test   %eax,%eax
  10476d:	78 d7                	js     104746 <sys_link+0x26>
    return -1;
  if((ip = namei(old)) == 0)
  10476f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  104772:	89 04 24             	mov    %eax,(%esp)
  104775:	e8 e6 d7 ff ff       	call   101f60 <namei>
  10477a:	85 c0                	test   %eax,%eax
  10477c:	89 c3                	mov    %eax,%ebx
  10477e:	74 c6                	je     104746 <sys_link+0x26>
    return -1;
  ilock(ip);
  104780:	89 04 24             	mov    %eax,(%esp)
  104783:	e8 18 d5 ff ff       	call   101ca0 <ilock>
  if(ip->type == T_DIR){
  104788:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
  10478d:	0f 84 86 00 00 00    	je     104819 <sys_link+0xf9>
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  104793:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
  104798:	8d 7d d2             	lea    -0x2e(%ebp),%edi
  if(ip->type == T_DIR){
    iunlockput(ip);
    return -1;
  }
  ip->nlink++;
  iupdate(ip);
  10479b:	89 1c 24             	mov    %ebx,(%esp)
  10479e:	e8 cd cd ff ff       	call   101570 <iupdate>
  iunlock(ip);
  1047a3:	89 1c 24             	mov    %ebx,(%esp)
  1047a6:	e8 85 d4 ff ff       	call   101c30 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
  1047ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1047ae:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1047b2:	89 04 24             	mov    %eax,(%esp)
  1047b5:	e8 86 d7 ff ff       	call   101f40 <nameiparent>
  1047ba:	85 c0                	test   %eax,%eax
  1047bc:	89 c6                	mov    %eax,%esi
  1047be:	74 44                	je     104804 <sys_link+0xe4>
    goto  bad;
  ilock(dp);
  1047c0:	89 04 24             	mov    %eax,(%esp)
  1047c3:	e8 d8 d4 ff ff       	call   101ca0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0)
  1047c8:	8b 06                	mov    (%esi),%eax
  1047ca:	3b 03                	cmp    (%ebx),%eax
  1047cc:	75 2e                	jne    1047fc <sys_link+0xdc>
  1047ce:	8b 43 04             	mov    0x4(%ebx),%eax
  1047d1:	89 7c 24 04          	mov    %edi,0x4(%esp)
  1047d5:	89 34 24             	mov    %esi,(%esp)
  1047d8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1047dc:	e8 5f d3 ff ff       	call   101b40 <dirlink>
  1047e1:	85 c0                	test   %eax,%eax
  1047e3:	78 17                	js     1047fc <sys_link+0xdc>
    goto bad;
  iunlockput(dp);
  1047e5:	89 34 24             	mov    %esi,(%esp)
  1047e8:	e8 93 d4 ff ff       	call   101c80 <iunlockput>
  iput(ip);
  1047ed:	89 1c 24             	mov    %ebx,(%esp)
  1047f0:	e8 fb d1 ff ff       	call   1019f0 <iput>
  1047f5:	31 c0                	xor    %eax,%eax
  return 0;
  1047f7:	e9 4f ff ff ff       	jmp    10474b <sys_link+0x2b>

bad:
  if(dp)
    iunlockput(dp);
  1047fc:	89 34 24             	mov    %esi,(%esp)
  1047ff:	e8 7c d4 ff ff       	call   101c80 <iunlockput>
  ilock(ip);
  104804:	89 1c 24             	mov    %ebx,(%esp)
  104807:	e8 94 d4 ff ff       	call   101ca0 <ilock>
  ip->nlink--;
  10480c:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
  104811:	89 1c 24             	mov    %ebx,(%esp)
  104814:	e8 57 cd ff ff       	call   101570 <iupdate>
  iunlockput(ip);
  104819:	89 1c 24             	mov    %ebx,(%esp)
  10481c:	e8 5f d4 ff ff       	call   101c80 <iunlockput>
  104821:	83 c8 ff             	or     $0xffffffff,%eax
  return -1;
  104824:	e9 22 ff ff ff       	jmp    10474b <sys_link+0x2b>
  104829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104830 <create>:
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  104830:	55                   	push   %ebp
  104831:	89 e5                	mov    %esp,%ebp
  104833:	57                   	push   %edi
  104834:	89 cf                	mov    %ecx,%edi
  104836:	56                   	push   %esi
  104837:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104838:	31 db                	xor    %ebx,%ebx
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  10483a:	83 ec 4c             	sub    $0x4c,%esp
  10483d:	89 55 c4             	mov    %edx,-0x3c(%ebp)
  104840:	0f b7 55 08          	movzwl 0x8(%ebp),%edx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104844:	8d 75 d6             	lea    -0x2a(%ebp),%esi
  return 0;
}

static struct inode*
create(char *path, int canexist, short type, short major, short minor)
{
  104847:	66 89 55 c2          	mov    %dx,-0x3e(%ebp)
  10484b:	0f b7 55 0c          	movzwl 0xc(%ebp),%edx
  10484f:	66 89 55 c0          	mov    %dx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
  104853:	89 74 24 04          	mov    %esi,0x4(%esp)
  104857:	89 04 24             	mov    %eax,(%esp)
  10485a:	e8 e1 d6 ff ff       	call   101f40 <nameiparent>
  10485f:	85 c0                	test   %eax,%eax
  104861:	74 67                	je     1048ca <create+0x9a>
    return 0;
  ilock(dp);
  104863:	89 04 24             	mov    %eax,(%esp)
  104866:	89 45 bc             	mov    %eax,-0x44(%ebp)
  104869:	e8 32 d4 ff ff       	call   101ca0 <ilock>

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
  10486e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  104871:	85 d2                	test   %edx,%edx
  104873:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104876:	74 60                	je     1048d8 <create+0xa8>
  104878:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  10487b:	89 14 24             	mov    %edx,(%esp)
  10487e:	89 44 24 08          	mov    %eax,0x8(%esp)
  104882:	89 74 24 04          	mov    %esi,0x4(%esp)
  104886:	e8 d5 ce ff ff       	call   101760 <dirlookup>
  10488b:	8b 55 bc             	mov    -0x44(%ebp),%edx
  10488e:	85 c0                	test   %eax,%eax
  104890:	89 c3                	mov    %eax,%ebx
  104892:	74 44                	je     1048d8 <create+0xa8>
    iunlockput(dp);
  104894:	89 14 24             	mov    %edx,(%esp)
  104897:	e8 e4 d3 ff ff       	call   101c80 <iunlockput>
    ilock(ip);
  10489c:	89 1c 24             	mov    %ebx,(%esp)
  10489f:	e8 fc d3 ff ff       	call   101ca0 <ilock>
    if(ip->type != type || ip->major != major || ip->minor != minor){
  1048a4:	66 39 7b 10          	cmp    %di,0x10(%ebx)
  1048a8:	0f 85 02 01 00 00    	jne    1049b0 <create+0x180>
  1048ae:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
  1048b2:	66 39 43 12          	cmp    %ax,0x12(%ebx)
  1048b6:	0f 85 f4 00 00 00    	jne    1049b0 <create+0x180>
  1048bc:	0f b7 55 c0          	movzwl -0x40(%ebp),%edx
  1048c0:	66 39 53 14          	cmp    %dx,0x14(%ebx)
  1048c4:	0f 85 e6 00 00 00    	jne    1049b0 <create+0x180>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  return ip;
}
  1048ca:	83 c4 4c             	add    $0x4c,%esp
  1048cd:	89 d8                	mov    %ebx,%eax
  1048cf:	5b                   	pop    %ebx
  1048d0:	5e                   	pop    %esi
  1048d1:	5f                   	pop    %edi
  1048d2:	5d                   	pop    %ebp
  1048d3:	c3                   	ret    
  1048d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    return ip;
  }

  if((ip = ialloc(dp->dev, type)) == 0){
  1048d8:	0f bf c7             	movswl %di,%eax
  1048db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1048df:	8b 02                	mov    (%edx),%eax
  1048e1:	89 04 24             	mov    %eax,(%esp)
  1048e4:	89 55 bc             	mov    %edx,-0x44(%ebp)
  1048e7:	e8 74 cf ff ff       	call   101860 <ialloc>
  1048ec:	8b 55 bc             	mov    -0x44(%ebp),%edx
  1048ef:	85 c0                	test   %eax,%eax
  1048f1:	89 c3                	mov    %eax,%ebx
  1048f3:	74 50                	je     104945 <create+0x115>
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  1048f5:	89 04 24             	mov    %eax,(%esp)
  1048f8:	89 55 bc             	mov    %edx,-0x44(%ebp)
  1048fb:	e8 a0 d3 ff ff       	call   101ca0 <ilock>
  ip->major = major;
  104900:	0f b7 45 c2          	movzwl -0x3e(%ebp),%eax
  ip->minor = minor;
  ip->nlink = 1;
  104904:	66 c7 43 16 01 00    	movw   $0x1,0x16(%ebx)
  if((ip = ialloc(dp->dev, type)) == 0){
    iunlockput(dp);
    return 0;
  }
  ilock(ip);
  ip->major = major;
  10490a:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
  10490e:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  104912:	66 89 43 14          	mov    %ax,0x14(%ebx)
  ip->nlink = 1;
  iupdate(ip);
  104916:	89 1c 24             	mov    %ebx,(%esp)
  104919:	e8 52 cc ff ff       	call   101570 <iupdate>
  
  if(dirlink(dp, name, ip->inum) < 0){
  10491e:	8b 43 04             	mov    0x4(%ebx),%eax
  104921:	89 74 24 04          	mov    %esi,0x4(%esp)
  104925:	89 44 24 08          	mov    %eax,0x8(%esp)
  104929:	8b 55 bc             	mov    -0x44(%ebp),%edx
  10492c:	89 14 24             	mov    %edx,(%esp)
  10492f:	e8 0c d2 ff ff       	call   101b40 <dirlink>
  104934:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104937:	85 c0                	test   %eax,%eax
  104939:	0f 88 85 00 00 00    	js     1049c4 <create+0x194>
    iunlockput(ip);
    iunlockput(dp);
    return 0;
  }

  if(type == T_DIR){  // Create . and .. entries.
  10493f:	66 83 ff 01          	cmp    $0x1,%di
  104943:	74 13                	je     104958 <create+0x128>
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  104945:	89 14 24             	mov    %edx,(%esp)
  104948:	e8 33 d3 ff ff       	call   101c80 <iunlockput>
  return ip;
}
  10494d:	83 c4 4c             	add    $0x4c,%esp
  104950:	89 d8                	mov    %ebx,%eax
  104952:	5b                   	pop    %ebx
  104953:	5e                   	pop    %esi
  104954:	5f                   	pop    %edi
  104955:	5d                   	pop    %ebp
  104956:	c3                   	ret    
  104957:	90                   	nop
    iunlockput(dp);
    return 0;
  }

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
  104958:	66 83 42 16 01       	addw   $0x1,0x16(%edx)
    iupdate(dp);
  10495d:	89 14 24             	mov    %edx,(%esp)
  104960:	89 55 bc             	mov    %edx,-0x44(%ebp)
  104963:	e8 08 cc ff ff       	call   101570 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
  104968:	8b 43 04             	mov    0x4(%ebx),%eax
  10496b:	c7 44 24 04 f9 65 10 	movl   $0x1065f9,0x4(%esp)
  104972:	00 
  104973:	89 1c 24             	mov    %ebx,(%esp)
  104976:	89 44 24 08          	mov    %eax,0x8(%esp)
  10497a:	e8 c1 d1 ff ff       	call   101b40 <dirlink>
  10497f:	8b 55 bc             	mov    -0x44(%ebp),%edx
  104982:	85 c0                	test   %eax,%eax
  104984:	78 1e                	js     1049a4 <create+0x174>
  104986:	8b 42 04             	mov    0x4(%edx),%eax
  104989:	c7 44 24 04 f8 65 10 	movl   $0x1065f8,0x4(%esp)
  104990:	00 
  104991:	89 1c 24             	mov    %ebx,(%esp)
  104994:	89 44 24 08          	mov    %eax,0x8(%esp)
  104998:	e8 a3 d1 ff ff       	call   101b40 <dirlink>
  10499d:	8b 55 bc             	mov    -0x44(%ebp),%edx
  1049a0:	85 c0                	test   %eax,%eax
  1049a2:	79 a1                	jns    104945 <create+0x115>
      panic("create dots");
  1049a4:	c7 04 24 fb 65 10 00 	movl   $0x1065fb,(%esp)
  1049ab:	e8 70 bf ff ff       	call   100920 <panic>

  if(canexist && (ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(ip->type != type || ip->major != major || ip->minor != minor){
      iunlockput(ip);
  1049b0:	89 1c 24             	mov    %ebx,(%esp)
  1049b3:	31 db                	xor    %ebx,%ebx
  1049b5:	e8 c6 d2 ff ff       	call   101c80 <iunlockput>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }
  iunlockput(dp);
  return ip;
}
  1049ba:	83 c4 4c             	add    $0x4c,%esp
  1049bd:	89 d8                	mov    %ebx,%eax
  1049bf:	5b                   	pop    %ebx
  1049c0:	5e                   	pop    %esi
  1049c1:	5f                   	pop    %edi
  1049c2:	5d                   	pop    %ebp
  1049c3:	c3                   	ret    
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);
  
  if(dirlink(dp, name, ip->inum) < 0){
    ip->nlink = 0;
  1049c4:	66 c7 43 16 00 00    	movw   $0x0,0x16(%ebx)
    iunlockput(ip);
  1049ca:	89 1c 24             	mov    %ebx,(%esp)
    iunlockput(dp);
  1049cd:	31 db                	xor    %ebx,%ebx
  ip->nlink = 1;
  iupdate(ip);
  
  if(dirlink(dp, name, ip->inum) < 0){
    ip->nlink = 0;
    iunlockput(ip);
  1049cf:	e8 ac d2 ff ff       	call   101c80 <iunlockput>
    iunlockput(dp);
  1049d4:	8b 55 bc             	mov    -0x44(%ebp),%edx
  1049d7:	89 14 24             	mov    %edx,(%esp)
  1049da:	e8 a1 d2 ff ff       	call   101c80 <iunlockput>
    return 0;
  1049df:	e9 e6 fe ff ff       	jmp    1048ca <create+0x9a>
  1049e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1049ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

001049f0 <sys_mkdir>:
  return 0;
}

int
sys_mkdir(void)
{
  1049f0:	55                   	push   %ebp
  1049f1:	89 e5                	mov    %esp,%ebp
  1049f3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
  1049f6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1049f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1049fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104a04:	e8 17 f9 ff ff       	call   104320 <argstr>
  104a09:	85 c0                	test   %eax,%eax
  104a0b:	79 0b                	jns    104a18 <sys_mkdir+0x28>
    return -1;
  iunlockput(ip);
  return 0;
  104a0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104a12:	c9                   	leave  
  104a13:	c3                   	ret    
  104a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = create(path, 0, T_DIR, 0, 0)) == 0)
  104a18:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104a1f:	00 
  104a20:	31 d2                	xor    %edx,%edx
  104a22:	b9 01 00 00 00       	mov    $0x1,%ecx
  104a27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104a31:	e8 fa fd ff ff       	call   104830 <create>
  104a36:	85 c0                	test   %eax,%eax
  104a38:	74 d3                	je     104a0d <sys_mkdir+0x1d>
    return -1;
  iunlockput(ip);
  104a3a:	89 04 24             	mov    %eax,(%esp)
  104a3d:	e8 3e d2 ff ff       	call   101c80 <iunlockput>
  104a42:	31 c0                	xor    %eax,%eax
  return 0;
}
  104a44:	c9                   	leave  
  104a45:	c3                   	ret    
  104a46:	8d 76 00             	lea    0x0(%esi),%esi
  104a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104a50 <sys_mknod>:
  return fd;
}

int
sys_mknod(void)
{
  104a50:	55                   	push   %ebp
  104a51:	89 e5                	mov    %esp,%ebp
  104a53:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104a56:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104a59:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104a64:	e8 b7 f8 ff ff       	call   104320 <argstr>
  104a69:	85 c0                	test   %eax,%eax
  104a6b:	79 0b                	jns    104a78 <sys_mknod+0x28>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  return 0;
  104a6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104a72:	c9                   	leave  
  104a73:	c3                   	ret    
  104a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
  104a78:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104a7b:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a7f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104a86:	e8 45 f8 ff ff       	call   1042d0 <argint>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104a8b:	85 c0                	test   %eax,%eax
  104a8d:	78 de                	js     104a6d <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
  104a8f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104a92:	89 44 24 04          	mov    %eax,0x4(%esp)
  104a96:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104a9d:	e8 2e f8 ff ff       	call   1042d0 <argint>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104aa2:	85 c0                	test   %eax,%eax
  104aa4:	78 c7                	js     104a6d <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
  104aa6:	0f bf 45 ec          	movswl -0x14(%ebp),%eax
  104aaa:	31 d2                	xor    %edx,%edx
  104aac:	b9 03 00 00 00       	mov    $0x3,%ecx
  104ab1:	89 44 24 04          	mov    %eax,0x4(%esp)
  104ab5:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
  104ab9:	89 04 24             	mov    %eax,(%esp)
  104abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104abf:	e8 6c fd ff ff       	call   104830 <create>
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  if((len=argstr(0, &path)) < 0 ||
  104ac4:	85 c0                	test   %eax,%eax
  104ac6:	74 a5                	je     104a6d <sys_mknod+0x1d>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, 0, T_DEV, major, minor)) == 0)
    return -1;
  iunlockput(ip);
  104ac8:	89 04 24             	mov    %eax,(%esp)
  104acb:	e8 b0 d1 ff ff       	call   101c80 <iunlockput>
  104ad0:	31 c0                	xor    %eax,%eax
  return 0;
}
  104ad2:	c9                   	leave  
  104ad3:	c3                   	ret    
  104ad4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104ada:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00104ae0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
  104ae0:	55                   	push   %ebp
  104ae1:	89 e5                	mov    %esp,%ebp
  104ae3:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104ae6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
  104ae9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  104aec:	89 75 fc             	mov    %esi,-0x4(%ebp)
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104aef:	89 44 24 04          	mov    %eax,0x4(%esp)
  104af3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104afa:	e8 21 f8 ff ff       	call   104320 <argstr>
  104aff:	85 c0                	test   %eax,%eax
  104b01:	79 15                	jns    104b18 <sys_open+0x38>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);

  return fd;
  104b03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104b08:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  104b0b:	8b 75 fc             	mov    -0x4(%ebp),%esi
  104b0e:	89 ec                	mov    %ebp,%esp
  104b10:	5d                   	pop    %ebp
  104b11:	c3                   	ret    
  104b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
  104b18:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104b1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  104b1f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104b26:	e8 a5 f7 ff ff       	call   1042d0 <argint>
  104b2b:	85 c0                	test   %eax,%eax
  104b2d:	78 d4                	js     104b03 <sys_open+0x23>
    return -1;

  if(omode & O_CREATE){
  104b2f:	f6 45 f1 02          	testb  $0x2,-0xf(%ebp)
  104b33:	74 7b                	je     104bb0 <sys_open+0xd0>
    if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
  104b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104b38:	b9 02 00 00 00       	mov    $0x2,%ecx
  104b3d:	ba 01 00 00 00       	mov    $0x1,%edx
  104b42:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104b49:	00 
  104b4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104b51:	e8 da fc ff ff       	call   104830 <create>
  104b56:	85 c0                	test   %eax,%eax
  104b58:	89 c6                	mov    %eax,%esi
  104b5a:	74 a7                	je     104b03 <sys_open+0x23>
      iunlockput(ip);
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  104b5c:	e8 4f c4 ff ff       	call   100fb0 <filealloc>
  104b61:	85 c0                	test   %eax,%eax
  104b63:	89 c3                	mov    %eax,%ebx
  104b65:	74 73                	je     104bda <sys_open+0xfa>
  104b67:	e8 44 f9 ff ff       	call   1044b0 <fdalloc>
  104b6c:	85 c0                	test   %eax,%eax
  104b6e:	66 90                	xchg   %ax,%ax
  104b70:	78 7d                	js     104bef <sys_open+0x10f>
    if(f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  104b72:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  104b75:	89 34 24             	mov    %esi,(%esp)
  104b78:	e8 b3 d0 ff ff       	call   101c30 <iunlock>

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  104b7d:	8b 55 f0             	mov    -0x10(%ebp),%edx
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);

  f->type = FD_INODE;
  104b80:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  f->ip = ip;
  104b86:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
  104b89:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
  104b90:	89 d1                	mov    %edx,%ecx
  104b92:	83 f1 01             	xor    $0x1,%ecx
  104b95:	83 e1 01             	and    $0x1,%ecx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104b98:	83 e2 03             	and    $0x3,%edx
  iunlock(ip);

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  104b9b:	88 4b 08             	mov    %cl,0x8(%ebx)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  104b9e:	0f 95 43 09          	setne  0x9(%ebx)

  return fd;
  104ba2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104ba5:	e9 5e ff ff ff       	jmp    104b08 <sys_open+0x28>
  104baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(omode & O_CREATE){
    if((ip = create(path, 1, T_FILE, 0, 0)) == 0)
      return -1;
  } else {
    if((ip = namei(path)) == 0)
  104bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104bb3:	89 04 24             	mov    %eax,(%esp)
  104bb6:	e8 a5 d3 ff ff       	call   101f60 <namei>
  104bbb:	85 c0                	test   %eax,%eax
  104bbd:	89 c6                	mov    %eax,%esi
  104bbf:	0f 84 3e ff ff ff    	je     104b03 <sys_open+0x23>
      return -1;
    ilock(ip);
  104bc5:	89 04 24             	mov    %eax,(%esp)
  104bc8:	e8 d3 d0 ff ff       	call   101ca0 <ilock>
    if(ip->type == T_DIR && (omode & (O_RDWR|O_WRONLY))){
  104bcd:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104bd2:	75 88                	jne    104b5c <sys_open+0x7c>
  104bd4:	f6 45 f0 03          	testb  $0x3,-0x10(%ebp)
  104bd8:	74 82                	je     104b5c <sys_open+0x7c>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
  104bda:	89 34 24             	mov    %esi,(%esp)
  104bdd:	8d 76 00             	lea    0x0(%esi),%esi
  104be0:	e8 9b d0 ff ff       	call   101c80 <iunlockput>
  104be5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  104bea:	e9 19 ff ff ff       	jmp    104b08 <sys_open+0x28>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
  104bef:	89 1c 24             	mov    %ebx,(%esp)
  104bf2:	e8 49 c4 ff ff       	call   101040 <fileclose>
  104bf7:	eb e1                	jmp    104bda <sys_open+0xfa>
  104bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104c00 <sys_unlink>:
  return 1;
}

int
sys_unlink(void)
{
  104c00:	55                   	push   %ebp
  104c01:	89 e5                	mov    %esp,%ebp
  104c03:	83 ec 78             	sub    $0x78,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104c06:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  return 1;
}

int
sys_unlink(void)
{
  104c09:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  104c0c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  104c0f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
  104c12:	89 44 24 04          	mov    %eax,0x4(%esp)
  104c16:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104c1d:	e8 fe f6 ff ff       	call   104320 <argstr>
  104c22:	85 c0                	test   %eax,%eax
  104c24:	79 12                	jns    104c38 <sys_unlink+0x38>
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  return 0;
  104c26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104c2b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  104c2e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  104c31:	8b 7d fc             	mov    -0x4(%ebp),%edi
  104c34:	89 ec                	mov    %ebp,%esp
  104c36:	5d                   	pop    %ebp
  104c37:	c3                   	ret    
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
  if((dp = nameiparent(path, name)) == 0)
  104c38:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104c3b:	8d 5d d2             	lea    -0x2e(%ebp),%ebx
  104c3e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104c42:	89 04 24             	mov    %eax,(%esp)
  104c45:	e8 f6 d2 ff ff       	call   101f40 <nameiparent>
  104c4a:	85 c0                	test   %eax,%eax
  104c4c:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  104c4f:	74 d5                	je     104c26 <sys_unlink+0x26>
    return -1;
  ilock(dp);
  104c51:	89 04 24             	mov    %eax,(%esp)
  104c54:	e8 47 d0 ff ff       	call   101ca0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0){
  104c59:	c7 44 24 04 f9 65 10 	movl   $0x1065f9,0x4(%esp)
  104c60:	00 
  104c61:	89 1c 24             	mov    %ebx,(%esp)
  104c64:	e8 c7 ca ff ff       	call   101730 <namecmp>
  104c69:	85 c0                	test   %eax,%eax
  104c6b:	0f 84 a4 00 00 00    	je     104d15 <sys_unlink+0x115>
  104c71:	c7 44 24 04 f8 65 10 	movl   $0x1065f8,0x4(%esp)
  104c78:	00 
  104c79:	89 1c 24             	mov    %ebx,(%esp)
  104c7c:	e8 af ca ff ff       	call   101730 <namecmp>
  104c81:	85 c0                	test   %eax,%eax
  104c83:	0f 84 8c 00 00 00    	je     104d15 <sys_unlink+0x115>
    iunlockput(dp);
    return -1;
  }

  if((ip = dirlookup(dp, name, &off)) == 0){
  104c89:	8d 45 e0             	lea    -0x20(%ebp),%eax
  104c8c:	89 44 24 08          	mov    %eax,0x8(%esp)
  104c90:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  104c93:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104c97:	89 04 24             	mov    %eax,(%esp)
  104c9a:	e8 c1 ca ff ff       	call   101760 <dirlookup>
  104c9f:	85 c0                	test   %eax,%eax
  104ca1:	89 c6                	mov    %eax,%esi
  104ca3:	74 70                	je     104d15 <sys_unlink+0x115>
    iunlockput(dp);
    return -1;
  }
  ilock(ip);
  104ca5:	89 04 24             	mov    %eax,(%esp)
  104ca8:	e8 f3 cf ff ff       	call   101ca0 <ilock>

  if(ip->nlink < 1)
  104cad:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
  104cb2:	0f 8e e9 00 00 00    	jle    104da1 <sys_unlink+0x1a1>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
  104cb8:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
  104cbd:	75 71                	jne    104d30 <sys_unlink+0x130>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
  104cbf:	83 7e 18 20          	cmpl   $0x20,0x18(%esi)
  104cc3:	76 6b                	jbe    104d30 <sys_unlink+0x130>
  104cc5:	8d 7d b2             	lea    -0x4e(%ebp),%edi
  104cc8:	bb 20 00 00 00       	mov    $0x20,%ebx
  104ccd:	8d 76 00             	lea    0x0(%esi),%esi
  104cd0:	eb 0e                	jmp    104ce0 <sys_unlink+0xe0>
  104cd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104cd8:	83 c3 10             	add    $0x10,%ebx
  104cdb:	3b 5e 18             	cmp    0x18(%esi),%ebx
  104cde:	73 50                	jae    104d30 <sys_unlink+0x130>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104ce0:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104ce7:	00 
  104ce8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  104cec:	89 7c 24 04          	mov    %edi,0x4(%esp)
  104cf0:	89 34 24             	mov    %esi,(%esp)
  104cf3:	e8 68 c7 ff ff       	call   101460 <readi>
  104cf8:	83 f8 10             	cmp    $0x10,%eax
  104cfb:	0f 85 94 00 00 00    	jne    104d95 <sys_unlink+0x195>
      panic("isdirempty: readi");
    if(de.inum != 0)
  104d01:	66 83 7d b2 00       	cmpw   $0x0,-0x4e(%ebp)
  104d06:	74 d0                	je     104cd8 <sys_unlink+0xd8>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
  104d08:	89 34 24             	mov    %esi,(%esp)
  104d0b:	90                   	nop
  104d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  104d10:	e8 6b cf ff ff       	call   101c80 <iunlockput>
    iunlockput(dp);
  104d15:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  104d18:	89 04 24             	mov    %eax,(%esp)
  104d1b:	e8 60 cf ff ff       	call   101c80 <iunlockput>
  104d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  104d25:	e9 01 ff ff ff       	jmp    104c2b <sys_unlink+0x2b>
  104d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  memset(&de, 0, sizeof(de));
  104d30:	8d 5d c2             	lea    -0x3e(%ebp),%ebx
  104d33:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  104d3a:	00 
  104d3b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104d42:	00 
  104d43:	89 1c 24             	mov    %ebx,(%esp)
  104d46:	e8 b5 f2 ff ff       	call   104000 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
  104d4b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  104d4e:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  104d55:	00 
  104d56:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  104d5a:	89 44 24 08          	mov    %eax,0x8(%esp)
  104d5e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  104d61:	89 04 24             	mov    %eax,(%esp)
  104d64:	e8 97 c8 ff ff       	call   101600 <writei>
  104d69:	83 f8 10             	cmp    $0x10,%eax
  104d6c:	75 3f                	jne    104dad <sys_unlink+0x1ad>
    panic("unlink: writei");
  iunlockput(dp);
  104d6e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  104d71:	89 04 24             	mov    %eax,(%esp)
  104d74:	e8 07 cf ff ff       	call   101c80 <iunlockput>

  ip->nlink--;
  104d79:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
  iupdate(ip);
  104d7e:	89 34 24             	mov    %esi,(%esp)
  104d81:	e8 ea c7 ff ff       	call   101570 <iupdate>
  iunlockput(ip);
  104d86:	89 34 24             	mov    %esi,(%esp)
  104d89:	e8 f2 ce ff ff       	call   101c80 <iunlockput>
  104d8e:	31 c0                	xor    %eax,%eax
  return 0;
  104d90:	e9 96 fe ff ff       	jmp    104c2b <sys_unlink+0x2b>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
  104d95:	c7 04 24 19 66 10 00 	movl   $0x106619,(%esp)
  104d9c:	e8 7f bb ff ff       	call   100920 <panic>
    return -1;
  }
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  104da1:	c7 04 24 07 66 10 00 	movl   $0x106607,(%esp)
  104da8:	e8 73 bb ff ff       	call   100920 <panic>
    return -1;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  104dad:	c7 04 24 2b 66 10 00 	movl   $0x10662b,(%esp)
  104db4:	e8 67 bb ff ff       	call   100920 <panic>
  104db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00104dc0 <T.62>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  104dc0:	55                   	push   %ebp
  104dc1:	89 e5                	mov    %esp,%ebp
  104dc3:	83 ec 28             	sub    $0x28,%esp
  104dc6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  104dc9:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  104dcb:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
  104dce:	89 75 fc             	mov    %esi,-0x4(%ebp)
  104dd1:	89 d6                	mov    %edx,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
  104dd3:	89 44 24 04          	mov    %eax,0x4(%esp)
  104dd7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  104dde:	e8 ed f4 ff ff       	call   1042d0 <argint>
  104de3:	85 c0                	test   %eax,%eax
  104de5:	79 11                	jns    104df8 <T.62+0x38>
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  104de7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return 0;
}
  104dec:	8b 5d f8             	mov    -0x8(%ebp),%ebx
  104def:	8b 75 fc             	mov    -0x4(%ebp),%esi
  104df2:	89 ec                	mov    %ebp,%esp
  104df4:	5d                   	pop    %ebp
  104df5:	c3                   	ret    
  104df6:	66 90                	xchg   %ax,%ax
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=cp->ofile[fd]) == 0)
  104df8:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  104dfc:	77 e9                	ja     104de7 <T.62+0x27>
  104dfe:	e8 7d e5 ff ff       	call   103380 <curproc>
  104e03:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  104e06:	8b 54 88 20          	mov    0x20(%eax,%ecx,4),%edx
  104e0a:	85 d2                	test   %edx,%edx
  104e0c:	74 d9                	je     104de7 <T.62+0x27>
    return -1;
  if(pfd)
  104e0e:	85 db                	test   %ebx,%ebx
  104e10:	74 02                	je     104e14 <T.62+0x54>
    *pfd = fd;
  104e12:	89 0b                	mov    %ecx,(%ebx)
  if(pf)
  104e14:	31 c0                	xor    %eax,%eax
  104e16:	85 f6                	test   %esi,%esi
  104e18:	74 d2                	je     104dec <T.62+0x2c>
    *pf = f;
  104e1a:	89 16                	mov    %edx,(%esi)
  104e1c:	eb ce                	jmp    104dec <T.62+0x2c>
  104e1e:	66 90                	xchg   %ax,%ax

00104e20 <sys_read>:
  return -1;
}

int
sys_read(void)
{
  104e20:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104e21:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_read(void)
{
  104e23:	89 e5                	mov    %esp,%ebp
  104e25:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104e28:	8d 55 f4             	lea    -0xc(%ebp),%edx
  104e2b:	e8 90 ff ff ff       	call   104dc0 <T.62>
  104e30:	85 c0                	test   %eax,%eax
  104e32:	79 0c                	jns    104e40 <sys_read+0x20>
    return -1;
  return fileread(f, p, n);
  104e34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104e39:	c9                   	leave  
  104e3a:	c3                   	ret    
  104e3b:	90                   	nop
  104e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104e40:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104e43:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e47:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104e4e:	e8 7d f4 ff ff       	call   1042d0 <argint>
  104e53:	85 c0                	test   %eax,%eax
  104e55:	78 dd                	js     104e34 <sys_read+0x14>
  104e57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104e5a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104e61:	89 44 24 08          	mov    %eax,0x8(%esp)
  104e65:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104e68:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e6c:	e8 2f f5 ff ff       	call   1043a0 <argptr>
  104e71:	85 c0                	test   %eax,%eax
  104e73:	78 bf                	js     104e34 <sys_read+0x14>
    return -1;
  return fileread(f, p, n);
  104e75:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104e78:	89 44 24 08          	mov    %eax,0x8(%esp)
  104e7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104e7f:	89 44 24 04          	mov    %eax,0x4(%esp)
  104e83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104e86:	89 04 24             	mov    %eax,(%esp)
  104e89:	e8 d2 bf ff ff       	call   100e60 <fileread>
}
  104e8e:	c9                   	leave  
  104e8f:	c3                   	ret    

00104e90 <sys_write>:

int
sys_write(void)
{
  104e90:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104e91:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
  104e93:	89 e5                	mov    %esp,%ebp
  104e95:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104e98:	8d 55 f4             	lea    -0xc(%ebp),%edx
  104e9b:	e8 20 ff ff ff       	call   104dc0 <T.62>
  104ea0:	85 c0                	test   %eax,%eax
  104ea2:	79 0c                	jns    104eb0 <sys_write+0x20>
    return -1;
  return filewrite(f, p, n);
  104ea4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104ea9:	c9                   	leave  
  104eaa:	c3                   	ret    
  104eab:	90                   	nop
  104eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
  104eb0:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104eb3:	89 44 24 04          	mov    %eax,0x4(%esp)
  104eb7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  104ebe:	e8 0d f4 ff ff       	call   1042d0 <argint>
  104ec3:	85 c0                	test   %eax,%eax
  104ec5:	78 dd                	js     104ea4 <sys_write+0x14>
  104ec7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104eca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104ed1:	89 44 24 08          	mov    %eax,0x8(%esp)
  104ed5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  104ed8:	89 44 24 04          	mov    %eax,0x4(%esp)
  104edc:	e8 bf f4 ff ff       	call   1043a0 <argptr>
  104ee1:	85 c0                	test   %eax,%eax
  104ee3:	78 bf                	js     104ea4 <sys_write+0x14>
    return -1;
  return filewrite(f, p, n);
  104ee5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104ee8:	89 44 24 08          	mov    %eax,0x8(%esp)
  104eec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104eef:	89 44 24 04          	mov    %eax,0x4(%esp)
  104ef3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104ef6:	89 04 24             	mov    %eax,(%esp)
  104ef9:	e8 b2 be ff ff       	call   100db0 <filewrite>
}
  104efe:	c9                   	leave  
  104eff:	c3                   	ret    

00104f00 <sys_dup>:

int
sys_dup(void)
{
  104f00:	55                   	push   %ebp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  104f01:	31 c0                	xor    %eax,%eax
  return filewrite(f, p, n);
}

int
sys_dup(void)
{
  104f03:	89 e5                	mov    %esp,%ebp
  104f05:	53                   	push   %ebx
  104f06:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
  104f09:	8d 55 f4             	lea    -0xc(%ebp),%edx
  104f0c:	e8 af fe ff ff       	call   104dc0 <T.62>
  104f11:	85 c0                	test   %eax,%eax
  104f13:	79 13                	jns    104f28 <sys_dup+0x28>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
  104f15:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
  104f1a:	89 d8                	mov    %ebx,%eax
  104f1c:	83 c4 24             	add    $0x24,%esp
  104f1f:	5b                   	pop    %ebx
  104f20:	5d                   	pop    %ebp
  104f21:	c3                   	ret    
  104f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
  104f28:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104f2b:	e8 80 f5 ff ff       	call   1044b0 <fdalloc>
  104f30:	85 c0                	test   %eax,%eax
  104f32:	89 c3                	mov    %eax,%ebx
  104f34:	78 df                	js     104f15 <sys_dup+0x15>
    return -1;
  filedup(f);
  104f36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104f39:	89 04 24             	mov    %eax,(%esp)
  104f3c:	e8 1f c0 ff ff       	call   100f60 <filedup>
  return fd;
  104f41:	eb d7                	jmp    104f1a <sys_dup+0x1a>
  104f43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104f50 <sys_fstat>:
  return 0;
}

int
sys_fstat(void)
{
  104f50:	55                   	push   %ebp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104f51:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
  104f53:	89 e5                	mov    %esp,%ebp
  104f55:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104f58:	8d 55 f4             	lea    -0xc(%ebp),%edx
  104f5b:	e8 60 fe ff ff       	call   104dc0 <T.62>
  104f60:	85 c0                	test   %eax,%eax
  104f62:	79 0c                	jns    104f70 <sys_fstat+0x20>
    return -1;
  return filestat(f, st);
  104f64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  104f69:	c9                   	leave  
  104f6a:	c3                   	ret    
  104f6b:	90                   	nop
  104f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_fstat(void)
{
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
  104f70:	8d 45 f0             	lea    -0x10(%ebp),%eax
  104f73:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
  104f7a:	00 
  104f7b:	89 44 24 04          	mov    %eax,0x4(%esp)
  104f7f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104f86:	e8 15 f4 ff ff       	call   1043a0 <argptr>
  104f8b:	85 c0                	test   %eax,%eax
  104f8d:	78 d5                	js     104f64 <sys_fstat+0x14>
    return -1;
  return filestat(f, st);
  104f8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104f92:	89 44 24 04          	mov    %eax,0x4(%esp)
  104f96:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104f99:	89 04 24             	mov    %eax,(%esp)
  104f9c:	e8 6f bf ff ff       	call   100f10 <filestat>
}
  104fa1:	c9                   	leave  
  104fa2:	c3                   	ret    
  104fa3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  104fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00104fb0 <sys_close>:
  return fd;
}

int
sys_close(void)
{
  104fb0:	55                   	push   %ebp
  104fb1:	89 e5                	mov    %esp,%ebp
  104fb3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
  104fb6:	8d 55 f0             	lea    -0x10(%ebp),%edx
  104fb9:	8d 45 f4             	lea    -0xc(%ebp),%eax
  104fbc:	e8 ff fd ff ff       	call   104dc0 <T.62>
  104fc1:	89 c2                	mov    %eax,%edx
  104fc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  104fc8:	85 d2                	test   %edx,%edx
  104fca:	78 1d                	js     104fe9 <sys_close+0x39>
    return -1;
  cp->ofile[fd] = 0;
  104fcc:	e8 af e3 ff ff       	call   103380 <curproc>
  104fd1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  104fd4:	c7 44 90 20 00 00 00 	movl   $0x0,0x20(%eax,%edx,4)
  104fdb:	00 
  fileclose(f);
  104fdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104fdf:	89 04 24             	mov    %eax,(%esp)
  104fe2:	e8 59 c0 ff ff       	call   101040 <fileclose>
  104fe7:	31 c0                	xor    %eax,%eax
  return 0;
}
  104fe9:	c9                   	leave  
  104fea:	c3                   	ret    
  104feb:	90                   	nop
  104fec:	90                   	nop
  104fed:	90                   	nop
  104fee:	90                   	nop
  104fef:	90                   	nop

00104ff0 <sys_getpid>:
  return kill(pid);
}

int
sys_getpid(void)
{
  104ff0:	55                   	push   %ebp
  104ff1:	89 e5                	mov    %esp,%ebp
  104ff3:	83 ec 08             	sub    $0x8,%esp
  return cp->pid;
  104ff6:	e8 85 e3 ff ff       	call   103380 <curproc>
  104ffb:	8b 40 10             	mov    0x10(%eax),%eax
}
  104ffe:	c9                   	leave  
  104fff:	c3                   	ret    

00105000 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
  105000:	55                   	push   %ebp
  105001:	89 e5                	mov    %esp,%ebp
  105003:	53                   	push   %ebx
  105004:	83 ec 24             	sub    $0x24,%esp
  int n, ticks0;
  
  if(argint(0, &n) < 0)
  105007:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10500a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10500e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105015:	e8 b6 f2 ff ff       	call   1042d0 <argint>
  10501a:	89 c2                	mov    %eax,%edx
  10501c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  105021:	85 d2                	test   %edx,%edx
  105023:	78 58                	js     10507d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
  105025:	c7 04 24 80 d7 10 00 	movl   $0x10d780,(%esp)
  10502c:	e8 5f ef ff ff       	call   103f90 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  105031:	8b 55 f4             	mov    -0xc(%ebp),%edx
  int n, ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  105034:	8b 1d 54 aa 10 00    	mov    0x10aa54,%ebx
  while(ticks - ticks0 < n){
  10503a:	85 d2                	test   %edx,%edx
  10503c:	7f 22                	jg     105060 <sys_sleep+0x60>
  10503e:	eb 48                	jmp    105088 <sys_sleep+0x88>
    if(cp->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  105040:	c7 44 24 04 80 d7 10 	movl   $0x10d780,0x4(%esp)
  105047:	00 
  105048:	c7 04 24 54 aa 10 00 	movl   $0x10aa54,(%esp)
  10504f:	e8 8c e5 ff ff       	call   1035e0 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
  105054:	a1 54 aa 10 00       	mov    0x10aa54,%eax
  105059:	29 d8                	sub    %ebx,%eax
  10505b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  10505e:	7d 28                	jge    105088 <sys_sleep+0x88>
    if(cp->killed){
  105060:	e8 1b e3 ff ff       	call   103380 <curproc>
  105065:	8b 40 1c             	mov    0x1c(%eax),%eax
  105068:	85 c0                	test   %eax,%eax
  10506a:	74 d4                	je     105040 <sys_sleep+0x40>
      release(&tickslock);
  10506c:	c7 04 24 80 d7 10 00 	movl   $0x10d780,(%esp)
  105073:	e8 d8 ee ff ff       	call   103f50 <release>
  105078:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
  10507d:	83 c4 24             	add    $0x24,%esp
  105080:	5b                   	pop    %ebx
  105081:	5d                   	pop    %ebp
  105082:	c3                   	ret    
  105083:	90                   	nop
  105084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  105088:	c7 04 24 80 d7 10 00 	movl   $0x10d780,(%esp)
  10508f:	e8 bc ee ff ff       	call   103f50 <release>
  return 0;
}
  105094:	83 c4 24             	add    $0x24,%esp
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  105097:	31 c0                	xor    %eax,%eax
  return 0;
}
  105099:	5b                   	pop    %ebx
  10509a:	5d                   	pop    %ebp
  10509b:	c3                   	ret    
  10509c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

001050a0 <sys_sbrk>:
  return cp->pid;
}

int
sys_sbrk(void)
{
  1050a0:	55                   	push   %ebp
  1050a1:	89 e5                	mov    %esp,%ebp
  1050a3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
  1050a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1050a9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1050ad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1050b4:	e8 17 f2 ff ff       	call   1042d0 <argint>
  1050b9:	85 c0                	test   %eax,%eax
  1050bb:	79 0b                	jns    1050c8 <sys_sbrk+0x28>
    return -1;
  if((addr = growproc(n)) < 0)
  1050bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return -1;
  return addr;
}
  1050c2:	c9                   	leave  
  1050c3:	c3                   	ret    
  1050c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  if((addr = growproc(n)) < 0)
  1050c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1050cb:	89 04 24             	mov    %eax,(%esp)
  1050ce:	e8 ad e9 ff ff       	call   103a80 <growproc>
  1050d3:	85 c0                	test   %eax,%eax
  1050d5:	78 e6                	js     1050bd <sys_sbrk+0x1d>
    return -1;
  return addr;
}
  1050d7:	c9                   	leave  
  1050d8:	c3                   	ret    
  1050d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

001050e0 <sys_kill>:
  return wait();
}

int
sys_kill(void)
{
  1050e0:	55                   	push   %ebp
  1050e1:	89 e5                	mov    %esp,%ebp
  1050e3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
  1050e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1050e9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1050ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1050f4:	e8 d7 f1 ff ff       	call   1042d0 <argint>
  1050f9:	89 c2                	mov    %eax,%edx
  1050fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  105100:	85 d2                	test   %edx,%edx
  105102:	78 0b                	js     10510f <sys_kill+0x2f>
    return -1;
  return kill(pid);
  105104:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105107:	89 04 24             	mov    %eax,(%esp)
  10510a:	e8 61 e1 ff ff       	call   103270 <kill>
}
  10510f:	c9                   	leave  
  105110:	c3                   	ret    
  105111:	eb 0d                	jmp    105120 <sys_wait>
  105113:	90                   	nop
  105114:	90                   	nop
  105115:	90                   	nop
  105116:	90                   	nop
  105117:	90                   	nop
  105118:	90                   	nop
  105119:	90                   	nop
  10511a:	90                   	nop
  10511b:	90                   	nop
  10511c:	90                   	nop
  10511d:	90                   	nop
  10511e:	90                   	nop
  10511f:	90                   	nop

00105120 <sys_wait>:
  return 0;  // not reached
}

int
sys_wait(void)
{
  105120:	55                   	push   %ebp
  105121:	89 e5                	mov    %esp,%ebp
  105123:	83 ec 08             	sub    $0x8,%esp
  return wait();
}
  105126:	c9                   	leave  
}

int
sys_wait(void)
{
  return wait();
  105127:	e9 84 e5 ff ff       	jmp    1036b0 <wait>
  10512c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00105130 <sys_exit>:
  return pid;
}

int
sys_exit(void)
{
  105130:	55                   	push   %ebp
  105131:	89 e5                	mov    %esp,%ebp
  105133:	83 ec 08             	sub    $0x8,%esp
  exit();
  105136:	e8 45 e3 ff ff       	call   103480 <exit>
  return 0;  // not reached
}
  10513b:	31 c0                	xor    %eax,%eax
  10513d:	c9                   	leave  
  10513e:	c3                   	ret    
  10513f:	90                   	nop

00105140 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  105140:	55                   	push   %ebp
  105141:	89 e5                	mov    %esp,%ebp
  105143:	83 ec 18             	sub    $0x18,%esp
  int pid;
  struct proc *np;

  if((np = copyproc(cp)) == 0)
  105146:	e8 35 e2 ff ff       	call   103380 <curproc>
  10514b:	89 04 24             	mov    %eax,(%esp)
  10514e:	e8 ed e9 ff ff       	call   103b40 <copyproc>
  105153:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  105158:	85 c0                	test   %eax,%eax
  10515a:	74 0a                	je     105166 <sys_fork+0x26>
    return -1;
  pid = np->pid;
  10515c:	8b 50 10             	mov    0x10(%eax),%edx
  np->state = RUNNABLE;
  10515f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  return pid;
}
  105166:	89 d0                	mov    %edx,%eax
  105168:	c9                   	leave  
  105169:	c3                   	ret    
  10516a:	90                   	nop
  10516b:	90                   	nop
  10516c:	90                   	nop
  10516d:	90                   	nop
  10516e:	90                   	nop
  10516f:	90                   	nop

00105170 <timer_init>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timer_init(void)
{
  105170:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
  105171:	ba 43 00 00 00       	mov    $0x43,%edx
  105176:	89 e5                	mov    %esp,%ebp
  105178:	83 ec 18             	sub    $0x18,%esp
  10517b:	b8 34 00 00 00       	mov    $0x34,%eax
  105180:	ee                   	out    %al,(%dx)
  105181:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
  105186:	b2 40                	mov    $0x40,%dl
  105188:	ee                   	out    %al,(%dx)
  105189:	b8 2e 00 00 00       	mov    $0x2e,%eax
  10518e:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  pic_enable(IRQ_TIMER);
  10518f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  105196:	e8 c5 db ff ff       	call   102d60 <pic_enable>
}
  10519b:	c9                   	leave  
  10519c:	c3                   	ret    
  10519d:	90                   	nop
  10519e:	90                   	nop
  10519f:	90                   	nop

001051a0 <alltraps>:
  1051a0:	1e                   	push   %ds
  1051a1:	06                   	push   %es
  1051a2:	60                   	pusha  
  1051a3:	b8 10 00 00 00       	mov    $0x10,%eax
  1051a8:	8e d8                	mov    %eax,%ds
  1051aa:	8e c0                	mov    %eax,%es
  1051ac:	54                   	push   %esp
  1051ad:	e8 4e 00 00 00       	call   105200 <trap>
  1051b2:	83 c4 04             	add    $0x4,%esp

001051b5 <trapret>:
  1051b5:	61                   	popa   
  1051b6:	07                   	pop    %es
  1051b7:	1f                   	pop    %ds
  1051b8:	83 c4 08             	add    $0x8,%esp
  1051bb:	cf                   	iret   

001051bc <forkret1>:
  1051bc:	8b 64 24 04          	mov    0x4(%esp),%esp
  1051c0:	e9 f0 ff ff ff       	jmp    1051b5 <trapret>
  1051c5:	90                   	nop
  1051c6:	90                   	nop
  1051c7:	90                   	nop
  1051c8:	90                   	nop
  1051c9:	90                   	nop
  1051ca:	90                   	nop
  1051cb:	90                   	nop
  1051cc:	90                   	nop
  1051cd:	90                   	nop
  1051ce:	90                   	nop
  1051cf:	90                   	nop

001051d0 <idtinit>:
  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  1051d0:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  1051d1:	b8 c0 d7 10 00       	mov    $0x10d7c0,%eax
  1051d6:	89 e5                	mov    %esp,%ebp
  1051d8:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  1051db:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
  1051e1:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
  1051e5:	c1 e8 10             	shr    $0x10,%eax
  1051e8:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
  1051ec:	8d 45 fa             	lea    -0x6(%ebp),%eax
  1051ef:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
  1051f2:	c9                   	leave  
  1051f3:	c3                   	ret    
  1051f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  1051fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00105200 <trap>:

void
trap(struct trapframe *tf)
{
  105200:	55                   	push   %ebp
  105201:	89 e5                	mov    %esp,%ebp
  105203:	83 ec 48             	sub    $0x48,%esp
  105206:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  105209:	8b 5d 08             	mov    0x8(%ebp),%ebx
  10520c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  10520f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
  105212:	8b 43 28             	mov    0x28(%ebx),%eax
  105215:	83 f8 30             	cmp    $0x30,%eax
  105218:	0f 84 8a 01 00 00    	je     1053a8 <trap+0x1a8>
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  10521e:	83 f8 21             	cmp    $0x21,%eax
  105221:	0f 84 69 01 00 00    	je     105390 <trap+0x190>
  105227:	76 47                	jbe    105270 <trap+0x70>
  105229:	83 f8 2e             	cmp    $0x2e,%eax
  10522c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  105230:	0f 84 42 01 00 00    	je     105378 <trap+0x178>
  105236:	83 f8 3f             	cmp    $0x3f,%eax
  105239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  105240:	75 37                	jne    105279 <trap+0x79>
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
  105242:	8b 7b 30             	mov    0x30(%ebx),%edi
  105245:	0f b7 73 34          	movzwl 0x34(%ebx),%esi
  105249:	e8 82 d6 ff ff       	call   1028d0 <cpu>
  10524e:	c7 04 24 3c 66 10 00 	movl   $0x10663c,(%esp)
  105255:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  105259:	89 74 24 08          	mov    %esi,0x8(%esp)
  10525d:	89 44 24 04          	mov    %eax,0x4(%esp)
  105261:	e8 1a b5 ff ff       	call   100780 <cprintf>
            cpu(), tf->cs, tf->eip);
    lapic_eoi();
  105266:	e8 d5 d4 ff ff       	call   102740 <lapic_eoi>
    break;
  10526b:	e9 90 00 00 00       	jmp    105300 <trap+0x100>
    if(cp->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  105270:	83 f8 20             	cmp    $0x20,%eax
  105273:	0f 84 e7 00 00 00    	je     105360 <trap+0x160>
  105279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            cpu(), tf->cs, tf->eip);
    lapic_eoi();
    break;
    
  default:
    if(cp == 0 || (tf->cs&3) == 0){
  105280:	e8 fb e0 ff ff       	call   103380 <curproc>
  105285:	85 c0                	test   %eax,%eax
  105287:	0f 84 9b 01 00 00    	je     105428 <trap+0x228>
  10528d:	f6 43 34 03          	testb  $0x3,0x34(%ebx)
  105291:	0f 84 91 01 00 00    	je     105428 <trap+0x228>
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  105297:	8b 53 30             	mov    0x30(%ebx),%edx
  10529a:	89 55 e0             	mov    %edx,-0x20(%ebp)
  10529d:	e8 2e d6 ff ff       	call   1028d0 <cpu>
  1052a2:	8b 4b 28             	mov    0x28(%ebx),%ecx
  1052a5:	8b 73 2c             	mov    0x2c(%ebx),%esi
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
  1052a8:	89 4d dc             	mov    %ecx,-0x24(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1052ab:	89 c7                	mov    %eax,%edi
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
  1052ad:	e8 ce e0 ff ff       	call   103380 <curproc>
  1052b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1052b5:	e8 c6 e0 ff ff       	call   103380 <curproc>
      cprintf("unexpected trap %d from cpu %d eip %x\n",
              tf->trapno, cpu(), tf->eip);
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
  1052ba:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1052bd:	89 7c 24 14          	mov    %edi,0x14(%esp)
  1052c1:	89 74 24 10          	mov    %esi,0x10(%esp)
  1052c5:	89 54 24 18          	mov    %edx,0x18(%esp)
  1052c9:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1052cc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1052d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1052d3:	81 c2 88 00 00 00    	add    $0x88,%edx
  1052d9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1052dd:	8b 40 10             	mov    0x10(%eax),%eax
  1052e0:	c7 04 24 88 66 10 00 	movl   $0x106688,(%esp)
  1052e7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1052eb:	e8 90 b4 ff ff       	call   100780 <cprintf>
            cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
    cp->killed = 1;
  1052f0:	e8 8b e0 ff ff       	call   103380 <curproc>
  1052f5:	c7 40 1c 01 00 00 00 	movl   $0x1,0x1c(%eax)
  1052fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
  105300:	e8 7b e0 ff ff       	call   103380 <curproc>
  105305:	85 c0                	test   %eax,%eax
  105307:	74 1c                	je     105325 <trap+0x125>
  105309:	e8 72 e0 ff ff       	call   103380 <curproc>
  10530e:	8b 40 1c             	mov    0x1c(%eax),%eax
  105311:	85 c0                	test   %eax,%eax
  105313:	74 10                	je     105325 <trap+0x125>
  105315:	0f b7 43 34          	movzwl 0x34(%ebx),%eax
  105319:	83 e0 03             	and    $0x3,%eax
  10531c:	83 f8 03             	cmp    $0x3,%eax
  10531f:	0f 84 33 01 00 00    	je     105458 <trap+0x258>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
  105325:	e8 56 e0 ff ff       	call   103380 <curproc>
  10532a:	85 c0                	test   %eax,%eax
  10532c:	74 0d                	je     10533b <trap+0x13b>
  10532e:	66 90                	xchg   %ax,%ax
  105330:	e8 4b e0 ff ff       	call   103380 <curproc>
  105335:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
  105339:	74 0d                	je     105348 <trap+0x148>
    yield();
}
  10533b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  10533e:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105341:	8b 7d fc             	mov    -0x4(%ebp),%edi
  105344:	89 ec                	mov    %ebp,%esp
  105346:	5d                   	pop    %ebp
  105347:	c3                   	ret    
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
  105348:	83 7b 28 20          	cmpl   $0x20,0x28(%ebx)
  10534c:	75 ed                	jne    10533b <trap+0x13b>
    yield();
}
  10534e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  105351:	8b 75 f8             	mov    -0x8(%ebp),%esi
  105354:	8b 7d fc             	mov    -0x4(%ebp),%edi
  105357:	89 ec                	mov    %ebp,%esp
  105359:	5d                   	pop    %ebp
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
  10535a:	e9 61 e4 ff ff       	jmp    1037c0 <yield>
  10535f:	90                   	nop
    return;
  }

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
  105360:	e8 6b d5 ff ff       	call   1028d0 <cpu>
  105365:	85 c0                	test   %eax,%eax
  105367:	0f 84 8b 00 00 00    	je     1053f8 <trap+0x1f8>
  10536d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
    lapic_eoi();
  105370:	e8 cb d3 ff ff       	call   102740 <lapic_eoi>
    break;
  105375:	eb 89                	jmp    105300 <trap+0x100>
  105377:	90                   	nop
  105378:	90                   	nop
  105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_IDE:
    ide_intr();
  105380:	e8 ab cd ff ff       	call   102130 <ide_intr>
  105385:	8d 76 00             	lea    0x0(%esi),%esi
  105388:	eb e3                	jmp    10536d <trap+0x16d>
  10538a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lapic_eoi();
    break;
  case IRQ_OFFSET + IRQ_KBD:
    kbd_intr();
  105390:	e8 9b d2 ff ff       	call   102630 <kbd_intr>
  105395:	8d 76 00             	lea    0x0(%esi),%esi
    lapic_eoi();
  105398:	e8 a3 d3 ff ff       	call   102740 <lapic_eoi>
  10539d:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  1053a0:	e9 5b ff ff ff       	jmp    105300 <trap+0x100>
  1053a5:	8d 76 00             	lea    0x0(%esi),%esi
  1053a8:	90                   	nop
  1053a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
  1053b0:	e8 cb df ff ff       	call   103380 <curproc>
  1053b5:	8b 48 1c             	mov    0x1c(%eax),%ecx
  1053b8:	85 c9                	test   %ecx,%ecx
  1053ba:	0f 85 a8 00 00 00    	jne    105468 <trap+0x268>
      exit();
    cp->tf = tf;
  1053c0:	e8 bb df ff ff       	call   103380 <curproc>
  1053c5:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
    syscall();
  1053cb:	e8 30 f0 ff ff       	call   104400 <syscall>
    if(cp->killed)
  1053d0:	e8 ab df ff ff       	call   103380 <curproc>
  1053d5:	8b 50 1c             	mov    0x1c(%eax),%edx
  1053d8:	85 d2                	test   %edx,%edx
  1053da:	0f 84 5b ff ff ff    	je     10533b <trap+0x13b>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
    yield();
}
  1053e0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  1053e3:	8b 75 f8             	mov    -0x8(%ebp),%esi
  1053e6:	8b 7d fc             	mov    -0x4(%ebp),%edi
  1053e9:	89 ec                	mov    %ebp,%esp
  1053eb:	5d                   	pop    %ebp
    if(cp->killed)
      exit();
    cp->tf = tf;
    syscall();
    if(cp->killed)
      exit();
  1053ec:	e9 8f e0 ff ff       	jmp    103480 <exit>
  1053f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  switch(tf->trapno){
  case IRQ_OFFSET + IRQ_TIMER:
    if(cpu() == 0){
      acquire(&tickslock);
  1053f8:	c7 04 24 80 d7 10 00 	movl   $0x10d780,(%esp)
  1053ff:	e8 8c eb ff ff       	call   103f90 <acquire>
      ticks++;
  105404:	83 05 54 aa 10 00 01 	addl   $0x1,0x10aa54
      wakeup(&ticks);
  10540b:	c7 04 24 54 aa 10 00 	movl   $0x10aa54,(%esp)
  105412:	e8 e9 de ff ff       	call   103300 <wakeup>
      release(&tickslock);
  105417:	c7 04 24 80 d7 10 00 	movl   $0x10d780,(%esp)
  10541e:	e8 2d eb ff ff       	call   103f50 <release>
  105423:	e9 45 ff ff ff       	jmp    10536d <trap+0x16d>
    break;
    
  default:
    if(cp == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x\n",
  105428:	8b 73 30             	mov    0x30(%ebx),%esi
  10542b:	e8 a0 d4 ff ff       	call   1028d0 <cpu>
  105430:	89 74 24 0c          	mov    %esi,0xc(%esp)
  105434:	89 44 24 08          	mov    %eax,0x8(%esp)
  105438:	8b 43 28             	mov    0x28(%ebx),%eax
  10543b:	c7 04 24 60 66 10 00 	movl   $0x106660,(%esp)
  105442:	89 44 24 04          	mov    %eax,0x4(%esp)
  105446:	e8 35 b3 ff ff       	call   100780 <cprintf>
              tf->trapno, cpu(), tf->eip);
      panic("trap");
  10544b:	c7 04 24 c4 66 10 00 	movl   $0x1066c4,(%esp)
  105452:	e8 c9 b4 ff ff       	call   100920 <panic>
  105457:	90                   	nop

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(cp && cp->killed && (tf->cs&3) == DPL_USER)
    exit();
  105458:	e8 23 e0 ff ff       	call   103480 <exit>
  10545d:	e9 c3 fe ff ff       	jmp    105325 <trap+0x125>
  105462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  105468:	90                   	nop
  105469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(cp->killed)
      exit();
  105470:	e8 0b e0 ff ff       	call   103480 <exit>
  105475:	8d 76 00             	lea    0x0(%esi),%esi
  105478:	e9 43 ff ff ff       	jmp    1053c0 <trap+0x1c0>
  10547d:	8d 76 00             	lea    0x0(%esi),%esi

00105480 <tvinit>:
struct spinlock tickslock;
int ticks;

void
tvinit(void)
{
  105480:	55                   	push   %ebp
  105481:	31 c0                	xor    %eax,%eax
  105483:	89 e5                	mov    %esp,%ebp
  105485:	ba c0 d7 10 00       	mov    $0x10d7c0,%edx
  10548a:	83 ec 18             	sub    $0x18,%esp
  10548d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  105490:	8b 0c 85 08 73 10 00 	mov    0x107308(,%eax,4),%ecx
  105497:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10549e:	66 89 0c c5 c0 d7 10 	mov    %cx,0x10d7c0(,%eax,8)
  1054a5:	00 
  1054a6:	c1 e9 10             	shr    $0x10,%ecx
  1054a9:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1054ae:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1054b3:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
  1054b8:	83 c0 01             	add    $0x1,%eax
  1054bb:	3d 00 01 00 00       	cmp    $0x100,%eax
  1054c0:	75 ce                	jne    105490 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  1054c2:	a1 c8 73 10 00       	mov    0x1073c8,%eax
  
  initlock(&tickslock, "time");
  1054c7:	c7 44 24 04 c9 66 10 	movl   $0x1066c9,0x4(%esp)
  1054ce:	00 
  1054cf:	c7 04 24 80 d7 10 00 	movl   $0x10d780,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
  1054d6:	66 c7 05 42 d9 10 00 	movw   $0x8,0x10d942
  1054dd:	08 00 
  1054df:	66 a3 40 d9 10 00    	mov    %ax,0x10d940
  1054e5:	c1 e8 10             	shr    $0x10,%eax
  1054e8:	c6 05 44 d9 10 00 00 	movb   $0x0,0x10d944
  1054ef:	c6 05 45 d9 10 00 ef 	movb   $0xef,0x10d945
  1054f6:	66 a3 46 d9 10 00    	mov    %ax,0x10d946
  
  initlock(&tickslock, "time");
  1054fc:	e8 cf e8 ff ff       	call   103dd0 <initlock>
}
  105501:	c9                   	leave  
  105502:	c3                   	ret    
  105503:	90                   	nop

00105504 <vector0>:
  105504:	6a 00                	push   $0x0
  105506:	6a 00                	push   $0x0
  105508:	e9 93 fc ff ff       	jmp    1051a0 <alltraps>

0010550d <vector1>:
  10550d:	6a 00                	push   $0x0
  10550f:	6a 01                	push   $0x1
  105511:	e9 8a fc ff ff       	jmp    1051a0 <alltraps>

00105516 <vector2>:
  105516:	6a 00                	push   $0x0
  105518:	6a 02                	push   $0x2
  10551a:	e9 81 fc ff ff       	jmp    1051a0 <alltraps>

0010551f <vector3>:
  10551f:	6a 00                	push   $0x0
  105521:	6a 03                	push   $0x3
  105523:	e9 78 fc ff ff       	jmp    1051a0 <alltraps>

00105528 <vector4>:
  105528:	6a 00                	push   $0x0
  10552a:	6a 04                	push   $0x4
  10552c:	e9 6f fc ff ff       	jmp    1051a0 <alltraps>

00105531 <vector5>:
  105531:	6a 00                	push   $0x0
  105533:	6a 05                	push   $0x5
  105535:	e9 66 fc ff ff       	jmp    1051a0 <alltraps>

0010553a <vector6>:
  10553a:	6a 00                	push   $0x0
  10553c:	6a 06                	push   $0x6
  10553e:	e9 5d fc ff ff       	jmp    1051a0 <alltraps>

00105543 <vector7>:
  105543:	6a 00                	push   $0x0
  105545:	6a 07                	push   $0x7
  105547:	e9 54 fc ff ff       	jmp    1051a0 <alltraps>

0010554c <vector8>:
  10554c:	6a 08                	push   $0x8
  10554e:	e9 4d fc ff ff       	jmp    1051a0 <alltraps>

00105553 <vector9>:
  105553:	6a 09                	push   $0x9
  105555:	e9 46 fc ff ff       	jmp    1051a0 <alltraps>

0010555a <vector10>:
  10555a:	6a 0a                	push   $0xa
  10555c:	e9 3f fc ff ff       	jmp    1051a0 <alltraps>

00105561 <vector11>:
  105561:	6a 0b                	push   $0xb
  105563:	e9 38 fc ff ff       	jmp    1051a0 <alltraps>

00105568 <vector12>:
  105568:	6a 0c                	push   $0xc
  10556a:	e9 31 fc ff ff       	jmp    1051a0 <alltraps>

0010556f <vector13>:
  10556f:	6a 0d                	push   $0xd
  105571:	e9 2a fc ff ff       	jmp    1051a0 <alltraps>

00105576 <vector14>:
  105576:	6a 0e                	push   $0xe
  105578:	e9 23 fc ff ff       	jmp    1051a0 <alltraps>

0010557d <vector15>:
  10557d:	6a 00                	push   $0x0
  10557f:	6a 0f                	push   $0xf
  105581:	e9 1a fc ff ff       	jmp    1051a0 <alltraps>

00105586 <vector16>:
  105586:	6a 00                	push   $0x0
  105588:	6a 10                	push   $0x10
  10558a:	e9 11 fc ff ff       	jmp    1051a0 <alltraps>

0010558f <vector17>:
  10558f:	6a 11                	push   $0x11
  105591:	e9 0a fc ff ff       	jmp    1051a0 <alltraps>

00105596 <vector18>:
  105596:	6a 00                	push   $0x0
  105598:	6a 12                	push   $0x12
  10559a:	e9 01 fc ff ff       	jmp    1051a0 <alltraps>

0010559f <vector19>:
  10559f:	6a 00                	push   $0x0
  1055a1:	6a 13                	push   $0x13
  1055a3:	e9 f8 fb ff ff       	jmp    1051a0 <alltraps>

001055a8 <vector20>:
  1055a8:	6a 00                	push   $0x0
  1055aa:	6a 14                	push   $0x14
  1055ac:	e9 ef fb ff ff       	jmp    1051a0 <alltraps>

001055b1 <vector21>:
  1055b1:	6a 00                	push   $0x0
  1055b3:	6a 15                	push   $0x15
  1055b5:	e9 e6 fb ff ff       	jmp    1051a0 <alltraps>

001055ba <vector22>:
  1055ba:	6a 00                	push   $0x0
  1055bc:	6a 16                	push   $0x16
  1055be:	e9 dd fb ff ff       	jmp    1051a0 <alltraps>

001055c3 <vector23>:
  1055c3:	6a 00                	push   $0x0
  1055c5:	6a 17                	push   $0x17
  1055c7:	e9 d4 fb ff ff       	jmp    1051a0 <alltraps>

001055cc <vector24>:
  1055cc:	6a 00                	push   $0x0
  1055ce:	6a 18                	push   $0x18
  1055d0:	e9 cb fb ff ff       	jmp    1051a0 <alltraps>

001055d5 <vector25>:
  1055d5:	6a 00                	push   $0x0
  1055d7:	6a 19                	push   $0x19
  1055d9:	e9 c2 fb ff ff       	jmp    1051a0 <alltraps>

001055de <vector26>:
  1055de:	6a 00                	push   $0x0
  1055e0:	6a 1a                	push   $0x1a
  1055e2:	e9 b9 fb ff ff       	jmp    1051a0 <alltraps>

001055e7 <vector27>:
  1055e7:	6a 00                	push   $0x0
  1055e9:	6a 1b                	push   $0x1b
  1055eb:	e9 b0 fb ff ff       	jmp    1051a0 <alltraps>

001055f0 <vector28>:
  1055f0:	6a 00                	push   $0x0
  1055f2:	6a 1c                	push   $0x1c
  1055f4:	e9 a7 fb ff ff       	jmp    1051a0 <alltraps>

001055f9 <vector29>:
  1055f9:	6a 00                	push   $0x0
  1055fb:	6a 1d                	push   $0x1d
  1055fd:	e9 9e fb ff ff       	jmp    1051a0 <alltraps>

00105602 <vector30>:
  105602:	6a 00                	push   $0x0
  105604:	6a 1e                	push   $0x1e
  105606:	e9 95 fb ff ff       	jmp    1051a0 <alltraps>

0010560b <vector31>:
  10560b:	6a 00                	push   $0x0
  10560d:	6a 1f                	push   $0x1f
  10560f:	e9 8c fb ff ff       	jmp    1051a0 <alltraps>

00105614 <vector32>:
  105614:	6a 00                	push   $0x0
  105616:	6a 20                	push   $0x20
  105618:	e9 83 fb ff ff       	jmp    1051a0 <alltraps>

0010561d <vector33>:
  10561d:	6a 00                	push   $0x0
  10561f:	6a 21                	push   $0x21
  105621:	e9 7a fb ff ff       	jmp    1051a0 <alltraps>

00105626 <vector34>:
  105626:	6a 00                	push   $0x0
  105628:	6a 22                	push   $0x22
  10562a:	e9 71 fb ff ff       	jmp    1051a0 <alltraps>

0010562f <vector35>:
  10562f:	6a 00                	push   $0x0
  105631:	6a 23                	push   $0x23
  105633:	e9 68 fb ff ff       	jmp    1051a0 <alltraps>

00105638 <vector36>:
  105638:	6a 00                	push   $0x0
  10563a:	6a 24                	push   $0x24
  10563c:	e9 5f fb ff ff       	jmp    1051a0 <alltraps>

00105641 <vector37>:
  105641:	6a 00                	push   $0x0
  105643:	6a 25                	push   $0x25
  105645:	e9 56 fb ff ff       	jmp    1051a0 <alltraps>

0010564a <vector38>:
  10564a:	6a 00                	push   $0x0
  10564c:	6a 26                	push   $0x26
  10564e:	e9 4d fb ff ff       	jmp    1051a0 <alltraps>

00105653 <vector39>:
  105653:	6a 00                	push   $0x0
  105655:	6a 27                	push   $0x27
  105657:	e9 44 fb ff ff       	jmp    1051a0 <alltraps>

0010565c <vector40>:
  10565c:	6a 00                	push   $0x0
  10565e:	6a 28                	push   $0x28
  105660:	e9 3b fb ff ff       	jmp    1051a0 <alltraps>

00105665 <vector41>:
  105665:	6a 00                	push   $0x0
  105667:	6a 29                	push   $0x29
  105669:	e9 32 fb ff ff       	jmp    1051a0 <alltraps>

0010566e <vector42>:
  10566e:	6a 00                	push   $0x0
  105670:	6a 2a                	push   $0x2a
  105672:	e9 29 fb ff ff       	jmp    1051a0 <alltraps>

00105677 <vector43>:
  105677:	6a 00                	push   $0x0
  105679:	6a 2b                	push   $0x2b
  10567b:	e9 20 fb ff ff       	jmp    1051a0 <alltraps>

00105680 <vector44>:
  105680:	6a 00                	push   $0x0
  105682:	6a 2c                	push   $0x2c
  105684:	e9 17 fb ff ff       	jmp    1051a0 <alltraps>

00105689 <vector45>:
  105689:	6a 00                	push   $0x0
  10568b:	6a 2d                	push   $0x2d
  10568d:	e9 0e fb ff ff       	jmp    1051a0 <alltraps>

00105692 <vector46>:
  105692:	6a 00                	push   $0x0
  105694:	6a 2e                	push   $0x2e
  105696:	e9 05 fb ff ff       	jmp    1051a0 <alltraps>

0010569b <vector47>:
  10569b:	6a 00                	push   $0x0
  10569d:	6a 2f                	push   $0x2f
  10569f:	e9 fc fa ff ff       	jmp    1051a0 <alltraps>

001056a4 <vector48>:
  1056a4:	6a 00                	push   $0x0
  1056a6:	6a 30                	push   $0x30
  1056a8:	e9 f3 fa ff ff       	jmp    1051a0 <alltraps>

001056ad <vector49>:
  1056ad:	6a 00                	push   $0x0
  1056af:	6a 31                	push   $0x31
  1056b1:	e9 ea fa ff ff       	jmp    1051a0 <alltraps>

001056b6 <vector50>:
  1056b6:	6a 00                	push   $0x0
  1056b8:	6a 32                	push   $0x32
  1056ba:	e9 e1 fa ff ff       	jmp    1051a0 <alltraps>

001056bf <vector51>:
  1056bf:	6a 00                	push   $0x0
  1056c1:	6a 33                	push   $0x33
  1056c3:	e9 d8 fa ff ff       	jmp    1051a0 <alltraps>

001056c8 <vector52>:
  1056c8:	6a 00                	push   $0x0
  1056ca:	6a 34                	push   $0x34
  1056cc:	e9 cf fa ff ff       	jmp    1051a0 <alltraps>

001056d1 <vector53>:
  1056d1:	6a 00                	push   $0x0
  1056d3:	6a 35                	push   $0x35
  1056d5:	e9 c6 fa ff ff       	jmp    1051a0 <alltraps>

001056da <vector54>:
  1056da:	6a 00                	push   $0x0
  1056dc:	6a 36                	push   $0x36
  1056de:	e9 bd fa ff ff       	jmp    1051a0 <alltraps>

001056e3 <vector55>:
  1056e3:	6a 00                	push   $0x0
  1056e5:	6a 37                	push   $0x37
  1056e7:	e9 b4 fa ff ff       	jmp    1051a0 <alltraps>

001056ec <vector56>:
  1056ec:	6a 00                	push   $0x0
  1056ee:	6a 38                	push   $0x38
  1056f0:	e9 ab fa ff ff       	jmp    1051a0 <alltraps>

001056f5 <vector57>:
  1056f5:	6a 00                	push   $0x0
  1056f7:	6a 39                	push   $0x39
  1056f9:	e9 a2 fa ff ff       	jmp    1051a0 <alltraps>

001056fe <vector58>:
  1056fe:	6a 00                	push   $0x0
  105700:	6a 3a                	push   $0x3a
  105702:	e9 99 fa ff ff       	jmp    1051a0 <alltraps>

00105707 <vector59>:
  105707:	6a 00                	push   $0x0
  105709:	6a 3b                	push   $0x3b
  10570b:	e9 90 fa ff ff       	jmp    1051a0 <alltraps>

00105710 <vector60>:
  105710:	6a 00                	push   $0x0
  105712:	6a 3c                	push   $0x3c
  105714:	e9 87 fa ff ff       	jmp    1051a0 <alltraps>

00105719 <vector61>:
  105719:	6a 00                	push   $0x0
  10571b:	6a 3d                	push   $0x3d
  10571d:	e9 7e fa ff ff       	jmp    1051a0 <alltraps>

00105722 <vector62>:
  105722:	6a 00                	push   $0x0
  105724:	6a 3e                	push   $0x3e
  105726:	e9 75 fa ff ff       	jmp    1051a0 <alltraps>

0010572b <vector63>:
  10572b:	6a 00                	push   $0x0
  10572d:	6a 3f                	push   $0x3f
  10572f:	e9 6c fa ff ff       	jmp    1051a0 <alltraps>

00105734 <vector64>:
  105734:	6a 00                	push   $0x0
  105736:	6a 40                	push   $0x40
  105738:	e9 63 fa ff ff       	jmp    1051a0 <alltraps>

0010573d <vector65>:
  10573d:	6a 00                	push   $0x0
  10573f:	6a 41                	push   $0x41
  105741:	e9 5a fa ff ff       	jmp    1051a0 <alltraps>

00105746 <vector66>:
  105746:	6a 00                	push   $0x0
  105748:	6a 42                	push   $0x42
  10574a:	e9 51 fa ff ff       	jmp    1051a0 <alltraps>

0010574f <vector67>:
  10574f:	6a 00                	push   $0x0
  105751:	6a 43                	push   $0x43
  105753:	e9 48 fa ff ff       	jmp    1051a0 <alltraps>

00105758 <vector68>:
  105758:	6a 00                	push   $0x0
  10575a:	6a 44                	push   $0x44
  10575c:	e9 3f fa ff ff       	jmp    1051a0 <alltraps>

00105761 <vector69>:
  105761:	6a 00                	push   $0x0
  105763:	6a 45                	push   $0x45
  105765:	e9 36 fa ff ff       	jmp    1051a0 <alltraps>

0010576a <vector70>:
  10576a:	6a 00                	push   $0x0
  10576c:	6a 46                	push   $0x46
  10576e:	e9 2d fa ff ff       	jmp    1051a0 <alltraps>

00105773 <vector71>:
  105773:	6a 00                	push   $0x0
  105775:	6a 47                	push   $0x47
  105777:	e9 24 fa ff ff       	jmp    1051a0 <alltraps>

0010577c <vector72>:
  10577c:	6a 00                	push   $0x0
  10577e:	6a 48                	push   $0x48
  105780:	e9 1b fa ff ff       	jmp    1051a0 <alltraps>

00105785 <vector73>:
  105785:	6a 00                	push   $0x0
  105787:	6a 49                	push   $0x49
  105789:	e9 12 fa ff ff       	jmp    1051a0 <alltraps>

0010578e <vector74>:
  10578e:	6a 00                	push   $0x0
  105790:	6a 4a                	push   $0x4a
  105792:	e9 09 fa ff ff       	jmp    1051a0 <alltraps>

00105797 <vector75>:
  105797:	6a 00                	push   $0x0
  105799:	6a 4b                	push   $0x4b
  10579b:	e9 00 fa ff ff       	jmp    1051a0 <alltraps>

001057a0 <vector76>:
  1057a0:	6a 00                	push   $0x0
  1057a2:	6a 4c                	push   $0x4c
  1057a4:	e9 f7 f9 ff ff       	jmp    1051a0 <alltraps>

001057a9 <vector77>:
  1057a9:	6a 00                	push   $0x0
  1057ab:	6a 4d                	push   $0x4d
  1057ad:	e9 ee f9 ff ff       	jmp    1051a0 <alltraps>

001057b2 <vector78>:
  1057b2:	6a 00                	push   $0x0
  1057b4:	6a 4e                	push   $0x4e
  1057b6:	e9 e5 f9 ff ff       	jmp    1051a0 <alltraps>

001057bb <vector79>:
  1057bb:	6a 00                	push   $0x0
  1057bd:	6a 4f                	push   $0x4f
  1057bf:	e9 dc f9 ff ff       	jmp    1051a0 <alltraps>

001057c4 <vector80>:
  1057c4:	6a 00                	push   $0x0
  1057c6:	6a 50                	push   $0x50
  1057c8:	e9 d3 f9 ff ff       	jmp    1051a0 <alltraps>

001057cd <vector81>:
  1057cd:	6a 00                	push   $0x0
  1057cf:	6a 51                	push   $0x51
  1057d1:	e9 ca f9 ff ff       	jmp    1051a0 <alltraps>

001057d6 <vector82>:
  1057d6:	6a 00                	push   $0x0
  1057d8:	6a 52                	push   $0x52
  1057da:	e9 c1 f9 ff ff       	jmp    1051a0 <alltraps>

001057df <vector83>:
  1057df:	6a 00                	push   $0x0
  1057e1:	6a 53                	push   $0x53
  1057e3:	e9 b8 f9 ff ff       	jmp    1051a0 <alltraps>

001057e8 <vector84>:
  1057e8:	6a 00                	push   $0x0
  1057ea:	6a 54                	push   $0x54
  1057ec:	e9 af f9 ff ff       	jmp    1051a0 <alltraps>

001057f1 <vector85>:
  1057f1:	6a 00                	push   $0x0
  1057f3:	6a 55                	push   $0x55
  1057f5:	e9 a6 f9 ff ff       	jmp    1051a0 <alltraps>

001057fa <vector86>:
  1057fa:	6a 00                	push   $0x0
  1057fc:	6a 56                	push   $0x56
  1057fe:	e9 9d f9 ff ff       	jmp    1051a0 <alltraps>

00105803 <vector87>:
  105803:	6a 00                	push   $0x0
  105805:	6a 57                	push   $0x57
  105807:	e9 94 f9 ff ff       	jmp    1051a0 <alltraps>

0010580c <vector88>:
  10580c:	6a 00                	push   $0x0
  10580e:	6a 58                	push   $0x58
  105810:	e9 8b f9 ff ff       	jmp    1051a0 <alltraps>

00105815 <vector89>:
  105815:	6a 00                	push   $0x0
  105817:	6a 59                	push   $0x59
  105819:	e9 82 f9 ff ff       	jmp    1051a0 <alltraps>

0010581e <vector90>:
  10581e:	6a 00                	push   $0x0
  105820:	6a 5a                	push   $0x5a
  105822:	e9 79 f9 ff ff       	jmp    1051a0 <alltraps>

00105827 <vector91>:
  105827:	6a 00                	push   $0x0
  105829:	6a 5b                	push   $0x5b
  10582b:	e9 70 f9 ff ff       	jmp    1051a0 <alltraps>

00105830 <vector92>:
  105830:	6a 00                	push   $0x0
  105832:	6a 5c                	push   $0x5c
  105834:	e9 67 f9 ff ff       	jmp    1051a0 <alltraps>

00105839 <vector93>:
  105839:	6a 00                	push   $0x0
  10583b:	6a 5d                	push   $0x5d
  10583d:	e9 5e f9 ff ff       	jmp    1051a0 <alltraps>

00105842 <vector94>:
  105842:	6a 00                	push   $0x0
  105844:	6a 5e                	push   $0x5e
  105846:	e9 55 f9 ff ff       	jmp    1051a0 <alltraps>

0010584b <vector95>:
  10584b:	6a 00                	push   $0x0
  10584d:	6a 5f                	push   $0x5f
  10584f:	e9 4c f9 ff ff       	jmp    1051a0 <alltraps>

00105854 <vector96>:
  105854:	6a 00                	push   $0x0
  105856:	6a 60                	push   $0x60
  105858:	e9 43 f9 ff ff       	jmp    1051a0 <alltraps>

0010585d <vector97>:
  10585d:	6a 00                	push   $0x0
  10585f:	6a 61                	push   $0x61
  105861:	e9 3a f9 ff ff       	jmp    1051a0 <alltraps>

00105866 <vector98>:
  105866:	6a 00                	push   $0x0
  105868:	6a 62                	push   $0x62
  10586a:	e9 31 f9 ff ff       	jmp    1051a0 <alltraps>

0010586f <vector99>:
  10586f:	6a 00                	push   $0x0
  105871:	6a 63                	push   $0x63
  105873:	e9 28 f9 ff ff       	jmp    1051a0 <alltraps>

00105878 <vector100>:
  105878:	6a 00                	push   $0x0
  10587a:	6a 64                	push   $0x64
  10587c:	e9 1f f9 ff ff       	jmp    1051a0 <alltraps>

00105881 <vector101>:
  105881:	6a 00                	push   $0x0
  105883:	6a 65                	push   $0x65
  105885:	e9 16 f9 ff ff       	jmp    1051a0 <alltraps>

0010588a <vector102>:
  10588a:	6a 00                	push   $0x0
  10588c:	6a 66                	push   $0x66
  10588e:	e9 0d f9 ff ff       	jmp    1051a0 <alltraps>

00105893 <vector103>:
  105893:	6a 00                	push   $0x0
  105895:	6a 67                	push   $0x67
  105897:	e9 04 f9 ff ff       	jmp    1051a0 <alltraps>

0010589c <vector104>:
  10589c:	6a 00                	push   $0x0
  10589e:	6a 68                	push   $0x68
  1058a0:	e9 fb f8 ff ff       	jmp    1051a0 <alltraps>

001058a5 <vector105>:
  1058a5:	6a 00                	push   $0x0
  1058a7:	6a 69                	push   $0x69
  1058a9:	e9 f2 f8 ff ff       	jmp    1051a0 <alltraps>

001058ae <vector106>:
  1058ae:	6a 00                	push   $0x0
  1058b0:	6a 6a                	push   $0x6a
  1058b2:	e9 e9 f8 ff ff       	jmp    1051a0 <alltraps>

001058b7 <vector107>:
  1058b7:	6a 00                	push   $0x0
  1058b9:	6a 6b                	push   $0x6b
  1058bb:	e9 e0 f8 ff ff       	jmp    1051a0 <alltraps>

001058c0 <vector108>:
  1058c0:	6a 00                	push   $0x0
  1058c2:	6a 6c                	push   $0x6c
  1058c4:	e9 d7 f8 ff ff       	jmp    1051a0 <alltraps>

001058c9 <vector109>:
  1058c9:	6a 00                	push   $0x0
  1058cb:	6a 6d                	push   $0x6d
  1058cd:	e9 ce f8 ff ff       	jmp    1051a0 <alltraps>

001058d2 <vector110>:
  1058d2:	6a 00                	push   $0x0
  1058d4:	6a 6e                	push   $0x6e
  1058d6:	e9 c5 f8 ff ff       	jmp    1051a0 <alltraps>

001058db <vector111>:
  1058db:	6a 00                	push   $0x0
  1058dd:	6a 6f                	push   $0x6f
  1058df:	e9 bc f8 ff ff       	jmp    1051a0 <alltraps>

001058e4 <vector112>:
  1058e4:	6a 00                	push   $0x0
  1058e6:	6a 70                	push   $0x70
  1058e8:	e9 b3 f8 ff ff       	jmp    1051a0 <alltraps>

001058ed <vector113>:
  1058ed:	6a 00                	push   $0x0
  1058ef:	6a 71                	push   $0x71
  1058f1:	e9 aa f8 ff ff       	jmp    1051a0 <alltraps>

001058f6 <vector114>:
  1058f6:	6a 00                	push   $0x0
  1058f8:	6a 72                	push   $0x72
  1058fa:	e9 a1 f8 ff ff       	jmp    1051a0 <alltraps>

001058ff <vector115>:
  1058ff:	6a 00                	push   $0x0
  105901:	6a 73                	push   $0x73
  105903:	e9 98 f8 ff ff       	jmp    1051a0 <alltraps>

00105908 <vector116>:
  105908:	6a 00                	push   $0x0
  10590a:	6a 74                	push   $0x74
  10590c:	e9 8f f8 ff ff       	jmp    1051a0 <alltraps>

00105911 <vector117>:
  105911:	6a 00                	push   $0x0
  105913:	6a 75                	push   $0x75
  105915:	e9 86 f8 ff ff       	jmp    1051a0 <alltraps>

0010591a <vector118>:
  10591a:	6a 00                	push   $0x0
  10591c:	6a 76                	push   $0x76
  10591e:	e9 7d f8 ff ff       	jmp    1051a0 <alltraps>

00105923 <vector119>:
  105923:	6a 00                	push   $0x0
  105925:	6a 77                	push   $0x77
  105927:	e9 74 f8 ff ff       	jmp    1051a0 <alltraps>

0010592c <vector120>:
  10592c:	6a 00                	push   $0x0
  10592e:	6a 78                	push   $0x78
  105930:	e9 6b f8 ff ff       	jmp    1051a0 <alltraps>

00105935 <vector121>:
  105935:	6a 00                	push   $0x0
  105937:	6a 79                	push   $0x79
  105939:	e9 62 f8 ff ff       	jmp    1051a0 <alltraps>

0010593e <vector122>:
  10593e:	6a 00                	push   $0x0
  105940:	6a 7a                	push   $0x7a
  105942:	e9 59 f8 ff ff       	jmp    1051a0 <alltraps>

00105947 <vector123>:
  105947:	6a 00                	push   $0x0
  105949:	6a 7b                	push   $0x7b
  10594b:	e9 50 f8 ff ff       	jmp    1051a0 <alltraps>

00105950 <vector124>:
  105950:	6a 00                	push   $0x0
  105952:	6a 7c                	push   $0x7c
  105954:	e9 47 f8 ff ff       	jmp    1051a0 <alltraps>

00105959 <vector125>:
  105959:	6a 00                	push   $0x0
  10595b:	6a 7d                	push   $0x7d
  10595d:	e9 3e f8 ff ff       	jmp    1051a0 <alltraps>

00105962 <vector126>:
  105962:	6a 00                	push   $0x0
  105964:	6a 7e                	push   $0x7e
  105966:	e9 35 f8 ff ff       	jmp    1051a0 <alltraps>

0010596b <vector127>:
  10596b:	6a 00                	push   $0x0
  10596d:	6a 7f                	push   $0x7f
  10596f:	e9 2c f8 ff ff       	jmp    1051a0 <alltraps>

00105974 <vector128>:
  105974:	6a 00                	push   $0x0
  105976:	68 80 00 00 00       	push   $0x80
  10597b:	e9 20 f8 ff ff       	jmp    1051a0 <alltraps>

00105980 <vector129>:
  105980:	6a 00                	push   $0x0
  105982:	68 81 00 00 00       	push   $0x81
  105987:	e9 14 f8 ff ff       	jmp    1051a0 <alltraps>

0010598c <vector130>:
  10598c:	6a 00                	push   $0x0
  10598e:	68 82 00 00 00       	push   $0x82
  105993:	e9 08 f8 ff ff       	jmp    1051a0 <alltraps>

00105998 <vector131>:
  105998:	6a 00                	push   $0x0
  10599a:	68 83 00 00 00       	push   $0x83
  10599f:	e9 fc f7 ff ff       	jmp    1051a0 <alltraps>

001059a4 <vector132>:
  1059a4:	6a 00                	push   $0x0
  1059a6:	68 84 00 00 00       	push   $0x84
  1059ab:	e9 f0 f7 ff ff       	jmp    1051a0 <alltraps>

001059b0 <vector133>:
  1059b0:	6a 00                	push   $0x0
  1059b2:	68 85 00 00 00       	push   $0x85
  1059b7:	e9 e4 f7 ff ff       	jmp    1051a0 <alltraps>

001059bc <vector134>:
  1059bc:	6a 00                	push   $0x0
  1059be:	68 86 00 00 00       	push   $0x86
  1059c3:	e9 d8 f7 ff ff       	jmp    1051a0 <alltraps>

001059c8 <vector135>:
  1059c8:	6a 00                	push   $0x0
  1059ca:	68 87 00 00 00       	push   $0x87
  1059cf:	e9 cc f7 ff ff       	jmp    1051a0 <alltraps>

001059d4 <vector136>:
  1059d4:	6a 00                	push   $0x0
  1059d6:	68 88 00 00 00       	push   $0x88
  1059db:	e9 c0 f7 ff ff       	jmp    1051a0 <alltraps>

001059e0 <vector137>:
  1059e0:	6a 00                	push   $0x0
  1059e2:	68 89 00 00 00       	push   $0x89
  1059e7:	e9 b4 f7 ff ff       	jmp    1051a0 <alltraps>

001059ec <vector138>:
  1059ec:	6a 00                	push   $0x0
  1059ee:	68 8a 00 00 00       	push   $0x8a
  1059f3:	e9 a8 f7 ff ff       	jmp    1051a0 <alltraps>

001059f8 <vector139>:
  1059f8:	6a 00                	push   $0x0
  1059fa:	68 8b 00 00 00       	push   $0x8b
  1059ff:	e9 9c f7 ff ff       	jmp    1051a0 <alltraps>

00105a04 <vector140>:
  105a04:	6a 00                	push   $0x0
  105a06:	68 8c 00 00 00       	push   $0x8c
  105a0b:	e9 90 f7 ff ff       	jmp    1051a0 <alltraps>

00105a10 <vector141>:
  105a10:	6a 00                	push   $0x0
  105a12:	68 8d 00 00 00       	push   $0x8d
  105a17:	e9 84 f7 ff ff       	jmp    1051a0 <alltraps>

00105a1c <vector142>:
  105a1c:	6a 00                	push   $0x0
  105a1e:	68 8e 00 00 00       	push   $0x8e
  105a23:	e9 78 f7 ff ff       	jmp    1051a0 <alltraps>

00105a28 <vector143>:
  105a28:	6a 00                	push   $0x0
  105a2a:	68 8f 00 00 00       	push   $0x8f
  105a2f:	e9 6c f7 ff ff       	jmp    1051a0 <alltraps>

00105a34 <vector144>:
  105a34:	6a 00                	push   $0x0
  105a36:	68 90 00 00 00       	push   $0x90
  105a3b:	e9 60 f7 ff ff       	jmp    1051a0 <alltraps>

00105a40 <vector145>:
  105a40:	6a 00                	push   $0x0
  105a42:	68 91 00 00 00       	push   $0x91
  105a47:	e9 54 f7 ff ff       	jmp    1051a0 <alltraps>

00105a4c <vector146>:
  105a4c:	6a 00                	push   $0x0
  105a4e:	68 92 00 00 00       	push   $0x92
  105a53:	e9 48 f7 ff ff       	jmp    1051a0 <alltraps>

00105a58 <vector147>:
  105a58:	6a 00                	push   $0x0
  105a5a:	68 93 00 00 00       	push   $0x93
  105a5f:	e9 3c f7 ff ff       	jmp    1051a0 <alltraps>

00105a64 <vector148>:
  105a64:	6a 00                	push   $0x0
  105a66:	68 94 00 00 00       	push   $0x94
  105a6b:	e9 30 f7 ff ff       	jmp    1051a0 <alltraps>

00105a70 <vector149>:
  105a70:	6a 00                	push   $0x0
  105a72:	68 95 00 00 00       	push   $0x95
  105a77:	e9 24 f7 ff ff       	jmp    1051a0 <alltraps>

00105a7c <vector150>:
  105a7c:	6a 00                	push   $0x0
  105a7e:	68 96 00 00 00       	push   $0x96
  105a83:	e9 18 f7 ff ff       	jmp    1051a0 <alltraps>

00105a88 <vector151>:
  105a88:	6a 00                	push   $0x0
  105a8a:	68 97 00 00 00       	push   $0x97
  105a8f:	e9 0c f7 ff ff       	jmp    1051a0 <alltraps>

00105a94 <vector152>:
  105a94:	6a 00                	push   $0x0
  105a96:	68 98 00 00 00       	push   $0x98
  105a9b:	e9 00 f7 ff ff       	jmp    1051a0 <alltraps>

00105aa0 <vector153>:
  105aa0:	6a 00                	push   $0x0
  105aa2:	68 99 00 00 00       	push   $0x99
  105aa7:	e9 f4 f6 ff ff       	jmp    1051a0 <alltraps>

00105aac <vector154>:
  105aac:	6a 00                	push   $0x0
  105aae:	68 9a 00 00 00       	push   $0x9a
  105ab3:	e9 e8 f6 ff ff       	jmp    1051a0 <alltraps>

00105ab8 <vector155>:
  105ab8:	6a 00                	push   $0x0
  105aba:	68 9b 00 00 00       	push   $0x9b
  105abf:	e9 dc f6 ff ff       	jmp    1051a0 <alltraps>

00105ac4 <vector156>:
  105ac4:	6a 00                	push   $0x0
  105ac6:	68 9c 00 00 00       	push   $0x9c
  105acb:	e9 d0 f6 ff ff       	jmp    1051a0 <alltraps>

00105ad0 <vector157>:
  105ad0:	6a 00                	push   $0x0
  105ad2:	68 9d 00 00 00       	push   $0x9d
  105ad7:	e9 c4 f6 ff ff       	jmp    1051a0 <alltraps>

00105adc <vector158>:
  105adc:	6a 00                	push   $0x0
  105ade:	68 9e 00 00 00       	push   $0x9e
  105ae3:	e9 b8 f6 ff ff       	jmp    1051a0 <alltraps>

00105ae8 <vector159>:
  105ae8:	6a 00                	push   $0x0
  105aea:	68 9f 00 00 00       	push   $0x9f
  105aef:	e9 ac f6 ff ff       	jmp    1051a0 <alltraps>

00105af4 <vector160>:
  105af4:	6a 00                	push   $0x0
  105af6:	68 a0 00 00 00       	push   $0xa0
  105afb:	e9 a0 f6 ff ff       	jmp    1051a0 <alltraps>

00105b00 <vector161>:
  105b00:	6a 00                	push   $0x0
  105b02:	68 a1 00 00 00       	push   $0xa1
  105b07:	e9 94 f6 ff ff       	jmp    1051a0 <alltraps>

00105b0c <vector162>:
  105b0c:	6a 00                	push   $0x0
  105b0e:	68 a2 00 00 00       	push   $0xa2
  105b13:	e9 88 f6 ff ff       	jmp    1051a0 <alltraps>

00105b18 <vector163>:
  105b18:	6a 00                	push   $0x0
  105b1a:	68 a3 00 00 00       	push   $0xa3
  105b1f:	e9 7c f6 ff ff       	jmp    1051a0 <alltraps>

00105b24 <vector164>:
  105b24:	6a 00                	push   $0x0
  105b26:	68 a4 00 00 00       	push   $0xa4
  105b2b:	e9 70 f6 ff ff       	jmp    1051a0 <alltraps>

00105b30 <vector165>:
  105b30:	6a 00                	push   $0x0
  105b32:	68 a5 00 00 00       	push   $0xa5
  105b37:	e9 64 f6 ff ff       	jmp    1051a0 <alltraps>

00105b3c <vector166>:
  105b3c:	6a 00                	push   $0x0
  105b3e:	68 a6 00 00 00       	push   $0xa6
  105b43:	e9 58 f6 ff ff       	jmp    1051a0 <alltraps>

00105b48 <vector167>:
  105b48:	6a 00                	push   $0x0
  105b4a:	68 a7 00 00 00       	push   $0xa7
  105b4f:	e9 4c f6 ff ff       	jmp    1051a0 <alltraps>

00105b54 <vector168>:
  105b54:	6a 00                	push   $0x0
  105b56:	68 a8 00 00 00       	push   $0xa8
  105b5b:	e9 40 f6 ff ff       	jmp    1051a0 <alltraps>

00105b60 <vector169>:
  105b60:	6a 00                	push   $0x0
  105b62:	68 a9 00 00 00       	push   $0xa9
  105b67:	e9 34 f6 ff ff       	jmp    1051a0 <alltraps>

00105b6c <vector170>:
  105b6c:	6a 00                	push   $0x0
  105b6e:	68 aa 00 00 00       	push   $0xaa
  105b73:	e9 28 f6 ff ff       	jmp    1051a0 <alltraps>

00105b78 <vector171>:
  105b78:	6a 00                	push   $0x0
  105b7a:	68 ab 00 00 00       	push   $0xab
  105b7f:	e9 1c f6 ff ff       	jmp    1051a0 <alltraps>

00105b84 <vector172>:
  105b84:	6a 00                	push   $0x0
  105b86:	68 ac 00 00 00       	push   $0xac
  105b8b:	e9 10 f6 ff ff       	jmp    1051a0 <alltraps>

00105b90 <vector173>:
  105b90:	6a 00                	push   $0x0
  105b92:	68 ad 00 00 00       	push   $0xad
  105b97:	e9 04 f6 ff ff       	jmp    1051a0 <alltraps>

00105b9c <vector174>:
  105b9c:	6a 00                	push   $0x0
  105b9e:	68 ae 00 00 00       	push   $0xae
  105ba3:	e9 f8 f5 ff ff       	jmp    1051a0 <alltraps>

00105ba8 <vector175>:
  105ba8:	6a 00                	push   $0x0
  105baa:	68 af 00 00 00       	push   $0xaf
  105baf:	e9 ec f5 ff ff       	jmp    1051a0 <alltraps>

00105bb4 <vector176>:
  105bb4:	6a 00                	push   $0x0
  105bb6:	68 b0 00 00 00       	push   $0xb0
  105bbb:	e9 e0 f5 ff ff       	jmp    1051a0 <alltraps>

00105bc0 <vector177>:
  105bc0:	6a 00                	push   $0x0
  105bc2:	68 b1 00 00 00       	push   $0xb1
  105bc7:	e9 d4 f5 ff ff       	jmp    1051a0 <alltraps>

00105bcc <vector178>:
  105bcc:	6a 00                	push   $0x0
  105bce:	68 b2 00 00 00       	push   $0xb2
  105bd3:	e9 c8 f5 ff ff       	jmp    1051a0 <alltraps>

00105bd8 <vector179>:
  105bd8:	6a 00                	push   $0x0
  105bda:	68 b3 00 00 00       	push   $0xb3
  105bdf:	e9 bc f5 ff ff       	jmp    1051a0 <alltraps>

00105be4 <vector180>:
  105be4:	6a 00                	push   $0x0
  105be6:	68 b4 00 00 00       	push   $0xb4
  105beb:	e9 b0 f5 ff ff       	jmp    1051a0 <alltraps>

00105bf0 <vector181>:
  105bf0:	6a 00                	push   $0x0
  105bf2:	68 b5 00 00 00       	push   $0xb5
  105bf7:	e9 a4 f5 ff ff       	jmp    1051a0 <alltraps>

00105bfc <vector182>:
  105bfc:	6a 00                	push   $0x0
  105bfe:	68 b6 00 00 00       	push   $0xb6
  105c03:	e9 98 f5 ff ff       	jmp    1051a0 <alltraps>

00105c08 <vector183>:
  105c08:	6a 00                	push   $0x0
  105c0a:	68 b7 00 00 00       	push   $0xb7
  105c0f:	e9 8c f5 ff ff       	jmp    1051a0 <alltraps>

00105c14 <vector184>:
  105c14:	6a 00                	push   $0x0
  105c16:	68 b8 00 00 00       	push   $0xb8
  105c1b:	e9 80 f5 ff ff       	jmp    1051a0 <alltraps>

00105c20 <vector185>:
  105c20:	6a 00                	push   $0x0
  105c22:	68 b9 00 00 00       	push   $0xb9
  105c27:	e9 74 f5 ff ff       	jmp    1051a0 <alltraps>

00105c2c <vector186>:
  105c2c:	6a 00                	push   $0x0
  105c2e:	68 ba 00 00 00       	push   $0xba
  105c33:	e9 68 f5 ff ff       	jmp    1051a0 <alltraps>

00105c38 <vector187>:
  105c38:	6a 00                	push   $0x0
  105c3a:	68 bb 00 00 00       	push   $0xbb
  105c3f:	e9 5c f5 ff ff       	jmp    1051a0 <alltraps>

00105c44 <vector188>:
  105c44:	6a 00                	push   $0x0
  105c46:	68 bc 00 00 00       	push   $0xbc
  105c4b:	e9 50 f5 ff ff       	jmp    1051a0 <alltraps>

00105c50 <vector189>:
  105c50:	6a 00                	push   $0x0
  105c52:	68 bd 00 00 00       	push   $0xbd
  105c57:	e9 44 f5 ff ff       	jmp    1051a0 <alltraps>

00105c5c <vector190>:
  105c5c:	6a 00                	push   $0x0
  105c5e:	68 be 00 00 00       	push   $0xbe
  105c63:	e9 38 f5 ff ff       	jmp    1051a0 <alltraps>

00105c68 <vector191>:
  105c68:	6a 00                	push   $0x0
  105c6a:	68 bf 00 00 00       	push   $0xbf
  105c6f:	e9 2c f5 ff ff       	jmp    1051a0 <alltraps>

00105c74 <vector192>:
  105c74:	6a 00                	push   $0x0
  105c76:	68 c0 00 00 00       	push   $0xc0
  105c7b:	e9 20 f5 ff ff       	jmp    1051a0 <alltraps>

00105c80 <vector193>:
  105c80:	6a 00                	push   $0x0
  105c82:	68 c1 00 00 00       	push   $0xc1
  105c87:	e9 14 f5 ff ff       	jmp    1051a0 <alltraps>

00105c8c <vector194>:
  105c8c:	6a 00                	push   $0x0
  105c8e:	68 c2 00 00 00       	push   $0xc2
  105c93:	e9 08 f5 ff ff       	jmp    1051a0 <alltraps>

00105c98 <vector195>:
  105c98:	6a 00                	push   $0x0
  105c9a:	68 c3 00 00 00       	push   $0xc3
  105c9f:	e9 fc f4 ff ff       	jmp    1051a0 <alltraps>

00105ca4 <vector196>:
  105ca4:	6a 00                	push   $0x0
  105ca6:	68 c4 00 00 00       	push   $0xc4
  105cab:	e9 f0 f4 ff ff       	jmp    1051a0 <alltraps>

00105cb0 <vector197>:
  105cb0:	6a 00                	push   $0x0
  105cb2:	68 c5 00 00 00       	push   $0xc5
  105cb7:	e9 e4 f4 ff ff       	jmp    1051a0 <alltraps>

00105cbc <vector198>:
  105cbc:	6a 00                	push   $0x0
  105cbe:	68 c6 00 00 00       	push   $0xc6
  105cc3:	e9 d8 f4 ff ff       	jmp    1051a0 <alltraps>

00105cc8 <vector199>:
  105cc8:	6a 00                	push   $0x0
  105cca:	68 c7 00 00 00       	push   $0xc7
  105ccf:	e9 cc f4 ff ff       	jmp    1051a0 <alltraps>

00105cd4 <vector200>:
  105cd4:	6a 00                	push   $0x0
  105cd6:	68 c8 00 00 00       	push   $0xc8
  105cdb:	e9 c0 f4 ff ff       	jmp    1051a0 <alltraps>

00105ce0 <vector201>:
  105ce0:	6a 00                	push   $0x0
  105ce2:	68 c9 00 00 00       	push   $0xc9
  105ce7:	e9 b4 f4 ff ff       	jmp    1051a0 <alltraps>

00105cec <vector202>:
  105cec:	6a 00                	push   $0x0
  105cee:	68 ca 00 00 00       	push   $0xca
  105cf3:	e9 a8 f4 ff ff       	jmp    1051a0 <alltraps>

00105cf8 <vector203>:
  105cf8:	6a 00                	push   $0x0
  105cfa:	68 cb 00 00 00       	push   $0xcb
  105cff:	e9 9c f4 ff ff       	jmp    1051a0 <alltraps>

00105d04 <vector204>:
  105d04:	6a 00                	push   $0x0
  105d06:	68 cc 00 00 00       	push   $0xcc
  105d0b:	e9 90 f4 ff ff       	jmp    1051a0 <alltraps>

00105d10 <vector205>:
  105d10:	6a 00                	push   $0x0
  105d12:	68 cd 00 00 00       	push   $0xcd
  105d17:	e9 84 f4 ff ff       	jmp    1051a0 <alltraps>

00105d1c <vector206>:
  105d1c:	6a 00                	push   $0x0
  105d1e:	68 ce 00 00 00       	push   $0xce
  105d23:	e9 78 f4 ff ff       	jmp    1051a0 <alltraps>

00105d28 <vector207>:
  105d28:	6a 00                	push   $0x0
  105d2a:	68 cf 00 00 00       	push   $0xcf
  105d2f:	e9 6c f4 ff ff       	jmp    1051a0 <alltraps>

00105d34 <vector208>:
  105d34:	6a 00                	push   $0x0
  105d36:	68 d0 00 00 00       	push   $0xd0
  105d3b:	e9 60 f4 ff ff       	jmp    1051a0 <alltraps>

00105d40 <vector209>:
  105d40:	6a 00                	push   $0x0
  105d42:	68 d1 00 00 00       	push   $0xd1
  105d47:	e9 54 f4 ff ff       	jmp    1051a0 <alltraps>

00105d4c <vector210>:
  105d4c:	6a 00                	push   $0x0
  105d4e:	68 d2 00 00 00       	push   $0xd2
  105d53:	e9 48 f4 ff ff       	jmp    1051a0 <alltraps>

00105d58 <vector211>:
  105d58:	6a 00                	push   $0x0
  105d5a:	68 d3 00 00 00       	push   $0xd3
  105d5f:	e9 3c f4 ff ff       	jmp    1051a0 <alltraps>

00105d64 <vector212>:
  105d64:	6a 00                	push   $0x0
  105d66:	68 d4 00 00 00       	push   $0xd4
  105d6b:	e9 30 f4 ff ff       	jmp    1051a0 <alltraps>

00105d70 <vector213>:
  105d70:	6a 00                	push   $0x0
  105d72:	68 d5 00 00 00       	push   $0xd5
  105d77:	e9 24 f4 ff ff       	jmp    1051a0 <alltraps>

00105d7c <vector214>:
  105d7c:	6a 00                	push   $0x0
  105d7e:	68 d6 00 00 00       	push   $0xd6
  105d83:	e9 18 f4 ff ff       	jmp    1051a0 <alltraps>

00105d88 <vector215>:
  105d88:	6a 00                	push   $0x0
  105d8a:	68 d7 00 00 00       	push   $0xd7
  105d8f:	e9 0c f4 ff ff       	jmp    1051a0 <alltraps>

00105d94 <vector216>:
  105d94:	6a 00                	push   $0x0
  105d96:	68 d8 00 00 00       	push   $0xd8
  105d9b:	e9 00 f4 ff ff       	jmp    1051a0 <alltraps>

00105da0 <vector217>:
  105da0:	6a 00                	push   $0x0
  105da2:	68 d9 00 00 00       	push   $0xd9
  105da7:	e9 f4 f3 ff ff       	jmp    1051a0 <alltraps>

00105dac <vector218>:
  105dac:	6a 00                	push   $0x0
  105dae:	68 da 00 00 00       	push   $0xda
  105db3:	e9 e8 f3 ff ff       	jmp    1051a0 <alltraps>

00105db8 <vector219>:
  105db8:	6a 00                	push   $0x0
  105dba:	68 db 00 00 00       	push   $0xdb
  105dbf:	e9 dc f3 ff ff       	jmp    1051a0 <alltraps>

00105dc4 <vector220>:
  105dc4:	6a 00                	push   $0x0
  105dc6:	68 dc 00 00 00       	push   $0xdc
  105dcb:	e9 d0 f3 ff ff       	jmp    1051a0 <alltraps>

00105dd0 <vector221>:
  105dd0:	6a 00                	push   $0x0
  105dd2:	68 dd 00 00 00       	push   $0xdd
  105dd7:	e9 c4 f3 ff ff       	jmp    1051a0 <alltraps>

00105ddc <vector222>:
  105ddc:	6a 00                	push   $0x0
  105dde:	68 de 00 00 00       	push   $0xde
  105de3:	e9 b8 f3 ff ff       	jmp    1051a0 <alltraps>

00105de8 <vector223>:
  105de8:	6a 00                	push   $0x0
  105dea:	68 df 00 00 00       	push   $0xdf
  105def:	e9 ac f3 ff ff       	jmp    1051a0 <alltraps>

00105df4 <vector224>:
  105df4:	6a 00                	push   $0x0
  105df6:	68 e0 00 00 00       	push   $0xe0
  105dfb:	e9 a0 f3 ff ff       	jmp    1051a0 <alltraps>

00105e00 <vector225>:
  105e00:	6a 00                	push   $0x0
  105e02:	68 e1 00 00 00       	push   $0xe1
  105e07:	e9 94 f3 ff ff       	jmp    1051a0 <alltraps>

00105e0c <vector226>:
  105e0c:	6a 00                	push   $0x0
  105e0e:	68 e2 00 00 00       	push   $0xe2
  105e13:	e9 88 f3 ff ff       	jmp    1051a0 <alltraps>

00105e18 <vector227>:
  105e18:	6a 00                	push   $0x0
  105e1a:	68 e3 00 00 00       	push   $0xe3
  105e1f:	e9 7c f3 ff ff       	jmp    1051a0 <alltraps>

00105e24 <vector228>:
  105e24:	6a 00                	push   $0x0
  105e26:	68 e4 00 00 00       	push   $0xe4
  105e2b:	e9 70 f3 ff ff       	jmp    1051a0 <alltraps>

00105e30 <vector229>:
  105e30:	6a 00                	push   $0x0
  105e32:	68 e5 00 00 00       	push   $0xe5
  105e37:	e9 64 f3 ff ff       	jmp    1051a0 <alltraps>

00105e3c <vector230>:
  105e3c:	6a 00                	push   $0x0
  105e3e:	68 e6 00 00 00       	push   $0xe6
  105e43:	e9 58 f3 ff ff       	jmp    1051a0 <alltraps>

00105e48 <vector231>:
  105e48:	6a 00                	push   $0x0
  105e4a:	68 e7 00 00 00       	push   $0xe7
  105e4f:	e9 4c f3 ff ff       	jmp    1051a0 <alltraps>

00105e54 <vector232>:
  105e54:	6a 00                	push   $0x0
  105e56:	68 e8 00 00 00       	push   $0xe8
  105e5b:	e9 40 f3 ff ff       	jmp    1051a0 <alltraps>

00105e60 <vector233>:
  105e60:	6a 00                	push   $0x0
  105e62:	68 e9 00 00 00       	push   $0xe9
  105e67:	e9 34 f3 ff ff       	jmp    1051a0 <alltraps>

00105e6c <vector234>:
  105e6c:	6a 00                	push   $0x0
  105e6e:	68 ea 00 00 00       	push   $0xea
  105e73:	e9 28 f3 ff ff       	jmp    1051a0 <alltraps>

00105e78 <vector235>:
  105e78:	6a 00                	push   $0x0
  105e7a:	68 eb 00 00 00       	push   $0xeb
  105e7f:	e9 1c f3 ff ff       	jmp    1051a0 <alltraps>

00105e84 <vector236>:
  105e84:	6a 00                	push   $0x0
  105e86:	68 ec 00 00 00       	push   $0xec
  105e8b:	e9 10 f3 ff ff       	jmp    1051a0 <alltraps>

00105e90 <vector237>:
  105e90:	6a 00                	push   $0x0
  105e92:	68 ed 00 00 00       	push   $0xed
  105e97:	e9 04 f3 ff ff       	jmp    1051a0 <alltraps>

00105e9c <vector238>:
  105e9c:	6a 00                	push   $0x0
  105e9e:	68 ee 00 00 00       	push   $0xee
  105ea3:	e9 f8 f2 ff ff       	jmp    1051a0 <alltraps>

00105ea8 <vector239>:
  105ea8:	6a 00                	push   $0x0
  105eaa:	68 ef 00 00 00       	push   $0xef
  105eaf:	e9 ec f2 ff ff       	jmp    1051a0 <alltraps>

00105eb4 <vector240>:
  105eb4:	6a 00                	push   $0x0
  105eb6:	68 f0 00 00 00       	push   $0xf0
  105ebb:	e9 e0 f2 ff ff       	jmp    1051a0 <alltraps>

00105ec0 <vector241>:
  105ec0:	6a 00                	push   $0x0
  105ec2:	68 f1 00 00 00       	push   $0xf1
  105ec7:	e9 d4 f2 ff ff       	jmp    1051a0 <alltraps>

00105ecc <vector242>:
  105ecc:	6a 00                	push   $0x0
  105ece:	68 f2 00 00 00       	push   $0xf2
  105ed3:	e9 c8 f2 ff ff       	jmp    1051a0 <alltraps>

00105ed8 <vector243>:
  105ed8:	6a 00                	push   $0x0
  105eda:	68 f3 00 00 00       	push   $0xf3
  105edf:	e9 bc f2 ff ff       	jmp    1051a0 <alltraps>

00105ee4 <vector244>:
  105ee4:	6a 00                	push   $0x0
  105ee6:	68 f4 00 00 00       	push   $0xf4
  105eeb:	e9 b0 f2 ff ff       	jmp    1051a0 <alltraps>

00105ef0 <vector245>:
  105ef0:	6a 00                	push   $0x0
  105ef2:	68 f5 00 00 00       	push   $0xf5
  105ef7:	e9 a4 f2 ff ff       	jmp    1051a0 <alltraps>

00105efc <vector246>:
  105efc:	6a 00                	push   $0x0
  105efe:	68 f6 00 00 00       	push   $0xf6
  105f03:	e9 98 f2 ff ff       	jmp    1051a0 <alltraps>

00105f08 <vector247>:
  105f08:	6a 00                	push   $0x0
  105f0a:	68 f7 00 00 00       	push   $0xf7
  105f0f:	e9 8c f2 ff ff       	jmp    1051a0 <alltraps>

00105f14 <vector248>:
  105f14:	6a 00                	push   $0x0
  105f16:	68 f8 00 00 00       	push   $0xf8
  105f1b:	e9 80 f2 ff ff       	jmp    1051a0 <alltraps>

00105f20 <vector249>:
  105f20:	6a 00                	push   $0x0
  105f22:	68 f9 00 00 00       	push   $0xf9
  105f27:	e9 74 f2 ff ff       	jmp    1051a0 <alltraps>

00105f2c <vector250>:
  105f2c:	6a 00                	push   $0x0
  105f2e:	68 fa 00 00 00       	push   $0xfa
  105f33:	e9 68 f2 ff ff       	jmp    1051a0 <alltraps>

00105f38 <vector251>:
  105f38:	6a 00                	push   $0x0
  105f3a:	68 fb 00 00 00       	push   $0xfb
  105f3f:	e9 5c f2 ff ff       	jmp    1051a0 <alltraps>

00105f44 <vector252>:
  105f44:	6a 00                	push   $0x0
  105f46:	68 fc 00 00 00       	push   $0xfc
  105f4b:	e9 50 f2 ff ff       	jmp    1051a0 <alltraps>

00105f50 <vector253>:
  105f50:	6a 00                	push   $0x0
  105f52:	68 fd 00 00 00       	push   $0xfd
  105f57:	e9 44 f2 ff ff       	jmp    1051a0 <alltraps>

00105f5c <vector254>:
  105f5c:	6a 00                	push   $0x0
  105f5e:	68 fe 00 00 00       	push   $0xfe
  105f63:	e9 38 f2 ff ff       	jmp    1051a0 <alltraps>

00105f68 <vector255>:
  105f68:	6a 00                	push   $0x0
  105f6a:	68 ff 00 00 00       	push   $0xff
  105f6f:	e9 2c f2 ff ff       	jmp    1051a0 <alltraps>
