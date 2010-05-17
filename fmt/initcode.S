6600 # Initial process execs /init.
6601 
6602 #include "syscall.h"
6603 #include "traps.h"
6604 
6605 # exec(init, argv)
6606 .globl start
6607 start:
6608   pushl $argv
6609   pushl $init
6610   pushl $0
6611   movl $SYS_exec, %eax
6612   int $T_SYSCALL
6613 
6614 # for(;;) exit();
6615 exit:
6616   movl $SYS_exit, %eax
6617   int $T_SYSCALL
6618   jmp exit
6619 
6620 # char init[] = "/init\0";
6621 init:
6622   .string "/init\0"
6623 
6624 # char *argv[] = { init, 0 };
6625 .p2align 2
6626 argv:
6627   .long init
6628   .long 0
6629 
6630 
6631 
6632 
6633 
6634 
6635 
6636 
6637 
6638 
6639 
6640 
6641 
6642 
6643 
6644 
6645 
6646 
6647 
6648 
6649 
