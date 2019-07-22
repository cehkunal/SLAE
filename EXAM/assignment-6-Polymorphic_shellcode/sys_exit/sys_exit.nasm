 ; Name   : 8 bytes sys_exit(0) x86 linux shellcode
 ; Date   : may, 31 2010
 ; Author : gunslinger_
 ; Web    : devilzc0de.com
 ; blog   : gunslinger.devilzc0de.com
 ; tested on : linux debian

global _start

section .text
_start:
	xor eax, eax
	mov al, 0x1
	xor ebx, ebx
	int 0x80

