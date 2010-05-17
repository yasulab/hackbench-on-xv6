6100 #include "types.h"
6101 #include "x86.h"
6102 #include "defs.h"
6103 #include "kbd.h"
6104 
6105 int
6106 kbd_getc(void)
6107 {
6108   static uint shift;
6109   static uchar *charcode[4] = {
6110     normalmap, shiftmap, ctlmap, ctlmap
6111   };
6112   uint st, data, c;
6113 
6114   st = inb(KBSTATP);
6115   if((st & KBS_DIB) == 0)
6116     return -1;
6117   data = inb(KBDATAP);
6118 
6119   if(data == 0xE0){
6120     shift |= E0ESC;
6121     return 0;
6122   } else if(data & 0x80){
6123     // Key released
6124     data = (shift & E0ESC ? data : data & 0x7F);
6125     shift &= ~(shiftcode[data] | E0ESC);
6126     return 0;
6127   } else if(shift & E0ESC){
6128     // Last character was an E0 escape; or with 0x80
6129     data |= 0x80;
6130     shift &= ~E0ESC;
6131   }
6132 
6133   shift |= shiftcode[data];
6134   shift ^= togglecode[data];
6135   c = charcode[shift & (CTL | SHIFT)][data];
6136   if(shift & CAPSLOCK){
6137     if('a' <= c && c <= 'z')
6138       c += 'A' - 'a';
6139     else if('A' <= c && c <= 'Z')
6140       c += 'a' - 'A';
6141   }
6142   return c;
6143 }
6144 
6145 void
6146 kbd_intr(void)
6147 {
6148   console_intr(kbd_getc);
6149 }
