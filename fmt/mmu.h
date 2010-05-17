0600 // This file contains definitions for the
0601 // x86 memory management unit (MMU).
0602 
0603 // Eflags register
0604 #define FL_CF           0x00000001      // Carry Flag
0605 #define FL_PF           0x00000004      // Parity Flag
0606 #define FL_AF           0x00000010      // Auxiliary carry Flag
0607 #define FL_ZF           0x00000040      // Zero Flag
0608 #define FL_SF           0x00000080      // Sign Flag
0609 #define FL_TF           0x00000100      // Trap Flag
0610 #define FL_IF           0x00000200      // Interrupt Enable
0611 #define FL_DF           0x00000400      // Direction Flag
0612 #define FL_OF           0x00000800      // Overflow Flag
0613 #define FL_IOPL_MASK    0x00003000      // I/O Privilege Level bitmask
0614 #define FL_IOPL_0       0x00000000      //   IOPL == 0
0615 #define FL_IOPL_1       0x00001000      //   IOPL == 1
0616 #define FL_IOPL_2       0x00002000      //   IOPL == 2
0617 #define FL_IOPL_3       0x00003000      //   IOPL == 3
0618 #define FL_NT           0x00004000      // Nested Task
0619 #define FL_RF           0x00010000      // Resume Flag
0620 #define FL_VM           0x00020000      // Virtual 8086 mode
0621 #define FL_AC           0x00040000      // Alignment Check
0622 #define FL_VIF          0x00080000      // Virtual Interrupt Flag
0623 #define FL_VIP          0x00100000      // Virtual Interrupt Pending
0624 #define FL_ID           0x00200000      // ID flag
0625 
0626 // Segment Descriptor
0627 struct segdesc {
0628   uint lim_15_0 : 16;  // Low bits of segment limit
0629   uint base_15_0 : 16; // Low bits of segment base address
0630   uint base_23_16 : 8; // Middle bits of segment base address
0631   uint type : 4;       // Segment type (see STS_ constants)
0632   uint s : 1;          // 0 = system, 1 = application
0633   uint dpl : 2;        // Descriptor Privilege Level
0634   uint p : 1;          // Present
0635   uint lim_19_16 : 4;  // High bits of segment limit
0636   uint avl : 1;        // Unused (available for software use)
0637   uint rsv1 : 1;       // Reserved
0638   uint db : 1;         // 0 = 16-bit segment, 1 = 32-bit segment
0639   uint g : 1;          // Granularity: limit scaled by 4K when set
0640   uint base_31_24 : 8; // High bits of segment base address
0641 };
0642 
0643 
0644 
0645 
0646 
0647 
0648 
0649 
0650 // Null segment
0651 #define SEG_NULL        (struct segdesc){ 0,0,0,0,0,0,0,0,0,0,0,0,0 }
0652 
0653 // Normal segment
0654 #define SEG(type, base, lim, dpl) (struct segdesc)                      \
0655 { ((lim) >> 12) & 0xffff, (base) & 0xffff, ((base) >> 16) & 0xff,       \
0656     type, 1, dpl, 1, (uint) (lim) >> 28, 0, 0, 1, 1,                    \
0657     (uint) (base) >> 24 }
0658 
0659 #define SEG16(type, base, lim, dpl) (struct segdesc)                    \
0660 { (lim) & 0xffff, (base) & 0xffff, ((base) >> 16) & 0xff,               \
0661     type, 1, dpl, 1, (uint) (lim) >> 16, 0, 0, 1, 0,                    \
0662     (uint) (base) >> 24 }
0663 
0664 #define DPL_USER    0x3     // User DPL
0665 
0666 // Application segment type bits
0667 #define STA_X       0x8     // Executable segment
0668 #define STA_E       0x4     // Expand down (non-executable segments)
0669 #define STA_C       0x4     // Conforming code segment (executable only)
0670 #define STA_W       0x2     // Writeable (non-executable segments)
0671 #define STA_R       0x2     // Readable (executable segments)
0672 #define STA_A       0x1     // Accessed
0673 
0674 // System segment type bits
0675 #define STS_T16A    0x1     // Available 16-bit TSS
0676 #define STS_LDT     0x2     // Local Descriptor Table
0677 #define STS_T16B    0x3     // Busy 16-bit TSS
0678 #define STS_CG16    0x4     // 16-bit Call Gate
0679 #define STS_TG      0x5     // Task Gate / Coum Transmitions
0680 #define STS_IG16    0x6     // 16-bit Interrupt Gate
0681 #define STS_TG16    0x7     // 16-bit Trap Gate
0682 #define STS_T32A    0x9     // Available 32-bit TSS
0683 #define STS_T32B    0xB     // Busy 32-bit TSS
0684 #define STS_CG32    0xC     // 32-bit Call Gate
0685 #define STS_IG32    0xE     // 32-bit Interrupt Gate
0686 #define STS_TG32    0xF     // 32-bit Trap Gate
0687 
0688 // Task state segment format
0689 struct taskstate {
0690   uint link;         // Old ts selector
0691   uint esp0;         // Stack pointers and segment selectors
0692   ushort ss0;        //   after an increase in privilege level
0693   ushort padding1;
0694   uint *esp1;
0695   ushort ss1;
0696   ushort padding2;
0697   uint *esp2;
0698   ushort ss2;
0699   ushort padding3;
0700   void *cr3;         // Page directory base
0701   uint *eip;         // Saved state from last task switch
0702   uint eflags;
0703   uint eax;          // More saved state (registers)
0704   uint ecx;
0705   uint edx;
0706   uint ebx;
0707   uint *esp;
0708   uint *ebp;
0709   uint esi;
0710   uint edi;
0711   ushort es;         // Even more saved state (segment selectors)
0712   ushort padding4;
0713   ushort cs;
0714   ushort padding5;
0715   ushort ss;
0716   ushort padding6;
0717   ushort ds;
0718   ushort padding7;
0719   ushort fs;
0720   ushort padding8;
0721   ushort gs;
0722   ushort padding9;
0723   ushort ldt;
0724   ushort padding10;
0725   ushort t;          // Trap on task switch
0726   ushort iomb;       // I/O map base address
0727 };
0728 
0729 // Gate descriptors for interrupts and traps
0730 struct gatedesc {
0731   uint off_15_0 : 16;   // low 16 bits of offset in segment
0732   uint cs : 16;         // code segment selector
0733   uint args : 5;        // # args, 0 for interrupt/trap gates
0734   uint rsv1 : 3;        // reserved(should be zero I guess)
0735   uint type : 4;        // type(STS_{TG,IG32,TG32})
0736   uint s : 1;           // must be 0 (system)
0737   uint dpl : 2;         // descriptor(meaning new) privilege level
0738   uint p : 1;           // Present
0739   uint off_31_16 : 16;  // high bits of offset in segment
0740 };
0741 
0742 
0743 
0744 
0745 
0746 
0747 
0748 
0749 
0750 // Set up a normal interrupt/trap gate descriptor.
0751 // - istrap: 1 for a trap (= exception) gate, 0 for an interrupt gate.
0752 //   interrupt gate clears FL_IF, trap gate leaves FL_IF alone
0753 // - sel: Code segment selector for interrupt/trap handler
0754 // - off: Offset in code segment for interrupt/trap handler
0755 // - dpl: Descriptor Privilege Level -
0756 //        the privilege level required for software to invoke
0757 //        this interrupt/trap gate explicitly using an int instruction.
0758 #define SETGATE(gate, istrap, sel, off, d)                \
0759 {                                                         \
0760   (gate).off_15_0 = (uint) (off) & 0xffff;                \
0761   (gate).cs = (sel);                                      \
0762   (gate).args = 0;                                        \
0763   (gate).rsv1 = 0;                                        \
0764   (gate).type = (istrap) ? STS_TG32 : STS_IG32;           \
0765   (gate).s = 0;                                           \
0766   (gate).dpl = (d);                                       \
0767   (gate).p = 1;                                           \
0768   (gate).off_31_16 = (uint) (off) >> 16;                  \
0769 }
0770 
0771 
0772 
0773 
0774 
0775 
0776 
0777 
0778 
0779 
0780 
0781 
0782 
0783 
0784 
0785 
0786 
0787 
0788 
0789 
0790 
0791 
0792 
0793 
0794 
0795 
0796 
0797 
0798 
0799 
