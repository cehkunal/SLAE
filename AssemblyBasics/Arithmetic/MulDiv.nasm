; Filename: MulDiv.nasm
; Author: Kunal Pachauri

global _start

section .text
_start:

	; Unsigned Multiplication in r/m8 
	mov eax, 0x0

	mov al, 0x10
	mov bl, 0x2
	mul bl

	mov al, 0xff
	mul bl

	;Unsigned Multilication in r/m16
	mov ax, 0x0
	mov bx, 0x0

	mov ax, 0x1122
	mov bx, 0x2
	mul bx

	mov ax, 0xffff
	mul bx

	;Unsigned Multiplication in r/m32
	mov eax, 0x0
	mov ebx, 0x0

	mov eax, 0x11223344
	mov ebx, 0x02
	mul ebx

	mov eax, 0xffffffff
	mov ebx, 0xffff
	mul ebx

	;Multiplication using Memory Location
	mul byte  [var1]
	mul word  [var2]
	mul dword [var3]

	;Division using r/m16
	mov dx, 0x0
	mov ax, 0x7788
	mov cx, 0x2
	div cx

	mov ax, 0x7788 + 0x1
	mov cx, 0x2
	div cx

	; Exit the Program Gracefully
	mov eax, 0x01
	mov ebx, 0x01
	int 0x80 

section .data

	var1	db	0x05
	var2	dw	0x1234
	var3	dd	0x12345678	
		
