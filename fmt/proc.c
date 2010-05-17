1600 #include "types.h"
1601 #include "defs.h"
1602 #include "param.h"
1603 #include "mmu.h"
1604 #include "x86.h"
1605 #include "proc.h"
1606 #include "spinlock.h"
1607 
1608 struct spinlock proc_table_lock;
1609 
1610 struct proc proc[NPROC];
1611 static struct proc *initproc;
1612 
1613 int nextpid = 1;
1614 extern void forkret(void);
1615 extern void forkret1(struct trapframe*);
1616 
1617 void
1618 pinit(void)
1619 {
1620   initlock(&proc_table_lock, "proc_table");
1621 }
1622 
1623 // Look in the process table for an UNUSED proc.
1624 // If found, change state to EMBRYO and return it.
1625 // Otherwise return 0.
1626 static struct proc*
1627 allocproc(void)
1628 {
1629   int i;
1630   struct proc *p;
1631 
1632   acquire(&proc_table_lock);
1633   for(i = 0; i < NPROC; i++){
1634     p = &proc[i];
1635     if(p->state == UNUSED){
1636       p->state = EMBRYO;
1637       p->pid = nextpid++;
1638       release(&proc_table_lock);
1639       return p;
1640     }
1641   }
1642   release(&proc_table_lock);
1643   return 0;
1644 }
1645 
1646 
1647 
1648 
1649 
1650 // Grow current process's memory by n bytes.
1651 // Return old size on success, -1 on failure.
1652 int
1653 growproc(int n)
1654 {
1655   char *newmem, *oldmem;
1656 
1657   newmem = kalloc(cp->sz + n);
1658   if(newmem == 0)
1659     return -1;
1660   memmove(newmem, cp->mem, cp->sz);
1661   memset(newmem + cp->sz, 0, n);
1662   oldmem = cp->mem;
1663   cp->mem = newmem;
1664   kfree(oldmem, cp->sz);
1665   cp->sz += n;
1666   setupsegs(cp);
1667   return cp->sz - n;
1668 }
1669 
1670 // Set up CPU's segment descriptors and task state for a given process.
1671 // If p==0, set up for "idle" state for when scheduler() is running.
1672 void
1673 setupsegs(struct proc *p)
1674 {
1675   struct cpu *c;
1676 
1677   pushcli();
1678   c = &cpus[cpu()];
1679   c->ts.ss0 = SEG_KDATA << 3;
1680   if(p)
1681     c->ts.esp0 = (uint)(p->kstack + KSTACKSIZE);
1682   else
1683     c->ts.esp0 = 0xffffffff;
1684 
1685   c->gdt[0] = SEG_NULL;
1686   c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0x100000 + 64*1024-1, 0);
1687   c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
1688   c->gdt[SEG_TSS] = SEG16(STS_T32A, (uint)&c->ts, sizeof(c->ts)-1, 0);
1689   c->gdt[SEG_TSS].s = 0;
1690   if(p){
1691     c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, (uint)p->mem, p->sz-1, DPL_USER);
1692     c->gdt[SEG_UDATA] = SEG(STA_W, (uint)p->mem, p->sz-1, DPL_USER);
1693   } else {
1694     c->gdt[SEG_UCODE] = SEG_NULL;
1695     c->gdt[SEG_UDATA] = SEG_NULL;
1696   }
1697 
1698 
1699 
1700   lgdt(c->gdt, sizeof(c->gdt));
1701   ltr(SEG_TSS << 3);
1702   popcli();
1703 }
1704 
1705 // Create a new process copying p as the parent.
1706 // Sets up stack to return as if from system call.
1707 // Caller must set state of returned proc to RUNNABLE.
1708 struct proc*
1709 copyproc(struct proc *p)
1710 {
1711   int i;
1712   struct proc *np;
1713 
1714   // Allocate process.
1715   if((np = allocproc()) == 0)
1716     return 0;
1717 
1718   // Allocate kernel stack.
1719   if((np->kstack = kalloc(KSTACKSIZE)) == 0){
1720     np->state = UNUSED;
1721     return 0;
1722   }
1723   np->tf = (struct trapframe*)(np->kstack + KSTACKSIZE) - 1;
1724 
1725   if(p){  // Copy process state from p.
1726     np->parent = p;
1727     memmove(np->tf, p->tf, sizeof(*np->tf));
1728 
1729     np->sz = p->sz;
1730     if((np->mem = kalloc(np->sz)) == 0){
1731       kfree(np->kstack, KSTACKSIZE);
1732       np->kstack = 0;
1733       np->state = UNUSED;
1734       return 0;
1735     }
1736     memmove(np->mem, p->mem, np->sz);
1737 
1738     for(i = 0; i < NOFILE; i++)
1739       if(p->ofile[i])
1740         np->ofile[i] = filedup(p->ofile[i]);
1741     np->cwd = idup(p->cwd);
1742   }
1743 
1744   // Set up new context to start executing at forkret (see below).
1745   memset(&np->context, 0, sizeof(np->context));
1746   np->context.eip = (uint)forkret;
1747   np->context.esp = (uint)np->tf;
1748 
1749 
1750   // Clear %eax so that fork system call returns 0 in child.
1751   np->tf->eax = 0;
1752   return np;
1753 }
1754 
1755 // Set up first user process.
1756 void
1757 userinit(void)
1758 {
1759   struct proc *p;
1760   extern uchar _binary_initcode_start[], _binary_initcode_size[];
1761 
1762   p = copyproc(0);
1763   p->sz = PAGE;
1764   p->mem = kalloc(p->sz);
1765   p->cwd = namei("/");
1766   memset(p->tf, 0, sizeof(*p->tf));
1767   p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
1768   p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
1769   p->tf->es = p->tf->ds;
1770   p->tf->ss = p->tf->ds;
1771   p->tf->eflags = FL_IF;
1772   p->tf->esp = p->sz;
1773 
1774   // Make return address readable; needed for some gcc.
1775   p->tf->esp -= 4;
1776   *(uint*)(p->mem + p->tf->esp) = 0xefefefef;
1777 
1778   // On entry to user space, start executing at beginning of initcode.S.
1779   p->tf->eip = 0;
1780   memmove(p->mem, _binary_initcode_start, (int)_binary_initcode_size);
1781   safestrcpy(p->name, "initcode", sizeof(p->name));
1782   p->state = RUNNABLE;
1783 
1784   initproc = p;
1785 }
1786 
1787 // Return currently running process.
1788 struct proc*
1789 curproc(void)
1790 {
1791   struct proc *p;
1792 
1793   pushcli();
1794   p = cpus[cpu()].curproc;
1795   popcli();
1796   return p;
1797 }
1798 
1799 
1800 // Per-CPU process scheduler.
1801 // Each CPU calls scheduler() after setting itself up.
1802 // Scheduler never returns.  It loops, doing:
1803 //  - choose a process to run
1804 //  - swtch to start running that process
1805 //  - eventually that process transfers control
1806 //      via swtch back to the scheduler.
1807 void
1808 scheduler(void)
1809 {
1810   struct proc *p;
1811   struct cpu *c;
1812   int i;
1813 
1814   c = &cpus[cpu()];
1815   for(;;){
1816     // Enable interrupts on this processor.
1817     sti();
1818 
1819     // Loop over process table looking for process to run.
1820     acquire(&proc_table_lock);
1821     for(i = 0; i < NPROC; i++){
1822       p = &proc[i];
1823       if(p->state != RUNNABLE)
1824         continue;
1825 
1826       // Switch to chosen process.  It is the process's job
1827       // to release proc_table_lock and then reacquire it
1828       // before jumping back to us.
1829       c->curproc = p;
1830       setupsegs(p);
1831       p->state = RUNNING;
1832       swtch(&c->context, &p->context);
1833 
1834       // Process is done running for now.
1835       // It should have changed its p->state before coming back.
1836       c->curproc = 0;
1837       setupsegs(0);
1838     }
1839     release(&proc_table_lock);
1840 
1841   }
1842 }
1843 
1844 
1845 
1846 
1847 
1848 
1849 
1850 // Enter scheduler.  Must already hold proc_table_lock
1851 // and have changed curproc[cpu()]->state.
1852 void
1853 sched(void)
1854 {
1855   if(read_eflags()&FL_IF)
1856     panic("sched interruptible");
1857   if(cp->state == RUNNING)
1858     panic("sched running");
1859   if(!holding(&proc_table_lock))
1860     panic("sched proc_table_lock");
1861   if(cpus[cpu()].ncli != 1)
1862     panic("sched locks");
1863 
1864   swtch(&cp->context, &cpus[cpu()].context);
1865 }
1866 
1867 // Give up the CPU for one scheduling round.
1868 void
1869 yield(void)
1870 {
1871   acquire(&proc_table_lock);
1872   cp->state = RUNNABLE;
1873   sched();
1874   release(&proc_table_lock);
1875 }
1876 
1877 // A fork child's very first scheduling by scheduler()
1878 // will swtch here.  "Return" to user space.
1879 void
1880 forkret(void)
1881 {
1882   // Still holding proc_table_lock from scheduler.
1883   release(&proc_table_lock);
1884 
1885   // Jump into assembly, never to return.
1886   forkret1(cp->tf);
1887 }
1888 
1889 
1890 
1891 
1892 
1893 
1894 
1895 
1896 
1897 
1898 
1899 
1900 // Atomically release lock and sleep on chan.
1901 // Reacquires lock when reawakened.
1902 void
1903 sleep(void *chan, struct spinlock *lk)
1904 {
1905   if(cp == 0)
1906     panic("sleep");
1907 
1908   if(lk == 0)
1909     panic("sleep without lk");
1910 
1911   // Must acquire proc_table_lock in order to
1912   // change p->state and then call sched.
1913   // Once we hold proc_table_lock, we can be
1914   // guaranteed that we won't miss any wakeup
1915   // (wakeup runs with proc_table_lock locked),
1916   // so it's okay to release lk.
1917   if(lk != &proc_table_lock){
1918     acquire(&proc_table_lock);
1919     release(lk);
1920   }
1921 
1922   // Go to sleep.
1923   cp->chan = chan;
1924   cp->state = SLEEPING;
1925   sched();
1926 
1927   // Tidy up.
1928   cp->chan = 0;
1929 
1930   // Reacquire original lock.
1931   if(lk != &proc_table_lock){
1932     release(&proc_table_lock);
1933     acquire(lk);
1934   }
1935 }
1936 
1937 // Wake up all processes sleeping on chan.
1938 // Proc_table_lock must be held.
1939 static void
1940 wakeup1(void *chan)
1941 {
1942   struct proc *p;
1943 
1944   for(p = proc; p < &proc[NPROC]; p++)
1945     if(p->state == SLEEPING && p->chan == chan)
1946       p->state = RUNNABLE;
1947 }
1948 
1949 
1950 // Wake up all processes sleeping on chan.
1951 // Proc_table_lock is acquired and released.
1952 void
1953 wakeup(void *chan)
1954 {
1955   acquire(&proc_table_lock);
1956   wakeup1(chan);
1957   release(&proc_table_lock);
1958 }
1959 
1960 // Kill the process with the given pid.
1961 // Process won't actually exit until it returns
1962 // to user space (see trap in trap.c).
1963 int
1964 kill(int pid)
1965 {
1966   struct proc *p;
1967 
1968   acquire(&proc_table_lock);
1969   for(p = proc; p < &proc[NPROC]; p++){
1970     if(p->pid == pid){
1971       p->killed = 1;
1972       // Wake process from sleep if necessary.
1973       if(p->state == SLEEPING)
1974         p->state = RUNNABLE;
1975       release(&proc_table_lock);
1976       return 0;
1977     }
1978   }
1979   release(&proc_table_lock);
1980   return -1;
1981 }
1982 
1983 // Exit the current process.  Does not return.
1984 // Exited processes remain in the zombie state
1985 // until their parent calls wait() to find out they exited.
1986 void
1987 exit(void)
1988 {
1989   struct proc *p;
1990   int fd;
1991 
1992   if(cp == initproc)
1993     panic("init exiting");
1994 
1995   // Close all open files.
1996   for(fd = 0; fd < NOFILE; fd++){
1997     if(cp->ofile[fd]){
1998       fileclose(cp->ofile[fd]);
1999       cp->ofile[fd] = 0;
2000     }
2001   }
2002 
2003   iput(cp->cwd);
2004   cp->cwd = 0;
2005 
2006   acquire(&proc_table_lock);
2007 
2008   // Parent might be sleeping in wait().
2009   wakeup1(cp->parent);
2010 
2011   // Pass abandoned children to init.
2012   for(p = proc; p < &proc[NPROC]; p++){
2013     if(p->parent == cp){
2014       p->parent = initproc;
2015       if(p->state == ZOMBIE)
2016         wakeup1(initproc);
2017     }
2018   }
2019 
2020   // Jump into the scheduler, never to return.
2021   cp->killed = 0;
2022   cp->state = ZOMBIE;
2023   sched();
2024   panic("zombie exit");
2025 }
2026 
2027 // Wait for a child process to exit and return its pid.
2028 // Return -1 if this process has no children.
2029 int
2030 wait(void)
2031 {
2032   struct proc *p;
2033   int i, havekids, pid;
2034 
2035   acquire(&proc_table_lock);
2036   for(;;){
2037     // Scan through table looking for zombie children.
2038     havekids = 0;
2039     for(i = 0; i < NPROC; i++){
2040       p = &proc[i];
2041       if(p->state == UNUSED)
2042         continue;
2043       if(p->parent == cp){
2044         if(p->state == ZOMBIE){
2045           // Found one.
2046           kfree(p->mem, p->sz);
2047           kfree(p->kstack, KSTACKSIZE);
2048           pid = p->pid;
2049           p->state = UNUSED;
2050           p->pid = 0;
2051           p->parent = 0;
2052           p->name[0] = 0;
2053           release(&proc_table_lock);
2054           return pid;
2055         }
2056         havekids = 1;
2057       }
2058     }
2059 
2060     // No point waiting if we don't have any children.
2061     if(!havekids || cp->killed){
2062       release(&proc_table_lock);
2063       return -1;
2064     }
2065 
2066     // Wait for children to exit.  (See wakeup1 call in proc_exit.)
2067     sleep(cp, &proc_table_lock);
2068   }
2069 }
2070 
2071 // Print a process listing to console.  For debugging.
2072 // Runs when user types ^P on console.
2073 // No lock to avoid wedging a stuck machine further.
2074 void
2075 procdump(void)
2076 {
2077   static char *states[] = {
2078   [UNUSED]    "unused",
2079   [EMBRYO]    "embryo",
2080   [SLEEPING]  "sleep ",
2081   [RUNNABLE]  "runble",
2082   [RUNNING]   "run   ",
2083   [ZOMBIE]    "zombie"
2084   };
2085   int i, j;
2086   struct proc *p;
2087   char *state;
2088   uint pc[10];
2089 
2090   for(i = 0; i < NPROC; i++){
2091     p = &proc[i];
2092     if(p->state == UNUSED)
2093       continue;
2094     if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
2095       state = states[p->state];
2096     else
2097       state = "???";
2098     cprintf("%d %s %s", p->pid, state, p->name);
2099     if(p->state == SLEEPING){
2100       getcallerpcs((uint*)p->context.ebp+2, pc);
2101       for(j=0; j<10 && pc[j] != 0; j++)
2102         cprintf(" %p", pc[j]);
2103     }
2104     cprintf("\n");
2105   }
2106 }
2107 
2108 
2109 
2110 
2111 
2112 
2113 
2114 
2115 
2116 
2117 
2118 
2119 
2120 
2121 
2122 
2123 
2124 
2125 
2126 
2127 
2128 
2129 
2130 
2131 
2132 
2133 
2134 
2135 
2136 
2137 
2138 
2139 
2140 
2141 
2142 
2143 
2144 
2145 
2146 
2147 
2148 
2149 
