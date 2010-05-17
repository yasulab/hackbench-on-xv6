
bootblock.o:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
.set CR0_PE_ON,      0x1         # protected mode enable flag

.globl start
start:
  .code16                     # Assemble for 16-bit mode
  cli                         # Disable interrupts
    7c00:	fa                   	cli    
  cld                         # String operations increment
    7c01:	fc                   	cld    

  # Set up the important data segment registers (DS, ES, SS).
  xorw    %ax,%ax             # Segment number zero
    7c02:	31 c0                	xor    %eax,%eax
  movw    %ax,%ds             # -> Data Segment
    7c04:	8e d8                	mov    %eax,%ds
  movw    %ax,%es             # -> Extra Segment
    7c06:	8e c0                	mov    %eax,%es
  movw    %ax,%ss             # -> Stack Segment
    7c08:	8e d0                	mov    %eax,%ss

00007c0a <seta20.1>:
  # Enable A20:
  #   For backwards compatibility with the earliest PCs, physical
  #   address line 20 is tied low, so that addresses higher than
  #   1MB wrap around to zero by default.  This code undoes this.
seta20.1:
  inb     $0x64,%al               # Wait for not busy
    7c0a:	e4 64                	in     $0x64,%al
  testb   $0x2,%al
    7c0c:	a8 02                	test   $0x2,%al
  jnz     seta20.1
    7c0e:	75 fa                	jne    7c0a <seta20.1>

  movb    $0xd1,%al               # 0xd1 -> port 0x64
    7c10:	b0 d1                	mov    $0xd1,%al
  outb    %al,$0x64
    7c12:	e6 64                	out    %al,$0x64

00007c14 <seta20.2>:

seta20.2:
  inb     $0x64,%al               # Wait for not busy
    7c14:	e4 64                	in     $0x64,%al
  testb   $0x2,%al
    7c16:	a8 02                	test   $0x2,%al
  jnz     seta20.2
    7c18:	75 fa                	jne    7c14 <seta20.2>

  movb    $0xdf,%al               # 0xdf -> port 0x60
    7c1a:	b0 df                	mov    $0xdf,%al
  outb    %al,$0x60
    7c1c:	e6 60                	out    %al,$0x60

  # Switch from real to protected mode, using a bootstrap GDT
  # and segment translation that makes virtual addresses 
  # identical to physical addresses, so that the 
  # effective memory map does not change during the switch.
  lgdt    gdtdesc
    7c1e:	0f 01 16             	lgdtl  (%esi)
    7c21:	64                   	fs
    7c22:	7c 0f                	jl     7c33 <protcseg+0x1>
  movl    %cr0, %eax
    7c24:	20 c0                	and    %al,%al
  orl     $CR0_PE_ON, %eax
    7c26:	66 83 c8 01          	or     $0x1,%ax
  movl    %eax, %cr0
    7c2a:	0f 22 c0             	mov    %eax,%cr0
  
  # Jump to next instruction, but in 32-bit code segment.
  # Switches processor into 32-bit mode.
  ljmp    $PROT_MODE_CSEG, $protcseg
    7c2d:	ea 32 7c 08 00 66 b8 	ljmp   $0xb866,$0x87c32

00007c32 <protcseg>:

  .code32                     # Assemble for 32-bit mode
protcseg:
  # Set up the protected-mode data segment registers
  movw    $PROT_MODE_DSEG, %ax    # Our data segment selector
    7c32:	66 b8 10 00          	mov    $0x10,%ax
  movw    %ax, %ds                # -> DS: Data Segment
    7c36:	8e d8                	mov    %eax,%ds
  movw    %ax, %es                # -> ES: Extra Segment
    7c38:	8e c0                	mov    %eax,%es
  movw    %ax, %fs                # -> FS
    7c3a:	8e e0                	mov    %eax,%fs
  movw    %ax, %gs                # -> GS
    7c3c:	8e e8                	mov    %eax,%gs
  movw    %ax, %ss                # -> SS: Stack Segment
    7c3e:	8e d0                	mov    %eax,%ss
  
  # Set up the stack pointer and call into C.
  movl    $start, %esp
    7c40:	bc 00 7c 00 00       	mov    $0x7c00,%esp
  call    bootmain
    7c45:	e8 d5 00 00 00       	call   7d1f <bootmain>

00007c4a <spin>:

  # If bootmain returns (it shouldn't), loop.
spin:
  jmp     spin
    7c4a:	eb fe                	jmp    7c4a <spin>

00007c4c <gdt>:
	...
    7c54:	ff                   	(bad)  
    7c55:	ff 00                	incl   (%eax)
    7c57:	00 00                	add    %al,(%eax)
    7c59:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c60:	00 92 cf 00 17 00    	add    %dl,0x1700cf(%edx)

00007c64 <gdtdesc>:
    7c64:	17                   	pop    %ss
    7c65:	00 4c 7c 00          	add    %cl,0x0(%esp,%edi,2)
    7c69:	00 90 90 55 89 e5    	add    %dl,-0x1a76aa70(%eax)

