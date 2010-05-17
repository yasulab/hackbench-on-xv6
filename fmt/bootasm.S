0900 #include "asm.h"
0901 
0902 # Start the first CPU: switch to 32-bit protected mode, jump into C.
0903 # The BIOS loads this code from the first sector of the hard disk into
0904 # memory at physical address 0x7c00 and starts executing in real mode
0905 # with %cs=0 %ip=7c00.
0906 
0907 .set PROT_MODE_CSEG, 0x8         # kernel code segment selector
0908 .set PROT_MODE_DSEG, 0x10        # kernel data segment selector
0909 .set CR0_PE_ON,      0x1         # protected mode enable flag
0910 
0911 .globl start
0912 start:
0913   .code16                     # Assemble for 16-bit mode
0914   cli                         # Disable interrupts
0915   cld                         # String operations increment
0916 
0917   # Set up the important data segment registers (DS, ES, SS).
0918   xorw    %ax,%ax             # Segment number zero
0919   movw    %ax,%ds             # -> Data Segment
0920   movw    %ax,%es             # -> Extra Segment
0921   movw    %ax,%ss             # -> Stack Segment
0922 
0923   # Enable A20:
0924   #   For backwards compatibility with the earliest PCs, physical
0925   #   address line 20 is tied low, so that addresses higher than
0926   #   1MB wrap around to zero by default.  This code undoes this.
0927 seta20.1:
0928   inb     $0x64,%al               # Wait for not busy
0929   testb   $0x2,%al
0930   jnz     seta20.1
0931 
0932   movb    $0xd1,%al               # 0xd1 -> port 0x64
0933   outb    %al,$0x64
0934 
0935 seta20.2:
0936   inb     $0x64,%al               # Wait for not busy
0937   testb   $0x2,%al
0938   jnz     seta20.2
0939 
0940   movb    $0xdf,%al               # 0xdf -> port 0x60
0941   outb    %al,$0x60
0942 
0943   # Switch from real to protected mode, using a bootstrap GDT
0944   # and segment translation that makes virtual addresses
0945   # identical to physical addresses, so that the
0946   # effective memory map does not change during the switch.
0947   lgdt    gdtdesc
0948   movl    %cr0, %eax
0949   orl     $CR0_PE_ON, %eax
0950   movl    %eax, %cr0
0951 
0952   # Jump to next instruction, but in 32-bit code segment.
0953   # Switches processor into 32-bit mode.
0954   ljmp    $PROT_MODE_CSEG, $protcseg
0955 
0956   .code32                     # Assemble for 32-bit mode
0957 protcseg:
0958   # Set up the protected-mode data segment registers
0959   movw    $PROT_MODE_DSEG, %ax    # Our data segment selector
0960   movw    %ax, %ds                # -> DS: Data Segment
0961   movw    %ax, %es                # -> ES: Extra Segment
0962   movw    %ax, %fs                # -> FS
0963   movw    %ax, %gs                # -> GS
0964   movw    %ax, %ss                # -> SS: Stack Segment
0965 
0966   # Set up the stack pointer and call into C.
0967   movl    $start, %esp
0968   call    bootmain
0969 
0970   # If bootmain returns (it shouldn't), loop.
0971 spin:
0972   jmp     spin
0973 
0974 # Bootstrap GDT
0975 .p2align 2                                # force 4 byte alignment
0976 gdt:
0977   SEG_NULLASM                             # null seg
0978   SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)   # code seg
0979   SEG_ASM(STA_W, 0x0, 0xffffffff)         # data seg
0980 
0981 gdtdesc:
0982   .word   0x17                            # sizeof(gdt) - 1
0983   .long   gdt                             # address gdt
0984 
0985 
0986 
0987 
0988 
0989 
0990 
0991 
0992 
0993 
0994 
0995 
0996 
0997 
0998 
0999 
