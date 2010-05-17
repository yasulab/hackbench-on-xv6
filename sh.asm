
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 ec 14             	sub    $0x14,%esp
       7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       a:	85 db                	test   %ebx,%ebx
       c:	74 05                	je     13 <nulterminate+0x13>
    return 0;
  
  switch(cmd->type){
       e:	83 3b 05             	cmpl   $0x5,(%ebx)
      11:	76 0d                	jbe    20 <nulterminate+0x20>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
      13:	89 d8                	mov    %ebx,%eax
      15:	83 c4 14             	add    $0x14,%esp
      18:	5b                   	pop    %ebx
      19:	5d                   	pop    %ebp
      1a:	c3                   	ret    
      1b:	90                   	nop
      1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
  
  switch(cmd->type){
      20:	8b 03                	mov    (%ebx),%eax
      22:	ff 24 85 00 13 00 00 	jmp    *0x1300(,%eax,4)
      29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
      30:	8b 43 04             	mov    0x4(%ebx),%eax
      33:	89 04 24             	mov    %eax,(%esp)
      36:	e8 c5 ff ff ff       	call   0 <nulterminate>
    nulterminate(lcmd->right);
      3b:	8b 43 08             	mov    0x8(%ebx),%eax
      3e:	89 04 24             	mov    %eax,(%esp)
      41:	e8 ba ff ff ff       	call   0 <nulterminate>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
      46:	89 d8                	mov    %ebx,%eax
      48:	83 c4 14             	add    $0x14,%esp
      4b:	5b                   	pop    %ebx
      4c:	5d                   	pop    %ebp
      4d:	c3                   	ret    
      4e:	66 90                	xchg   %ax,%ax
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
      50:	8b 43 04             	mov    0x4(%ebx),%eax
      53:	89 04 24             	mov    %eax,(%esp)
      56:	e8 a5 ff ff ff       	call   0 <nulterminate>
    break;
  }
  return cmd;
}
      5b:	89 d8                	mov    %ebx,%eax
      5d:	83 c4 14             	add    $0x14,%esp
      60:	5b                   	pop    %ebx
      61:	5d                   	pop    %ebp
      62:	c3                   	ret    
      63:	90                   	nop
      64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
      68:	8b 43 04             	mov    0x4(%ebx),%eax
      6b:	89 04 24             	mov    %eax,(%esp)
      6e:	e8 8d ff ff ff       	call   0 <nulterminate>
    *rcmd->efile = 0;
      73:	8b 43 0c             	mov    0xc(%ebx),%eax
      76:	c6 00 00             	movb   $0x0,(%eax)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
      79:	89 d8                	mov    %ebx,%eax
      7b:	83 c4 14             	add    $0x14,%esp
      7e:	5b                   	pop    %ebx
      7f:	5d                   	pop    %ebp
      80:	c3                   	ret    
      81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      88:	8b 43 04             	mov    0x4(%ebx),%eax
      8b:	85 c0                	test   %eax,%eax
      8d:	74 84                	je     13 <nulterminate+0x13>
      8f:	89 d8                	mov    %ebx,%eax
      91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
      98:	8b 50 2c             	mov    0x2c(%eax),%edx
      9b:	c6 02 00             	movb   $0x0,(%edx)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      9e:	8b 50 08             	mov    0x8(%eax),%edx
      a1:	83 c0 04             	add    $0x4,%eax
      a4:	85 d2                	test   %edx,%edx
      a6:	75 f0                	jne    98 <nulterminate+0x98>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
      a8:	89 d8                	mov    %ebx,%eax
      aa:	83 c4 14             	add    $0x14,%esp
      ad:	5b                   	pop    %ebx
      ae:	5d                   	pop    %ebp
      af:	c3                   	ret    

