; Filename: Loop.nasm
; Author: Kunal Pachauri
; Website: kunalpachauri.co.in

global _start

section .text
_start:
	jmp Begin

NeverExecute:	
	mov eax, 0x10
	xor ebx, ebx

Begin:
	mov ecx,0x05

PrintHW:
	push ecx

	;Print Hello World using SYSCALL
	mov eax, 0x04
	mov ebx, 1
	mov ecx, message
	mov edx, mlen
	int 0x80

	pop ecx
	loop PrintHW

	;Exit Gracefully once Hello World is Printed in Loop
	mov eax, 0x1
	mov ebx, 0xa
	int 0x80

section .data
	message: db "Hello World! "
 	mlen	equ	$-message	
