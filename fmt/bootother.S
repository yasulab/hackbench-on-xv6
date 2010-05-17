1000 #include "asm.h"
1001 
1002 # Start an Application Processor. This must be placed on a 4KB boundary
1003 # somewhere in the 1st MB of conventional memory (APBOOTSTRAP). However,
1004 # due to some shortcuts below it's restricted further to within the 1st
1005 # 64KB. The AP starts in real-mode, with
1006 #   CS selector set to the startup memory address/16;
1007 #   CS base set to startup memory address;
1008 #   CS limit set to 64KB;
1009 #   CPL and IP set to 0.
1010 #
1011 # Bootothers (in main.c) starts each non-boot CPU in turn.
1012 # It puts the correct %esp in start-4,
1013 # and the place to jump to in start-8.
1014 #
1015 # This code is identical to bootasm.S except:
1016 #   - it does not need to enable A20
1017 #   - it uses the address at start-4 for the %esp
1018 #   - it jumps to the address at start-8 instead of calling bootmain
1019 
1020 .set PROT_MODE_CSEG, 0x8         # kernel code segment selector
1021 .set PROT_MODE_DSEG, 0x10        # kernel data segment selector
1022 .set CR0_PE_ON,      0x1         # protected mode enable flag
1023 
1024 .globl start
1025 start:
1026   .code16                     # Assemble for 16-bit mode
1027   cli                         # Disable interrupts
1028   cld                         # String operations increment
1029 
1030   # Set up the important data segment registers (DS, ES, SS).
1031   xorw    %ax,%ax             # Segment number zero
1032   movw    %ax,%ds             # -> Data Segment
1033   movw    %ax,%es             # -> Extra Segment
1034   movw    %ax,%ss             # -> Stack Segment
1035 
1036   # Switch from real to protected mode, using a bootstrap GDT
1037   # and segment translation that makes virtual addresses
1038   # identical to their physical addresses, so that the
1039   # effective memory map does not change during the switch.
1040   lgdt    gdtdesc
1041   movl    %cr0, %eax
1042   orl     $CR0_PE_ON, %eax
1043   movl    %eax, %cr0
1044 
1045   # Jump to next instruction, but in 32-bit code segment.
1046   # Switches processor into 32-bit mode.
1047   ljmp    $PROT_MODE_CSEG, $protcseg
1048 
1049 
1050   .code32                     # Assemble for 32-bit mode
1051 protcseg:
1052   # Set up the protected-mode data segment registers
1053   movw    $PROT_MODE_DSEG, %ax    # Our data segment selector
1054   movw    %ax, %ds                # -> DS: Data Segment
1055   movw    %ax, %es                # -> ES: Extra Segment
1056   movw    %ax, %fs                # -> FS
1057   movw    %ax, %gs                # -> GS
1058   movw    %ax, %ss                # -> SS: Stack Segment
1059 
1060   movl    start-4, %esp
1061   movl    start-8, %eax
1062   jmp     *%eax
1063 
1064 # Bootstrap GDT
1065 .p2align 2                                # force 4 byte alignment
1066 gdt:
1067   SEG_NULLASM                             # null seg
1068   SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)   # code seg
1069   SEG_ASM(STA_W, 0x0, 0xffffffff)         # data seg
1070 
1071 gdtdesc:
1072   .word   0x17                            # sizeof(gdt) - 1
1073   .long   gdt                             # address gdt
1074 
1075 
1076 
1077 
1078 
1079 
1080 
1081 
1082 
1083 
1084 
1085 
1086 
1087 
1088 
1089 
1090 
1091 
1092 
1093 
1094 
1095 
1096 
1097 
1098 
1099 
