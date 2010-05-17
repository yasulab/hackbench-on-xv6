1350 // Mutual exclusion spin locks.
1351 
1352 #include "types.h"
1353 #include "defs.h"
1354 #include "param.h"
1355 #include "x86.h"
1356 #include "mmu.h"
1357 #include "proc.h"
1358 #include "spinlock.h"
1359 
1360 extern int use_console_lock;
1361 
1362 void
1363 initlock(struct spinlock *lock, char *name)
1364 {
1365   lock->name = name;
1366   lock->locked = 0;
1367   lock->cpu = 0xffffffff;
1368 }
1369 
1370 // Acquire the lock.
1371 // Loops (spins) until the lock is acquired.
1372 // Holding a lock for a long time may cause
1373 // other CPUs to waste time spinning to acquire it.
1374 void
1375 acquire(struct spinlock *lock)
1376 {
1377   pushcli();
1378   if(holding(lock))
1379     panic("acquire");
1380 
1381   // The xchg is atomic.
1382   // It also serializes, so that reads after acquire are not
1383   // reordered before it.
1384   while(xchg(&lock->locked, 1) == 1)
1385     ;
1386 
1387   // Record info about lock acquisition for debugging.
1388   // The +10 is only so that we can tell the difference
1389   // between forgetting to initialize lock->cpu
1390   // and holding a lock on cpu 0.
1391   lock->cpu = cpu() + 10;
1392   getcallerpcs(&lock, lock->pcs);
1393 }
1394 
1395 
1396 
1397 
1398 
1399 
1400 // Release the lock.
1401 void
1402 release(struct spinlock *lock)
1403 {
1404   if(!holding(lock))
1405     panic("release");
1406 
1407   lock->pcs[0] = 0;
1408   lock->cpu = 0xffffffff;
1409 
1410   // The xchg serializes, so that reads before release are
1411   // not reordered after it.  (This reordering would be allowed
1412   // by the Intel manuals, but does not happen on current
1413   // Intel processors.  The xchg being asm volatile also keeps
1414   // gcc from delaying the above assignments.)
1415   xchg(&lock->locked, 0);
1416 
1417   popcli();
1418 }
1419 
1420 // Record the current call stack in pcs[] by following the %ebp chain.
1421 void
1422 getcallerpcs(void *v, uint pcs[])
1423 {
1424   uint *ebp;
1425   int i;
1426 
1427   ebp = (uint*)v - 2;
1428   for(i = 0; i < 10; i++){
1429     if(ebp == 0 || ebp == (uint*)0xffffffff)
1430       break;
1431     pcs[i] = ebp[1];     // saved %eip
1432     ebp = (uint*)ebp[0]; // saved %ebp
1433   }
1434   for(; i < 10; i++)
1435     pcs[i] = 0;
1436 }
1437 
1438 // Check whether this cpu is holding the lock.
1439 int
1440 holding(struct spinlock *lock)
1441 {
1442   return lock->locked && lock->cpu == cpu() + 10;
1443 }
1444 
1445 
1446 
1447 
1448 
1449 
1450 // Pushcli/popcli are like cli/sti except that they are matched:
1451 // it takes two popcli to undo two pushcli.  Also, if interrupts
1452 // are off, then pushcli, popcli leaves them off.
1453 
1454 void
1455 pushcli(void)
1456 {
1457   int eflags;
1458 
1459   eflags = read_eflags();
1460   cli();
1461   if(cpus[cpu()].ncli++ == 0)
1462     cpus[cpu()].intena = eflags & FL_IF;
1463 }
1464 
1465 void
1466 popcli(void)
1467 {
1468   if(read_eflags()&FL_IF)
1469     panic("popcli - interruptible");
1470   if(--cpus[cpu()].ncli < 0)
1471     panic("popcli");
1472   if(cpus[cpu()].ncli == 0 && cpus[cpu()].intena)
1473     sti();
1474 }
1475 
1476 
1477 
1478 
1479 
1480 
1481 
1482 
1483 
1484 
1485 
1486 
1487 
1488 
1489 
1490 
1491 
1492 
1493 
1494 
1495 
1496 
1497 
1498 
1499 
