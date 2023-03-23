#!/usr/bin/env python3
# pip install pycryptodome > requirement

from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
import base64

# Set the key and initialization vector (IV)
key = get_random_bytes(32)
iv = get_random_bytes(AES.block_size)

# Define the encryption function
def encrypt(plaintext):
    # Create the AES cipher object
    cipher = AES.new(key, AES.MODE_CBC, iv)
    
    # Pad the plaintext to a multiple of the block size
    padded_plaintext = plaintext + (AES.block_size - len(plaintext) % AES.block_size) * chr(AES.block_size - len(plaintext) % AES.block_size)
    
    # Encrypt the padded plaintext
    ciphertext = cipher.encrypt(padded_plaintext.encode('utf-8'))
    
    # Encode the ciphertext as base64
    encoded_ciphertext = base64.b64encode(ciphertext).decode('utf-8')
    
    return encoded_ciphertext

# Define the decryption function
def decrypt(encoded_ciphertext):
    # Create the AES cipher object
    cipher = AES.new(key, AES.MODE_CBC, iv)
    
    # Decode the ciphertext from base64
    ciphertext = base64.b64decode(encoded_ciphertext)
    
    # Decrypt the ciphertext
    decryptedtext = cipher.decrypt(ciphertext).decode('utf-8')
    
    # Unpad the decrypted plaintext
    unpadded_decryptedtext = decryptedtext[:-ord(decryptedtext[-1])]
    
    return unpadded_decryptedtext

# Test the encryption and decryption functions
plaintext = 'Hello, world!'
print('Original plaintext:', plaintext)

encoded_ciphertext = encrypt(plaintext)
print('Encoded ciphertext:', encoded_ciphertext)

decryptedtext = decrypt(encoded_ciphertext)
print('Decrypted plaintext:', decryptedtext)
