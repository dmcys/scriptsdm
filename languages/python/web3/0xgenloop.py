from web3.auto import w3
from eth_account import Account
import msvcrt

num_wallets = int(input("How many wallets do you want to generate? "))

with open("wallets.txt", "w") as file:
    for i in range(1, num_wallets+1):
        new_account = Account.create()
        private_key = new_account.privateKey.hex()
        public_key = new_account.publicKey.hex()
        file.write(f"Wallet {i}\n")
        file.write("Private key:\n")
        file.write(f"{private_key}\n")
        file.write("Public key:\n")
        file.write(f"{public_key}\n\n")
        
        if msvcrt.kbhit():
            break
            
        print("Press any key to stop...")
        
    print("Done!")
