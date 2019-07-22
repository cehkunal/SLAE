#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xfe\xc0\xcd\x80";
main()
{

	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();

}
