4900 #include "types.h"
4901 #include "param.h"
4902 #include "mmu.h"
4903 #include "proc.h"
4904 #include "defs.h"
4905 #include "x86.h"
4906 #include "elf.h"
4907 
4908 int
4909 exec(char *path, char **argv)
4910 {
4911   char *mem, *s, *last;
4912   int i, argc, arglen, len, off;
4913   uint sz, sp, argp;
4914   struct elfhdr elf;
4915   struct inode *ip;
4916   struct proghdr ph;
4917 
4918   if((ip = namei(path)) == 0)
4919     return -1;
4920   ilock(ip);
4921 
4922   // Compute memory size of new process.
4923   mem = 0;
4924   sz = 0;
4925 
4926   // Program segments.
4927   if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
4928     goto bad;
4929   if(elf.magic != ELF_MAGIC)
4930     goto bad;
4931   for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
4932     if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
4933       goto bad;
4934     if(ph.type != ELF_PROG_LOAD)
4935       continue;
4936     if(ph.memsz < ph.filesz)
4937       goto bad;
4938     sz += ph.memsz;
4939   }
4940 
4941   // Arguments.
4942   arglen = 0;
4943   for(argc=0; argv[argc]; argc++)
4944     arglen += strlen(argv[argc]) + 1;
4945   arglen = (arglen+3) & ~3;
4946   sz += arglen + 4*(argc+1);
4947 
4948   // Stack.
4949   sz += PAGE;
4950   // Allocate program memory.
4951   sz = (sz+PAGE-1) & ~(PAGE-1);
4952   mem = kalloc(sz);
4953   if(mem == 0)
4954     goto bad;
4955   memset(mem, 0, sz);
4956 
4957   // Load program into memory.
4958   for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
4959     if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
4960       goto bad;
4961     if(ph.type != ELF_PROG_LOAD)
4962       continue;
4963     if(ph.va + ph.memsz > sz)
4964       goto bad;
4965     if(readi(ip, mem + ph.va, ph.offset, ph.filesz) != ph.filesz)
4966       goto bad;
4967     memset(mem + ph.va + ph.filesz, 0, ph.memsz - ph.filesz);
4968   }
4969   iunlockput(ip);
4970 
4971   // Initialize stack.
4972   sp = sz;
4973   argp = sz - arglen - 4*(argc+1);
4974 
4975   // Copy argv strings and pointers to stack.
4976   *(uint*)(mem+argp + 4*argc) = 0;  // argv[argc]
4977   for(i=argc-1; i>=0; i--){
4978     len = strlen(argv[i]) + 1;
4979     sp -= len;
4980     memmove(mem+sp, argv[i], len);
4981     *(uint*)(mem+argp + 4*i) = sp;  // argv[i]
4982   }
4983 
4984   // Stack frame for main(argc, argv), below arguments.
4985   sp = argp;
4986   sp -= 4;
4987   *(uint*)(mem+sp) = argp;
4988   sp -= 4;
4989   *(uint*)(mem+sp) = argc;
4990   sp -= 4;
4991   *(uint*)(mem+sp) = 0xffffffff;   // fake return pc
4992 
4993   // Save program name for debugging.
4994   for(last=s=path; *s; s++)
4995     if(*s == '/')
4996       last = s+1;
4997   safestrcpy(cp->name, last, sizeof(cp->name));
4998 
4999 
5000   // Commit to the new image.
5001   kfree(cp->mem, cp->sz);
5002   cp->mem = mem;
5003   cp->sz = sz;
5004   cp->tf->eip = elf.entry;  // main
5005   cp->tf->esp = sp;
5006   setupsegs(cp);
5007   return 0;
5008 
5009  bad:
5010   if(mem)
5011     kfree(mem, sz);
5012   iunlockput(ip);
5013   return -1;
5014 }
5015 
5016 
5017 
5018 
5019 
5020 
5021 
5022 
5023 
5024 
5025 
5026 
5027 
5028 
5029 
5030 
5031 
5032 
5033 
5034 
5035 
5036 
5037 
5038 
5039 
5040 
5041 
5042 
5043 
5044 
5045 
5046 
5047 
5048 
5049 
