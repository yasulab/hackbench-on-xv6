6650 // init: The initial user-level program
6651 
6652 #include "types.h"
6653 #include "stat.h"
6654 #include "user.h"
6655 #include "fcntl.h"
6656 
6657 char *sh_args[] = { "sh", 0 };
6658 
6659 int
6660 main(void)
6661 {
6662   int pid, wpid;
6663 
6664   if(open("console", O_RDWR) < 0){
6665     mknod("console", 1, 1);
6666     open("console", O_RDWR);
6667   }
6668   dup(0);  // stdout
6669   dup(0);  // stderr
6670 
6671   for(;;){
6672     printf(1, "init: starting sh\n");
6673     pid = fork();
6674     if(pid < 0){
6675       printf(1, "init: fork failed\n");
6676       exit();
6677     }
6678     if(pid == 0){
6679       exec("sh", sh_args);
6680       printf(1, "init: exec sh failed\n");
6681       exit();
6682     }
6683     while((wpid=wait()) >= 0 && wpid != pid)
6684       printf(1, "zombie!\n");
6685   }
6686 }
6687 
6688 
6689 
6690 
6691 
6692 
6693 
6694 
6695 
6696 
6697 
6698 
6699 
