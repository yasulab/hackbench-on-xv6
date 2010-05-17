1100 // Boot loader.
1101 //
1102 // Part of the boot sector, along with bootasm.S, which calls bootmain().
1103 // bootasm.S has put the processor into protected 32-bit mode.
1104 // bootmain() loads an ELF kernel image from the disk starting at
1105 // sector 1 and then jumps to the kernel entry routine.
1106 
1107 #include "types.h"
1108 #include "elf.h"
1109 #include "x86.h"
1110 
1111 #define SECTSIZE  512
1112 
1113 void readseg(uint, uint, uint);
1114 
1115 void
1116 bootmain(void)
1117 {
1118   struct elfhdr *elf;
1119   struct proghdr *ph, *eph;
1120   void (*entry)(void);
1121 
1122   elf = (struct elfhdr*)0x10000;  // scratch space
1123 
1124   // Read 1st page off disk
1125   readseg((uint)elf, SECTSIZE*8, 0);
1126 
1127   // Is this an ELF executable?
1128   if(elf->magic != ELF_MAGIC)
1129     goto bad;
1130 
1131   // Load each program segment (ignores ph flags).
1132   ph = (struct proghdr*)((uchar*)elf + elf->phoff);
1133   eph = ph + elf->phnum;
1134   for(; ph < eph; ph++)
1135     readseg(ph->va & 0xFFFFFF, ph->memsz, ph->offset);
1136 
1137   // Call the entry point from the ELF header.
1138   // Does not return!
1139   entry = (void(*)(void))(elf->entry & 0xFFFFFF);
1140   entry();
1141 
1142 bad:
1143   outw(0x8A00, 0x8A00);
1144   outw(0x8A00, 0x8E00);
1145   for(;;)
1146     ;
1147 }
1148 
1149 
1150 void
1151 waitdisk(void)
1152 {
1153   // Wait for disk ready.
1154   while((inb(0x1F7) & 0xC0) != 0x40)
1155     ;
1156 }
1157 
1158 // Read a single sector at offset into dst.
1159 void
1160 readsect(void *dst, uint offset)
1161 {
1162   // Issue command.
1163   waitdisk();
1164   outb(0x1F2, 1);   // count = 1
1165   outb(0x1F3, offset);
1166   outb(0x1F4, offset >> 8);
1167   outb(0x1F5, offset >> 16);
1168   outb(0x1F6, (offset >> 24) | 0xE0);
1169   outb(0x1F7, 0x20);  // cmd 0x20 - read sectors
1170 
1171   // Read data.
1172   waitdisk();
1173   insl(0x1F0, dst, SECTSIZE/4);
1174 }
1175 
1176 // Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
1177 // Might copy more than asked.
1178 void
1179 readseg(uint va, uint count, uint offset)
1180 {
1181   uint eva;
1182 
1183   eva = va + count;
1184 
1185   // Round down to sector boundary.
1186   va &= ~(SECTSIZE - 1);
1187 
1188   // Translate from bytes to sectors; kernel starts at sector 1.
1189   offset = (offset / SECTSIZE) + 1;
1190 
1191   // If this is too slow, we could read lots of sectors at a time.
1192   // We'd write more to memory than asked, but it doesn't matter --
1193   // we load in increasing order.
1194   for(; va < eva; va += SECTSIZE, offset++)
1195     readsect((uchar*)va, offset);
1196 }
1197 
1198 
1199 
