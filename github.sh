#!/bin/bash

CONFIG_FILE=~/.git-manager.conf

# Função para clonar um repositório
clone_repo() {
    echo "Digite a URL do repositório que deseja clonar:"
    read url
    echo "Digite o nome da branch que deseja clonar (pressione enter para usar a branch padrão):"
    read branch
    if [ -z "$branch" ]
    then
        git clone $url
    else
        git clone -b $branch $url
    fi
    echo "Repositório clonado com sucesso!"
}


# Função para adicionar e confirmar alterações
add_commit_changes() {
    echo "Digite a mensagem do commit:"
    read message
    git add .
    git commit -m "$message"
    echo "Alterações adicionadas e confirmadas com sucesso!"
}

# Função para enviar alterações para um repositório remoto
push_changes() {
    echo "Digite a URL do repositório remoto:"
    read url
    echo "Digite o nome da branch que deseja enviar as alterações:"
    read branch
    if [ -z "$branch" ]
    then
        branch="main"
    fi
# Definir o valor da opção core.autocrlf para o git config
    autocrlf="input"
git config --local core.autocrlf "$autocrlf"
# Extrair o valor das variáveis username e token do arquivo de configuração
# Ask user if they encrypted the CONFIG_FILE using gpg, openssl, both or not at all
echo "Did you encrypt the CONFIG_FILE? (gpg, openssl, gpg+openssl, none)"
read encryption_method
# Check the encryption method and obtain the decrypted contents of the CONFIG_FILE
if [ "$encryption_method" = "gpg" ]; then
    read -p -s "Enter the KEY-ID used to encrypt the file:" USER_ID;
    username=$(grep -oP '^username=\K.*' <<< "$(<$CONFIG_FILE gpg --decrypt --armor --recipient $USER_ID)")
    token=$(grep -oP '^token=\K.*' <<< "$(<$CONFIG_FILE gpg --decrypt --armor --recipient $USER_ID)")
    
elif [ "$encryption_method" = "openssl" ]; then
    read -p -s "Enter the password used to encrypt the file:" password;
    username=$(grep -oP '^username=\K.*' <<< "$(<$openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password")
    token=$(grep -oP '^token=\K.*' <<< "$(<$openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password")
    
elif [ "$encryption_method" = "gpg+openssl" ]; then
    read -p -s "Enter the password used to encrypt the file:" password;
    read -p -s "Enter the KEY-ID used to encrypt the file:" USER_ID;
    opensl=$(openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password)
    username=$(grep -oP '^username=\K.*' <<< "$(<$opensl gpg --decrypt --armor --recipient $USER_ID")
    token=$(grep -oP '^token=\K.*' <<< "$(<$opensl gpg --decrypt --armor --recipient $USER_ID")
else
    username=$(cat $CONFIG_FILE | grep -oP '^username=\K.*')
    token=$(cat $CONFIG_FILE | grep -oP '^token=\K.*')
fi
# Configurar as credenciais do usuário no GitHub
    git config --local user.name "$username"
    git config --local user.email "$username@users.noreply.github.com"
# Enviar as alterações para o repositório remoto
    git remote add origin $url
    git branch -M $branch
    git push -u origin $branch
    echo "Alterações enviadas com sucesso para o repositório remoto!"
}


# Função para atualizar um repositório local
pull_changes() {
    git pull
    echo "Repositório atualizado com sucesso!"
}

# Função para configurar o perfil do usuário
configure_profile() {
    echo "Como você gostaria de encriptar o arquivo de configuração? Digite o número correspondente:"
    echo "1. GPG"
    echo "2. OpenSSL"
    echo "3. GPG+OpenSSL"
    echo "4. Não encriptar o arquivo"
    read encryption_option
    case $encryption_option in
        1)
            encryption_method="gpg"
            ;;
        2)
            encryption_method="openssl"
            echo "Digite uma senha para encriptar o arquivo:"
            read -s openssl_passphrase
            ;;
        3)
            encryption_method="gpg+openssl"
            echo "Digite uma senha para encriptar o arquivo com OpenSSL:"
            read -s openssl_passphrase
            ;;
        *)
            encryption_method="none"
            ;;
    esac
    echo "Digite seu nome de usuário do Git:"
    read username
    echo "Digite seu token de acesso do Git:"
    read token
    if [ "$encryption_method" = "gpg" ]; then
        echo "username=\"$username\"" | gpg --encrypt --armor --recipient $USER_ID > $CONFIG_FILE
        echo "token=\"$token\"" | gpg --encrypt --armor --recipient $USER_ID >> $CONFIG_FILE
    elif [ "$encryption_method" = "openssl" ]; then
        echo -e "$openssl_passphrase\n$openssl_passphrase" | openssl aes-256-cbc -salt -in <(echo -e "username=\"$username\"\ntoken=\"$token\"") -out $CONFIG_FILE
    elif [ "$encryption_method" = "gpg+openssl" ]; then
        echo -e "$openssl_passphrase\n$openssl_passphrase" | openssl aes-256-cbc -salt -in <(echo -e "username=\"$username\"\ntoken=\"$token\"") | gpg --encrypt --armor --recipient $USER_ID > $CONFIG_FILE
    else
        echo "username=\"$username\"" > $CONFIG_FILE
        echo "token=\"$token\"" >> $CONFIG_FILE
    fi
    echo "Perfil configurado com sucesso!"
}

#Menu principal

echo "Bem-vindo ao Gerenciador de Repositórios Git"
echo "Por favor, selecione uma opção:"
echo "1. Clonar um repositório"
echo "2. Adicionar e confirmar alterações"
echo "3. Enviar alterações para um repositório remoto"
echo "4. Atualizar um repositório local"
echo "5. Configurar o perfil do usuário"
read choice

case $choice in
1)
clone_repo
;;
2)
add_commit_changes
;;
3)
push_changes
;;
4)
pull_changes
;;
5)
configure_profile
;;
*)
echo "Opção inválida, por favor selecione uma opção válida"
;;
esac
