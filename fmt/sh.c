6750 // Shell.
6751 
6752 #include "types.h"
6753 #include "user.h"
6754 #include "fcntl.h"
6755 
6756 // Parsed command representation
6757 #define EXEC  1
6758 #define REDIR 2
6759 #define PIPE  3
6760 #define LIST  4
6761 #define BACK  5
6762 
6763 #define MAXARGS 10
6764 
6765 struct cmd {
6766   int type;
6767 };
6768 
6769 struct execcmd {
6770   int type;
6771   char *argv[MAXARGS];
6772   char *eargv[MAXARGS];
6773 };
6774 
6775 struct redircmd {
6776   int type;
6777   struct cmd *cmd;
6778   char *file;
6779   char *efile;
6780   int mode;
6781   int fd;
6782 };
6783 
6784 struct pipecmd {
6785   int type;
6786   struct cmd *left;
6787   struct cmd *right;
6788 };
6789 
6790 struct listcmd {
6791   int type;
6792   struct cmd *left;
6793   struct cmd *right;
6794 };
6795 
6796 struct backcmd {
6797   int type;
6798   struct cmd *cmd;
6799 };
6800 int fork1(void);  // Fork but panics on failure.
6801 void panic(char*);
6802 struct cmd *parsecmd(char*);
6803 
6804 // Execute cmd.  Never returns.
6805 void
6806 runcmd(struct cmd *cmd)
6807 {
6808   int p[2];
6809   struct backcmd *bcmd;
6810   struct execcmd *ecmd;
6811   struct listcmd *lcmd;
6812   struct pipecmd *pcmd;
6813   struct redircmd *rcmd;
6814 
6815   if(cmd == 0)
6816     exit();
6817 
6818   switch(cmd->type){
6819   default:
6820     panic("runcmd");
6821 
6822   case EXEC:
6823     ecmd = (struct execcmd*)cmd;
6824     if(ecmd->argv[0] == 0)
6825       exit();
6826     exec(ecmd->argv[0], ecmd->argv);
6827     printf(2, "exec %s failed\n", ecmd->argv[0]);
6828     break;
6829 
6830   case REDIR:
6831     rcmd = (struct redircmd*)cmd;
6832     close(rcmd->fd);
6833     if(open(rcmd->file, rcmd->mode) < 0){
6834       printf(2, "open %s failed\n", rcmd->file);
6835       exit();
6836     }
6837     runcmd(rcmd->cmd);
6838     break;
6839 
6840   case LIST:
6841     lcmd = (struct listcmd*)cmd;
6842     if(fork1() == 0)
6843       runcmd(lcmd->left);
6844     wait();
6845     runcmd(lcmd->right);
6846     break;
6847 
6848 
6849 
6850   case PIPE:
6851     pcmd = (struct pipecmd*)cmd;
6852     if(pipe(p) < 0)
6853       panic("pipe");
6854     if(fork1() == 0){
6855       close(1);
6856       dup(p[1]);
6857       close(p[0]);
6858       close(p[1]);
6859       runcmd(pcmd->left);
6860     }
6861     if(fork1() == 0){
6862       close(0);
6863       dup(p[0]);
6864       close(p[0]);
6865       close(p[1]);
6866       runcmd(pcmd->right);
6867     }
6868     close(p[0]);
6869     close(p[1]);
6870     wait();
6871     wait();
6872     break;
6873 
6874   case BACK:
6875     bcmd = (struct backcmd*)cmd;
6876     if(fork1() == 0)
6877       runcmd(bcmd->cmd);
6878     break;
6879   }
6880   exit();
6881 }
6882 
6883 int
6884 getcmd(char *buf, int nbuf)
6885 {
6886   printf(2, "$ ");
6887   memset(buf, 0, nbuf);
6888   gets(buf, nbuf);
6889   if(buf[0] == 0) // EOF
6890     return -1;
6891   return 0;
6892 }
6893 
6894 
6895 
6896 
6897 
6898 
6899 
6900 int
6901 main(void)
6902 {
6903   static char buf[100];
6904   int fd;
6905 
6906   // Assumes three file descriptors open.
6907   while((fd = open("console", O_RDWR)) >= 0){
6908     if(fd >= 3){
6909       close(fd);
6910       break;
6911     }
6912   }
6913 
6914   // Read and run input commands.
6915   while(getcmd(buf, sizeof(buf)) >= 0){
6916     if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
6917       // Clumsy but will have to do for now.
6918       // Chdir has no effect on the parent if run in the child.
6919       buf[strlen(buf)-1] = 0;  // chop \n
6920       if(chdir(buf+3) < 0)
6921         printf(2, "cannot cd %s\n", buf+3);
6922       continue;
6923     }
6924     if(fork1() == 0)
6925       runcmd(parsecmd(buf));
6926     wait();
6927   }
6928   exit();
6929 }
6930 
6931 void
6932 panic(char *s)
6933 {
6934   printf(2, "%s\n", s);
6935   exit();
6936 }
6937 
6938 int
6939 fork1(void)
6940 {
6941   int pid;
6942 
6943   pid = fork();
6944   if(pid == -1)
6945     panic("fork");
6946   return pid;
6947 }
6948 
6949 
6950 // Constructors
6951 
6952 struct cmd*
6953 execcmd(void)
6954 {
6955   struct execcmd *cmd;
6956 
6957   cmd = malloc(sizeof(*cmd));
6958   memset(cmd, 0, sizeof(*cmd));
6959   cmd->type = EXEC;
6960   return (struct cmd*)cmd;
6961 }
6962 
6963 struct cmd*
6964 redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
6965 {
6966   struct redircmd *cmd;
6967 
6968   cmd = malloc(sizeof(*cmd));
6969   memset(cmd, 0, sizeof(*cmd));
6970   cmd->type = REDIR;
6971   cmd->cmd = subcmd;
6972   cmd->file = file;
6973   cmd->efile = efile;
6974   cmd->mode = mode;
6975   cmd->fd = fd;
6976   return (struct cmd*)cmd;
6977 }
6978 
6979 struct cmd*
6980 pipecmd(struct cmd *left, struct cmd *right)
6981 {
6982   struct pipecmd *cmd;
6983 
6984   cmd = malloc(sizeof(*cmd));
6985   memset(cmd, 0, sizeof(*cmd));
6986   cmd->type = PIPE;
6987   cmd->left = left;
6988   cmd->right = right;
6989   return (struct cmd*)cmd;
6990 }
6991 
6992 
6993 
6994 
6995 
6996 
6997 
6998 
6999 
7000 struct cmd*
7001 listcmd(struct cmd *left, struct cmd *right)
7002 {
7003   struct listcmd *cmd;
7004 
7005   cmd = malloc(sizeof(*cmd));
7006   memset(cmd, 0, sizeof(*cmd));
7007   cmd->type = LIST;
7008   cmd->left = left;
7009   cmd->right = right;
7010   return (struct cmd*)cmd;
7011 }
7012 
7013 struct cmd*
7014 backcmd(struct cmd *subcmd)
7015 {
7016   struct backcmd *cmd;
7017 
7018   cmd = malloc(sizeof(*cmd));
7019   memset(cmd, 0, sizeof(*cmd));
7020   cmd->type = BACK;
7021   cmd->cmd = subcmd;
7022   return (struct cmd*)cmd;
7023 }
7024 // Parsing
7025 
7026 char whitespace[] = " \t\r\n\v";
7027 char symbols[] = "<|>&;()";
7028 
7029 int
7030 gettoken(char **ps, char *es, char **q, char **eq)
7031 {
7032   char *s;
7033   int ret;
7034 
7035   s = *ps;
7036   while(s < es && strchr(whitespace, *s))
7037     s++;
7038   if(q)
7039     *q = s;
7040   ret = *s;
7041   switch(*s){
7042   case 0:
7043     break;
7044   case '|':
7045   case '(':
7046   case ')':
7047   case ';':
7048   case '&':
7049   case '<':
7050     s++;
7051     break;
7052   case '>':
7053     s++;
7054     if(*s == '>'){
7055       ret = '+';
7056       s++;
7057     }
7058     break;
7059   default:
7060     ret = 'a';
7061     while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
7062       s++;
7063     break;
7064   }
7065   if(eq)
7066     *eq = s;
7067 
7068   while(s < es && strchr(whitespace, *s))
7069     s++;
7070   *ps = s;
7071   return ret;
7072 }
7073 
7074 int
7075 peek(char **ps, char *es, char *toks)
7076 {
7077   char *s;
7078 
7079   s = *ps;
7080   while(s < es && strchr(whitespace, *s))
7081     s++;
7082   *ps = s;
7083   return *s && strchr(toks, *s);
7084 }
7085 
7086 
7087 
7088 
7089 
7090 
7091 
7092 
7093 
7094 
7095 
7096 
7097 
7098 
7099 
7100 struct cmd *parseline(char**, char*);
7101 struct cmd *parsepipe(char**, char*);
7102 struct cmd *parseexec(char**, char*);
7103 struct cmd *nulterminate(struct cmd*);
7104 
7105 struct cmd*
7106 parsecmd(char *s)
7107 {
7108   char *es;
7109   struct cmd *cmd;
7110 
7111   es = s + strlen(s);
7112   cmd = parseline(&s, es);
7113   peek(&s, es, "");
7114   if(s != es){
7115     printf(2, "leftovers: %s\n", s);
7116     panic("syntax");
7117   }
7118   nulterminate(cmd);
7119   return cmd;
7120 }
7121 
7122 struct cmd*
7123 parseline(char **ps, char *es)
7124 {
7125   struct cmd *cmd;
7126 
7127   cmd = parsepipe(ps, es);
7128   while(peek(ps, es, "&")){
7129     gettoken(ps, es, 0, 0);
7130     cmd = backcmd(cmd);
7131   }
7132   if(peek(ps, es, ";")){
7133     gettoken(ps, es, 0, 0);
7134     cmd = listcmd(cmd, parseline(ps, es));
7135   }
7136   return cmd;
7137 }
7138 
7139 
7140 
7141 
7142 
7143 
7144 
7145 
7146 
7147 
7148 
7149 
7150 struct cmd*
7151 parsepipe(char **ps, char *es)
7152 {
7153   struct cmd *cmd;
7154 
7155   cmd = parseexec(ps, es);
7156   if(peek(ps, es, "|")){
7157     gettoken(ps, es, 0, 0);
7158     cmd = pipecmd(cmd, parsepipe(ps, es));
7159   }
7160   return cmd;
7161 }
7162 
7163 struct cmd*
7164 parseredirs(struct cmd *cmd, char **ps, char *es)
7165 {
7166   int tok;
7167   char *q, *eq;
7168 
7169   while(peek(ps, es, "<>")){
7170     tok = gettoken(ps, es, 0, 0);
7171     if(gettoken(ps, es, &q, &eq) != 'a')
7172       panic("missing file for redirection");
7173     switch(tok){
7174     case '<':
7175       cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
7176       break;
7177     case '>':
7178       cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
7179       break;
7180     case '+':  // >>
7181       cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
7182       break;
7183     }
7184   }
7185   return cmd;
7186 }
7187 
7188 
7189 
7190 
7191 
7192 
7193 
7194 
7195 
7196 
7197 
7198 
7199 
7200 struct cmd*
7201 parseblock(char **ps, char *es)
7202 {
7203   struct cmd *cmd;
7204 
7205   if(!peek(ps, es, "("))
7206     panic("parseblock");
7207   gettoken(ps, es, 0, 0);
7208   cmd = parseline(ps, es);
7209   if(!peek(ps, es, ")"))
7210     panic("syntax - missing )");
7211   gettoken(ps, es, 0, 0);
7212   cmd = parseredirs(cmd, ps, es);
7213   return cmd;
7214 }
7215 
7216 struct cmd*
7217 parseexec(char **ps, char *es)
7218 {
7219   char *q, *eq;
7220   int tok, argc;
7221   struct execcmd *cmd;
7222   struct cmd *ret;
7223 
7224   if(peek(ps, es, "("))
7225     return parseblock(ps, es);
7226 
7227   ret = execcmd();
7228   cmd = (struct execcmd*)ret;
7229 
7230   argc = 0;
7231   ret = parseredirs(ret, ps, es);
7232   while(!peek(ps, es, "|)&;")){
7233     if((tok=gettoken(ps, es, &q, &eq)) == 0)
7234       break;
7235     if(tok != 'a')
7236       panic("syntax");
7237     cmd->argv[argc] = q;
7238     cmd->eargv[argc] = eq;
7239     argc++;
7240     if(argc >= MAXARGS)
7241       panic("too many args");
7242     ret = parseredirs(ret, ps, es);
7243   }
7244   cmd->argv[argc] = 0;
7245   cmd->eargv[argc] = 0;
7246   return ret;
7247 }
7248 
7249 
7250 // NUL-terminate all the counted strings.
7251 struct cmd*
7252 nulterminate(struct cmd *cmd)
7253 {
7254   int i;
7255   struct backcmd *bcmd;
7256   struct execcmd *ecmd;
7257   struct listcmd *lcmd;
7258   struct pipecmd *pcmd;
7259   struct redircmd *rcmd;
7260 
7261   if(cmd == 0)
7262     return 0;
7263 
7264   switch(cmd->type){
7265   case EXEC:
7266     ecmd = (struct execcmd*)cmd;
7267     for(i=0; ecmd->argv[i]; i++)
7268       *ecmd->eargv[i] = 0;
7269     break;
7270 
7271   case REDIR:
7272     rcmd = (struct redircmd*)cmd;
7273     nulterminate(rcmd->cmd);
7274     *rcmd->efile = 0;
7275     break;
7276 
7277   case PIPE:
7278     pcmd = (struct pipecmd*)cmd;
7279     nulterminate(pcmd->left);
7280     nulterminate(pcmd->right);
7281     break;
7282 
7283   case LIST:
7284     lcmd = (struct listcmd*)cmd;
7285     nulterminate(lcmd->left);
7286     nulterminate(lcmd->right);
7287     break;
7288 
7289   case BACK:
7290     bcmd = (struct backcmd*)cmd;
7291     nulterminate(bcmd->cmd);
7292     break;
7293   }
7294   return cmd;
7295 }
7296 
7297 
7298 
7299 
