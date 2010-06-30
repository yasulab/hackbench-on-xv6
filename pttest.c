#include "types.h"
#include "stat.h"
#include "user.h"

int g_pt;

int main(int argc, char *argv[]){
  int *pt = 10;

  if(fork()==0){
    *pt = 20;
    printf(1, "child: global = %p, %d\n", pt, *pt);
    exit();
  }
  wait();
  printf(1, "parent: global = %p, %d\n", pt, *pt);
  exit();
}

  
     
