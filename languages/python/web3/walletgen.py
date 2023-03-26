import secrets
from eth_keys import keys

# Generate a 32-byte random string
private_key_bytes = secrets.token_bytes(32)

# Convert the bytes to a private key
private_key = keys.PrivateKey(private_key_bytes)

# Get the public key from the private key
public_key = private_key.public_key

# Print both keys to the console
print("Private key:", private_key)
print("Public key:", public_key)
