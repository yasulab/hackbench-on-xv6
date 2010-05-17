6500 // Intel 8253/8254/82C54 Programmable Interval Timer (PIT).
6501 // Only used on uniprocessors;
6502 // SMP machines use the local APIC timer.
6503 
6504 #include "types.h"
6505 #include "defs.h"
6506 #include "traps.h"
6507 #include "x86.h"
6508 
6509 #define IO_TIMER1       0x040           // 8253 Timer #1
6510 
6511 // Frequency of all three count-down timers;
6512 // (TIMER_FREQ/freq) is the appropriate count
6513 // to generate a frequency of freq Hz.
6514 
6515 #define TIMER_FREQ      1193182
6516 #define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))
6517 
6518 #define TIMER_MODE      (IO_TIMER1 + 3) // timer mode port
6519 #define TIMER_SEL0      0x00    // select counter 0
6520 #define TIMER_RATEGEN   0x04    // mode 2, rate generator
6521 #define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first
6522 
6523 void
6524 timer_init(void)
6525 {
6526   // Interrupt 100 times/sec.
6527   outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
6528   outb(IO_TIMER1, TIMER_DIV(100) % 256);
6529   outb(IO_TIMER1, TIMER_DIV(100) / 256);
6530   pic_enable(IRQ_TIMER);
6531 }
6532 
6533 
6534 
6535 
6536 
6537 
6538 
6539 
6540 
6541 
6542 
6543 
6544 
6545 
6546 
6547 
6548 
6549 
6550 // Blank page
6551 
6552 
6553 
6554 
6555 
6556 
6557 
6558 
6559 
6560 
6561 
6562 
6563 
6564 
6565 
6566 
6567 
6568 
6569 
6570 
6571 
6572 
6573 
6574 
6575 
6576 
6577 
6578 
6579 
6580 
6581 
6582 
6583 
6584 
6585 
6586 
6587 
6588 
6589 
6590 
6591 
6592 
6593 
6594 
6595 
6596 
6597 
6598 
6599 