00007c6c <waitdisk>:
    ;
}

void
waitdisk(void)
{
    7c6c:	55                   	push   %ebp
    7c6d:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
    7c6f:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c74:	ec                   	in     (%dx),%al
  // Wait for disk ready.
  while((inb(0x1F7) & 0xC0) != 0x40)
    7c75:	25 c0 00 00 00       	and    $0xc0,%eax
    7c7a:	83 f8 40             	cmp    $0x40,%eax
    7c7d:	75 f5                	jne    7c74 <waitdisk+0x8>
    ;
}
    7c7f:	5d                   	pop    %ebp
    7c80:	c3                   	ret    

00007c81 <readsect>:

// Read a single sector at offset into dst.
void
readsect(void *dst, uint offset)
{
    7c81:	55                   	push   %ebp
    7c82:	89 e5                	mov    %esp,%ebp
    7c84:	57                   	push   %edi
    7c85:	53                   	push   %ebx
    7c86:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  // Issue command.
  waitdisk();
    7c89:	e8 de ff ff ff       	call   7c6c <waitdisk>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
    7c8e:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7c93:	b8 01 00 00 00       	mov    $0x1,%eax
    7c98:	ee                   	out    %al,(%dx)
    7c99:	b2 f3                	mov    $0xf3,%dl
    7c9b:	89 d8                	mov    %ebx,%eax
    7c9d:	ee                   	out    %al,(%dx)
    7c9e:	89 d8                	mov    %ebx,%eax
    7ca0:	c1 e8 08             	shr    $0x8,%eax
    7ca3:	b2 f4                	mov    $0xf4,%dl
    7ca5:	ee                   	out    %al,(%dx)
    7ca6:	89 d8                	mov    %ebx,%eax
    7ca8:	c1 e8 10             	shr    $0x10,%eax
    7cab:	b2 f5                	mov    $0xf5,%dl
    7cad:	ee                   	out    %al,(%dx)
    7cae:	c1 eb 18             	shr    $0x18,%ebx
    7cb1:	89 d8                	mov    %ebx,%eax
    7cb3:	83 c8 e0             	or     $0xffffffe0,%eax
    7cb6:	b2 f6                	mov    $0xf6,%dl
    7cb8:	ee                   	out    %al,(%dx)
    7cb9:	b2 f7                	mov    $0xf7,%dl
    7cbb:	b8 20 00 00 00       	mov    $0x20,%eax
    7cc0:	ee                   	out    %al,(%dx)
  outb(0x1F5, offset >> 16);
  outb(0x1F6, (offset >> 24) | 0xE0);
  outb(0x1F7, 0x20);  // cmd 0x20 - read sectors

  // Read data.
  waitdisk();
    7cc1:	e8 a6 ff ff ff       	call   7c6c <waitdisk>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld\n\trepne\n\tinsl"     :
    7cc6:	8b 7d 08             	mov    0x8(%ebp),%edi
    7cc9:	b9 80 00 00 00       	mov    $0x80,%ecx
    7cce:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7cd3:	fc                   	cld    
    7cd4:	f2 6d                	repnz insl (%dx),%es:(%edi)
  insl(0x1F0, dst, SECTSIZE/4);
}
    7cd6:	5b                   	pop    %ebx
    7cd7:	5f                   	pop    %edi
    7cd8:	5d                   	pop    %ebp
    7cd9:	c3                   	ret    

00007cda <readseg>:

// Read 'count' bytes at 'offset' from kernel into virtual address 'va'.
// Might copy more than asked.
void
readseg(uint va, uint count, uint offset)
{
    7cda:	55                   	push   %ebp
    7cdb:	89 e5                	mov    %esp,%ebp
    7cdd:	57                   	push   %edi
    7cde:	56                   	push   %esi
    7cdf:	53                   	push   %ebx
    7ce0:	83 ec 08             	sub    $0x8,%esp
    7ce3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint eva;

  eva = va + count;
    7ce6:	8b 7d 0c             	mov    0xc(%ebp),%edi
    7ce9:	01 df                	add    %ebx,%edi

  // Round down to sector boundary.
  va &= ~(SECTSIZE - 1);
    7ceb:	81 e3 00 fe ff ff    	and    $0xfffffe00,%ebx
  offset = (offset / SECTSIZE) + 1;

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; va < eva; va += SECTSIZE, offset++)
    7cf1:	39 df                	cmp    %ebx,%edi
    7cf3:	76 22                	jbe    7d17 <readseg+0x3d>

  // Round down to sector boundary.
  va &= ~(SECTSIZE - 1);

  // Translate from bytes to sectors; kernel starts at sector 1.
  offset = (offset / SECTSIZE) + 1;
    7cf5:	8b 75 10             	mov    0x10(%ebp),%esi
    7cf8:	c1 ee 09             	shr    $0x9,%esi
    7cfb:	83 c6 01             	add    $0x1,%esi

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; va < eva; va += SECTSIZE, offset++)
    readsect((uchar*)va, offset);
    7cfe:	89 74 24 04          	mov    %esi,0x4(%esp)
    7d02:	89 1c 24             	mov    %ebx,(%esp)
    7d05:	e8 77 ff ff ff       	call   7c81 <readsect>
  offset = (offset / SECTSIZE) + 1;

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; va < eva; va += SECTSIZE, offset++)
    7d0a:	81 c3 00 02 00 00    	add    $0x200,%ebx
    7d10:	83 c6 01             	add    $0x1,%esi
    7d13:	39 df                	cmp    %ebx,%edi
    7d15:	77 e7                	ja     7cfe <readseg+0x24>
    readsect((uchar*)va, offset);
}
    7d17:	83 c4 08             	add    $0x8,%esp
    7d1a:	5b                   	pop    %ebx
    7d1b:	5e                   	pop    %esi
    7d1c:	5f                   	pop    %edi
    7d1d:	5d                   	pop    %ebp
    7d1e:	c3                   	ret    