000000b0 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
      b0:	55                   	push   %ebp
      b1:	89 e5                	mov    %esp,%ebp
      b3:	57                   	push   %edi
      b4:	56                   	push   %esi
      b5:	53                   	push   %ebx
      b6:	83 ec 1c             	sub    $0x1c,%esp
      b9:	8b 7d 08             	mov    0x8(%ebp),%edi
      bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;
  
  s = *ps;
      bf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
      c1:	39 f3                	cmp    %esi,%ebx
      c3:	72 0a                	jb     cf <peek+0x1f>
      c5:	eb 1f                	jmp    e6 <peek+0x36>
      c7:	90                   	nop
    s++;
      c8:	83 c3 01             	add    $0x1,%ebx
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
      cb:	39 de                	cmp    %ebx,%esi
      cd:	76 17                	jbe    e6 <peek+0x36>
      cf:	0f be 03             	movsbl (%ebx),%eax
      d2:	c7 04 24 00 14 00 00 	movl   $0x1400,(%esp)
      d9:	89 44 24 04          	mov    %eax,0x4(%esp)
      dd:	e8 3e 0c 00 00       	call   d20 <strchr>
      e2:	85 c0                	test   %eax,%eax
      e4:	75 e2                	jne    c8 <peek+0x18>
    s++;
  *ps = s;
      e6:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
      e8:	0f b6 13             	movzbl (%ebx),%edx
      eb:	31 c0                	xor    %eax,%eax
      ed:	84 d2                	test   %dl,%dl
      ef:	75 0f                	jne    100 <peek+0x50>
}
      f1:	83 c4 1c             	add    $0x1c,%esp
      f4:	5b                   	pop    %ebx
      f5:	5e                   	pop    %esi
      f6:	5f                   	pop    %edi
      f7:	5d                   	pop    %ebp
      f8:	c3                   	ret    
      f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
     100:	0f be d2             	movsbl %dl,%edx
     103:	89 54 24 04          	mov    %edx,0x4(%esp)
     107:	8b 45 10             	mov    0x10(%ebp),%eax
     10a:	89 04 24             	mov    %eax,(%esp)
     10d:	e8 0e 0c 00 00       	call   d20 <strchr>
     112:	85 c0                	test   %eax,%eax
     114:	0f 95 c0             	setne  %al
}
     117:	83 c4 1c             	add    $0x1c,%esp
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
     11a:	0f b6 c0             	movzbl %al,%eax
}
     11d:	5b                   	pop    %ebx
     11e:	5e                   	pop    %esi
     11f:	5f                   	pop    %edi
     120:	5d                   	pop    %ebp
     121:	c3                   	ret    
     122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	57                   	push   %edi
     134:	56                   	push   %esi
     135:	53                   	push   %ebx
     136:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;
  
  s = *ps;
     139:	8b 45 08             	mov    0x8(%ebp),%eax
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     13c:	8b 75 0c             	mov    0xc(%ebp),%esi
     13f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *s;
  int ret;
  
  s = *ps;
     142:	8b 18                	mov    (%eax),%ebx
  while(s < es && strchr(whitespace, *s))
     144:	39 f3                	cmp    %esi,%ebx
     146:	72 0f                	jb     157 <gettoken+0x27>
     148:	eb 24                	jmp    16e <gettoken+0x3e>
     14a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     150:	83 c3 01             	add    $0x1,%ebx
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     153:	39 de                	cmp    %ebx,%esi
     155:	76 17                	jbe    16e <gettoken+0x3e>
     157:	0f be 03             	movsbl (%ebx),%eax
     15a:	c7 04 24 00 14 00 00 	movl   $0x1400,(%esp)
     161:	89 44 24 04          	mov    %eax,0x4(%esp)
     165:	e8 b6 0b 00 00       	call   d20 <strchr>
     16a:	85 c0                	test   %eax,%eax
     16c:	75 e2                	jne    150 <gettoken+0x20>
    s++;
  if(q)
     16e:	85 ff                	test   %edi,%edi
     170:	74 02                	je     174 <gettoken+0x44>
    *q = s;
     172:	89 1f                	mov    %ebx,(%edi)
  ret = *s;
     174:	0f b6 13             	movzbl (%ebx),%edx
     177:	0f be fa             	movsbl %dl,%edi
  switch(*s){
     17a:	80 fa 3c             	cmp    $0x3c,%dl
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
     17d:	89 f8                	mov    %edi,%eax
  switch(*s){
     17f:	7f 4f                	jg     1d0 <gettoken+0xa0>
     181:	80 fa 3b             	cmp    $0x3b,%dl
     184:	0f 8c a6 00 00 00    	jl     230 <gettoken+0x100>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     18a:	83 c3 01             	add    $0x1,%ebx
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     18d:	8b 55 14             	mov    0x14(%ebp),%edx
     190:	85 d2                	test   %edx,%edx
     192:	74 05                	je     199 <gettoken+0x69>
    *eq = s;
     194:	8b 45 14             	mov    0x14(%ebp),%eax
     197:	89 18                	mov    %ebx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     199:	39 f3                	cmp    %esi,%ebx
     19b:	72 0a                	jb     1a7 <gettoken+0x77>
     19d:	eb 1f                	jmp    1be <gettoken+0x8e>
     19f:	90                   	nop
    s++;
     1a0:	83 c3 01             	add    $0x1,%ebx
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     1a3:	39 de                	cmp    %ebx,%esi
     1a5:	76 17                	jbe    1be <gettoken+0x8e>
     1a7:	0f be 03             	movsbl (%ebx),%eax
     1aa:	c7 04 24 00 14 00 00 	movl   $0x1400,(%esp)
     1b1:	89 44 24 04          	mov    %eax,0x4(%esp)
     1b5:	e8 66 0b 00 00       	call   d20 <strchr>
     1ba:	85 c0                	test   %eax,%eax
     1bc:	75 e2                	jne    1a0 <gettoken+0x70>
    s++;
  *ps = s;
     1be:	8b 45 08             	mov    0x8(%ebp),%eax
     1c1:	89 18                	mov    %ebx,(%eax)
  return ret;
}
     1c3:	83 c4 1c             	add    $0x1c,%esp
     1c6:	89 f8                	mov    %edi,%eax
     1c8:	5b                   	pop    %ebx
     1c9:	5e                   	pop    %esi
     1ca:	5f                   	pop    %edi
     1cb:	5d                   	pop    %ebp
     1cc:	c3                   	ret    
     1cd:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     1d0:	80 fa 3e             	cmp    $0x3e,%dl
     1d3:	0f 84 7f 00 00 00    	je     258 <gettoken+0x128>
     1d9:	80 fa 7c             	cmp    $0x7c,%dl
     1dc:	74 ac                	je     18a <gettoken+0x5a>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     1de:	39 de                	cmp    %ebx,%esi
     1e0:	77 2f                	ja     211 <gettoken+0xe1>
     1e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1e8:	eb 3b                	jmp    225 <gettoken+0xf5>
     1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1f0:	0f be 03             	movsbl (%ebx),%eax
     1f3:	c7 04 24 06 14 00 00 	movl   $0x1406,(%esp)
     1fa:	89 44 24 04          	mov    %eax,0x4(%esp)
     1fe:	e8 1d 0b 00 00       	call   d20 <strchr>
     203:	85 c0                	test   %eax,%eax
     205:	75 1e                	jne    225 <gettoken+0xf5>
      s++;
     207:	83 c3 01             	add    $0x1,%ebx
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     20a:	39 de                	cmp    %ebx,%esi
     20c:	76 17                	jbe    225 <gettoken+0xf5>
     20e:	0f be 03             	movsbl (%ebx),%eax
     211:	89 44 24 04          	mov    %eax,0x4(%esp)
     215:	c7 04 24 00 14 00 00 	movl   $0x1400,(%esp)
     21c:	e8 ff 0a 00 00       	call   d20 <strchr>
     221:	85 c0                	test   %eax,%eax
     223:	74 cb                	je     1f0 <gettoken+0xc0>
     225:	bf 61 00 00 00       	mov    $0x61,%edi
     22a:	e9 5e ff ff ff       	jmp    18d <gettoken+0x5d>
     22f:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     230:	80 fa 29             	cmp    $0x29,%dl
     233:	7f a9                	jg     1de <gettoken+0xae>
     235:	80 fa 28             	cmp    $0x28,%dl
     238:	0f 8d 4c ff ff ff    	jge    18a <gettoken+0x5a>
     23e:	84 d2                	test   %dl,%dl
     240:	0f 84 47 ff ff ff    	je     18d <gettoken+0x5d>
     246:	80 fa 26             	cmp    $0x26,%dl
     249:	75 93                	jne    1de <gettoken+0xae>
     24b:	90                   	nop
     24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     250:	e9 35 ff ff ff       	jmp    18a <gettoken+0x5a>
     255:	8d 76 00             	lea    0x0(%esi),%esi
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     258:	83 c3 01             	add    $0x1,%ebx
    if(*s == '>'){
     25b:	80 3b 3e             	cmpb   $0x3e,(%ebx)
     25e:	66 90                	xchg   %ax,%ax
     260:	0f 85 27 ff ff ff    	jne    18d <gettoken+0x5d>
      ret = '+';
      s++;
     266:	83 c3 01             	add    $0x1,%ebx
     269:	bf 2b 00 00 00       	mov    $0x2b,%edi
     26e:	66 90                	xchg   %ax,%ax
     270:	e9 18 ff ff ff       	jmp    18d <gettoken+0x5d>
     275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <backcmd>:
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
     280:	55                   	push   %ebp
     281:	89 e5                	mov    %esp,%ebp
     283:	53                   	push   %ebx
     284:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     287:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     28e:	e8 8d 0f 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     293:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     29a:	00 
     29b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2a2:	00 
struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2a3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     2a5:	89 04 24             	mov    %eax,(%esp)
     2a8:	e8 43 0a 00 00       	call   cf0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     2ad:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
     2b0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     2b6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     2b9:	89 d8                	mov    %ebx,%eax
     2bb:	83 c4 14             	add    $0x14,%esp
     2be:	5b                   	pop    %ebx
     2bf:	5d                   	pop    %ebp
     2c0:	c3                   	ret    
     2c1:	eb 0d                	jmp    2d0 <listcmd>
     2c3:	90                   	nop
     2c4:	90                   	nop
     2c5:	90                   	nop
     2c6:	90                   	nop
     2c7:	90                   	nop
     2c8:	90                   	nop
     2c9:	90                   	nop
     2ca:	90                   	nop
     2cb:	90                   	nop
     2cc:	90                   	nop
     2cd:	90                   	nop
     2ce:	90                   	nop
     2cf:	90                   	nop

000002d0 <listcmd>:
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	53                   	push   %ebx
     2d4:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2d7:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     2de:	e8 3d 0f 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2e3:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     2ea:	00 
     2eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2f2:	00 
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2f3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     2f5:	89 04 24             	mov    %eax,(%esp)
     2f8:	e8 f3 09 00 00       	call   cf0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     2fd:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
     300:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     306:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     309:	8b 45 0c             	mov    0xc(%ebp),%eax
     30c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     30f:	89 d8                	mov    %ebx,%eax
     311:	83 c4 14             	add    $0x14,%esp
     314:	5b                   	pop    %ebx
     315:	5d                   	pop    %ebp
     316:	c3                   	ret    
     317:	89 f6                	mov    %esi,%esi
     319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <pipecmd>:
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	53                   	push   %ebx
     324:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     327:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     32e:	e8 ed 0e 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     333:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     33a:	00 
     33b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     342:	00 
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     343:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     345:	89 04 24             	mov    %eax,(%esp)
     348:	e8 a3 09 00 00       	call   cf0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     34d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
     350:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     356:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     359:	8b 45 0c             	mov    0xc(%ebp),%eax
     35c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     35f:	89 d8                	mov    %ebx,%eax
     361:	83 c4 14             	add    $0x14,%esp
     364:	5b                   	pop    %ebx
     365:	5d                   	pop    %ebp
     366:	c3                   	ret    
     367:	89 f6                	mov    %esi,%esi
     369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <redircmd>:
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	53                   	push   %ebx
     374:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     377:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     37e:	e8 9d 0e 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     383:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     38a:	00 
     38b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     392:	00 
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     393:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     395:	89 04 24             	mov    %eax,(%esp)
     398:	e8 53 09 00 00       	call   cf0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     39d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
     3a0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3a6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ac:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3af:	8b 45 10             	mov    0x10(%ebp),%eax
     3b2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3b5:	8b 45 14             	mov    0x14(%ebp),%eax
     3b8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3bb:	8b 45 18             	mov    0x18(%ebp),%eax
     3be:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3c1:	89 d8                	mov    %ebx,%eax
     3c3:	83 c4 14             	add    $0x14,%esp
     3c6:	5b                   	pop    %ebx
     3c7:	5d                   	pop    %ebp
     3c8:	c3                   	ret    
     3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003d0 <execcmd>:

// Constructors

struct cmd*
execcmd(void)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	53                   	push   %ebx
     3d4:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3de:	e8 3d 0e 00 00       	call   1220 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3e3:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     3ea:	00 
     3eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3f2:	00 
struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3f3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3f5:	89 04 24             	mov    %eax,(%esp)
     3f8:	e8 f3 08 00 00       	call   cf0 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     3fd:	89 d8                	mov    %ebx,%eax
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
     3ff:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     405:	83 c4 14             	add    $0x14,%esp
     408:	5b                   	pop    %ebx
     409:	5d                   	pop    %ebp
     40a:	c3                   	ret    
     40b:	90                   	nop
     40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000410 <panic>:
  exit();
}

void
panic(char *s)
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     416:	8b 45 08             	mov    0x8(%ebp),%eax
     419:	c7 44 24 04 99 13 00 	movl   $0x1399,0x4(%esp)
     420:	00 
     421:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     428:	89 44 24 08          	mov    %eax,0x8(%esp)
     42c:	e8 bf 0b 00 00       	call   ff0 <printf>
  exit();
     431:	e8 52 0a 00 00       	call   e88 <exit>
     436:	8d 76 00             	lea    0x0(%esi),%esi
     439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	57                   	push   %edi
     444:	56                   	push   %esi
     445:	53                   	push   %ebx
     446:	83 ec 3c             	sub    $0x3c,%esp
     449:	8b 7d 0c             	mov    0xc(%ebp),%edi
     44c:	8b 75 10             	mov    0x10(%ebp),%esi
     44f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     450:	c7 44 24 08 4d 13 00 	movl   $0x134d,0x8(%esp)
     457:	00 
     458:	89 74 24 04          	mov    %esi,0x4(%esp)
     45c:	89 3c 24             	mov    %edi,(%esp)
     45f:	e8 4c fc ff ff       	call   b0 <peek>
     464:	85 c0                	test   %eax,%eax
     466:	0f 84 a4 00 00 00    	je     510 <parseredirs+0xd0>
    tok = gettoken(ps, es, 0, 0);
     46c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     473:	00 
     474:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     47b:	00 
     47c:	89 74 24 04          	mov    %esi,0x4(%esp)
     480:	89 3c 24             	mov    %edi,(%esp)
     483:	e8 a8 fc ff ff       	call   130 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     488:	89 74 24 04          	mov    %esi,0x4(%esp)
     48c:	89 3c 24             	mov    %edi,(%esp)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
     48f:	89 c3                	mov    %eax,%ebx
    if(gettoken(ps, es, &q, &eq) != 'a')
     491:	8d 45 e0             	lea    -0x20(%ebp),%eax
     494:	89 44 24 0c          	mov    %eax,0xc(%esp)
     498:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     49b:	89 44 24 08          	mov    %eax,0x8(%esp)
     49f:	e8 8c fc ff ff       	call   130 <gettoken>
     4a4:	83 f8 61             	cmp    $0x61,%eax
     4a7:	74 0c                	je     4b5 <parseredirs+0x75>
      panic("missing file for redirection");
     4a9:	c7 04 24 30 13 00 00 	movl   $0x1330,(%esp)
     4b0:	e8 5b ff ff ff       	call   410 <panic>
    switch(tok){
     4b5:	83 fb 3c             	cmp    $0x3c,%ebx
     4b8:	74 3e                	je     4f8 <parseredirs+0xb8>
     4ba:	83 fb 3e             	cmp    $0x3e,%ebx
     4bd:	74 05                	je     4c4 <parseredirs+0x84>
     4bf:	83 fb 2b             	cmp    $0x2b,%ebx
     4c2:	75 8c                	jne    450 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     4c4:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     4cb:	00 
     4cc:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     4d3:	00 
     4d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     4d7:	89 44 24 08          	mov    %eax,0x8(%esp)
     4db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4de:	89 44 24 04          	mov    %eax,0x4(%esp)
     4e2:	8b 45 08             	mov    0x8(%ebp),%eax
     4e5:	89 04 24             	mov    %eax,(%esp)
     4e8:	e8 83 fe ff ff       	call   370 <redircmd>
     4ed:	89 45 08             	mov    %eax,0x8(%ebp)
     4f0:	e9 5b ff ff ff       	jmp    450 <parseredirs+0x10>
     4f5:	8d 76 00             	lea    0x0(%esi),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     4f8:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     4ff:	00 
     500:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     507:	00 
     508:	eb ca                	jmp    4d4 <parseredirs+0x94>
     50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
     510:	8b 45 08             	mov    0x8(%ebp),%eax
     513:	83 c4 3c             	add    $0x3c,%esp
     516:	5b                   	pop    %ebx
     517:	5e                   	pop    %esi
     518:	5f                   	pop    %edi
     519:	5d                   	pop    %ebp
     51a:	c3                   	ret    
     51b:	90                   	nop
     51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000520 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     520:	55                   	push   %ebp
     521:	89 e5                	mov    %esp,%ebp
     523:	57                   	push   %edi
     524:	56                   	push   %esi
     525:	53                   	push   %ebx
     526:	83 ec 3c             	sub    $0x3c,%esp
     529:	8b 75 08             	mov    0x8(%ebp),%esi
     52c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     52f:	c7 44 24 08 50 13 00 	movl   $0x1350,0x8(%esp)
     536:	00 
     537:	89 34 24             	mov    %esi,(%esp)
     53a:	89 7c 24 04          	mov    %edi,0x4(%esp)
     53e:	e8 6d fb ff ff       	call   b0 <peek>
     543:	85 c0                	test   %eax,%eax
     545:	0f 85 cd 00 00 00    	jne    618 <parseexec+0xf8>
    return parseblock(ps, es);

  ret = execcmd();
     54b:	e8 80 fe ff ff       	call   3d0 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     550:	31 db                	xor    %ebx,%ebx
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
     552:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     555:	89 7c 24 08          	mov    %edi,0x8(%esp)
     559:	89 74 24 04          	mov    %esi,0x4(%esp)
     55d:	89 04 24             	mov    %eax,(%esp)
     560:	e8 db fe ff ff       	call   440 <parseredirs>
     565:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
     568:	eb 1c                	jmp    586 <parseexec+0x66>
     56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     570:	89 7c 24 08          	mov    %edi,0x8(%esp)
     574:	89 74 24 04          	mov    %esi,0x4(%esp)
     578:	8b 45 d0             	mov    -0x30(%ebp),%eax
     57b:	89 04 24             	mov    %eax,(%esp)
     57e:	e8 bd fe ff ff       	call   440 <parseredirs>
     583:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     586:	c7 44 24 08 67 13 00 	movl   $0x1367,0x8(%esp)
     58d:	00 
     58e:	89 7c 24 04          	mov    %edi,0x4(%esp)
     592:	89 34 24             	mov    %esi,(%esp)
     595:	e8 16 fb ff ff       	call   b0 <peek>
     59a:	85 c0                	test   %eax,%eax
     59c:	75 5a                	jne    5f8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     59e:	8d 45 e0             	lea    -0x20(%ebp),%eax
     5a1:	8d 55 e4             	lea    -0x1c(%ebp),%edx
     5a4:	89 44 24 0c          	mov    %eax,0xc(%esp)
     5a8:	89 54 24 08          	mov    %edx,0x8(%esp)
     5ac:	89 7c 24 04          	mov    %edi,0x4(%esp)
     5b0:	89 34 24             	mov    %esi,(%esp)
     5b3:	e8 78 fb ff ff       	call   130 <gettoken>
     5b8:	85 c0                	test   %eax,%eax
     5ba:	74 3c                	je     5f8 <parseexec+0xd8>
      break;
    if(tok != 'a')
     5bc:	83 f8 61             	cmp    $0x61,%eax
     5bf:	74 0c                	je     5cd <parseexec+0xad>
      panic("syntax");
     5c1:	c7 04 24 52 13 00 00 	movl   $0x1352,(%esp)
     5c8:	e8 43 fe ff ff       	call   410 <panic>
    cmd->argv[argc] = q;
     5cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     5d3:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     5d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     5da:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     5de:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     5e1:	83 fb 09             	cmp    $0x9,%ebx
     5e4:	7e 8a                	jle    570 <parseexec+0x50>
      panic("too many args");
     5e6:	c7 04 24 59 13 00 00 	movl   $0x1359,(%esp)
     5ed:	e8 1e fe ff ff       	call   410 <panic>
     5f2:	e9 79 ff ff ff       	jmp    570 <parseexec+0x50>
     5f7:	90                   	nop
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     5f8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  cmd->eargv[argc] = 0;
  return ret;
}
     5fb:	8b 45 d0             	mov    -0x30(%ebp),%eax
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     5fe:	c7 44 9a 04 00 00 00 	movl   $0x0,0x4(%edx,%ebx,4)
     605:	00 
  cmd->eargv[argc] = 0;
     606:	c7 44 9a 2c 00 00 00 	movl   $0x0,0x2c(%edx,%ebx,4)
     60d:	00 
  return ret;
}
     60e:	83 c4 3c             	add    $0x3c,%esp
     611:	5b                   	pop    %ebx
     612:	5e                   	pop    %esi
     613:	5f                   	pop    %edi
     614:	5d                   	pop    %ebp
     615:	c3                   	ret    
     616:	66 90                	xchg   %ax,%ax
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
    return parseblock(ps, es);
     618:	89 7c 24 04          	mov    %edi,0x4(%esp)
     61c:	89 34 24             	mov    %esi,(%esp)
     61f:	e8 6c 01 00 00       	call   790 <parseblock>
     624:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     627:	8b 45 d0             	mov    -0x30(%ebp),%eax
     62a:	83 c4 3c             	add    $0x3c,%esp
     62d:	5b                   	pop    %ebx
     62e:	5e                   	pop    %esi
     62f:	5f                   	pop    %edi
     630:	5d                   	pop    %ebp
     631:	c3                   	ret    
     632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	83 ec 28             	sub    $0x28,%esp
     646:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     649:	8b 5d 08             	mov    0x8(%ebp),%ebx
     64c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     64f:	8b 75 0c             	mov    0xc(%ebp),%esi
     652:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     655:	89 1c 24             	mov    %ebx,(%esp)
     658:	89 74 24 04          	mov    %esi,0x4(%esp)
     65c:	e8 bf fe ff ff       	call   520 <parseexec>
  if(peek(ps, es, "|")){
     661:	c7 44 24 08 6c 13 00 	movl   $0x136c,0x8(%esp)
     668:	00 
     669:	89 74 24 04          	mov    %esi,0x4(%esp)
     66d:	89 1c 24             	mov    %ebx,(%esp)
struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
     670:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     672:	e8 39 fa ff ff       	call   b0 <peek>
     677:	85 c0                	test   %eax,%eax
     679:	75 15                	jne    690 <parsepipe+0x50>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
     67b:	89 f8                	mov    %edi,%eax
     67d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     680:	8b 75 f8             	mov    -0x8(%ebp),%esi
     683:	8b 7d fc             	mov    -0x4(%ebp),%edi
     686:	89 ec                	mov    %ebp,%esp
     688:	5d                   	pop    %ebp
     689:	c3                   	ret    
     68a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
     690:	89 74 24 04          	mov    %esi,0x4(%esp)
     694:	89 1c 24             	mov    %ebx,(%esp)
     697:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     69e:	00 
     69f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     6a6:	00 
     6a7:	e8 84 fa ff ff       	call   130 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6ac:	89 74 24 04          	mov    %esi,0x4(%esp)
     6b0:	89 1c 24             	mov    %ebx,(%esp)
     6b3:	e8 88 ff ff ff       	call   640 <parsepipe>
  }
  return cmd;
}
     6b8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6bb:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
     6be:	8b 75 f8             	mov    -0x8(%ebp),%esi
     6c1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6c4:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
     6c7:	89 ec                	mov    %ebp,%esp
     6c9:	5d                   	pop    %ebp
  struct cmd *cmd;
  
  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     6ca:	e9 51 fc ff ff       	jmp    320 <pipecmd>
     6cf:	90                   	nop

