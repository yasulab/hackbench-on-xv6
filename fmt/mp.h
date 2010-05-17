5300 // See MultiProcessor Specification Version 1.[14]
5301 
5302 struct mp {             // floating pointer
5303   uchar signature[4];           // "_MP_"
5304   void *physaddr;               // phys addr of MP config table
5305   uchar length;                 // 1
5306   uchar specrev;                // [14]
5307   uchar checksum;               // all bytes must add up to 0
5308   uchar type;                   // MP system config type
5309   uchar imcrp;
5310   uchar reserved[3];
5311 };
5312 
5313 struct mpconf {         // configuration table header
5314   uchar signature[4];           // "PCMP"
5315   ushort length;                // total table length
5316   uchar version;                // [14]
5317   uchar checksum;               // all bytes must add up to 0
5318   uchar product[20];            // product id
5319   uint *oemtable;               // OEM table pointer
5320   ushort oemlength;             // OEM table length
5321   ushort entry;                 // entry count
5322   uint *lapicaddr;              // address of local APIC
5323   ushort xlength;               // extended table length
5324   uchar xchecksum;              // extended table checksum
5325   uchar reserved;
5326 };
5327 
5328 struct mpproc {         // processor table entry
5329   uchar type;                   // entry type (0)
5330   uchar apicid;                 // local APIC id
5331   uchar version;                // local APIC verison
5332   uchar flags;                  // CPU flags
5333     #define MPBOOT 0x02           // This proc is the bootstrap processor.
5334   uchar signature[4];           // CPU signature
5335   uint feature;                 // feature flags from CPUID instruction
5336   uchar reserved[8];
5337 };
5338 
5339 struct mpioapic {       // I/O APIC table entry
5340   uchar type;                   // entry type (2)
5341   uchar apicno;                 // I/O APIC id
5342   uchar version;                // I/O APIC version
5343   uchar flags;                  // I/O APIC flags
5344   uint *addr;                  // I/O APIC address
5345 };
5346 
5347 
5348 
5349 
5350 // Table entry types
5351 #define MPPROC    0x00  // One per processor
5352 #define MPBUS     0x01  // One per bus
5353 #define MPIOAPIC  0x02  // One per I/O APIC
5354 #define MPIOINTR  0x03  // One per bus interrupt source
5355 #define MPLINTR   0x04  // One per system interrupt source
5356 
5357 
5358 
5359 
5360 
5361 
5362 
5363 
5364 
5365 
5366 
5367 
5368 
5369 
5370 
5371 
5372 
5373 
5374 
5375 
5376 
5377 
5378 
5379 
5380 
5381 
5382 
5383 
5384 
5385 
5386 
5387 
5388 
5389 
5390 
5391 
5392 
5393 
5394 
5395 
5396 
5397 
5398 
5399 