00007d1f <bootmain>:

void readseg(uint, uint, uint);

void
bootmain(void)
{
    7d1f:	55                   	push   %ebp
    7d20:	89 e5                	mov    %esp,%ebp
    7d22:	53                   	push   %ebx
    7d23:	83 ec 24             	sub    $0x24,%esp
  void (*entry)(void);

  elf = (struct elfhdr*)0x10000;  // scratch space

  // Read 1st page off disk
  readseg((uint)elf, SECTSIZE*8, 0);
    7d26:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    7d2d:	00 
    7d2e:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    7d35:	00 
    7d36:	c7 04 24 00 00 01 00 	movl   $0x10000,(%esp)
    7d3d:	e8 98 ff ff ff       	call   7cda <readseg>

  // Is this an ELF executable?
  if(elf->magic != ELF_MAGIC)
    7d42:	81 3d 00 00 01 00 7f 	cmpl   $0x464c457f,0x10000
    7d49:	45 4c 46 
    7d4c:	75 4f                	jne    7d9d <bootmain+0x7e>
    goto bad;

  // Load each program segment (ignores ph flags).
  ph = (struct proghdr*)((uchar*)elf + elf->phoff);
    7d4e:	b8 00 00 01 00       	mov    $0x10000,%eax
    7d53:	8b 58 1c             	mov    0x1c(%eax),%ebx
    7d56:	81 c3 00 00 01 00    	add    $0x10000,%ebx
  eph = ph + elf->phnum;
    7d5c:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
    7d60:	c1 e0 05             	shl    $0x5,%eax
    7d63:	8d 04 03             	lea    (%ebx,%eax,1),%eax
    7d66:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; ph < eph; ph++)
    7d69:	eb 21                	jmp    7d8c <bootmain+0x6d>
    readseg(ph->va & 0xFFFFFF, ph->memsz, ph->offset);
    7d6b:	8b 43 04             	mov    0x4(%ebx),%eax
    7d6e:	89 44 24 08          	mov    %eax,0x8(%esp)
    7d72:	8b 43 14             	mov    0x14(%ebx),%eax
    7d75:	89 44 24 04          	mov    %eax,0x4(%esp)
    7d79:	8b 43 08             	mov    0x8(%ebx),%eax
    7d7c:	25 ff ff ff 00       	and    $0xffffff,%eax
    7d81:	89 04 24             	mov    %eax,(%esp)
    7d84:	e8 51 ff ff ff       	call   7cda <readseg>
    goto bad;

  // Load each program segment (ignores ph flags).
  ph = (struct proghdr*)((uchar*)elf + elf->phoff);
  eph = ph + elf->phnum;
  for(; ph < eph; ph++)
    7d89:	83 c3 20             	add    $0x20,%ebx
    7d8c:	3b 5d f4             	cmp    -0xc(%ebp),%ebx
    7d8f:	72 da                	jb     7d6b <bootmain+0x4c>
    readseg(ph->va & 0xFFFFFF, ph->memsz, ph->offset);

  // Call the entry point from the ELF header.
  // Does not return!
  entry = (void(*)(void))(elf->entry & 0xFFFFFF);
    7d91:	a1 18 00 01 00       	mov    0x10018,%eax
  entry();
    7d96:	25 ff ff ff 00       	and    $0xffffff,%eax
    7d9b:	ff d0                	call   *%eax
}

static inline void
outw(ushort port, ushort data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
    7d9d:	ba 00 8a ff ff       	mov    $0xffff8a00,%edx
    7da2:	b8 00 8a ff ff       	mov    $0xffff8a00,%eax
    7da7:	66 ef                	out    %ax,(%dx)
    7da9:	b8 00 8e ff ff       	mov    $0xffff8e00,%eax
    7dae:	66 ef                	out    %ax,(%dx)
    7db0:	eb fe                	jmp    7db0 <bootmain+0x91>
