4350 #include "types.h"
4351 #include "defs.h"
4352 #include "param.h"
4353 #include "file.h"
4354 #include "spinlock.h"
4355 #include "dev.h"
4356 
4357 struct devsw devsw[NDEV];
4358 struct spinlock file_table_lock;
4359 struct file file[NFILE];
4360 
4361 void
4362 fileinit(void)
4363 {
4364   initlock(&file_table_lock, "file_table");
4365 }
4366 
4367 // Allocate a file structure.
4368 struct file*
4369 filealloc(void)
4370 {
4371   int i;
4372 
4373   acquire(&file_table_lock);
4374   for(i = 0; i < NFILE; i++){
4375     if(file[i].type == FD_CLOSED){
4376       file[i].type = FD_NONE;
4377       file[i].ref = 1;
4378       release(&file_table_lock);
4379       return file + i;
4380     }
4381   }
4382   release(&file_table_lock);
4383   return 0;
4384 }
4385 
4386 // Increment ref count for file f.
4387 struct file*
4388 filedup(struct file *f)
4389 {
4390   acquire(&file_table_lock);
4391   if(f->ref < 1 || f->type == FD_CLOSED)
4392     panic("filedup");
4393   f->ref++;
4394   release(&file_table_lock);
4395   return f;
4396 }
4397 
4398 
4399 
4400 // Close file f.  (Decrement ref count, close when reaches 0.)
4401 void
4402 fileclose(struct file *f)
4403 {
4404   struct file ff;
4405 
4406   acquire(&file_table_lock);
4407   if(f->ref < 1 || f->type == FD_CLOSED)
4408     panic("fileclose");
4409   if(--f->ref > 0){
4410     release(&file_table_lock);
4411     return;
4412   }
4413   ff = *f;
4414   f->ref = 0;
4415   f->type = FD_CLOSED;
4416   release(&file_table_lock);
4417 
4418   if(ff.type == FD_PIPE)
4419     pipeclose(ff.pipe, ff.writable);
4420   else if(ff.type == FD_INODE)
4421     iput(ff.ip);
4422   else
4423     panic("fileclose");
4424 }
4425 
4426 // Get metadata about file f.
4427 int
4428 filestat(struct file *f, struct stat *st)
4429 {
4430   if(f->type == FD_INODE){
4431     ilock(f->ip);
4432     stati(f->ip, st);
4433     iunlock(f->ip);
4434     return 0;
4435   }
4436   return -1;
4437 }
4438 
4439 
4440 
4441 
4442 
4443 
4444 
4445 
4446 
4447 
4448 
4449 
4450 // Read from file f.  Addr is kernel address.
4451 int
4452 fileread(struct file *f, char *addr, int n)
4453 {
4454   int r;
4455 
4456   if(f->readable == 0)
4457     return -1;
4458   if(f->type == FD_PIPE)
4459     return piperead(f->pipe, addr, n);
4460   if(f->type == FD_INODE){
4461     ilock(f->ip);
4462     if((r = readi(f->ip, addr, f->off, n)) > 0)
4463       f->off += r;
4464     iunlock(f->ip);
4465     return r;
4466   }
4467   panic("fileread");
4468 }
4469 
4470 // Write to file f.  Addr is kernel address.
4471 int
4472 filewrite(struct file *f, char *addr, int n)
4473 {
4474   int r;
4475 
4476   if(f->writable == 0)
4477     return -1;
4478   if(f->type == FD_PIPE)
4479     return pipewrite(f->pipe, addr, n);
4480   if(f->type == FD_INODE){
4481     ilock(f->ip);
4482     if((r = writei(f->ip, addr, f->off, n)) > 0)
4483       f->off += r;
4484     iunlock(f->ip);
4485     return r;
4486   }
4487   panic("filewrite");
4488 }
4489 
4490 
4491 
4492 
4493 
4494 
4495 
4496 
4497 
4498 
4499 