000006d0 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	57                   	push   %edi
     6d4:	56                   	push   %esi
     6d5:	53                   	push   %ebx
     6d6:	83 ec 1c             	sub    $0x1c,%esp
     6d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     6dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     6df:	89 1c 24             	mov    %ebx,(%esp)
     6e2:	89 74 24 04          	mov    %esi,0x4(%esp)
     6e6:	e8 55 ff ff ff       	call   640 <parsepipe>
     6eb:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     6ed:	eb 27                	jmp    716 <parseline+0x46>
     6ef:	90                   	nop
    gettoken(ps, es, 0, 0);
     6f0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     6f7:	00 
     6f8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     6ff:	00 
     700:	89 74 24 04          	mov    %esi,0x4(%esp)
     704:	89 1c 24             	mov    %ebx,(%esp)
     707:	e8 24 fa ff ff       	call   130 <gettoken>
    cmd = backcmd(cmd);
     70c:	89 3c 24             	mov    %edi,(%esp)
     70f:	e8 6c fb ff ff       	call   280 <backcmd>
     714:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     716:	c7 44 24 08 6e 13 00 	movl   $0x136e,0x8(%esp)
     71d:	00 
     71e:	89 74 24 04          	mov    %esi,0x4(%esp)
     722:	89 1c 24             	mov    %ebx,(%esp)
     725:	e8 86 f9 ff ff       	call   b0 <peek>
     72a:	85 c0                	test   %eax,%eax
     72c:	75 c2                	jne    6f0 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     72e:	c7 44 24 08 6a 13 00 	movl   $0x136a,0x8(%esp)
     735:	00 
     736:	89 74 24 04          	mov    %esi,0x4(%esp)
     73a:	89 1c 24             	mov    %ebx,(%esp)
     73d:	e8 6e f9 ff ff       	call   b0 <peek>
     742:	85 c0                	test   %eax,%eax
     744:	75 0a                	jne    750 <parseline+0x80>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
     746:	83 c4 1c             	add    $0x1c,%esp
     749:	89 f8                	mov    %edi,%eax
     74b:	5b                   	pop    %ebx
     74c:	5e                   	pop    %esi
     74d:	5f                   	pop    %edi
     74e:	5d                   	pop    %ebp
     74f:	c3                   	ret    
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
     750:	89 74 24 04          	mov    %esi,0x4(%esp)
     754:	89 1c 24             	mov    %ebx,(%esp)
     757:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     75e:	00 
     75f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     766:	00 
     767:	e8 c4 f9 ff ff       	call   130 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     76c:	89 74 24 04          	mov    %esi,0x4(%esp)
     770:	89 1c 24             	mov    %ebx,(%esp)
     773:	e8 58 ff ff ff       	call   6d0 <parseline>
     778:	89 7d 08             	mov    %edi,0x8(%ebp)
     77b:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
     77e:	83 c4 1c             	add    $0x1c,%esp
     781:	5b                   	pop    %ebx
     782:	5e                   	pop    %esi
     783:	5f                   	pop    %edi
     784:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
     785:	e9 46 fb ff ff       	jmp    2d0 <listcmd>
     78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000790 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	83 ec 28             	sub    $0x28,%esp
     796:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     799:	8b 5d 08             	mov    0x8(%ebp),%ebx
     79c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     79f:	8b 75 0c             	mov    0xc(%ebp),%esi
     7a2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     7a5:	c7 44 24 08 50 13 00 	movl   $0x1350,0x8(%esp)
     7ac:	00 
     7ad:	89 1c 24             	mov    %ebx,(%esp)
     7b0:	89 74 24 04          	mov    %esi,0x4(%esp)
     7b4:	e8 f7 f8 ff ff       	call   b0 <peek>
     7b9:	85 c0                	test   %eax,%eax
     7bb:	0f 84 87 00 00 00    	je     848 <parseblock+0xb8>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
     7c1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     7c8:	00 
     7c9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     7d0:	00 
     7d1:	89 74 24 04          	mov    %esi,0x4(%esp)
     7d5:	89 1c 24             	mov    %ebx,(%esp)
     7d8:	e8 53 f9 ff ff       	call   130 <gettoken>
  cmd = parseline(ps, es);
     7dd:	89 74 24 04          	mov    %esi,0x4(%esp)
     7e1:	89 1c 24             	mov    %ebx,(%esp)
     7e4:	e8 e7 fe ff ff       	call   6d0 <parseline>
  if(!peek(ps, es, ")"))
     7e9:	c7 44 24 08 8c 13 00 	movl   $0x138c,0x8(%esp)
     7f0:	00 
     7f1:	89 74 24 04          	mov    %esi,0x4(%esp)
     7f5:	89 1c 24             	mov    %ebx,(%esp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
     7f8:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     7fa:	e8 b1 f8 ff ff       	call   b0 <peek>
     7ff:	85 c0                	test   %eax,%eax
     801:	75 0c                	jne    80f <parseblock+0x7f>
    panic("syntax - missing )");
     803:	c7 04 24 7b 13 00 00 	movl   $0x137b,(%esp)
     80a:	e8 01 fc ff ff       	call   410 <panic>
  gettoken(ps, es, 0, 0);
     80f:	89 74 24 04          	mov    %esi,0x4(%esp)
     813:	89 1c 24             	mov    %ebx,(%esp)
     816:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     81d:	00 
     81e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     825:	00 
     826:	e8 05 f9 ff ff       	call   130 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     82b:	89 74 24 08          	mov    %esi,0x8(%esp)
     82f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     833:	89 3c 24             	mov    %edi,(%esp)
     836:	e8 05 fc ff ff       	call   440 <parseredirs>
  return cmd;
}
     83b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     83e:	8b 75 f8             	mov    -0x8(%ebp),%esi
     841:	8b 7d fc             	mov    -0x4(%ebp),%edi
     844:	89 ec                	mov    %ebp,%esp
     846:	5d                   	pop    %ebp
     847:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
     848:	c7 04 24 70 13 00 00 	movl   $0x1370,(%esp)
     84f:	e8 bc fb ff ff       	call   410 <panic>
     854:	e9 68 ff ff ff       	jmp    7c1 <parseblock+0x31>
     859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000860 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	56                   	push   %esi
     864:	53                   	push   %ebx
     865:	83 ec 10             	sub    $0x10,%esp
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
     868:	8b 5d 08             	mov    0x8(%ebp),%ebx
     86b:	89 1c 24             	mov    %ebx,(%esp)
     86e:	e8 5d 04 00 00       	call   cd0 <strlen>
     873:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     875:	8d 45 08             	lea    0x8(%ebp),%eax
     878:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     87c:	89 04 24             	mov    %eax,(%esp)
     87f:	e8 4c fe ff ff       	call   6d0 <parseline>
  peek(&s, es, "");
     884:	c7 44 24 08 bb 13 00 	movl   $0x13bb,0x8(%esp)
     88b:	00 
     88c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
{
  char *es;
  struct cmd *cmd;
  
  es = s + strlen(s);
  cmd = parseline(&s, es);
     890:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     892:	8d 45 08             	lea    0x8(%ebp),%eax
     895:	89 04 24             	mov    %eax,(%esp)
     898:	e8 13 f8 ff ff       	call   b0 <peek>
  if(s != es){
     89d:	8b 45 08             	mov    0x8(%ebp),%eax
     8a0:	39 d8                	cmp    %ebx,%eax
     8a2:	74 24                	je     8c8 <parsecmd+0x68>
    printf(2, "leftovers: %s\n", s);
     8a4:	89 44 24 08          	mov    %eax,0x8(%esp)
     8a8:	c7 44 24 04 8e 13 00 	movl   $0x138e,0x4(%esp)
     8af:	00 
     8b0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     8b7:	e8 34 07 00 00       	call   ff0 <printf>
    panic("syntax");
     8bc:	c7 04 24 52 13 00 00 	movl   $0x1352,(%esp)
     8c3:	e8 48 fb ff ff       	call   410 <panic>
  }
  nulterminate(cmd);
     8c8:	89 34 24             	mov    %esi,(%esp)
     8cb:	e8 30 f7 ff ff       	call   0 <nulterminate>
  return cmd;
}
     8d0:	83 c4 10             	add    $0x10,%esp
     8d3:	89 f0                	mov    %esi,%eax
     8d5:	5b                   	pop    %ebx
     8d6:	5e                   	pop    %esi
     8d7:	5d                   	pop    %ebp
     8d8:	c3                   	ret    
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008e0 <fork1>:
  exit();
}

