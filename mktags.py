import os, commands, re

gather = ["*.[chsS]", "Make*", "*.cc", "*.cfg"]
discard = [".*\/\.svn\/*", "build.sh4a*", "Makefile.depend", "Makefile.build"]

#
# gathering files
#
temp=""
for i in gather:
    cmd = 'find . -type f -name \'' + i + '\' -print'
    outval = commands.getoutput(cmd)
    temp = temp + '\n' + outval

files=""
for i in temp.splitlines(True):
    found = None
    for hit in discard:
        found = re.search(hit, i)
        if found != None:
            break
    if found == None:
        files = files + i

print "I gatherd these files:\n" + files

#
# cscope
#
cscopef = r"./cscope.files"

o = open(cscopef, 'w')
o.write(files)
o.close()

os.system('cat ' + cscopef + ' | xargs ctags -a -o ./tags')
os.system('cscope -k -i ' + cscopef)

