0550 //
0551 // assembler macros to create x86 segments
0552 //
0553 
0554 #define SEG_NULLASM                                             \
0555         .word 0, 0;                                             \
0556         .byte 0, 0, 0, 0
0557 
0558 #define SEG_ASM(type,base,lim)                                  \
0559         .word (((lim) >> 12) & 0xffff), ((base) & 0xffff);      \
0560         .byte (((base) >> 16) & 0xff), (0x90 | (type)),         \
0561                 (0xC0 | (((lim) >> 28) & 0xf)), (((base) >> 24) & 0xff)
0562 
0563 #define STA_X     0x8       // Executable segment
0564 #define STA_E     0x4       // Expand down (non-executable segments)
0565 #define STA_C     0x4       // Conforming code segment (executable only)
0566 #define STA_W     0x2       // Writeable (non-executable segments)
0567 #define STA_R     0x2       // Readable (executable segments)
0568 #define STA_A     0x1       // Accessed
0569 
0570 
0571 
0572 
0573 
0574 
0575 
0576 
0577 
0578 
0579 
0580 
0581 
0582 
0583 
0584 
0585 
0586 
0587 
0588 
0589 
0590 
0591 
0592 
0593 
0594 
0595 
0596 
0597 
0598 
0599 
