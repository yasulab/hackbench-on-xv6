2500 #include "types.h"
2501 #include "defs.h"
2502 #include "param.h"
2503 #include "mmu.h"
2504 #include "proc.h"
2505 #include "x86.h"
2506 #include "traps.h"
2507 #include "spinlock.h"
2508 
2509 // Interrupt descriptor table (shared by all CPUs).
2510 struct gatedesc idt[256];
2511 extern uint vectors[];  // in vectors.S: array of 256 entry pointers
2512 struct spinlock tickslock;
2513 int ticks;
2514 
2515 void
2516 tvinit(void)
2517 {
2518   int i;
2519 
2520   for(i = 0; i < 256; i++)
2521     SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
2522   SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
2523 
2524   initlock(&tickslock, "time");
2525 }
2526 
2527 void
2528 idtinit(void)
2529 {
2530   lidt(idt, sizeof(idt));
2531 }
2532 
2533 void
2534 trap(struct trapframe *tf)
2535 {
2536   if(tf->trapno == T_SYSCALL){
2537     if(cp->killed)
2538       exit();
2539     cp->tf = tf;
2540     syscall();
2541     if(cp->killed)
2542       exit();
2543     return;
2544   }
2545 
2546   switch(tf->trapno){
2547   case IRQ_OFFSET + IRQ_TIMER:
2548     if(cpu() == 0){
2549       acquire(&tickslock);
2550       ticks++;
2551       wakeup(&ticks);
2552       release(&tickslock);
2553     }
2554     lapic_eoi();
2555     break;
2556   case IRQ_OFFSET + IRQ_IDE:
2557     ide_intr();
2558     lapic_eoi();
2559     break;
2560   case IRQ_OFFSET + IRQ_KBD:
2561     kbd_intr();
2562     lapic_eoi();
2563     break;
2564   case IRQ_OFFSET + IRQ_SPURIOUS:
2565     cprintf("cpu%d: spurious interrupt at %x:%x\n",
2566             cpu(), tf->cs, tf->eip);
2567     lapic_eoi();
2568     break;
2569 
2570   default:
2571     if(cp == 0 || (tf->cs&3) == 0){
2572       // In kernel, it must be our mistake.
2573       cprintf("unexpected trap %d from cpu %d eip %x\n",
2574               tf->trapno, cpu(), tf->eip);
2575       panic("trap");
2576     }
2577     // In user space, assume process misbehaved.
2578     cprintf("pid %d %s: trap %d err %d on cpu %d eip %x -- kill proc\n",
2579             cp->pid, cp->name, tf->trapno, tf->err, cpu(), tf->eip);
2580     cp->killed = 1;
2581   }
2582 
2583   // Force process exit if it has been killed and is in user space.
2584   // (If it is still executing in the kernel, let it keep running
2585   // until it gets to the regular system call return.)
2586   if(cp && cp->killed && (tf->cs&3) == DPL_USER)
2587     exit();
2588 
2589   // Force process to give up CPU on clock tick.
2590   // If interrupts were on while locks held, would need to check nlock.
2591   if(cp && cp->state == RUNNING && tf->trapno == IRQ_OFFSET+IRQ_TIMER)
2592     yield();
2593 }
2594 
2595 
2596 
2597 
2598 
2599 
