#include "types.h"
#include "stat.h"
//#include "defs.h"
#include "user.h"

int main(int argc, char *argv[]){
  int i = getticks();
  //asm volatile();

  printf(1, "%d\n", i);
  exit();
}
