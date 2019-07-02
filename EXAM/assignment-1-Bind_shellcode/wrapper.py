import re,subprocess,sys,os

#Script to take template, port number and generate shellcode.
#Template should be in the same folder
# Usage: python wrapper.py <TEMPLATE_FILE> <PORT_NUMBER>

if len(sys.argv)<3:
   print '[*] Usage: python wrapper.py <TEMPLATE_FILE> <PORT>' 
   exit(1)


#Reading Template File 
with open(sys.argv[1]) as f:
   data = f.read()

#Converting Port Number to Hex
port = int(sys.argv[2])
if port not in range(1024,65536):
   print '[-] Port number should be in between 1024 to 65535'
   exit(2)

portInHex = hex(int(port))
portInHexLittleEndian = '0x' + portInHex[-2:] + portInHex[2:4]

#Replacing Port in data
data = data.replace('PORTINHEX',portInHexLittleEndian)

#Write to a Temp File tmp.nasm
with open('tmp.nasm','w') as f:
   f.write(data)

#Assemble and Link Temp File
subprocess.Popen(['nasm', '-o', 'tmp.o', '-f', 'elf32', 'tmp.nasm'], stdout=subprocess.PIPE)
subprocess.Popen(['ld', '-o', 'tmp', 'tmp.o'], stdout=subprocess.PIPE)

#Extract Shellcode
binary = 'tmp'
s_data=subprocess.Popen(['objdump','-j','.text','-d',binary],stdout=subprocess.PIPE).communicate()[0]
x = s_data.split('.text:')[1].strip()
y = x.split("\n")
l = list()
for i in y:
    tmp = i.split("\t")
    if len(tmp)>1:
    	l.append(tmp[1].strip())

final_piece = " ".join(l)

reg = re.sub("[^0-9a-f ]","",final_piece)


### print in \x form
print "\\x"+"\\x".join(reg.split())


###Clearing up tmp Files
os.remove('tmp')
os.remove('tmp.o')
os.remove('tmp.nasm')
