; Filename: helloWorld.nasm
; Creating a shellcode that prints hello world on screen using dynamically inserting in Stack instead of JMP-CALL-POP
; 1. Replace all 0x00 opcode instructions
; 2. No hardcoded address (Using ESP for reference to populate Hello World)
; NOTE: Since Stack grows from High Memory -> Low Memory, we need to insert Hello world in reverse order
; Author: Kunal Pachauri

global _start

section .text

_start:
	; Print Hello World on the screen
	
	xor eax, eax
	mov al, 0x4

	xor ebx, ebx
	mov bl, 0x1

	xor edx, edx
	push edx

	push 0x0a21646c
	push 0x726f5720
	push 0x6f6c6c65
	push 0x48000000

	mov ecx, esp
	

	mov dl, 16

	int 0x80

	; Exit the program gracefully

	xor eax, eax
	mov al, 0x1

	xor ebx, ebx

	int 0x80

