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

add_commit_changes() {
    echo "Input the commit message: "
    read message
    echo "What the name of respository that you want modify? "
    read url
    echo "What the name of branche that you want modify? "
    read branch
    git config --unset credential.helper

# Function to decrypt
echo "Did you encrypt the CONFIG_FILE? (gpg, openssl, gpg+openssl, none)"
read encryption_method
if [ "$encryption_method" = "gpg" ]; then
    echo "Input USER-ID of GPG Key: "
    read -s USER_ID
    decryptedu=$(gpg --decrypt --armor --recipient $USER_ID $CONFIG_FILE | grep username | cut -d'=' -f2 | tr -d '"')
    decryptedt=$(gpg --decrypt --armor --recipient $USER_ID $CONFIG_FILE | grep token | cut -d'=' -f2 | tr -d '"')
    git remote set-url origin https://${decryptedu}:${decryptedt}@github.com/${decryptedu}/${url}.git
    git add ./
    git commit -m "${message}"
    echo "Alterações adicionadas e confirmadas com sucesso!"
elif [ "$encryption_method" = "openssl" ]; then
    echo "Input password of openssl file: "
    read -s password
    decryptedu=$(openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password | grep username | cut -d'=' -f2 | tr -d '"')
    decryptedt=$(openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password | grep token | cut -d'=' -f2 | tr -d '"')
    git remote set-url origin https://${decryptedu}:${decryptedt}@github.com/${decryptedu}/${url}.git
    git add ./
    git commit -m "${message}"
    echo "Alterações adicionadas e confirmadas com sucesso!"
elif [ "$encryption_method" = "gpg+openssl" ]; then
    read -p -s "Enter the password used to encrypt the file:" password;
    read -p -s "Enter the KEY-ID used to encrypt the file:" USER_ID;
    opensl=$(openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password)
    decryptedu=$(gpg --decrypt --armor --recipient $USER_ID $opensl | grep username | cut -d'=' -f2 | tr -d '"')
    decryptedt=$(gpg --decrypt --armor --recipient $USER_ID $opensl | grep token | cut -d'=' -f2 | tr -d '"')
    git remote set-url origin https://${decryptedu}:${decryptedt}@github.com/${decryptedu}/${url}.git
    git add ./
    git commit -m "${message}"
    echo "Alterações adicionadas e confirmadas com sucesso!"
else
    decryptedu=$(cat $CONFIG_FILE | grep username | cut -d'=' -f2 | tr -d '"')
    decryptedt=$(cat $CONFIG_FILE | grep token | cut -d'=' -f2 | tr -d '"')
    git remote set-url origin https://${decryptedu}:${decryptedt}@github.com/${decryptedu}/${url}.git
    git add ./
    git commit -m "${message}"
    echo "Alterações adicionadas e confirmadas com sucesso!"
fi
}


# Função para enviar alterações para um repositório remoto
push_changes() {
#    echo "Digite a URL do repositório remoto:"
#    echo "Digite o nome do repositório remoto:"
    read url
    echo "Digite o nome da branch que deseja enviar as alterações:"
    read branch
    if [ -z "$branch" ]
    then
        branch="main"
    fi
# Function to decrypt
echo "Did you encrypt the CONFIG_FILE? (gpg, openssl, gpg+openssl, none)"
read encryption_method
if [ "$encryption_method" = "gpg" ]; then
    echo "Input USER-ID of GPG Key: "
    read -s USER_ID
    decryptedu=$(gpg --decrypt --armor --recipient $USER_ID $CONFIG_FILE | grep username | cut -d'=' -f2 | tr -d '"')
    decryptedt=$(gpg --decrypt --armor --recipient $USER_ID $CONFIG_FILE | grep token | cut -d'=' -f2 | tr -d '"')
    git config --unset credential.helper
    git push https://${decryptedu}:${decryptedt}@github.com/${decryptedu}/${url}.git ${branch}
    echo "Alterações enviadas com sucesso para o repositório remoto!"
elif [ "$encryption_method" = "openssl" ]; then
    echo "Input password of openssl file: "
    read -s password
    decryptedu=$(openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password | grep username | cut -d'=' -f2 | tr -d '"')
    decryptedt=$(openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password | grep token | cut -d'=' -f2 | tr -d '"')
    git config --unset credential.helper
    git push https://${decryptedu}:${decryptedt}@github.com/${decryptedu}/${url}.git ${branch}
    echo "Alterações enviadas com sucesso para o repositório remoto!"
elif [ "$encryption_method" = "gpg+openssl" ]; then
    read -p -s "Enter the password used to encrypt the file:" password;
    read -p -s "Enter the KEY-ID used to encrypt the file:" USER_ID;
    opensl=$(openssl aes-256-cbc -d -in $CONFIG_FILE -pass pass:$password)
    decryptedu=$(gpg --decrypt --armor --recipient $USER_ID $opensl | grep username | cut -d'=' -f2 | tr -d '"')
    decryptedt=$(gpg --decrypt --armor --recipient $USER_ID $opensl | grep token | cut -d'=' -f2 | tr -d '"')
    git config --unset credential.helper
    git push https://${decryptedu}:${decryptedt}@github.com/${decryptedu}/${url}.git ${branch}
    echo "Alterações enviadas com sucesso para o repositório remoto!"
else
    decryptedu=$(cat $CONFIG_FILE | grep username | cut -d'=' -f2 | tr -d '"')
    decryptedt=$(cat $CONFIG_FILE | grep token | cut -d'=' -f2 | tr -d '"')
    git config --unset credential.helper
    git push https://${decryptedu}:${decryptedt}@github.com/${decryptedu}/${url}.git ${branch}
    echo "Alterações enviadas com sucesso para o repositório remoto!"
fi
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
