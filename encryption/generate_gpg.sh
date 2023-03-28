#!/bin/bash

# Generate a new GPG key if one doesn't exist
if ! gpg --list-keys > /dev/null 2>&1; then
  gpg --batch --gen-key <<EOF
    Key-Type: RSA
    Key-Length: 2048
    Name-Real: My Encryption Key
    Name-Email: myemail@example.com
    Expire-Date: 0
    Passphrase: mypassphrase
    %commit
EOF
fi

# Encrypt a file using the GPG key
gpg --batch --yes --output file.txt.gpg --encrypt --recipient "myemail@example.com" file.txt

# Decrypt the encrypted file
gpg --batch --yes --output file.txt --decrypt file.txt.gpg
