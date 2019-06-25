#!/bin/bash

echo '[+] Assembling with Nasm'
nasm -o $1.o -f elf32 $1.nasm

echo '[+] Linking ...'
ld -o $1 $1.o

echo '[+] Done! '

