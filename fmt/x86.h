0350 // Routines to let C code use special x86 instructions.
0351 
0352 static inline uchar
0353 inb(ushort port)
0354 {
0355   uchar data;
0356 
0357   asm volatile("in %1,%0" : "=a" (data) : "d" (port));
0358   return data;
0359 }
0360 
0361 static inline void
0362 insl(int port, void *addr, int cnt)
0363 {
0364   asm volatile("cld\n\trepne\n\tinsl"     :
0365                    "=D" (addr), "=c" (cnt)    :
0366                    "d" (port), "0" (addr), "1" (cnt)  :
0367                    "memory", "cc");
0368 }
0369 
0370 static inline void
0371 outb(ushort port, uchar data)
0372 {
0373   asm volatile("out %0,%1" : : "a" (data), "d" (port));
0374 }
0375 
0376 static inline void
0377 outw(ushort port, ushort data)
0378 {
0379   asm volatile("out %0,%1" : : "a" (data), "d" (port));
0380 }
0381 
0382 static inline void
0383 outsl(int port, const void *addr, int cnt)
0384 {
0385   asm volatile("cld\n\trepne\n\toutsl"    :
0386                    "=S" (addr), "=c" (cnt)    :
0387                    "d" (port), "0" (addr), "1" (cnt)  :
0388                    "cc");
0389 }
0390 
0391 static inline uint
0392 read_ebp(void)
0393 {
0394   uint ebp;
0395 
0396   asm volatile("movl %%ebp, %0" : "=a" (ebp));
0397   return ebp;
0398 }
0399 
0400 struct segdesc;
0401 
0402 static inline void
0403 lgdt(struct segdesc *p, int size)
0404 {
0405   volatile ushort pd[3];
0406 
0407   pd[0] = size-1;
0408   pd[1] = (uint)p;
0409   pd[2] = (uint)p >> 16;
0410 
0411   asm volatile("lgdt (%0)" : : "r" (pd));
0412 }
0413 
0414 struct gatedesc;
0415 
0416 static inline void
0417 lidt(struct gatedesc *p, int size)
0418 {
0419   volatile ushort pd[3];
0420 
0421   pd[0] = size-1;
0422   pd[1] = (uint)p;
0423   pd[2] = (uint)p >> 16;
0424 
0425   asm volatile("lidt (%0)" : : "r" (pd));
0426 }
0427 
0428 static inline void
0429 ltr(ushort sel)
0430 {
0431   asm volatile("ltr %0" : : "r" (sel));
0432 }
0433 
0434 static inline uint
0435 read_eflags(void)
0436 {
0437   uint eflags;
0438   asm volatile("pushfl; popl %0" : "=r" (eflags));
0439   return eflags;
0440 }
0441 
0442 static inline void
0443 write_eflags(uint eflags)
0444 {
0445   asm volatile("pushl %0; popfl" : : "r" (eflags));
0446 }
0447 
0448 
0449 
0450 static inline uint
0451 xchg(volatile uint *addr, uint newval)
0452 {
0453   uint result;
0454 
0455   // The + in "+m" denotes a read-modify-write operand.
0456   asm volatile("lock; xchgl %0, %1" :
0457                "+m" (*addr), "=a" (result) :
0458                "1" (newval) :
0459                "cc");
0460   return result;
0461 }
0462 
0463 static inline void
0464 cli(void)
0465 {
0466   asm volatile("cli");
0467 }
0468 
0469 static inline void
0470 sti(void)
0471 {
0472   asm volatile("sti");
0473 }
0474 
0475 // Layout of the trap frame built on the stack by the
0476 // hardware and by trapasm.S, and passed to trap().
0477 struct trapframe {
0478   // registers as pushed by pusha
0479   uint edi;
0480   uint esi;
0481   uint ebp;
0482   uint oesp;      // useless & ignored
0483   uint ebx;
0484   uint edx;
0485   uint ecx;
0486   uint eax;
0487 
0488   // rest of trap frame
0489   ushort es;
0490   ushort padding1;
0491   ushort ds;
0492   ushort padding2;
0493   uint trapno;
0494 
0495   // below here defined by x86 hardware
0496   uint err;
0497   uint eip;
0498   ushort cs;
0499   ushort padding3;
0500   uint eflags;
0501 
0502   // below here only when crossing rings, such as from user to kernel
0503   uint esp;
0504   ushort ss;
0505   ushort padding4;
0506 };
0507 
0508 
0509 
0510 
0511 
0512 
0513 
0514 
0515 
0516 
0517 
0518 
0519 
0520 
0521 
0522 
0523 
0524 
0525 
0526 
0527 
0528 
0529 
0530 
0531 
0532 
0533 
0534 
0535 
0536 
0537 
0538 
0539 
0540 
0541 
0542 
0543 
0544 
0545 
0546 
0547 
0548 
0549 
