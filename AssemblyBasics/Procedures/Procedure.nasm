; Filename: Procedure.nasm
; Author: Kunal Pachauri
; Website: kunalpachauri.co.in

global _start

section .text

HelloWorldProc:
	;Print Hello World using write syscall
	mov eax, 0x04
	mov ebx, 0x1
	mov ecx, message
	mov edx, mlen
	int 0x80
	ret	

_start:
	mov ecx, 0x10
	
PrintHelloWorld:
	push ecx
	call HelloWorldProc
	pop ecx
	loop PrintHelloWorld

	;Exit Gracefully
	mov eax, 0x1
	mov ebx, 10
	int 0x80
	

section .data
	message: db "Hello World! "
	mlen	equ	$-message
