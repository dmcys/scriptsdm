import secrets
from eth_keys import keys
import os

# Prompt the user to select encryption method
encrypt = input("Do you want to encrypt wallets.txt using GPG? (y/n) ")
if encrypt.lower() == "y":
    # Prompt the user to select a key or generate a new one
    new_key = input("Do you want to generate a new key? (y/n) ")
    if new_key.lower() == "y":
        # Generate a new key and encrypt wallets.txt
        encrypt_times = int(input("How many times do you want to encrypt wallets.txt? "))
        os.system(f"gpg --gen-key && gpg -c --cipher-algo AES256 --s2k-digest-algo SHA512 wallets.txt")
        for i in range(1, encrypt_times):
            os.system(f"gpg -c --cipher-algo AES256 --s2k-digest-algo SHA512 wallets.txt.gpg")
    else:
        # Use an existing key and encrypt wallets.txt
        key_path = input("Enter the path to your GPG key: ")
        encrypt_times = int(input("How many times do you want to encrypt wallets.txt? "))
        os.system(f"gpg -e --cipher-algo AES256 --s2k-digest-algo SHA512 --recipient-file {key_path} wallets.txt")
        for i in range(1, encrypt_times):
            os.system(f"gpg -e --cipher-algo AES256 --s2k-digest-algo SHA512 --recipient-file {key_path} wallets.txt.gpg")

# Prompt the user to select how many wallets to generate
num_wallets = int(input("How many wallets do you want to generate? "))

# Create the wallets.txt file
with open("wallets.txt", "w") as file:
    for i in range(1, num_wallets+1):
        # Generate a 32-byte random string
        private_key_bytes = secrets.token_bytes(32)

        # Convert the bytes to a private key
        private_key = keys.PrivateKey(private_key_bytes)

        # Get the public key from the private key
        public_key = private_key.public_key

        # Write the wallet info to wallets.txt
        file.write(f"Wallet {i}\n")
        file.write("Private key:\n")
        file.write(f"{private_key}\n")
        file.write("Public key:\n")
        file.write(f"{public_key}\n\n")
