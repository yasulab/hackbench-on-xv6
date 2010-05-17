#include "types.h"
#include "stat.h"
#include "user.h"

/* Test groups of 20 processes spraying to 20 receivers */
//#include <stdio.h>
//#include <string.h>
//#include <errno.h>
//#include <sys/types.h>
//#include <sys/socket.h>
//#include <sys/wait.h>
//#include <sys/time.h>
//#include <sys/poll.h>

/* HOW TO Piping ???:
   send:
   1. fdout = dup(1)
   2. close(1)
   recv:
   1. fdin = dup(0)
   2. close(0)
   pipe:
   pipe(fdin, fdout)
 */

#define DATASIZE 100
#define POLLIN 1
#define FREE 0
#define SENDER 1
#define RECEIVER 2
#define STDIN  0
#define STDOUT 1
#define STDERR 2
static unsigned int loops = 100;
static int use_pipes = 1; // Use Pipe mode
//static int pollfd = 0; // 0: not used, 1: used
//static unsigned int *pollfd[512];

/* Data structure descripbing a polling request. */

struct pollfd{
  int fd;              /* File descriptor to poll. */
  short int events;    /* Types of events poller cares about. */
  short int revents;   /* Types of events that actually occurred. */
}pollfd[512];

static void barf(const char *msg)
{
  printf(STDOUT, "(Error: %s)\n", msg);
  exit();
}

static void fdpair(int fds[2])
{
  if (use_pipes) {
    // TODO: Implement myPipe
    //    pipe(fds[0], fds[1]);
    if (pipe(fds) == 0)
      return;
  } else {
    // This mode would not run correctly in xv6
    //if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
    //  return;
    barf("Socket mode is running. (error)\n");
  }
  //barf("Creating fdpair");
}

/* Block until we're ready to go */
static void ready(int ready_out, int wakefd, int id, int caller)
{
  char dummy;
  // TODO: Implement myPoll function
  pollfd[id].fd = wakefd;
  pollfd[id].events = POLLIN;

  /* Tell them we're ready. */
  if (write(ready_out, &dummy, 1) != 1)
    barf("CLIENT: ready write");

  /* Wait for "GO" signal */
  //TODO: Polling should be re-implemented for xv6.
  //if (poll(&pollfd, 1, -1) != 1)
  //        barf("poll");
  if(caller == SENDER){
    while(pollfd[id].events == POLLIN);
  }else if(caller == RECEIVER){
    pollfd[id].events = FREE;
  }else{
    barf("Failed being ready.");
  }
}



/* Sender sprays loops messages down each file descriptor */
static void sender(unsigned int num_fds,
                   int out_fd[num_fds],
                   int ready_out,
                   int wakefd,
		   int id)
{
  char data[DATASIZE];
  unsigned int i, j;

  //TODO: Fix Me?
  ready(ready_out, wakefd, id, SENDER);

  /* Now pump to every receiver. */
  for (i = 0; i < loops; i++) {
    for (j = 0; j < num_fds; j++) {
      int ret, done = 0;

    again:
      ret = write(out_fd[j], data + done, sizeof(data)-done);
      if (ret < 0)
	barf("SENDER: write");
      done += ret;
      if (done < sizeof(data))
	goto again;
    }
  }
}

/* One receiver per fd */
static void receiver(unsigned int num_packets,
                     int in_fd,
                     int ready_out,
                     int wakefd,
		     int id)
{
  unsigned int i;

  /* Wait for start... */
  ready(ready_out, wakefd, id, RECEIVER);

  /* Receive them all */
  for (i = 0; i < num_packets; i++) {
    char data[DATASIZE];
    int ret, done = 0;

  again:
    ret = read(in_fd, data + done, DATASIZE - done);
    printf(STDOUT, "ret = %d\n", ret);
    if (ret < 0)
      barf("SERVER: read");
    done += ret;
    if (done < DATASIZE)
      goto again;
  }
}

/* One group of senders and receivers */
static unsigned int group(unsigned int num_fds,
                          int ready_out,
                          int wakefd)
{
  unsigned int i;
  unsigned int out_fds[num_fds];

  for (i = 0; i < num_fds; i++) {
    int fds[2];

    /* Create the pipe between client and server */
    fdpair(fds);

    /* Fork the receiver. */
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      close(fds[1]);
      receiver(num_fds*loops, fds[0], ready_out, wakefd, i);
      exit();
    }

    out_fds[i] = fds[1];
    close(fds[0]);
  }

  /* Now we have all the fds, fork the senders */
  for (i = 0; i < num_fds; i++) {
    switch (fork()) {
    case -1: barf("fork()");
    case 0:
      sender(num_fds, out_fds, ready_out, wakefd, i);
      exit();
    }
  }

  /* Close the fds we have left */
  for (i = 0; i < num_fds; i++)
    close(out_fds[i]);

  /* Return number of children to reap */
  return num_fds * 2;
}

int main(int argc, char *argv[])
{
  unsigned int i, num_groups, total_children;
  //struct timeval start, stop, diff;
  int start=0, stop=0, diff=0;
  unsigned int num_fds = 20;
  int readyfds[2], wakefds[2];
  char dummy;

  /*
    if (argv[1] && strcmp(argv[1], "-pipe") == 0) {
    use_pipes = 1;
    argc--;
    argv++;
    }
  */
  use_pipes = 1;
  argc--;
  argv++;

  //if (argc != 2 || (num_groups = atoi(argv[1])) == 0)
  //        barf("Usage: hackbench [-pipe] <num groups>\n");

  num_groups = 1; // TODO: This may seriously be considered.

  fdpair(readyfds);
  fdpair(wakefds);

  total_children = 0;
  for (i = 0; i < num_groups; i++)
    total_children += group(num_fds, readyfds[1], wakefds[0]);

  /* Wait for everyone to be ready */
  for (i = 0; i < total_children; i++)
    if (read(readyfds[0], &dummy, 1) != 1)
      barf("Reading for readyfds");

  //gettimeofday(&start, NULL);
  start = getticks();
  

  /* Kick them off */
  if (write(wakefds[1], &dummy, 1) != 1)
    barf("Writing to start them");

  /* Reap them all */
  for (i = 0; i < total_children; i++) {
    int status;
    //wait(&status); // TODO: Too Many Arguments???
    wait();
    // TODO: What's WIFEXITED ???
    //if (!WIFEXITED(status))
    //  exit();
  }
  
  stop = getticks();
  diff = stop - start;

  /* Print time... */
  printf(STDOUT, "Time: %d [ticks]\n", diff);
  exit();
}

