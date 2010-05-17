5850 // Intel 8259A programmable interrupt controllers.
5851 
5852 #include "types.h"
5853 #include "x86.h"
5854 #include "traps.h"
5855 
5856 // I/O Addresses of the two programmable interrupt controllers
5857 #define IO_PIC1         0x20    // Master (IRQs 0-7)
5858 #define IO_PIC2         0xA0    // Slave (IRQs 8-15)
5859 
5860 #define IRQ_SLAVE       2       // IRQ at which slave connects to master
5861 
5862 // Current IRQ mask.
5863 // Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
5864 static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);
5865 
5866 static void
5867 pic_setmask(ushort mask)
5868 {
5869   irqmask = mask;
5870   outb(IO_PIC1+1, mask);
5871   outb(IO_PIC2+1, mask >> 8);
5872 }
5873 
5874 void
5875 pic_enable(int irq)
5876 {
5877   pic_setmask(irqmask & ~(1<<irq));
5878 }
5879 
5880 // Initialize the 8259A interrupt controllers.
5881 void
5882 pic_init(void)
5883 {
5884   // mask all interrupts
5885   outb(IO_PIC1+1, 0xFF);
5886   outb(IO_PIC2+1, 0xFF);
5887 
5888   // Set up master (8259A-1)
5889 
5890   // ICW1:  0001g0hi
5891   //    g:  0 = edge triggering, 1 = level triggering
5892   //    h:  0 = cascaded PICs, 1 = master only
5893   //    i:  0 = no ICW4, 1 = ICW4 required
5894   outb(IO_PIC1, 0x11);
5895 
5896   // ICW2:  Vector offset
5897   outb(IO_PIC1+1, IRQ_OFFSET);
5898 
5899 
5900   // ICW3:  (master PIC) bit mask of IR lines connected to slaves
5901   //        (slave PIC) 3-bit # of slave's connection to master
5902   outb(IO_PIC1+1, 1<<IRQ_SLAVE);
5903 
5904   // ICW4:  000nbmap
5905   //    n:  1 = special fully nested mode
5906   //    b:  1 = buffered mode
5907   //    m:  0 = slave PIC, 1 = master PIC
5908   //      (ignored when b is 0, as the master/slave role
5909   //      can be hardwired).
5910   //    a:  1 = Automatic EOI mode
5911   //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
5912   outb(IO_PIC1+1, 0x3);
5913 
5914   // Set up slave (8259A-2)
5915   outb(IO_PIC2, 0x11);                  // ICW1
5916   outb(IO_PIC2+1, IRQ_OFFSET + 8);      // ICW2
5917   outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
5918   // NB Automatic EOI mode doesn't tend to work on the slave.
5919   // Linux source code says it's "to be investigated".
5920   outb(IO_PIC2+1, 0x3);                 // ICW4
5921 
5922   // OCW3:  0ef01prs
5923   //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
5924   //    p:  0 = no polling, 1 = polling mode
5925   //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
5926   outb(IO_PIC1, 0x68);             // clear specific mask
5927   outb(IO_PIC1, 0x0a);             // read IRR by default
5928 
5929   outb(IO_PIC2, 0x68);             // OCW3
5930   outb(IO_PIC2, 0x0a);             // OCW3
5931 
5932   if(irqmask != 0xFFFF)
5933     pic_setmask(irqmask);
5934 }
5935 
5936 
5937 
5938 
5939 
5940 
5941 
5942 
5943 
5944 
5945 
5946 
5947 
5948 
5949 
