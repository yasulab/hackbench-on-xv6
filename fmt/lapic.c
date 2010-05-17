5550 // The local APIC manages internal (non-I/O) interrupts.
5551 // See Chapter 8 & Appendix C of Intel processor manual volume 3.
5552 
5553 #include "types.h"
5554 #include "defs.h"
5555 #include "traps.h"
5556 #include "mmu.h"
5557 #include "x86.h"
5558 
5559 // Local APIC registers, divided by 4 for use as uint[] indices.
5560 #define ID      (0x0020/4)   // ID
5561 #define VER     (0x0030/4)   // Version
5562 #define TPR     (0x0080/4)   // Task Priority
5563 #define EOI     (0x00B0/4)   // EOI
5564 #define SVR     (0x00F0/4)   // Spurious Interrupt Vector
5565   #define ENABLE     0x00000100   // Unit Enable
5566 #define ESR     (0x0280/4)   // Error Status
5567 #define ICRLO   (0x0300/4)   // Interrupt Command
5568   #define INIT       0x00000500   // INIT/RESET
5569   #define STARTUP    0x00000600   // Startup IPI
5570   #define DELIVS     0x00001000   // Delivery status
5571   #define ASSERT     0x00004000   // Assert interrupt (vs deassert)
5572   #define LEVEL      0x00008000   // Level triggered
5573   #define BCAST      0x00080000   // Send to all APICs, including self.
5574 #define ICRHI   (0x0310/4)   // Interrupt Command [63:32]
5575 #define TIMER   (0x0320/4)   // Local Vector Table 0 (TIMER)
5576   #define X1         0x0000000B   // divide counts by 1
5577   #define PERIODIC   0x00020000   // Periodic
5578 #define PCINT   (0x0340/4)   // Performance Counter LVT
5579 #define LINT0   (0x0350/4)   // Local Vector Table 1 (LINT0)
5580 #define LINT1   (0x0360/4)   // Local Vector Table 2 (LINT1)
5581 #define ERROR   (0x0370/4)   // Local Vector Table 3 (ERROR)
5582   #define MASKED     0x00010000   // Interrupt masked
5583 #define TICR    (0x0380/4)   // Timer Initial Count
5584 #define TCCR    (0x0390/4)   // Timer Current Count
5585 #define TDCR    (0x03E0/4)   // Timer Divide Configuration
5586 
5587 volatile uint *lapic;  // Initialized in mp.c
5588 
5589 static void
5590 lapicw(int index, int value)
5591 {
5592   lapic[index] = value;
5593   lapic[ID];  // wait for write to finish, by reading
5594 }
5595 
5596 
5597 
5598 
5599 
5600 void
5601 lapic_init(int c)
5602 {
5603   if(!lapic)
5604     return;
5605 
5606   // Enable local APIC; set spurious interrupt vector.
5607   lapicw(SVR, ENABLE | (IRQ_OFFSET+IRQ_SPURIOUS));
5608 
5609   // The timer repeatedly counts down at bus frequency
5610   // from lapic[TICR] and then issues an interrupt.
5611   // If xv6 cared more about precise timekeeping,
5612   // TICR would be calibrated using an external time source.
5613   lapicw(TDCR, X1);
5614   lapicw(TIMER, PERIODIC | (IRQ_OFFSET + IRQ_TIMER));
5615   lapicw(TICR, 10000000);
5616 
5617   // Disable logical interrupt lines.
5618   lapicw(LINT0, MASKED);
5619   lapicw(LINT1, MASKED);
5620 
5621   // Disable performance counter overflow interrupts
5622   // on machines that provide that interrupt entry.
5623   if(((lapic[VER]>>16) & 0xFF) >= 4)
5624     lapicw(PCINT, MASKED);
5625 
5626   // Map error interrupt to IRQ_ERROR.
5627   lapicw(ERROR, IRQ_OFFSET+IRQ_ERROR);
5628 
5629   // Clear error status register (requires back-to-back writes).
5630   lapicw(ESR, 0);
5631   lapicw(ESR, 0);
5632 
5633   // Ack any outstanding interrupts.
5634   lapicw(EOI, 0);
5635 
5636   // Send an Init Level De-Assert to synchronise arbitration ID's.
5637   lapicw(ICRHI, 0);
5638   lapicw(ICRLO, BCAST | INIT | LEVEL);
5639   while(lapic[ICRLO] & DELIVS)
5640     ;
5641 
5642   // Enable interrupts on the APIC (but not on the processor).
5643   lapicw(TPR, 0);
5644 }
5645 
5646 
5647 
5648 
5649 
5650 int
5651 cpu(void)
5652 {
5653   // Cannot call cpu when interrupts are enabled:
5654   // result not guaranteed to last long enough to be used!
5655   // Would prefer to panic but even printing is chancy here:
5656   // everything, including cprintf, calls cpu, at least indirectly
5657   // through acquire and release.
5658   if(read_eflags()&FL_IF){
5659     static int n;
5660     if(n++ == 0)
5661       cprintf("cpu called from %x with interrupts enabled\n",
5662         ((uint*)read_ebp())[1]);
5663   }
5664 
5665   if(lapic)
5666     return lapic[ID]>>24;
5667   return 0;
5668 }
5669 
5670 // Acknowledge interrupt.
5671 void
5672 lapic_eoi(void)
5673 {
5674   if(lapic)
5675     lapicw(EOI, 0);
5676 }
5677 
5678 // Spin for a given number of microseconds.
5679 // On real hardware would want to tune this dynamically.
5680 static void
5681 microdelay(int us)
5682 {
5683   volatile int j = 0;
5684 
5685   while(us-- > 0)
5686     for(j=0; j<10000; j++);
5687 }
5688 
5689 
5690 
5691 
5692 
5693 
5694 
5695 
5696 
5697 
5698 
5699 
5700 #define IO_RTC  0x70
5701 
5702 // Start additional processor running bootstrap code at addr.
5703 // See Appendix B of MultiProcessor Specification.
5704 void
5705 lapic_startap(uchar apicid, uint addr)
5706 {
5707   int i;
5708   ushort *wrv;
5709 
5710   // "The BSP must initialize CMOS shutdown code to 0AH
5711   // and the warm reset vector (DWORD based at 40:67) to point at
5712   // the AP startup code prior to the [universal startup algorithm]."
5713   outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
5714   outb(IO_RTC+1, 0x0A);
5715   wrv = (ushort*)(0x40<<4 | 0x67);  // Warm reset vector
5716   wrv[0] = 0;
5717   wrv[1] = addr >> 4;
5718 
5719   // "Universal startup algorithm."
5720   // Send INIT (level-triggered) interrupt to reset other CPU.
5721   lapicw(ICRHI, apicid<<24);
5722   lapicw(ICRLO, INIT | LEVEL | ASSERT);
5723   microdelay(200);
5724   lapicw(ICRLO, INIT | LEVEL);
5725   microdelay(100);	// should be 10ms, but too slow in Bochs!
5726 
5727   // Send startup IPI (twice!) to enter bootstrap code.
5728   // Regular hardware is supposed to only accept a STARTUP
5729   // when it is in the halted state due to an INIT.  So the second
5730   // should be ignored, but it is part of the official Intel algorithm.
5731   // Bochs complains about the second one.  Too bad for Bochs.
5732   for(i = 0; i < 2; i++){
5733     lapicw(ICRHI, apicid<<24);
5734     lapicw(ICRLO, STARTUP | (addr>>12));
5735     microdelay(200);
5736   }
5737 }
5738 
5739 
5740 
5741 
5742 
5743 
5744 
5745 
5746 
5747 
5748 
5749 
