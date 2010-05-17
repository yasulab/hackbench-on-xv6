5050 #include "types.h"
5051 #include "defs.h"
5052 #include "param.h"
5053 #include "mmu.h"
5054 #include "proc.h"
5055 #include "file.h"
5056 #include "spinlock.h"
5057 
5058 #define PIPESIZE 512
5059 
5060 struct pipe {
5061   int readopen;   // read fd is still open
5062   int writeopen;  // write fd is still open
5063   int writep;     // next index to write
5064   int readp;      // next index to read
5065   struct spinlock lock;
5066   char data[PIPESIZE];
5067 };
5068 
5069 int
5070 pipealloc(struct file **f0, struct file **f1)
5071 {
5072   struct pipe *p;
5073 
5074   p = 0;
5075   *f0 = *f1 = 0;
5076   if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
5077     goto bad;
5078   if((p = (struct pipe*)kalloc(PAGE)) == 0)
5079     goto bad;
5080   p->readopen = 1;
5081   p->writeopen = 1;
5082   p->writep = 0;
5083   p->readp = 0;
5084   initlock(&p->lock, "pipe");
5085   (*f0)->type = FD_PIPE;
5086   (*f0)->readable = 1;
5087   (*f0)->writable = 0;
5088   (*f0)->pipe = p;
5089   (*f1)->type = FD_PIPE;
5090   (*f1)->readable = 0;
5091   (*f1)->writable = 1;
5092   (*f1)->pipe = p;
5093   return 0;
5094 
5095  bad:
5096   if(p)
5097     kfree((char*)p, PAGE);
5098   if(*f0){
5099     (*f0)->type = FD_NONE;
5100     fileclose(*f0);
5101   }
5102   if(*f1){
5103     (*f1)->type = FD_NONE;
5104     fileclose(*f1);
5105   }
5106   return -1;
5107 }
5108 
5109 void
5110 pipeclose(struct pipe *p, int writable)
5111 {
5112   acquire(&p->lock);
5113   if(writable){
5114     p->writeopen = 0;
5115     wakeup(&p->readp);
5116   } else {
5117     p->readopen = 0;
5118     wakeup(&p->writep);
5119   }
5120   release(&p->lock);
5121 
5122   if(p->readopen == 0 && p->writeopen == 0)
5123     kfree((char*)p, PAGE);
5124 }
5125 
5126 int
5127 pipewrite(struct pipe *p, char *addr, int n)
5128 {
5129   int i;
5130 
5131   acquire(&p->lock);
5132   for(i = 0; i < n; i++){
5133     while(((p->writep + 1) % PIPESIZE) == p->readp){
5134       if(p->readopen == 0 || cp->killed){
5135         release(&p->lock);
5136         return -1;
5137       }
5138       wakeup(&p->readp);
5139       sleep(&p->writep, &p->lock);
5140     }
5141     p->data[p->writep] = addr[i];
5142     p->writep = (p->writep + 1) % PIPESIZE;
5143   }
5144   wakeup(&p->readp);
5145   release(&p->lock);
5146   return i;
5147 }
5148 
5149 
5150 int
5151 piperead(struct pipe *p, char *addr, int n)
5152 {
5153   int i;
5154 
5155   acquire(&p->lock);
5156   while(p->readp == p->writep && p->writeopen){
5157     if(cp->killed){
5158       release(&p->lock);
5159       return -1;
5160     }
5161     sleep(&p->readp, &p->lock);
5162   }
5163   for(i = 0; i < n; i++){
5164     if(p->readp == p->writep)
5165       break;
5166     addr[i] = p->data[p->readp];
5167     p->readp = (p->readp + 1) % PIPESIZE;
5168   }
5169   wakeup(&p->writep);
5170   release(&p->lock);
5171   return i;
5172 }
5173 
5174 
5175 
5176 
5177 
5178 
5179 
5180 
5181 
5182 
5183 
5184 
5185 
5186 
5187 
5188 
5189 
5190 
5191 
5192 
5193 
5194 
5195 
5196 
5197 
5198 
5199 
