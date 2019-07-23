#!/usr/bin/python
import argparse
from Crypto.Cipher import Blowfish
from Crypto import Random
from struct import pack

parser = argparse.ArgumentParser()
parser.add_argument('-p','--plain_shellcode',help="Shellcode to be encrypted")
parser.add_argument('-c','--cipher_shellcode',help="Shellcode to be decrypted")
parser.add_argument('-k','--key',help="Key to be used for encryption/decryption")
args = parser.parse_args()

def encrypt(pText, key):
	bs      = Blowfish.block_size	# Defining the Block size as 8 bytes
	iv      = Random.new().read(bs)  # Generating the Initialization vector
	cipher  = Blowfish.new(key, Blowfish.MODE_CBC, iv) # Creating cipher object to encryt plaintext
	msgLen  = bs - divmod(len(pText), bs)[1]	# Getting Remainder of msgLen/Block_Size to be used in padding
	padding = [msgLen]*msgLen 	# Creating padding for proper operation
	padding = pack('b'*msgLen, *padding) # Formatting the padding Bytes
	cText   = iv + cipher.encrypt(pText + padding) # Creating the Cipher Text
	return cText

def decrypt(cText, key):
	bs      = Blowfish.block_size
 	iv	= cText[:bs]
	cText	= cText[bs:]
	cipher  = Blowfish.new(key, Blowfish.MODE_CBC, iv)
	pText	= cipher.decrypt(cText)
	last_byte = pText[-1]
	pText = pText[: -(last_byte if type(last_byte) is int else ord(last_byte))]
	return repr(pText)

print '[*]Encrypting Shellcode\n'
enc_shellcode = encrypt(args.plain_shellcode, args.key)
print enc_shellcode
print '[*]Decrypting Shellcode\n'
dec_shellcode = decrypt(enc_shellcode, args.key)
shellcode = []
for i in dec_shellcode:
	if i == 'x':
		shellcode.append('\\')
		shellcode.append(i)
	else:
		shellcode.append(i)
print ''.join(shellcode)
	
