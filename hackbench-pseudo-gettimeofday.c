#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/poll.h>
#include <sys/stat.h>
#include <fcntl.h>

int getkiffies()
{
    char buf[64], *ptr;
    int kiffies = 0, fd; 
    
    fd = open("/proc/kiffies", O_RDONLY);
    if(fd < 0){ 
        return -1;
    }   
    if(read(fd, buf, 63) < 0){ 
        return -1;
    }   
 
    for(ptr = buf; *ptr != '\n'; ptr++){
        kiffies *= 10; 
        kiffies += *ptr - '0';
    }   
    return kiffies;
}

int pseudo_gettimeofday(struct timeval *tv, struct timezone *tz)
{
	int kiffies = getkiffies();

	/* We assume that HZ == 100. */
	tv->tv_sec = kiffies / 100;
	tv->tv_usec = (kiffies - (tv->tv_sec * 100)) * 10000;
}



