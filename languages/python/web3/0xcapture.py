#!/bin/bash
0xcap() {
# Scan the wallets.txt file for lines containing "Publickey:0x0"
# and copy them to a new file named 0xwallets.txt,
# skipping one line from the previous content
grep "Publickey:0x0" wallets.txt | awk '{print prev "\n" $0; prev=$0}' > 0xwallets.txt
}
0xcap
