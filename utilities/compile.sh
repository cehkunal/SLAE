#!/bin/bash

echo '[+] Assembling with Nasm'
nasm -o $1.o -f elf32 $1.nasm

echo '[+] Linking ...'
ld -N -o $1 $1.o

echo '[+] Done! '

