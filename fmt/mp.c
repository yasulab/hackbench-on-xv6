5400 // Multiprocessor bootstrap.
5401 // Search memory for MP description structures.
5402 // http://developer.intel.com/design/pentium/datashts/24201606.pdf
5403 
5404 #include "types.h"
5405 #include "defs.h"
5406 #include "param.h"
5407 #include "mp.h"
5408 #include "x86.h"
5409 #include "mmu.h"
5410 #include "proc.h"
5411 
5412 struct cpu cpus[NCPU];
5413 static struct cpu *bcpu;
5414 int ismp;
5415 int ncpu;
5416 uchar ioapic_id;
5417 
5418 int
5419 mp_bcpu(void)
5420 {
5421   return bcpu-cpus;
5422 }
5423 
5424 static uchar
5425 sum(uchar *addr, int len)
5426 {
5427   int i, sum;
5428 
5429   sum = 0;
5430   for(i=0; i<len; i++)
5431     sum += addr[i];
5432   return sum;
5433 }
5434 
5435 // Look for an MP structure in the len bytes at addr.
5436 static struct mp*
5437 mp_search1(uchar *addr, int len)
5438 {
5439   uchar *e, *p;
5440 
5441   e = addr+len;
5442   for(p = addr; p < e; p += sizeof(struct mp))
5443     if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
5444       return (struct mp*)p;
5445   return 0;
5446 }
5447 
5448 
5449 
5450 // Search for the MP Floating Pointer Structure, which according to the
5451 // spec is in one of the following three locations:
5452 // 1) in the first KB of the EBDA;
5453 // 2) in the last KB of system base memory;
5454 // 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
5455 static struct mp*
5456 mp_search(void)
5457 {
5458   uchar *bda;
5459   uint p;
5460   struct mp *mp;
5461 
5462   bda = (uchar*)0x400;
5463   if((p = ((bda[0x0F]<<8)|bda[0x0E]) << 4)){
5464     if((mp = mp_search1((uchar*)p, 1024)))
5465       return mp;
5466   } else {
5467     p = ((bda[0x14]<<8)|bda[0x13])*1024;
5468     if((mp = mp_search1((uchar*)p-1024, 1024)))
5469       return mp;
5470   }
5471   return mp_search1((uchar*)0xF0000, 0x10000);
5472 }
5473 
5474 // Search for an MP configuration table.  For now,
5475 // don't accept the default configurations (physaddr == 0).
5476 // Check for correct signature, calculate the checksum and,
5477 // if correct, check the version.
5478 // To do: check extended table checksum.
5479 static struct mpconf*
5480 mp_config(struct mp **pmp)
5481 {
5482   struct mpconf *conf;
5483   struct mp *mp;
5484 
5485   if((mp = mp_search()) == 0 || mp->physaddr == 0)
5486     return 0;
5487   conf = (struct mpconf*)mp->physaddr;
5488   if(memcmp(conf, "PCMP", 4) != 0)
5489     return 0;
5490   if(conf->version != 1 && conf->version != 4)
5491     return 0;
5492   if(sum((uchar*)conf, conf->length) != 0)
5493     return 0;
5494   *pmp = mp;
5495   return conf;
5496 }
5497 
5498 
5499 
5500 void
5501 mp_init(void)
5502 {
5503   uchar *p, *e;
5504   struct mp *mp;
5505   struct mpconf *conf;
5506   struct mpproc *proc;
5507   struct mpioapic *ioapic;
5508 
5509   bcpu = &cpus[ncpu];
5510   if((conf = mp_config(&mp)) == 0)
5511     return;
5512 
5513   ismp = 1;
5514   lapic = (uint*)conf->lapicaddr;
5515 
5516   for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
5517     switch(*p){
5518     case MPPROC:
5519       proc = (struct mpproc*)p;
5520       cpus[ncpu].apicid = proc->apicid;
5521       if(proc->flags & MPBOOT)
5522         bcpu = &cpus[ncpu];
5523       ncpu++;
5524       p += sizeof(struct mpproc);
5525       continue;
5526     case MPIOAPIC:
5527       ioapic = (struct mpioapic*)p;
5528       ioapic_id = ioapic->apicno;
5529       p += sizeof(struct mpioapic);
5530       continue;
5531     case MPBUS:
5532     case MPIOINTR:
5533     case MPLINTR:
5534       p += 8;
5535       continue;
5536     default:
5537       cprintf("mp_init: unknown config type %x\n", *p);
5538       panic("mp_init");
5539     }
5540   }
5541 
5542   if(mp->imcrp){
5543     // Bochs doesn't support IMCR, so this doesn't run on Bochs.
5544     // But it would on real hardware.
5545     outb(0x22, 0x70);   // Select IMCR
5546     outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
5547   }
5548 }
5549 
