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

	var1: db 0xAA
	var2: db 0xBB,0xCC,0xDD
	var3: dw 0xEE
	var4: dd 0xAABBCCDD
	var5: dd 0x11223344
	var6: TIMES 6 db 0xFF


	message: db "Hello World!"
	; Finding the length of the string
	msgLen	equ  $-message

section .bss
	
	var7: resb 100
	var8: resw 20
