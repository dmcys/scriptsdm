import secrets
from eth_keys import keys
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
while True:
# Open the wallets.txt file in append mode
with open("wallets.txt", "a") as file:
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
# Prompt the user to continue or quit
choice = input("Do you want to generate more wallets? (Y/N) ")
if choice.upper() == "N":
   break