int
fork1(void)
{
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 28             	sub    $0x28,%esp
  int pid;
  
  pid = fork();
     8e6:	e8 95 05 00 00       	call   e80 <fork>
  if(pid == -1)
     8eb:	83 f8 ff             	cmp    $0xffffffff,%eax
     8ee:	74 08                	je     8f8 <fork1+0x18>
    panic("fork");
  return pid;
}
     8f0:	c9                   	leave  
     8f1:	c3                   	ret    
     8f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int pid;
  
  pid = fork();
  if(pid == -1)
    panic("fork");
     8f8:	c7 04 24 9d 13 00 00 	movl   $0x139d,(%esp)
     8ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
     902:	e8 09 fb ff ff       	call   410 <panic>
     907:	8b 45 f4             	mov    -0xc(%ebp),%eax
  return pid;
}
     90a:	c9                   	leave  
     90b:	c3                   	ret    
     90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000910 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	83 ec 18             	sub    $0x18,%esp
     916:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     919:	8b 5d 08             	mov    0x8(%ebp),%ebx
     91c:	89 75 fc             	mov    %esi,-0x4(%ebp)
     91f:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     922:	c7 44 24 04 a2 13 00 	movl   $0x13a2,0x4(%esp)
     929:	00 
     92a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     931:	e8 ba 06 00 00       	call   ff0 <printf>
  memset(buf, 0, nbuf);
     936:	89 74 24 08          	mov    %esi,0x8(%esp)
     93a:	89 1c 24             	mov    %ebx,(%esp)
     93d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     944:	00 
     945:	e8 a6 03 00 00       	call   cf0 <memset>
  gets(buf, nbuf);
     94a:	89 74 24 04          	mov    %esi,0x4(%esp)
     94e:	89 1c 24             	mov    %ebx,(%esp)
     951:	e8 ca 04 00 00       	call   e20 <gets>
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
     956:	8b 75 fc             	mov    -0x4(%ebp),%esi
getcmd(char *buf, int nbuf)
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
     959:	80 3b 01             	cmpb   $0x1,(%ebx)
    return -1;
  return 0;
}
     95c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
