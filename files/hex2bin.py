#!/usr/bin/env python3

hex_string = 'YOURHEXHERE'
binary_string = ''

# Iterate over each character in the hex string
for c in hex_string:
    # Convert the hex character to its corresponding binary string
    binary_char = bin(int(c, 16))[2:].zfill(4)
    # Append the binary string to the result
    binary_string += binary_char

print(binary_string)
