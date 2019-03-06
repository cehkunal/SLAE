; HelloWorld.asm
; Author: Kunal Pachauri

global _start

section .text

_start:

	; Print Hello World on Screen
	; SYSCALL for write - 4
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, message
	mov edx, msgLen
	int 0x80

	; Exit The Program Gracefully
	; SYSCALL for exit - 1
	mov eax, 0x1
	mov ebx, 0x5
	int 0x80

section .data

	message: db "Hello World!"
	; Finding the length of the string
	msgLen	equ  $-message

