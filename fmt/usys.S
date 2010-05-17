6700 #include "syscall.h"
6701 #include "traps.h"
6702 
6703 #define STUB(name) \
6704   .globl name; \
6705   name: \
6706     movl $SYS_ ## name, %eax; \
6707     int $T_SYSCALL; \
6708     ret
6709 
6710 STUB(fork)
6711 STUB(exit)
6712 STUB(wait)
6713 STUB(pipe)
6714 STUB(read)
6715 STUB(write)
6716 STUB(close)
6717 STUB(kill)
6718 STUB(exec)
6719 STUB(open)
6720 STUB(mknod)
6721 STUB(unlink)
6722 STUB(fstat)
6723 STUB(link)
6724 STUB(mkdir)
6725 STUB(chdir)
6726 STUB(dup)
6727 STUB(getpid)
6728 STUB(sbrk)
6729 STUB(sleep)
6730 
6731 
6732 
6733 
6734 
6735 
6736 
6737 
6738 
6739 
6740 
6741 
6742 
6743 
6744 
6745 
6746 
6747 
6748 
6749 