getcmd(char *buf, int nbuf)
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
     95f:	19 c0                	sbb    %eax,%eax
    return -1;
  return 0;
}
     961:	89 ec                	mov    %ebp,%esp
     963:	5d                   	pop    %ebp
     964:	c3                   	ret    
     965:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000970 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
     970:	55                   	push   %ebp
     971:	89 e5                	mov    %esp,%ebp
     973:	53                   	push   %ebx
     974:	83 ec 24             	sub    $0x24,%esp
     977:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     97a:	85 db                	test   %ebx,%ebx
     97c:	74 42                	je     9c0 <runcmd+0x50>
    exit();
  
  switch(cmd->type){
     97e:	83 3b 05             	cmpl   $0x5,(%ebx)
     981:	76 45                	jbe    9c8 <runcmd+0x58>
  default:
    panic("runcmd");
     983:	c7 04 24 a5 13 00 00 	movl   $0x13a5,(%esp)
     98a:	e8 81 fa ff ff       	call   410 <panic>

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
     98f:	8b 43 04             	mov    0x4(%ebx),%eax
     992:	85 c0                	test   %eax,%eax
     994:	74 2a                	je     9c0 <runcmd+0x50>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
     996:	8d 53 04             	lea    0x4(%ebx),%edx
     999:	89 54 24 04          	mov    %edx,0x4(%esp)
     99d:	89 04 24             	mov    %eax,(%esp)
     9a0:	e8 1b 05 00 00       	call   ec0 <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     9a5:	8b 43 04             	mov    0x4(%ebx),%eax
     9a8:	c7 44 24 04 ac 13 00 	movl   $0x13ac,0x4(%esp)
     9af:	00 
     9b0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     9b7:	89 44 24 08          	mov    %eax,0x8(%esp)
     9bb:	e8 30 06 00 00       	call   ff0 <printf>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     9c0:	e8 c3 04 00 00       	call   e88 <exit>
     9c5:	8d 76 00             	lea    0x0(%esi),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();
  
  switch(cmd->type){
     9c8:	8b 03                	mov    (%ebx),%eax
     9ca:	ff 24 85 18 13 00 00 	jmp    *0x1318(,%eax,4)
     9d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wait();
    break;
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
     9d8:	e8 03 ff ff ff       	call   8e0 <fork1>
     9dd:	85 c0                	test   %eax,%eax
     9df:	90                   	nop
     9e0:	0f 84 a7 00 00 00    	je     a8d <runcmd+0x11d>
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     9e6:	e8 9d 04 00 00       	call   e88 <exit>
     9eb:	90                   	nop
     9ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
     9f0:	e8 eb fe ff ff       	call   8e0 <fork1>
     9f5:	85 c0                	test   %eax,%eax
     9f7:	0f 84 a3 00 00 00    	je     aa0 <runcmd+0x130>
     9fd:	8d 76 00             	lea    0x0(%esi),%esi
      runcmd(lcmd->left);
    wait();
     a00:	e8 8b 04 00 00       	call   e90 <wait>
    runcmd(lcmd->right);
     a05:	8b 43 08             	mov    0x8(%ebx),%eax
     a08:	89 04 24             	mov    %eax,(%esp)
     a0b:	e8 60 ff ff ff       	call   970 <runcmd>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     a10:	e8 73 04 00 00       	call   e88 <exit>
     a15:	8d 76 00             	lea    0x0(%esi),%esi
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
     a18:	8d 45 f0             	lea    -0x10(%ebp),%eax
     a1b:	89 04 24             	mov    %eax,(%esp)
     a1e:	e8 75 04 00 00       	call   e98 <pipe>
     a23:	85 c0                	test   %eax,%eax
     a25:	0f 88 25 01 00 00    	js     b50 <runcmd+0x1e0>
      panic("pipe");
    if(fork1() == 0){
     a2b:	e8 b0 fe ff ff       	call   8e0 <fork1>
     a30:	85 c0                	test   %eax,%eax
     a32:	0f 84 b8 00 00 00    	je     af0 <runcmd+0x180>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
     a38:	e8 a3 fe ff ff       	call   8e0 <fork1>
     a3d:	85 c0                	test   %eax,%eax
     a3f:	90                   	nop
     a40:	74 6e                	je     ab0 <runcmd+0x140>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     a42:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a45:	89 04 24             	mov    %eax,(%esp)
     a48:	e8 63 04 00 00       	call   eb0 <close>
    close(p[1]);
     a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a50:	89 04 24             	mov    %eax,(%esp)
     a53:	e8 58 04 00 00       	call   eb0 <close>
    wait();
     a58:	e8 33 04 00 00       	call   e90 <wait>
    wait();
     a5d:	e8 2e 04 00 00       	call   e90 <wait>
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
    break;
  }
  exit();
     a62:	e8 21 04 00 00       	call   e88 <exit>
     a67:	90                   	nop
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
     a68:	8b 43 14             	mov    0x14(%ebx),%eax
     a6b:	89 04 24             	mov    %eax,(%esp)
     a6e:	e8 3d 04 00 00       	call   eb0 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     a73:	8b 43 10             	mov    0x10(%ebx),%eax
     a76:	89 44 24 04          	mov    %eax,0x4(%esp)
     a7a:	8b 43 08             	mov    0x8(%ebx),%eax
     a7d:	89 04 24             	mov    %eax,(%esp)
     a80:	e8 43 04 00 00       	call   ec8 <open>
     a85:	85 c0                	test   %eax,%eax
     a87:	0f 88 a3 00 00 00    	js     b30 <runcmd+0x1c0>
    break;
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
     a8d:	8b 43 04             	mov    0x4(%ebx),%eax
     a90:	89 04 24             	mov    %eax,(%esp)
     a93:	e8 d8 fe ff ff       	call   970 <runcmd>
    break;
  }
  exit();
     a98:	e8 eb 03 00 00       	call   e88 <exit>
     a9d:	8d 76 00             	lea    0x0(%esi),%esi
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
      runcmd(lcmd->left);
     aa0:	8b 43 04             	mov    0x4(%ebx),%eax
     aa3:	89 04 24             	mov    %eax,(%esp)
     aa6:	e8 c5 fe ff ff       	call   970 <runcmd>
     aab:	e9 4d ff ff ff       	jmp    9fd <runcmd+0x8d>
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
     ab0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     ab7:	e8 f4 03 00 00       	call   eb0 <close>
      dup(p[0]);
     abc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     abf:	89 04 24             	mov    %eax,(%esp)
     ac2:	e8 39 04 00 00       	call   f00 <dup>
      close(p[0]);
     ac7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aca:	89 04 24             	mov    %eax,(%esp)
     acd:	e8 de 03 00 00       	call   eb0 <close>
      close(p[1]);
     ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad5:	89 04 24             	mov    %eax,(%esp)
     ad8:	e8 d3 03 00 00       	call   eb0 <close>
      runcmd(pcmd->right);
     add:	8b 43 08             	mov    0x8(%ebx),%eax
     ae0:	89 04 24             	mov    %eax,(%esp)
     ae3:	e8 88 fe ff ff       	call   970 <runcmd>
     ae8:	e9 55 ff ff ff       	jmp    a42 <runcmd+0xd2>
     aed:	8d 76 00             	lea    0x0(%esi),%esi
  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
     af0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     af7:	e8 b4 03 00 00       	call   eb0 <close>
      dup(p[1]);
     afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aff:	89 04 24             	mov    %eax,(%esp)
     b02:	e8 f9 03 00 00       	call   f00 <dup>
      close(p[0]);
     b07:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b0a:	89 04 24             	mov    %eax,(%esp)
     b0d:	e8 9e 03 00 00       	call   eb0 <close>
      close(p[1]);
     b12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b15:	89 04 24             	mov    %eax,(%esp)
     b18:	e8 93 03 00 00       	call   eb0 <close>
      runcmd(pcmd->left);
     b1d:	8b 43 04             	mov    0x4(%ebx),%eax
     b20:	89 04 24             	mov    %eax,(%esp)
     b23:	e8 48 fe ff ff       	call   970 <runcmd>
     b28:	e9 0b ff ff ff       	jmp    a38 <runcmd+0xc8>
     b2d:	8d 76 00             	lea    0x0(%esi),%esi

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
     b30:	8b 43 08             	mov    0x8(%ebx),%eax
     b33:	c7 44 24 04 bc 13 00 	movl   $0x13bc,0x4(%esp)
     b3a:	00 
     b3b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     b42:	89 44 24 08          	mov    %eax,0x8(%esp)
     b46:	e8 a5 04 00 00       	call   ff0 <printf>
      exit();
     b4b:	e8 38 03 00 00       	call   e88 <exit>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
     b50:	c7 04 24 cc 13 00 00 	movl   $0x13cc,(%esp)
     b57:	e8 b4 f8 ff ff       	call   410 <panic>
     b5c:	e9 ca fe ff ff       	jmp    a2b <runcmd+0xbb>
     b61:	eb 0d                	jmp    b70 <main>
     b63:	90                   	nop
     b64:	90                   	nop
     b65:	90                   	nop
     b66:	90                   	nop
     b67:	90                   	nop
     b68:	90                   	nop
     b69:	90                   	nop
     b6a:	90                   	nop
     b6b:	90                   	nop
     b6c:	90                   	nop
     b6d:	90                   	nop
     b6e:	90                   	nop
     b6f:	90                   	nop

00000b70 <main>:
  return 0;
}

int
main(void)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	83 e4 f0             	and    $0xfffffff0,%esp
     b76:	83 ec 10             	sub    $0x10,%esp
     b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     b80:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     b87:	00 
     b88:	c7 04 24 d1 13 00 00 	movl   $0x13d1,(%esp)
     b8f:	e8 34 03 00 00       	call   ec8 <open>
     b94:	85 c0                	test   %eax,%eax
     b96:	78 28                	js     bc0 <main+0x50>
    if(fd >= 3){
     b98:	83 f8 02             	cmp    $0x2,%eax
     b9b:	7e e3                	jle    b80 <main+0x10>
      close(fd);
     b9d:	89 04 24             	mov    %eax,(%esp)
     ba0:	e8 0b 03 00 00       	call   eb0 <close>
      break;
     ba5:	eb 19                	jmp    bc0 <main+0x50>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
     ba7:	c7 04 24 20 14 00 00 	movl   $0x1420,(%esp)
     bae:	e8 ad fc ff ff       	call   860 <parsecmd>
     bb3:	89 04 24             	mov    %eax,(%esp)
     bb6:	e8 b5 fd ff ff       	call   970 <runcmd>
    wait();
     bbb:	e8 d0 02 00 00       	call   e90 <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     bc0:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
     bc7:	00 
     bc8:	c7 04 24 20 14 00 00 	movl   $0x1420,(%esp)
     bcf:	e8 3c fd ff ff       	call   910 <getcmd>
     bd4:	85 c0                	test   %eax,%eax
     bd6:	78 70                	js     c48 <main+0xd8>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     bd8:	80 3d 20 14 00 00 63 	cmpb   $0x63,0x1420
     bdf:	75 09                	jne    bea <main+0x7a>
     be1:	80 3d 21 14 00 00 64 	cmpb   $0x64,0x1421
     be8:	74 0e                	je     bf8 <main+0x88>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
     bea:	e8 f1 fc ff ff       	call   8e0 <fork1>
     bef:	85 c0                	test   %eax,%eax
     bf1:	75 c8                	jne    bbb <main+0x4b>
     bf3:	eb b2                	jmp    ba7 <main+0x37>
     bf5:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     bf8:	80 3d 22 14 00 00 20 	cmpb   $0x20,0x1422
     bff:	90                   	nop
     c00:	75 e8                	jne    bea <main+0x7a>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     c02:	c7 04 24 20 14 00 00 	movl   $0x1420,(%esp)
     c09:	e8 c2 00 00 00       	call   cd0 <strlen>
      if(chdir(buf+3) < 0)
     c0e:	c7 04 24 23 14 00 00 	movl   $0x1423,(%esp)
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     c15:	c6 80 1f 14 00 00 00 	movb   $0x0,0x141f(%eax)
      if(chdir(buf+3) < 0)
     c1c:	e8 d7 02 00 00       	call   ef8 <chdir>
     c21:	85 c0                	test   %eax,%eax
     c23:	79 9b                	jns    bc0 <main+0x50>
        printf(2, "cannot cd %s\n", buf+3);
     c25:	c7 44 24 08 23 14 00 	movl   $0x1423,0x8(%esp)
     c2c:	00 
     c2d:	c7 44 24 04 d9 13 00 	movl   $0x13d9,0x4(%esp)
     c34:	00 
     c35:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     c3c:	e8 af 03 00 00       	call   ff0 <printf>
     c41:	e9 7a ff ff ff       	jmp    bc0 <main+0x50>
     c46:	66 90                	xchg   %ax,%ax
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     c48:	e8 3b 02 00 00       	call   e88 <exit>
     c4d:	90                   	nop
     c4e:	90                   	nop
     c4f:	90                   	nop

00000c50 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
     c50:	55                   	push   %ebp
     c51:	31 d2                	xor    %edx,%edx
     c53:	89 e5                	mov    %esp,%ebp
     c55:	8b 45 08             	mov    0x8(%ebp),%eax
     c58:	53                   	push   %ebx
     c59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c60:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
     c64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     c67:	83 c2 01             	add    $0x1,%edx
     c6a:	84 c9                	test   %cl,%cl
     c6c:	75 f2                	jne    c60 <strcpy+0x10>
    ;
  return os;
}
     c6e:	5b                   	pop    %ebx
     c6f:	5d                   	pop    %ebp
     c70:	c3                   	ret    
     c71:	eb 0d                	jmp    c80 <strcmp>
     c73:	90                   	nop
     c74:	90                   	nop
     c75:	90                   	nop
     c76:	90                   	nop
     c77:	90                   	nop
     c78:	90                   	nop
     c79:	90                   	nop
     c7a:	90                   	nop
     c7b:	90                   	nop
     c7c:	90                   	nop
     c7d:	90                   	nop
     c7e:	90                   	nop
     c7f:	90                   	nop

