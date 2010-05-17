5950 // PC keyboard interface constants
5951 
5952 #define KBSTATP         0x64    // kbd controller status port(I)
5953 #define KBS_DIB         0x01    // kbd data in buffer
5954 #define KBDATAP         0x60    // kbd data port(I)
5955 
5956 #define NO              0
5957 
5958 #define SHIFT           (1<<0)
5959 #define CTL             (1<<1)
5960 #define ALT             (1<<2)
5961 
5962 #define CAPSLOCK        (1<<3)
5963 #define NUMLOCK         (1<<4)
5964 #define SCROLLLOCK      (1<<5)
5965 
5966 #define E0ESC           (1<<6)
5967 
5968 // Special keycodes
5969 #define KEY_HOME        0xE0
5970 #define KEY_END         0xE1
5971 #define KEY_UP          0xE2
5972 #define KEY_DN          0xE3
5973 #define KEY_LF          0xE4
5974 #define KEY_RT          0xE5
5975 #define KEY_PGUP        0xE6
5976 #define KEY_PGDN        0xE7
5977 #define KEY_INS         0xE8
5978 #define KEY_DEL         0xE9
5979 
5980 // C('A') == Control-A
5981 #define C(x) (x - '@')
5982 
5983 static uchar shiftcode[256] =
5984 {
5985   [0x1D] CTL,
5986   [0x2A] SHIFT,
5987   [0x36] SHIFT,
5988   [0x38] ALT,
5989   [0x9D] CTL,
5990   [0xB8] ALT
5991 };
5992 
5993 static uchar togglecode[256] =
5994 {
5995   [0x3A] CAPSLOCK,
5996   [0x45] NUMLOCK,
5997   [0x46] SCROLLLOCK
5998 };
5999 
6000 static uchar normalmap[256] =
6001 {
6002   NO,   0x1B, '1',  '2',  '3',  '4',  '5',  '6',  // 0x00
6003   '7',  '8',  '9',  '0',  '-',  '=',  '\b', '\t',
6004   'q',  'w',  'e',  'r',  't',  'y',  'u',  'i',  // 0x10
6005   'o',  'p',  '[',  ']',  '\n', NO,   'a',  's',
6006   'd',  'f',  'g',  'h',  'j',  'k',  'l',  ';',  // 0x20
6007   '\'', '`',  NO,   '\\', 'z',  'x',  'c',  'v',
6008   'b',  'n',  'm',  ',',  '.',  '/',  NO,   '*',  // 0x30
6009   NO,   ' ',  NO,   NO,   NO,   NO,   NO,   NO,
6010   NO,   NO,   NO,   NO,   NO,   NO,   NO,   '7',  // 0x40
6011   '8',  '9',  '-',  '4',  '5',  '6',  '+',  '1',
6012   '2',  '3',  '0',  '.',  NO,   NO,   NO,   NO,   // 0x50
6013   [0x9C] '\n',      // KP_Enter
6014   [0xB5] '/',       // KP_Div
6015   [0xC8] KEY_UP,    [0xD0] KEY_DN,
6016   [0xC9] KEY_PGUP,  [0xD1] KEY_PGDN,
6017   [0xCB] KEY_LF,    [0xCD] KEY_RT,
6018   [0x97] KEY_HOME,  [0xCF] KEY_END,
6019   [0xD2] KEY_INS,   [0xD3] KEY_DEL
6020 };
6021 
6022 static uchar shiftmap[256] =
6023 {
6024   NO,   033,  '!',  '@',  '#',  '$',  '%',  '^',  // 0x00
6025   '&',  '*',  '(',  ')',  '_',  '+',  '\b', '\t',
6026   'Q',  'W',  'E',  'R',  'T',  'Y',  'U',  'I',  // 0x10
6027   'O',  'P',  '{',  '}',  '\n', NO,   'A',  'S',
6028   'D',  'F',  'G',  'H',  'J',  'K',  'L',  ':',  // 0x20
6029   '"',  '~',  NO,   '|',  'Z',  'X',  'C',  'V',
6030   'B',  'N',  'M',  '<',  '>',  '?',  NO,   '*',  // 0x30
6031   NO,   ' ',  NO,   NO,   NO,   NO,   NO,   NO,
6032   NO,   NO,   NO,   NO,   NO,   NO,   NO,   '7',  // 0x40
6033   '8',  '9',  '-',  '4',  '5',  '6',  '+',  '1',
6034   '2',  '3',  '0',  '.',  NO,   NO,   NO,   NO,   // 0x50
6035   [0x9C] '\n',      // KP_Enter
6036   [0xB5] '/',       // KP_Div
6037   [0xC8] KEY_UP,    [0xD0] KEY_DN,
6038   [0xC9] KEY_PGUP,  [0xD1] KEY_PGDN,
6039   [0xCB] KEY_LF,    [0xCD] KEY_RT,
6040   [0x97] KEY_HOME,  [0xCF] KEY_END,
6041   [0xD2] KEY_INS,   [0xD3] KEY_DEL
6042 };
6043 
6044 
6045 
6046 
6047 
6048 
6049 
6050 static uchar ctlmap[256] =
6051 {
6052   NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
6053   NO,      NO,      NO,      NO,      NO,      NO,      NO,      NO,
6054   C('Q'),  C('W'),  C('E'),  C('R'),  C('T'),  C('Y'),  C('U'),  C('I'),
6055   C('O'),  C('P'),  NO,      NO,      '\r',    NO,      C('A'),  C('S'),
6056   C('D'),  C('F'),  C('G'),  C('H'),  C('J'),  C('K'),  C('L'),  NO,
6057   NO,      NO,      NO,      C('\\'), C('Z'),  C('X'),  C('C'),  C('V'),
6058   C('B'),  C('N'),  C('M'),  NO,      NO,      C('/'),  NO,      NO,
6059   [0x9C] '\r',      // KP_Enter
6060   [0xB5] C('/'),    // KP_Div
6061   [0xC8] KEY_UP,    [0xD0] KEY_DN,
6062   [0xC9] KEY_PGUP,  [0xD1] KEY_PGDN,
6063   [0xCB] KEY_LF,    [0xCD] KEY_RT,
6064   [0x97] KEY_HOME,  [0xCF] KEY_END,
6065   [0xD2] KEY_INS,   [0xD3] KEY_DEL
6066 };
6067 
6068 
6069 
6070 
6071 
6072 
6073 
6074 
6075 
6076 
6077 
6078 
6079 
6080 
6081 
6082 
6083 
6084 
6085 
6086 
6087 
6088 
6089 
6090 
6091 
6092 
6093 
6094 
6095 
6096 
6097 
6098 
6099 
