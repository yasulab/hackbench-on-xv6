3300 // Simple PIO-based (non-DMA) IDE driver code.
3301 
3302 #include "types.h"
3303 #include "defs.h"
3304 #include "param.h"
3305 #include "mmu.h"
3306 #include "proc.h"
3307 #include "x86.h"
3308 #include "traps.h"
3309 #include "spinlock.h"
3310 #include "buf.h"
3311 
3312 #define IDE_BSY       0x80
3313 #define IDE_DRDY      0x40
3314 #define IDE_DF        0x20
3315 #define IDE_ERR       0x01
3316 
3317 #define IDE_CMD_READ  0x20
3318 #define IDE_CMD_WRITE 0x30
3319 
3320 // ide_queue points to the buf now being read/written to the disk.
3321 // ide_queue->qnext points to the next buf to be processed.
3322 // You must hold ide_lock while manipulating queue.
3323 
3324 static struct spinlock ide_lock;
3325 static struct buf *ide_queue;
3326 
3327 static int disk_1_present;
3328 static void ide_start_request();
3329 
3330 // Wait for IDE disk to become ready.
3331 static int
3332 ide_wait_ready(int check_error)
3333 {
3334   int r;
3335 
3336   while(((r = inb(0x1f7)) & IDE_BSY) || !(r & IDE_DRDY))
3337     ;
3338   if(check_error && (r & (IDE_DF|IDE_ERR)) != 0)
3339     return -1;
3340   return 0;
3341 }
3342 
3343 
3344 
3345 
3346 
3347 
3348 
3349 
3350 void
3351 ide_init(void)
3352 {
3353   int i;
3354 
3355   initlock(&ide_lock, "ide");
3356   pic_enable(IRQ_IDE);
3357   ioapic_enable(IRQ_IDE, ncpu - 1);
3358   ide_wait_ready(0);
3359 
3360   // Check if disk 1 is present
3361   outb(0x1f6, 0xe0 | (1<<4));
3362   for(i=0; i<1000; i++){
3363     if(inb(0x1f7) != 0){
3364       disk_1_present = 1;
3365       break;
3366     }
3367   }
3368 
3369   // Switch back to disk 0.
3370   outb(0x1f6, 0xe0 | (0<<4));
3371 }
3372 
3373 // Start the request for b.  Caller must hold ide_lock.
3374 static void
3375 ide_start_request(struct buf *b)
3376 {
3377   if(b == 0)
3378     panic("ide_start_request");
3379 
3380   ide_wait_ready(0);
3381   outb(0x3f6, 0);  // generate interrupt
3382   outb(0x1f2, 1);  // number of sectors
3383   outb(0x1f3, b->sector & 0xff);
3384   outb(0x1f4, (b->sector >> 8) & 0xff);
3385   outb(0x1f5, (b->sector >> 16) & 0xff);
3386   outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
3387   if(b->flags & B_DIRTY){
3388     outb(0x1f7, IDE_CMD_WRITE);
3389     outsl(0x1f0, b->data, 512/4);
3390   } else {
3391     outb(0x1f7, IDE_CMD_READ);
3392   }
3393 }
3394 
3395 
3396 
3397 
3398 
3399 
3400 // Interrupt handler.
3401 void
3402 ide_intr(void)
3403 {
3404   struct buf *b;
3405 
3406   acquire(&ide_lock);
3407   if((b = ide_queue) == 0){
3408     release(&ide_lock);
3409     return;
3410   }
3411 
3412   // Read data if needed.
3413   if(!(b->flags & B_DIRTY) && ide_wait_ready(1) >= 0)
3414     insl(0x1f0, b->data, 512/4);
3415 
3416   // Wake process waiting for this buf.
3417   b->flags |= B_VALID;
3418   b->flags &= ~B_DIRTY;
3419   wakeup(b);
3420 
3421   // Start disk on next buf in queue.
3422   if((ide_queue = b->qnext) != 0)
3423     ide_start_request(ide_queue);
3424 
3425   release(&ide_lock);
3426 }
3427 
3428 // Sync buf with disk.
3429 // If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
3430 // Else if B_VALID is not set, read buf from disk, set B_VALID.
3431 void
3432 ide_rw(struct buf *b)
3433 {
3434   struct buf **pp;
3435 
3436   if(!(b->flags & B_BUSY))
3437     panic("ide_rw: buf not busy");
3438   if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
3439     panic("ide_rw: nothing to do");
3440   if(b->dev != 0 && !disk_1_present)
3441     panic("ide disk 1 not present");
3442 
3443   acquire(&ide_lock);
3444 
3445   // Append b to ide_queue.
3446   b->qnext = 0;
3447   for(pp=&ide_queue; *pp; pp=&(*pp)->qnext)
3448     ;
3449   *pp = b;
3450   // Start disk if necessary.
3451   if(ide_queue == b)
3452     ide_start_request(b);
3453 
3454   // Wait for request to finish.
3455   // Assuming will not sleep too long: ignore cp->killed.
3456   while((b->flags & (B_VALID|B_DIRTY)) != B_VALID)
3457     sleep(b, &ide_lock);
3458 
3459   release(&ide_lock);
3460 }
3461 
3462 
3463 
3464 
3465 
3466 
3467 
3468 
3469 
3470 
3471 
3472 
3473 
3474 
3475 
3476 
3477 
3478 
3479 
3480 
3481 
3482 
3483 
3484 
3485 
3486 
3487 
3488 
3489 
3490 
3491 
3492 
3493 
3494 
3495 
3496 
3497 
3498 
3499 
