import time
import os

# Define the prefix we're looking for
PREFIX = '0x0'

# Start an infinite loop that runs until a key is pressed
while True:
    # Clear the console
    os.system('cls' if os.name == 'nt' else 'clear')
    print('Press any key to stop...')

    # Open the wallets file and read the lines
    with open('wallets.txt', 'r') as f:
        lines = f.readlines()

    # Define a variable to keep track of the current wallet
    current_wallet = None

    # Define a variable to keep track of the wallets that start with 0x0
    found_wallets = []

    # Loop through the lines
    for line in lines:
        # Check if the line starts with the prefix
        if line.startswith(PREFIX):
            # If it does, get the wallet number and set it as the current wallet
            current_wallet = line.split()[1].strip(')')

            # Check if the current wallet is not already in the found wallets list
            if current_wallet not in found_wallets:
                # If it isn't, add it to the list
                found_wallets.append(current_wallet)

        # Check if we're currently processing a wallet and if the line contains the private key or public key
        if current_wallet and ('privatekey' in line.lower() or 'publickey' in line.lower()):
            # If it does, append the line to the current wallet's data
            with open(f'0x{current_wallet}.txt', 'a') as f:
                f.write(line)

    # Check if any wallets were found
    if found_wallets:
        # If they were, print a message and the list of wallets
        print(f'Found {len(found_wallets)} wallets that start with "{PREFIX}":')
        print(', '.join(found_wallets))
    else:
        # If they weren't, print a message saying so
        print(f'No wallets found that start with "{PREFIX}"')

    # Wait for 1 second
    time.sleep(1)
