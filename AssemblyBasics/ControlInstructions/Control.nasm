; Filename: Control.nasm
; Author: Kunal Pachauri

global _start

section .text
_start:
	mov eax,0x10
	jmp begin

NeverExecute:

	mov eax, 0x44
	mov ebx, 0xcc

begin:
	mov eax, 0x05

printHW:
	push eax

	; Instructions to Print Hello World
	mov eax, 0x04
	mov ebx, 0x01
	mov ecx, message
	mov edx, mlen
	int 0x80

	pop eax
	dec eax
	jnz printHW

	; Exit gracefully
	mov eax, 0x01
	mov ebx, 0x02
	int 0x80


section .data

	message:	db	"Hello World!"
	mlen		equ	$-message