00000c80 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	53                   	push   %ebx
     c84:	8b 4d 08             	mov    0x8(%ebp),%ecx
     c87:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
     c8a:	0f b6 01             	movzbl (%ecx),%eax
     c8d:	84 c0                	test   %al,%al
     c8f:	75 14                	jne    ca5 <strcmp+0x25>
     c91:	eb 25                	jmp    cb8 <strcmp+0x38>
     c93:	90                   	nop
     c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p++, q++;
     c98:	83 c1 01             	add    $0x1,%ecx
     c9b:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     c9e:	0f b6 01             	movzbl (%ecx),%eax
     ca1:	84 c0                	test   %al,%al
     ca3:	74 13                	je     cb8 <strcmp+0x38>
     ca5:	0f b6 1a             	movzbl (%edx),%ebx
     ca8:	38 d8                	cmp    %bl,%al
     caa:	74 ec                	je     c98 <strcmp+0x18>
     cac:	0f b6 db             	movzbl %bl,%ebx
     caf:	0f b6 c0             	movzbl %al,%eax
     cb2:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
     cb4:	5b                   	pop    %ebx
     cb5:	5d                   	pop    %ebp
     cb6:	c3                   	ret    
     cb7:	90                   	nop
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     cb8:	0f b6 1a             	movzbl (%edx),%ebx
     cbb:	31 c0                	xor    %eax,%eax
     cbd:	0f b6 db             	movzbl %bl,%ebx
     cc0:	29 d8                	sub    %ebx,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
}
     cc2:	5b                   	pop    %ebx
     cc3:	5d                   	pop    %ebp
     cc4:	c3                   	ret    
     cc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cd0 <strlen>:

uint
strlen(char *s)
{
     cd0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
     cd1:	31 d2                	xor    %edx,%edx
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
     cd3:	89 e5                	mov    %esp,%ebp
  int n;

  for(n = 0; s[n]; n++)
     cd5:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
     cd7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     cda:	80 39 00             	cmpb   $0x0,(%ecx)
     cdd:	74 0c                	je     ceb <strlen+0x1b>
     cdf:	90                   	nop
     ce0:	83 c2 01             	add    $0x1,%edx
     ce3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     ce7:	89 d0                	mov    %edx,%eax
     ce9:	75 f5                	jne    ce0 <strlen+0x10>
    ;
  return n;
}
     ceb:	5d                   	pop    %ebp
     cec:	c3                   	ret    
     ced:	8d 76 00             	lea    0x0(%esi),%esi

00000cf0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	8b 4d 10             	mov    0x10(%ebp),%ecx
     cf6:	53                   	push   %ebx
     cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  char *d;
  
  d = dst;
  while(n-- > 0)
     cfa:	85 c9                	test   %ecx,%ecx
     cfc:	74 14                	je     d12 <memset+0x22>
     cfe:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
     d02:	31 d2                	xor    %edx,%edx
     d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *d++ = c;
     d08:	88 1c 10             	mov    %bl,(%eax,%edx,1)
     d0b:	83 c2 01             	add    $0x1,%edx
memset(void *dst, int c, uint n)
{
  char *d;
  
  d = dst;
  while(n-- > 0)
     d0e:	39 ca                	cmp    %ecx,%edx
     d10:	75 f6                	jne    d08 <memset+0x18>
    *d++ = c;
  return dst;
}
     d12:	5b                   	pop    %ebx
     d13:	5d                   	pop    %ebp
     d14:	c3                   	ret    
     d15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d20 <strchr>:

char*
strchr(const char *s, char c)
{
     d20:	55                   	push   %ebp
     d21:	89 e5                	mov    %esp,%ebp
     d23:	8b 45 08             	mov    0x8(%ebp),%eax
     d26:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     d2a:	0f b6 10             	movzbl (%eax),%edx
     d2d:	84 d2                	test   %dl,%dl
     d2f:	75 11                	jne    d42 <strchr+0x22>
     d31:	eb 15                	jmp    d48 <strchr+0x28>
     d33:	90                   	nop
     d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d38:	83 c0 01             	add    $0x1,%eax
     d3b:	0f b6 10             	movzbl (%eax),%edx
     d3e:	84 d2                	test   %dl,%dl
     d40:	74 06                	je     d48 <strchr+0x28>
    if(*s == c)
     d42:	38 ca                	cmp    %cl,%dl
     d44:	75 f2                	jne    d38 <strchr+0x18>
      return (char*) s;
  return 0;
}
     d46:	5d                   	pop    %ebp
     d47:	c3                   	ret    
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     d48:	31 c0                	xor    %eax,%eax
    if(*s == c)
      return (char*) s;
  return 0;
}
     d4a:	5d                   	pop    %ebp
     d4b:	90                   	nop
     d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d50:	c3                   	ret    
     d51:	eb 0d                	jmp    d60 <atoi>
     d53:	90                   	nop
     d54:	90                   	nop
     d55:	90                   	nop
     d56:	90                   	nop
     d57:	90                   	nop
     d58:	90                   	nop
     d59:	90                   	nop
     d5a:	90                   	nop
     d5b:	90                   	nop
     d5c:	90                   	nop
     d5d:	90                   	nop
     d5e:	90                   	nop
     d5f:	90                   	nop

00000d60 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     d60:	55                   	push   %ebp
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d61:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
     d63:	89 e5                	mov    %esp,%ebp
     d65:	8b 4d 08             	mov    0x8(%ebp),%ecx
     d68:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d69:	0f b6 11             	movzbl (%ecx),%edx
     d6c:	8d 5a d0             	lea    -0x30(%edx),%ebx
     d6f:	80 fb 09             	cmp    $0x9,%bl
     d72:	77 1c                	ja     d90 <atoi+0x30>
     d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
     d78:	0f be d2             	movsbl %dl,%edx
     d7b:	83 c1 01             	add    $0x1,%ecx
     d7e:	8d 04 80             	lea    (%eax,%eax,4),%eax
     d81:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d85:	0f b6 11             	movzbl (%ecx),%edx
     d88:	8d 5a d0             	lea    -0x30(%edx),%ebx
     d8b:	80 fb 09             	cmp    $0x9,%bl
     d8e:	76 e8                	jbe    d78 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
     d90:	5b                   	pop    %ebx
     d91:	5d                   	pop    %ebp
     d92:	c3                   	ret    
     d93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000da0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	56                   	push   %esi
     da4:	8b 45 08             	mov    0x8(%ebp),%eax
     da7:	53                   	push   %ebx
     da8:	8b 5d 10             	mov    0x10(%ebp),%ebx
     dab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     dae:	85 db                	test   %ebx,%ebx
     db0:	7e 14                	jle    dc6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
     db2:	31 d2                	xor    %edx,%edx
     db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
     db8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     dbc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     dbf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     dc2:	39 da                	cmp    %ebx,%edx
     dc4:	75 f2                	jne    db8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     dc6:	5b                   	pop    %ebx
     dc7:	5e                   	pop    %esi
     dc8:	5d                   	pop    %ebp
     dc9:	c3                   	ret    
     dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000dd0 <stat>:
  return buf;
}

int
stat(char *n, struct stat *st)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(char *n, struct stat *st)
{
     dd9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     ddc:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
     ddf:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     de4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     deb:	00 
     dec:	89 04 24             	mov    %eax,(%esp)
     def:	e8 d4 00 00 00       	call   ec8 <open>
  if(fd < 0)
     df4:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     df6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     df8:	78 19                	js     e13 <stat+0x43>
    return -1;
  r = fstat(fd, st);
     dfa:	8b 45 0c             	mov    0xc(%ebp),%eax
     dfd:	89 1c 24             	mov    %ebx,(%esp)
     e00:	89 44 24 04          	mov    %eax,0x4(%esp)
     e04:	e8 d7 00 00 00       	call   ee0 <fstat>
  close(fd);
     e09:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
     e0c:	89 c6                	mov    %eax,%esi
  close(fd);
     e0e:	e8 9d 00 00 00       	call   eb0 <close>
  return r;
}
     e13:	89 f0                	mov    %esi,%eax
     e15:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     e18:	8b 75 fc             	mov    -0x4(%ebp),%esi
     e1b:	89 ec                	mov    %ebp,%esp
     e1d:	5d                   	pop    %ebp
     e1e:	c3                   	ret    
     e1f:	90                   	nop

00000e20 <gets>:
  return 0;
}

char*
gets(char *buf, int max)
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	57                   	push   %edi
     e24:	56                   	push   %esi
     e25:	31 f6                	xor    %esi,%esi
     e27:	53                   	push   %ebx
     e28:	83 ec 2c             	sub    $0x2c,%esp
     e2b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e2e:	eb 06                	jmp    e36 <gets+0x16>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     e30:	3c 0a                	cmp    $0xa,%al
     e32:	74 39                	je     e6d <gets+0x4d>
     e34:	89 de                	mov    %ebx,%esi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e36:	8d 5e 01             	lea    0x1(%esi),%ebx
     e39:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     e3c:	7d 31                	jge    e6f <gets+0x4f>
    cc = read(0, &c, 1);
     e3e:	8d 45 e7             	lea    -0x19(%ebp),%eax
     e41:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e48:	00 
     e49:	89 44 24 04          	mov    %eax,0x4(%esp)
     e4d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e54:	e8 47 00 00 00       	call   ea0 <read>
    if(cc < 1)
     e59:	85 c0                	test   %eax,%eax
     e5b:	7e 12                	jle    e6f <gets+0x4f>
      break;
    buf[i++] = c;
     e5d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     e61:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
     e65:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     e69:	3c 0d                	cmp    $0xd,%al
     e6b:	75 c3                	jne    e30 <gets+0x10>
     e6d:	89 de                	mov    %ebx,%esi
      break;
  }
  buf[i] = '\0';
     e6f:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
     e73:	89 f8                	mov    %edi,%eax
     e75:	83 c4 2c             	add    $0x2c,%esp
     e78:	5b                   	pop    %ebx
     e79:	5e                   	pop    %esi
     e7a:	5f                   	pop    %edi
     e7b:	5d                   	pop    %ebp
     e7c:	c3                   	ret    
     e7d:	90                   	nop
     e7e:	90                   	nop
     e7f:	90                   	nop

00000e80 <fork>:
     e80:	b8 01 00 00 00       	mov    $0x1,%eax
     e85:	cd 30                	int    $0x30
     e87:	c3                   	ret    

00000e88 <exit>:
     e88:	b8 02 00 00 00       	mov    $0x2,%eax
     e8d:	cd 30                	int    $0x30
     e8f:	c3                   	ret    

