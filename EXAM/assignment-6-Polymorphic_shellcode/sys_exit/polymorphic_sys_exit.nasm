 ; Filename: polymorphic_sys_exit.nasm
 ; Author: Kunal Pachauri
 ; Purpose: Polymorphic shellcode version of http://shell-storm.org/shellcode/files/shellcode-623.php
 ; SLAE-9237

global _start

section .text
_start:
	xor ebx, ebx
	mul ebx
	inc al
	int 0x80

