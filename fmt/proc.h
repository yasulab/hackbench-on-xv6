1500 // Segments in proc->gdt
1501 #define SEG_KCODE 1  // kernel code
1502 #define SEG_KDATA 2  // kernel data+stack
1503 #define SEG_UCODE 3
1504 #define SEG_UDATA 4
1505 #define SEG_TSS   5  // this process's task state
1506 #define NSEGS     6
1507 
1508 // Saved registers for kernel context switches.
1509 // Don't need to save all the %fs etc. segment registers,
1510 // because they are constant across kernel contexts.
1511 // Save all the regular registers so we don't need to care
1512 // which are caller save, but not the return register %eax.
1513 // (Not saving %eax just simplifies the switching code.)
1514 // The layout of context must match code in swtch.S.
1515 struct context {
1516   int eip;
1517   int esp;
1518   int ebx;
1519   int ecx;
1520   int edx;
1521   int esi;
1522   int edi;
1523   int ebp;
1524 };
1525 
1526 enum proc_state { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };
1527 
1528 // Per-process state
1529 struct proc {
1530   char *mem;                // Start of process memory (kernel address)
1531   uint sz;                  // Size of process memory (bytes)
1532   char *kstack;             // Bottom of kernel stack for this process
1533   enum proc_state state;    // Process state
1534   int pid;                  // Process ID
1535   struct proc *parent;      // Parent process
1536   void *chan;               // If non-zero, sleeping on chan
1537   int killed;               // If non-zero, have been killed
1538   struct file *ofile[NOFILE];  // Open files
1539   struct inode *cwd;        // Current directory
1540   struct context context;   // Switch here to run process
1541   struct trapframe *tf;     // Trap frame for current interrupt
1542   char name[16];            // Process name (debugging)
1543 };
1544 
1545 
1546 
1547 
1548 
1549 
1550 // Process memory is laid out contiguously, low addresses first:
1551 //   text
1552 //   original data and bss
1553 //   fixed-size stack
1554 //   expandable heap
1555 
1556 // Per-CPU state
1557 struct cpu {
1558   uchar apicid;               // Local APIC ID
1559   struct proc *curproc;       // Process currently running.
1560   struct context context;     // Switch here to enter scheduler
1561   struct taskstate ts;        // Used by x86 to find stack for interrupt
1562   struct segdesc gdt[NSEGS];  // x86 global descriptor table
1563   volatile uint booted;        // Has the CPU started?
1564   int ncli;                   // Depth of pushcli nesting.
1565   int intena;                 // Were interrupts enabled before pushcli?
1566 };
1567 
1568 extern struct cpu cpus[NCPU];
1569 extern int ncpu;
1570 
1571 // "cp" is a short alias for curproc().
1572 // It gets used enough to make this worthwhile.
1573 #define cp curproc()
1574 
1575 
1576 
1577 
1578 
1579 
1580 
1581 
1582 
1583 
1584 
1585 
1586 
1587 
1588 
1589 
1590 
1591 
1592 
1593 
1594 
1595 
1596 
1597 
1598 
1599 