00000e90 <wait>:
     e90:	b8 03 00 00 00       	mov    $0x3,%eax
     e95:	cd 30                	int    $0x30
     e97:	c3                   	ret    

00000e98 <pipe>:
     e98:	b8 04 00 00 00       	mov    $0x4,%eax
     e9d:	cd 30                	int    $0x30
     e9f:	c3                   	ret    

00000ea0 <read>:
     ea0:	b8 06 00 00 00       	mov    $0x6,%eax
     ea5:	cd 30                	int    $0x30
     ea7:	c3                   	ret    

00000ea8 <write>:
     ea8:	b8 05 00 00 00       	mov    $0x5,%eax
     ead:	cd 30                	int    $0x30
     eaf:	c3                   	ret    

00000eb0 <close>:
     eb0:	b8 07 00 00 00       	mov    $0x7,%eax
     eb5:	cd 30                	int    $0x30
     eb7:	c3                   	ret    

00000eb8 <kill>:
     eb8:	b8 08 00 00 00       	mov    $0x8,%eax
     ebd:	cd 30                	int    $0x30
     ebf:	c3                   	ret    

00000ec0 <exec>:
     ec0:	b8 09 00 00 00       	mov    $0x9,%eax
     ec5:	cd 30                	int    $0x30
     ec7:	c3                   	ret    

00000ec8 <open>:
     ec8:	b8 0a 00 00 00       	mov    $0xa,%eax
     ecd:	cd 30                	int    $0x30
     ecf:	c3                   	ret    

00000ed0 <mknod>:
     ed0:	b8 0b 00 00 00       	mov    $0xb,%eax
     ed5:	cd 30                	int    $0x30
     ed7:	c3                   	ret    

00000ed8 <unlink>:
     ed8:	b8 0c 00 00 00       	mov    $0xc,%eax
     edd:	cd 30                	int    $0x30
     edf:	c3                   	ret    

00000ee0 <fstat>:
     ee0:	b8 0d 00 00 00       	mov    $0xd,%eax
     ee5:	cd 30                	int    $0x30
     ee7:	c3                   	ret    

00000ee8 <link>:
     ee8:	b8 0e 00 00 00       	mov    $0xe,%eax
     eed:	cd 30                	int    $0x30
     eef:	c3                   	ret    

00000ef0 <mkdir>:
     ef0:	b8 0f 00 00 00       	mov    $0xf,%eax
     ef5:	cd 30                	int    $0x30
     ef7:	c3                   	ret    

00000ef8 <chdir>:
     ef8:	b8 10 00 00 00       	mov    $0x10,%eax
     efd:	cd 30                	int    $0x30
     eff:	c3                   	ret    

00000f00 <dup>:
     f00:	b8 11 00 00 00       	mov    $0x11,%eax
     f05:	cd 30                	int    $0x30
     f07:	c3                   	ret    

00000f08 <getpid>:
     f08:	b8 12 00 00 00       	mov    $0x12,%eax
     f0d:	cd 30                	int    $0x30
     f0f:	c3                   	ret    

00000f10 <sbrk>:
     f10:	b8 13 00 00 00       	mov    $0x13,%eax
     f15:	cd 30                	int    $0x30
     f17:	c3                   	ret    

00000f18 <sleep>:
     f18:	b8 14 00 00 00       	mov    $0x14,%eax
     f1d:	cd 30                	int    $0x30
     f1f:	c3                   	ret    

00000f20 <getticks>:
     f20:	b8 15 00 00 00       	mov    $0x15,%eax
     f25:	cd 30                	int    $0x30
     f27:	c3                   	ret    
     f28:	90                   	nop
     f29:	90                   	nop
     f2a:	90                   	nop
     f2b:	90                   	nop
     f2c:	90                   	nop
     f2d:	90                   	nop
     f2e:	90                   	nop
     f2f:	90                   	nop

