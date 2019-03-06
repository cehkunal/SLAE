; FileName: MovingData.nasm
; Author: Kunal Pachauri

global _start


section .text
 
_start:

	; Moving Immediate Value To Registers
	mov eax, 0xaabbccdd
	mov ah, 0xff
	mov al, 0xcc
	mov ax, 0xbbee

	mov ebx, 0
	mov ecx, 0

	; Moving Register to Register
	mov ebx, eax
	mov ecx, ebx
	mov cl, ah

	mov ebx, 0
	mov eax, 0
	mov ecx, 0

	; Move From Memory To Register
	mov eax, [sample]
	mov bh, [sample+1]	
	mov bl, [sample+2]

	mov eax, 0
	mov ebx, 0
	mov ecx, 0

	; Move from Register To Memory
	mov eax, 0x33445566
	mov byte [sample], al

	; Move Immediate Value Into Memory
	mov word [sample], 0x2231

	; lea Demo
	lea eax, [sample]
	lea ebx, [eax]

	; xchg Demo
	xchg eax, ebx


	; Exit the program Gracefully
	mov eax, 0x01
	mov ebx, 0x02
	int 0x80

section .data

sample: db 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x11, 0x22
