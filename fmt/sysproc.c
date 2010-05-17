2800 #include "types.h"
2801 #include "defs.h"
2802 #include "param.h"
2803 #include "mmu.h"
2804 #include "proc.h"
2805 
2806 int
2807 sys_fork(void)
2808 {
2809   int pid;
2810   struct proc *np;
2811 
2812   if((np = copyproc(cp)) == 0)
2813     return -1;
2814   pid = np->pid;
2815   np->state = RUNNABLE;
2816   return pid;
2817 }
2818 
2819 int
2820 sys_exit(void)
2821 {
2822   exit();
2823   return 0;  // not reached
2824 }
2825 
2826 int
2827 sys_wait(void)
2828 {
2829   return wait();
2830 }
2831 
2832 int
2833 sys_kill(void)
2834 {
2835   int pid;
2836 
2837   if(argint(0, &pid) < 0)
2838     return -1;
2839   return kill(pid);
2840 }
2841 
2842 int
2843 sys_getpid(void)
2844 {
2845   return cp->pid;
2846 }
2847 
2848 
2849 
2850 int
2851 sys_sbrk(void)
2852 {
2853   int addr;
2854   int n;
2855 
2856   if(argint(0, &n) < 0)
2857     return -1;
2858   if((addr = growproc(n)) < 0)
2859     return -1;
2860   return addr;
2861 }
2862 
2863 int
2864 sys_sleep(void)
2865 {
2866   int n, ticks0;
2867 
2868   if(argint(0, &n) < 0)
2869     return -1;
2870   acquire(&tickslock);
2871   ticks0 = ticks;
2872   while(ticks - ticks0 < n){
2873     if(cp->killed){
2874       release(&tickslock);
2875       return -1;
2876     }
2877     sleep(&ticks, &tickslock);
2878   }
2879   release(&tickslock);
2880   return 0;
2881 }
2882 
2883 
2884 
2885 
2886 
2887 
2888 
2889 
2890 
2891 
2892 
2893 
2894 
2895 
2896 
2897 
2898 
2899 
