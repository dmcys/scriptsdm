import subprocess
from web3.auto import w3
from eth_account import Account

# Instala as bibliotecas necessárias
subprocess.check_call(['pip', 'install', 'web3', 'eth-account'])

while True:
    # Pede ao usuário quantas carteiras gerar
    num_wallets = input('Quantas carteiras deseja gerar? (Digite "s" para sair) ')

    # Sai do loop se o usuário digitar "s"
    if num_wallets.lower() == 's':
        break

    # Converte a entrada do usuário para um número inteiro
    num_wallets = int(num_wallets)

    # Gera as carteiras e escreve as informações em um arquivo de texto
    with open('web3_wallets.txt', 'a') as f:
        for i in range(num_wallets):
            # Gera uma nova carteira
            new_account = w3.eth.account.create()

            # Obtém as informações da carteira
            private_key = new_account.privateKey.hex()
            public_key = new_account.public_key.hex()
            seed_words = ' '.join(new_account._mnemonic_phrase)

            # Escreve as informações da carteira em um arquivo de texto
            f.write(f'Carteira {i + 1}:\n')
            f.write(f'PrivKey: {private_key}\n')
            f.write(f'Pubkey: {public_key}\n')
            f.write(f'WordsSeed: {seed_words}\n')
            f.write('\n')
