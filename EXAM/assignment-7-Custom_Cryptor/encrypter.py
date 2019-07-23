#!/usr/bin/python
import argparse
from Crypto.Cipher import Blowfish
from Crypto import Random
from struct import pack

parser = argparse.ArgumentParser()
parser.add_argument('-p','--plain_shellcode',help="Shellcode to be encrypted")
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

print '[*]Encrypting Shellcode\n'
enc_shellcode = encrypt(args.plain_shellcode, args.key)
print 'Raw Shellcode: ' + enc_shellcode
print 'Hex Encoded Shellcode: ' + enc_shellcode.encode('hex')
	
