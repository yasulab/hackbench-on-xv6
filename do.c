#include "types.h"
#include "stat.h"
#include "user.h"

#define STDOUT 1
#define STDIN 0
#define STDERR 2
#define COMMAND 1

int g_pt;

static void barf(const char *msg){
  printf(STDOUT, "(Error: %s)\n", msg);
  exit();
}

void pttest(){
  int *pt = 10;
  if(fork()==0){
    *pt = 20;
    printf(1, "child: global = %p, %d\n", pt, *pt);
    exit();
  }
  wait();
  printf(1, "parent: global = %p, %d\n", pt, *pt);
}

void testticks(){
  int i = getticks();
  //asm volatile();

  printf(1, "%d\n", i);
}

void pipetest(){
  int fds[2];

  if(pipe(fds) == 0){
    
  }else{
    printf(STDOUT, "Pipe Error.\n");
  }

  switch(fork()){
  case -1: barf("fork()");

}

int main(int argc, char *argv[]){
  if(argc != 2){
    printf(STDOUT, "usage: '$ do PROGRAM_NAME\n", argc);
    exit();   
  }
  printf(STDOUT, "Command = %s\n", argv[COMMAND]);
  if(!(strcmp(argv[COMMAND], "pttest"))){
    pttest();
  }else if(!(strcmp(argv[COMMAND], "testticks"))){
    testticks();
  }else{
    printf(STDOUT, "'%s' is an unknown command\n", argv[COMMAND]);
  }
}

