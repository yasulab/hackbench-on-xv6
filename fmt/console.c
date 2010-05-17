6150 // Console input and output.
6151 // Input is from the keyboard only.
6152 // Output is written to the screen and the printer port.
6153 
6154 #include "types.h"
6155 #include "defs.h"
6156 #include "param.h"
6157 #include "traps.h"
6158 #include "spinlock.h"
6159 #include "dev.h"
6160 #include "mmu.h"
6161 #include "proc.h"
6162 #include "x86.h"
6163 
6164 #define CRTPORT 0x3d4
6165 #define LPTPORT 0x378
6166 #define BACKSPACE 0x100
6167 
6168 static ushort *crt = (ushort*)0xb8000;  // CGA memory
6169 
6170 static struct spinlock console_lock;
6171 int panicked = 0;
6172 int use_console_lock = 0;
6173 
6174 // Copy console output to parallel port, which you can tell
6175 // .bochsrc to copy to the stdout:
6176 //   parport1: enabled=1, file="/dev/stdout"
6177 static void
6178 lpt_putc(int c)
6179 {
6180   int i;
6181 
6182   for(i = 0; !(inb(LPTPORT+1) & 0x80) && i < 12800; i++)
6183     ;
6184   if(c == BACKSPACE)
6185     c = '\b';
6186   outb(LPTPORT+0, c);
6187   outb(LPTPORT+2, 0x08|0x04|0x01);
6188   outb(LPTPORT+2, 0x08);
6189 }
6190 
6191 
6192 
6193 
6194 
6195 
6196 
6197 
6198 
6199 
6200 static void
6201 cga_putc(int c)
6202 {
6203   int pos;
6204 
6205   // Cursor position: col + 80*row.
6206   outb(CRTPORT, 14);
6207   pos = inb(CRTPORT+1) << 8;
6208   outb(CRTPORT, 15);
6209   pos |= inb(CRTPORT+1);
6210 
6211   if(c == '\n')
6212     pos += 80 - pos%80;
6213   else if(c == BACKSPACE){
6214     if(pos > 0)
6215       crt[--pos] = ' ' | 0x0700;
6216   } else
6217     crt[pos++] = (c&0xff) | 0x0700;  // black on white
6218 
6219   if((pos/80) >= 24){  // Scroll up.
6220     memmove(crt, crt+80, sizeof(crt[0])*23*80);
6221     pos -= 80;
6222     memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
6223   }
6224 
6225   outb(CRTPORT, 14);
6226   outb(CRTPORT+1, pos>>8);
6227   outb(CRTPORT, 15);
6228   outb(CRTPORT+1, pos);
6229   crt[pos] = ' ' | 0x0700;
6230 }
6231 
6232 void
6233 cons_putc(int c)
6234 {
6235   if(panicked){
6236     cli();
6237     for(;;)
6238       ;
6239   }
6240 
6241   lpt_putc(c);
6242   cga_putc(c);
6243 }
6244 
6245 
6246 
6247 
6248 
6249 
6250 void
6251 printint(int xx, int base, int sgn)
6252 {
6253   static char digits[] = "0123456789ABCDEF";
6254   char buf[16];
6255   int i = 0, neg = 0;
6256   uint x;
6257 
6258   if(sgn && xx < 0){
6259     neg = 1;
6260     x = 0 - xx;
6261   } else {
6262     x = xx;
6263   }
6264 
6265   do{
6266     buf[i++] = digits[x % base];
6267   }while((x /= base) != 0);
6268   if(neg)
6269     buf[i++] = '-';
6270 
6271   while(--i >= 0)
6272     cons_putc(buf[i]);
6273 }
6274 
6275 // Print to the console. only understands %d, %x, %p, %s.
6276 void
6277 cprintf(char *fmt, ...)
6278 {
6279   int i, c, state, locking;
6280   uint *argp;
6281   char *s;
6282 
6283   locking = use_console_lock;
6284   if(locking)
6285     acquire(&console_lock);
6286 
6287   argp = (uint*)(void*)&fmt + 1;
6288   state = 0;
6289   for(i = 0; fmt[i]; i++){
6290     c = fmt[i] & 0xff;
6291     switch(state){
6292     case 0:
6293       if(c == '%')
6294         state = '%';
6295       else
6296         cons_putc(c);
6297       break;
6298 
6299 
6300     case '%':
6301       switch(c){
6302       case 'd':
6303         printint(*argp++, 10, 1);
6304         break;
6305       case 'x':
6306       case 'p':
6307         printint(*argp++, 16, 0);
6308         break;
6309       case 's':
6310         s = (char*)*argp++;
6311         if(s == 0)
6312           s = "(null)";
6313         for(; *s; s++)
6314           cons_putc(*s);
6315         break;
6316       case '%':
6317         cons_putc('%');
6318         break;
6319       default:
6320         // Print unknown % sequence to draw attention.
6321         cons_putc('%');
6322         cons_putc(c);
6323         break;
6324       }
6325       state = 0;
6326       break;
6327     }
6328   }
6329 
6330   if(locking)
6331     release(&console_lock);
6332 }
6333 
6334 int
6335 console_write(struct inode *ip, char *buf, int n)
6336 {
6337   int i;
6338 
6339   iunlock(ip);
6340   acquire(&console_lock);
6341   for(i = 0; i < n; i++)
6342     cons_putc(buf[i] & 0xff);
6343   release(&console_lock);
6344   ilock(ip);
6345 
6346   return n;
6347 }
6348 
6349 
6350 #define INPUT_BUF 128
6351 struct {
6352   struct spinlock lock;
6353   char buf[INPUT_BUF];
6354   int r;  // Read index
6355   int w;  // Write index
6356   int e;  // Edit index
6357 } input;
6358 
6359 #define C(x)  ((x)-'@')  // Control-x
6360 
6361 void
6362 console_intr(int (*getc)(void))
6363 {
6364   int c;
6365 
6366   acquire(&input.lock);
6367   while((c = getc()) >= 0){
6368     switch(c){
6369     case C('P'):  // Process listing.
6370       procdump();
6371       break;
6372     case C('U'):  // Kill line.
6373       while(input.e > input.w &&
6374             input.buf[(input.e-1) % INPUT_BUF] != '\n'){
6375         input.e--;
6376         cons_putc(BACKSPACE);
6377       }
6378       break;
6379     case C('H'):  // Backspace
6380       if(input.e > input.w){
6381         input.e--;
6382         cons_putc(BACKSPACE);
6383       }
6384       break;
6385     default:
6386       if(c != 0 && input.e < input.r+INPUT_BUF){
6387         input.buf[input.e++ % INPUT_BUF] = c;
6388         cons_putc(c);
6389         if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
6390           input.w = input.e;
6391           wakeup(&input.r);
6392         }
6393       }
6394       break;
6395     }
6396   }
6397   release(&input.lock);
6398 }
6399 
6400 int
6401 console_read(struct inode *ip, char *dst, int n)
6402 {
6403   uint target;
6404   int c;
6405 
6406   iunlock(ip);
6407   target = n;
6408   acquire(&input.lock);
6409   while(n > 0){
6410     while(input.r == input.w){
6411       if(cp->killed){
6412         release(&input.lock);
6413         ilock(ip);
6414         return -1;
6415       }
6416       sleep(&input.r, &input.lock);
6417     }
6418     c = input.buf[input.r++ % INPUT_BUF];
6419     if(c == C('D')){  // EOF
6420       if(n < target){
6421         // Save ^D for next time, to make sure
6422         // caller gets a 0-byte result.
6423         input.r--;
6424       }
6425       break;
6426     }
6427     *dst++ = c;
6428     --n;
6429     if(c == '\n')
6430       break;
6431   }
6432   release(&input.lock);
6433   ilock(ip);
6434 
6435   return target - n;
6436 }
6437 
6438 
6439 
6440 
6441 
6442 
6443 
6444 
6445 
6446 
6447 
6448 
6449 
6450 void
6451 console_init(void)
6452 {
6453   initlock(&console_lock, "console");
6454   initlock(&input.lock, "console input");
6455 
6456   devsw[CONSOLE].write = console_write;
6457   devsw[CONSOLE].read = console_read;
6458   use_console_lock = 1;
6459 
6460   pic_enable(IRQ_KBD);
6461   ioapic_enable(IRQ_KBD, 0);
6462 }
6463 
6464 void
6465 panic(char *s)
6466 {
6467   int i;
6468   uint pcs[10];
6469 
6470   __asm __volatile("cli");
6471   use_console_lock = 0;
6472   cprintf("cpu%d: panic: ", cpu());
6473   cprintf(s, 0);
6474   cprintf("\n", 0);
6475   getcallerpcs(&s, pcs);
6476   for(i=0; i<10; i++)
6477     cprintf(" %p", pcs[i]);
6478   panicked = 1; // freeze other CPU
6479   for(;;)
6480     ;
6481 }
6482 
6483 
6484 
6485 
6486 
6487 
6488 
6489 
6490 
6491 
6492 
6493 
6494 
6495 
6496 
6497 
6498 
6499 
