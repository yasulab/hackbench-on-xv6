1200 #include "types.h"
1201 #include "defs.h"
1202 #include "param.h"
1203 #include "mmu.h"
1204 #include "proc.h"
1205 #include "x86.h"
1206 
1207 static void bootothers(void);
1208 static void mpmain(void) __attribute__((noreturn));
1209 
1210 // Bootstrap processor starts running C code here.
1211 int
1212 main(void)
1213 {
1214   extern char edata[], end[];
1215 
1216   // clear BSS
1217   memset(edata, 0, end - edata);
1218 
1219   mp_init(); // collect info about this machine
1220   lapic_init(mp_bcpu());
1221   cprintf("\ncpu%d: starting xv6\n\n", cpu());
1222 
1223   pinit();         // process table
1224   binit();         // buffer cache
1225   pic_init();      // interrupt controller
1226   ioapic_init();   // another interrupt controller
1227   kinit();         // physical memory allocator
1228   tvinit();        // trap vectors
1229   fileinit();      // file table
1230   iinit();         // inode cache
1231   console_init();  // I/O devices & their interrupts
1232   ide_init();      // disk
1233   if(!ismp)
1234     timer_init();  // uniprocessor timer
1235   userinit();      // first user process
1236   bootothers();    // start other processors
1237 
1238   // Finish setting up this processor in mpmain.
1239   mpmain();
1240 }
1241 
1242 
1243 
1244 
1245 
1246 
1247 
1248 
1249 
1250 // Bootstrap processor gets here after setting up the hardware.
1251 // Additional processors start here.
1252 static void
1253 mpmain(void)
1254 {
1255   cprintf("cpu%d: mpmain\n", cpu());
1256   idtinit();
1257   if(cpu() != mp_bcpu())
1258     lapic_init(cpu());
1259   setupsegs(0);
1260   xchg(&cpus[cpu()].booted, 1);
1261 
1262   cprintf("cpu%d: scheduling\n");
1263   scheduler();
1264 }
1265 
1266 static void
1267 bootothers(void)
1268 {
1269   extern uchar _binary_bootother_start[], _binary_bootother_size[];
1270   uchar *code;
1271   struct cpu *c;
1272   char *stack;
1273 
1274   // Write bootstrap code to unused memory at 0x7000.
1275   code = (uchar*)0x7000;
1276   memmove(code, _binary_bootother_start, (uint)_binary_bootother_size);
1277 
1278   for(c = cpus; c < cpus+ncpu; c++){
1279     if(c == cpus+cpu())  // We've started already.
1280       continue;
1281 
1282     // Fill in %esp, %eip and start code on cpu.
1283     stack = kalloc(KSTACKSIZE);
1284     *(void**)(code-4) = stack + KSTACKSIZE;
1285     *(void**)(code-8) = mpmain;
1286     lapic_startap(c->apicid, (uint)code);
1287 
1288     // Wait for cpu to get through bootstrap.
1289     while(c->booted == 0)
1290       ;
1291   }
1292 }
1293 
1294 
1295 
1296 
1297 
1298 
1299 