00000f30 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	83 ec 28             	sub    $0x28,%esp
     f36:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
     f39:	8d 55 f4             	lea    -0xc(%ebp),%edx
     f3c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f43:	00 
     f44:	89 54 24 04          	mov    %edx,0x4(%esp)
     f48:	89 04 24             	mov    %eax,(%esp)
     f4b:	e8 58 ff ff ff       	call   ea8 <write>
}
     f50:	c9                   	leave  
     f51:	c3                   	ret    
     f52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f60 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	57                   	push   %edi
     f64:	89 c7                	mov    %eax,%edi
     f66:	56                   	push   %esi
     f67:	89 ce                	mov    %ecx,%esi
     f69:	53                   	push   %ebx
     f6a:	83 ec 2c             	sub    $0x2c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f70:	85 c9                	test   %ecx,%ecx
     f72:	74 04                	je     f78 <printint+0x18>
     f74:	85 d2                	test   %edx,%edx
     f76:	78 5d                	js     fd5 <printint+0x75>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f78:	89 d0                	mov    %edx,%eax
     f7a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     f81:	31 c9                	xor    %ecx,%ecx
     f83:	8d 5d d8             	lea    -0x28(%ebp),%ebx
     f86:	66 90                	xchg   %ax,%ax
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     f88:	31 d2                	xor    %edx,%edx
     f8a:	f7 f6                	div    %esi
     f8c:	0f b6 92 ee 13 00 00 	movzbl 0x13ee(%edx),%edx
     f93:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
     f96:	83 c1 01             	add    $0x1,%ecx
  }while((x /= base) != 0);
     f99:	85 c0                	test   %eax,%eax
     f9b:	75 eb                	jne    f88 <printint+0x28>
  if(neg)
     f9d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     fa0:	85 c0                	test   %eax,%eax
     fa2:	74 08                	je     fac <printint+0x4c>
    buf[i++] = '-';
     fa4:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
     fa9:	83 c1 01             	add    $0x1,%ecx

  while(--i >= 0)
     fac:	8d 71 ff             	lea    -0x1(%ecx),%esi
     faf:	01 f3                	add    %esi,%ebx
     fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
     fb8:	0f be 13             	movsbl (%ebx),%edx
     fbb:	89 f8                	mov    %edi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     fbd:	83 ee 01             	sub    $0x1,%esi
     fc0:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
     fc3:	e8 68 ff ff ff       	call   f30 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     fc8:	83 fe ff             	cmp    $0xffffffff,%esi
     fcb:	75 eb                	jne    fb8 <printint+0x58>
    putc(fd, buf[i]);
}
     fcd:	83 c4 2c             	add    $0x2c,%esp
     fd0:	5b                   	pop    %ebx
     fd1:	5e                   	pop    %esi
     fd2:	5f                   	pop    %edi
     fd3:	5d                   	pop    %ebp
     fd4:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     fd5:	89 d0                	mov    %edx,%eax
     fd7:	f7 d8                	neg    %eax
     fd9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
     fe0:	eb 9f                	jmp    f81 <printint+0x21>
     fe2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ff0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     ff0:	55                   	push   %ebp
     ff1:	89 e5                	mov    %esp,%ebp
     ff3:	57                   	push   %edi
     ff4:	56                   	push   %esi
     ff5:	53                   	push   %ebx
     ff6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     ffc:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     fff:	0f b6 08             	movzbl (%eax),%ecx
    1002:	84 c9                	test   %cl,%cl
    1004:	0f 84 96 00 00 00    	je     10a0 <printf+0xb0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    100a:	8d 55 10             	lea    0x10(%ebp),%edx
    100d:	31 f6                	xor    %esi,%esi
    100f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    1012:	31 db                	xor    %ebx,%ebx
    1014:	eb 1a                	jmp    1030 <printf+0x40>
    1016:	66 90                	xchg   %ax,%ax
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1018:	83 f9 25             	cmp    $0x25,%ecx
    101b:	0f 85 87 00 00 00    	jne    10a8 <printf+0xb8>
    1021:	66 be 25 00          	mov    $0x25,%si
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1025:	83 c3 01             	add    $0x1,%ebx
    1028:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
    102c:	84 c9                	test   %cl,%cl
    102e:	74 70                	je     10a0 <printf+0xb0>
    c = fmt[i] & 0xff;
    if(state == 0){
    1030:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1032:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
    1035:	74 e1                	je     1018 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1037:	83 fe 25             	cmp    $0x25,%esi
    103a:	75 e9                	jne    1025 <printf+0x35>
      if(c == 'd'){
    103c:	83 f9 64             	cmp    $0x64,%ecx
    103f:	90                   	nop
    1040:	0f 84 fa 00 00 00    	je     1140 <printf+0x150>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1046:	83 f9 70             	cmp    $0x70,%ecx
    1049:	74 75                	je     10c0 <printf+0xd0>
    104b:	83 f9 78             	cmp    $0x78,%ecx
    104e:	66 90                	xchg   %ax,%ax
    1050:	74 6e                	je     10c0 <printf+0xd0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1052:	83 f9 73             	cmp    $0x73,%ecx
    1055:	0f 84 8d 00 00 00    	je     10e8 <printf+0xf8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    105b:	83 f9 63             	cmp    $0x63,%ecx
    105e:	66 90                	xchg   %ax,%ax
    1060:	0f 84 fe 00 00 00    	je     1164 <printf+0x174>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1066:	83 f9 25             	cmp    $0x25,%ecx
    1069:	0f 84 b9 00 00 00    	je     1128 <printf+0x138>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    106f:	ba 25 00 00 00       	mov    $0x25,%edx
    1074:	89 f8                	mov    %edi,%eax
    1076:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1079:	83 c3 01             	add    $0x1,%ebx
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    107c:	31 f6                	xor    %esi,%esi
        ap++;
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    107e:	e8 ad fe ff ff       	call   f30 <putc>
        putc(fd, c);
    1083:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    1086:	89 f8                	mov    %edi,%eax
    1088:	0f be d1             	movsbl %cl,%edx
    108b:	e8 a0 fe ff ff       	call   f30 <putc>
    1090:	8b 45 0c             	mov    0xc(%ebp),%eax
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1093:	0f b6 0c 18          	movzbl (%eax,%ebx,1),%ecx
    1097:	84 c9                	test   %cl,%cl
    1099:	75 95                	jne    1030 <printf+0x40>
    109b:	90                   	nop
    109c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    10a0:	83 c4 2c             	add    $0x2c,%esp
    10a3:	5b                   	pop    %ebx
    10a4:	5e                   	pop    %esi
    10a5:	5f                   	pop    %edi
    10a6:	5d                   	pop    %ebp
    10a7:	c3                   	ret    
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    10a8:	89 f8                	mov    %edi,%eax
    10aa:	0f be d1             	movsbl %cl,%edx
    10ad:	e8 7e fe ff ff       	call   f30 <putc>
    10b2:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b5:	e9 6b ff ff ff       	jmp    1025 <printf+0x35>
    10ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    10c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10c3:	b9 10 00 00 00       	mov    $0x10,%ecx
        ap++;
    10c8:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    10ca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    10d1:	8b 10                	mov    (%eax),%edx
    10d3:	89 f8                	mov    %edi,%eax
    10d5:	e8 86 fe ff ff       	call   f60 <printint>
    10da:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    10dd:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    10e1:	e9 3f ff ff ff       	jmp    1025 <printf+0x35>
    10e6:	66 90                	xchg   %ax,%ax
      } else if(c == 's'){
        s = (char*)*ap;
    10e8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    10eb:	8b 32                	mov    (%edx),%esi
        ap++;
    10ed:	83 c2 04             	add    $0x4,%edx
    10f0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        if(s == 0)
    10f3:	85 f6                	test   %esi,%esi
    10f5:	0f 84 84 00 00 00    	je     117f <printf+0x18f>
          s = "(null)";
        while(*s != 0){
    10fb:	0f b6 16             	movzbl (%esi),%edx
    10fe:	84 d2                	test   %dl,%dl
    1100:	74 1d                	je     111f <printf+0x12f>
    1102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          putc(fd, *s);
    1108:	0f be d2             	movsbl %dl,%edx
          s++;
    110b:	83 c6 01             	add    $0x1,%esi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
    110e:	89 f8                	mov    %edi,%eax
    1110:	e8 1b fe ff ff       	call   f30 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1115:	0f b6 16             	movzbl (%esi),%edx
    1118:	84 d2                	test   %dl,%dl
    111a:	75 ec                	jne    1108 <printf+0x118>
    111c:	8b 45 0c             	mov    0xc(%ebp),%eax
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    111f:	31 f6                	xor    %esi,%esi
    1121:	e9 ff fe ff ff       	jmp    1025 <printf+0x35>
    1126:	66 90                	xchg   %ax,%ax
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
        putc(fd, c);
    1128:	89 f8                	mov    %edi,%eax
    112a:	ba 25 00 00 00       	mov    $0x25,%edx
    112f:	e8 fc fd ff ff       	call   f30 <putc>
    1134:	31 f6                	xor    %esi,%esi
    1136:	8b 45 0c             	mov    0xc(%ebp),%eax
    1139:	e9 e7 fe ff ff       	jmp    1025 <printf+0x35>
    113e:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1140:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1143:	b1 0a                	mov    $0xa,%cl
        ap++;
    1145:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1148:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    114f:	8b 10                	mov    (%eax),%edx
    1151:	89 f8                	mov    %edi,%eax
    1153:	e8 08 fe ff ff       	call   f60 <printint>
    1158:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    115b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    115f:	e9 c1 fe ff ff       	jmp    1025 <printf+0x35>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1164:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        ap++;
    1167:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1169:	0f be 10             	movsbl (%eax),%edx
    116c:	89 f8                	mov    %edi,%eax
    116e:	e8 bd fd ff ff       	call   f30 <putc>
    1173:	8b 45 0c             	mov    0xc(%ebp),%eax
        ap++;
    1176:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
    117a:	e9 a6 fe ff ff       	jmp    1025 <printf+0x35>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
    117f:	be e7 13 00 00       	mov    $0x13e7,%esi
    1184:	e9 72 ff ff ff       	jmp    10fb <printf+0x10b>
    1189:	90                   	nop
    118a:	90                   	nop
    118b:	90                   	nop
    118c:	90                   	nop
    118d:	90                   	nop
    118e:	90                   	nop
    118f:	90                   	nop

00001190 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1190:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1191:	a1 8c 14 00 00       	mov    0x148c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1196:	89 e5                	mov    %esp,%ebp
    1198:	57                   	push   %edi
    1199:	56                   	push   %esi
    119a:	53                   	push   %ebx
    119b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*) ap - 1;
    119e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11a1:	39 c8                	cmp    %ecx,%eax
    11a3:	73 1d                	jae    11c2 <free+0x32>
    11a5:	8d 76 00             	lea    0x0(%esi),%esi
    11a8:	8b 10                	mov    (%eax),%edx
    11aa:	39 d1                	cmp    %edx,%ecx
    11ac:	72 1a                	jb     11c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11ae:	39 d0                	cmp    %edx,%eax
    11b0:	72 08                	jb     11ba <free+0x2a>
    11b2:	39 c8                	cmp    %ecx,%eax
    11b4:	72 12                	jb     11c8 <free+0x38>
    11b6:	39 d1                	cmp    %edx,%ecx
    11b8:	72 0e                	jb     11c8 <free+0x38>
    11ba:	89 d0                	mov    %edx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11bc:	39 c8                	cmp    %ecx,%eax
    11be:	66 90                	xchg   %ax,%ax
    11c0:	72 e6                	jb     11a8 <free+0x18>
    11c2:	8b 10                	mov    (%eax),%edx
    11c4:	eb e8                	jmp    11ae <free+0x1e>
    11c6:	66 90                	xchg   %ax,%ax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    11c8:	8b 71 04             	mov    0x4(%ecx),%esi
    11cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    11ce:	39 d7                	cmp    %edx,%edi
    11d0:	74 19                	je     11eb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    11d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    11d5:	8b 50 04             	mov    0x4(%eax),%edx
    11d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    11db:	39 ce                	cmp    %ecx,%esi
    11dd:	74 21                	je     1200 <free+0x70>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    11df:	89 08                	mov    %ecx,(%eax)
  freep = p;
    11e1:	a3 8c 14 00 00       	mov    %eax,0x148c
}
    11e6:	5b                   	pop    %ebx
    11e7:	5e                   	pop    %esi
    11e8:	5f                   	pop    %edi
    11e9:	5d                   	pop    %ebp
    11ea:	c3                   	ret    
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11eb:	03 72 04             	add    0x4(%edx),%esi
    bp->s.ptr = p->s.ptr->s.ptr;
    11ee:	8b 12                	mov    (%edx),%edx
  bp = (Header*) ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11f0:	89 71 04             	mov    %esi,0x4(%ecx)
    bp->s.ptr = p->s.ptr->s.ptr;
    11f3:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    11f6:	8b 50 04             	mov    0x4(%eax),%edx
    11f9:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    11fc:	39 ce                	cmp    %ecx,%esi
    11fe:	75 df                	jne    11df <free+0x4f>
    p->s.size += bp->s.size;
    1200:	03 51 04             	add    0x4(%ecx),%edx
    1203:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1206:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1209:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    120b:	a3 8c 14 00 00       	mov    %eax,0x148c
}
    1210:	5b                   	pop    %ebx
    1211:	5e                   	pop    %esi
    1212:	5f                   	pop    %edi
    1213:	5d                   	pop    %ebp
    1214:	c3                   	ret    
    1215:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001220 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
    1226:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1229:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
    122c:	8b 0d 8c 14 00 00    	mov    0x148c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1232:	83 c3 07             	add    $0x7,%ebx
    1235:	c1 eb 03             	shr    $0x3,%ebx
    1238:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
    123b:	85 c9                	test   %ecx,%ecx
    123d:	0f 84 93 00 00 00    	je     12d6 <malloc+0xb6>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1243:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1245:	8b 50 04             	mov    0x4(%eax),%edx
    1248:	39 d3                	cmp    %edx,%ebx
    124a:	76 1f                	jbe    126b <malloc+0x4b>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*) (p + 1);
    124c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1253:	90                   	nop
    1254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    if(p == freep)
    1258:	3b 05 8c 14 00 00    	cmp    0x148c,%eax
    125e:	74 30                	je     1290 <malloc+0x70>
    1260:	89 c1                	mov    %eax,%ecx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1262:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    1264:	8b 50 04             	mov    0x4(%eax),%edx
    1267:	39 d3                	cmp    %edx,%ebx
    1269:	77 ed                	ja     1258 <malloc+0x38>
      if(p->s.size == nunits)
    126b:	39 d3                	cmp    %edx,%ebx
    126d:	74 61                	je     12d0 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    126f:	29 da                	sub    %ebx,%edx
    1271:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1274:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
    1277:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    127a:	89 0d 8c 14 00 00    	mov    %ecx,0x148c
      return (void*) (p + 1);
    1280:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1283:	83 c4 1c             	add    $0x1c,%esp
    1286:	5b                   	pop    %ebx
    1287:	5e                   	pop    %esi
    1288:	5f                   	pop    %edi
    1289:	5d                   	pop    %ebp
    128a:	c3                   	ret    
    128b:	90                   	nop
    128c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < PAGE)
    1290:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
    1296:	b8 00 80 00 00       	mov    $0x8000,%eax
    129b:	bf 00 10 00 00       	mov    $0x1000,%edi
    12a0:	76 04                	jbe    12a6 <malloc+0x86>
    12a2:	89 f0                	mov    %esi,%eax
    12a4:	89 df                	mov    %ebx,%edi
    nu = PAGE;
  p = sbrk(nu * sizeof(Header));
    12a6:	89 04 24             	mov    %eax,(%esp)
    12a9:	e8 62 fc ff ff       	call   f10 <sbrk>
  if(p == (char*) -1)
    12ae:	83 f8 ff             	cmp    $0xffffffff,%eax
    12b1:	74 18                	je     12cb <malloc+0xab>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    12b3:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    12b6:	83 c0 08             	add    $0x8,%eax
    12b9:	89 04 24             	mov    %eax,(%esp)
    12bc:	e8 cf fe ff ff       	call   1190 <free>
  return freep;
    12c1:	8b 0d 8c 14 00 00    	mov    0x148c,%ecx
      }
      freep = prevp;
      return (void*) (p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    12c7:	85 c9                	test   %ecx,%ecx
    12c9:	75 97                	jne    1262 <malloc+0x42>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    12cb:	31 c0                	xor    %eax,%eax
    12cd:	eb b4                	jmp    1283 <malloc+0x63>
    12cf:	90                   	nop
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    12d0:	8b 10                	mov    (%eax),%edx
    12d2:	89 11                	mov    %edx,(%ecx)
    12d4:	eb a4                	jmp    127a <malloc+0x5a>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    12d6:	c7 05 8c 14 00 00 84 	movl   $0x1484,0x148c
    12dd:	14 00 00 
    base.s.size = 0;
    12e0:	b9 84 14 00 00       	mov    $0x1484,%ecx
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    12e5:	c7 05 84 14 00 00 84 	movl   $0x1484,0x1484
    12ec:	14 00 00 
    base.s.size = 0;
    12ef:	c7 05 88 14 00 00 00 	movl   $0x0,0x1488
    12f6:	00 00 00 
    12f9:	e9 45 ff ff ff       	jmp    1243 <malloc+0x23>
