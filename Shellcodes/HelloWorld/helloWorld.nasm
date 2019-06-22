; Filename: helloWorld.nasm
; Creating a shellcode that prints hello world on screen using JMP-CALL-POP Technique
; 1. Replace all 0x00 opcode instructions
; 2. No hardcoded address (Reson of using JMP-CALL-POP Technique to dynamically populate address)

global _start

section .text

_start:
	jmp short call_shellcode
	; Print Hello World on the screen
	
shellcode:
	xor eax, eax
	mov al, 0x4

	xor ebx, ebx
	mov bl, 0x1

	pop ecx	
	
	xor edx, edx
	mov dl, 13

	int 0x80

	; Exit the program gracefully

	xor eax, eax
	mov al, 0x1

	xor ebx, ebx

	int 0x80

call_shellcode:
	call shellcode
	message: db "Hello World!", 0xA
