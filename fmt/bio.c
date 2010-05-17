3500 // Buffer cache.
3501 //
3502 // The buffer cache is a linked list of buf structures holding
3503 // cached copies of disk block contents.  Caching disk blocks
3504 // in memory reduces the number of disk reads and also provides
3505 // a synchronization point for disk blocks used by multiple processes.
3506 //
3507 // Interface:
3508 // * To get a buffer for a particular disk block, call bread.
3509 // * After changing buffer data, call bwrite to flush it to disk.
3510 // * When done with the buffer, call brelse.
3511 // * Do not use the buffer after calling brelse.
3512 // * Only one process at a time can use a buffer,
3513 //     so do not keep them longer than necessary.
3514 //
3515 // The implementation uses three state flags internally:
3516 // * B_BUSY: the block has been returned from bread
3517 //     and has not been passed back to brelse.
3518 // * B_VALID: the buffer data has been initialized
3519 //     with the associated disk block contents.
3520 // * B_DIRTY: the buffer data has been modified
3521 //     and needs to be written to disk.
3522 
3523 #include "types.h"
3524 #include "defs.h"
3525 #include "param.h"
3526 #include "spinlock.h"
3527 #include "buf.h"
3528 
3529 struct buf buf[NBUF];
3530 struct spinlock buf_table_lock;
3531 
3532 // Linked list of all buffers, through prev/next.
3533 // bufhead->next is most recently used.
3534 // bufhead->tail is least recently used.
3535 struct buf bufhead;
3536 
3537 void
3538 binit(void)
3539 {
3540   struct buf *b;
3541 
3542   initlock(&buf_table_lock, "buf_table");
3543 
3544   // Create linked list of buffers
3545   bufhead.prev = &bufhead;
3546   bufhead.next = &bufhead;
3547   for(b = buf; b < buf+NBUF; b++){
3548     b->next = bufhead.next;
3549     b->prev = &bufhead;
3550     bufhead.next->prev = b;
3551     bufhead.next = b;
3552   }
3553 }
3554 
3555 // Look through buffer cache for sector on device dev.
3556 // If not found, allocate fresh block.
3557 // In either case, return locked buffer.
3558 static struct buf*
3559 bget(uint dev, uint sector)
3560 {
3561   struct buf *b;
3562 
3563   acquire(&buf_table_lock);
3564 
3565  loop:
3566   // Try for cached block.
3567   for(b = bufhead.next; b != &bufhead; b = b->next){
3568     if((b->flags & (B_BUSY|B_VALID)) &&
3569        b->dev == dev && b->sector == sector){
3570       if(b->flags & B_BUSY){
3571         sleep(buf, &buf_table_lock);
3572         goto loop;
3573       }
3574       b->flags |= B_BUSY;
3575       release(&buf_table_lock);
3576       return b;
3577     }
3578   }
3579 
3580   // Allocate fresh block.
3581   for(b = bufhead.prev; b != &bufhead; b = b->prev){
3582     if((b->flags & B_BUSY) == 0){
3583       b->flags = B_BUSY;
3584       b->dev = dev;
3585       b->sector = sector;
3586       release(&buf_table_lock);
3587       return b;
3588     }
3589   }
3590   panic("bget: no buffers");
3591 }
3592 
3593 
3594 
3595 
3596 
3597 
3598 
3599 
3600 // Return a B_BUSY buf with the contents of the indicated disk sector.
3601 struct buf*
3602 bread(uint dev, uint sector)
3603 {
3604   struct buf *b;
3605 
3606   b = bget(dev, sector);
3607   if(!(b->flags & B_VALID))
3608     ide_rw(b);
3609   return b;
3610 }
3611 
3612 // Write buf's contents to disk.  Must be locked.
3613 void
3614 bwrite(struct buf *b)
3615 {
3616   if((b->flags & B_BUSY) == 0)
3617     panic("bwrite");
3618   b->flags |= B_DIRTY;
3619   ide_rw(b);
3620 }
3621 
3622 // Release the buffer buf.
3623 void
3624 brelse(struct buf *b)
3625 {
3626   if((b->flags & B_BUSY) == 0)
3627     panic("brelse");
3628 
3629   acquire(&buf_table_lock);
3630 
3631   b->next->prev = b->prev;
3632   b->prev->next = b->next;
3633   b->next = bufhead.next;
3634   b->prev = &bufhead;
3635   bufhead.next->prev = b;
3636   bufhead.next = b;
3637 
3638   b->flags &= ~B_BUSY;
3639   wakeup(buf);
3640 
3641   release(&buf_table_lock);
3642 }
3643 
3644 
3645 
3646 
3647 
3648 
3649 
