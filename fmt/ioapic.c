5750 // The I/O APIC manages hardware interrupts for an SMP system.
5751 // http://www.intel.com/design/chipsets/datashts/29056601.pdf
5752 // See also picirq.c.
5753 
5754 #include "types.h"
5755 #include "defs.h"
5756 #include "traps.h"
5757 
5758 #define IOAPIC  0xFEC00000   // Default physical address of IO APIC
5759 
5760 #define REG_ID     0x00  // Register index: ID
5761 #define REG_VER    0x01  // Register index: version
5762 #define REG_TABLE  0x10  // Redirection table base
5763 
5764 // The redirection table starts at REG_TABLE and uses
5765 // two registers to configure each interrupt.
5766 // The first (low) register in a pair contains configuration bits.
5767 // The second (high) register contains a bitmask telling which
5768 // CPUs can serve that interrupt.
5769 #define INT_DISABLED   0x00010000  // Interrupt disabled
5770 #define INT_LEVEL      0x00008000  // Level-triggered (vs edge-)
5771 #define INT_ACTIVELOW  0x00002000  // Active low (vs high)
5772 #define INT_LOGICAL    0x00000800  // Destination is CPU id (vs APIC ID)
5773 
5774 volatile struct ioapic *ioapic;
5775 
5776 // IO APIC MMIO structure: write reg, then read or write data.
5777 struct ioapic {
5778   uint reg;
5779   uint pad[3];
5780   uint data;
5781 };
5782 
5783 static uint
5784 ioapic_read(int reg)
5785 {
5786   ioapic->reg = reg;
5787   return ioapic->data;
5788 }
5789 
5790 static void
5791 ioapic_write(int reg, uint data)
5792 {
5793   ioapic->reg = reg;
5794   ioapic->data = data;
5795 }
5796 
5797 
5798 
5799 
5800 void
5801 ioapic_init(void)
5802 {
5803   int i, id, maxintr;
5804 
5805   if(!ismp)
5806     return;
5807 
5808   ioapic = (volatile struct ioapic*)IOAPIC;
5809   maxintr = (ioapic_read(REG_VER) >> 16) & 0xFF;
5810   id = ioapic_read(REG_ID) >> 24;
5811   if(id != ioapic_id)
5812     cprintf("ioapic_init: id isn't equal to ioapic_id; not a MP\n");
5813 
5814   // Mark all interrupts edge-triggered, active high, disabled,
5815   // and not routed to any CPUs.
5816   for(i = 0; i <= maxintr; i++){
5817     ioapic_write(REG_TABLE+2*i, INT_DISABLED | (IRQ_OFFSET + i));
5818     ioapic_write(REG_TABLE+2*i+1, 0);
5819   }
5820 }
5821 
5822 void
5823 ioapic_enable(int irq, int cpunum)
5824 {
5825   if(!ismp)
5826     return;
5827 
5828   // Mark interrupt edge-triggered, active high,
5829   // enabled, and routed to the given cpunum,
5830   // which happens to be that cpu's APIC ID.
5831   ioapic_write(REG_TABLE+2*irq, IRQ_OFFSET + irq);
5832   ioapic_write(REG_TABLE+2*irq+1, cpunum << 24);
5833 }
5834 
5835 
5836 
5837 
5838 
5839 
5840 
5841 
5842 
5843 
5844 
5845 
5846 
5847 
5848 
5849 
