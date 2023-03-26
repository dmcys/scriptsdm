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
    echo "2. Não encriptar o arquivo"
    read encryption_option
    case $encryption_option in
        1)
            encryption_method="gpg"
            echo "Digite o ID do seu chave GPG:"
            read gpg_key_id
            ;;
        *)
            encryption_method="none"
            ;;
    esac
    echo "Digite seu nome de usuário do Git:"
    read username
    echo "Digite seu token de acesso do Git:"
    read token
    if [ "$encryption_method" != "none" ]
    then
        echo "username=\"$username\"" > $CONFIG_FILE
        echo "token=\"$token\"" >> $CONFIG_FILE
        echo "encrypt=true" >> $CONFIG_FILE
        echo "gpg_key_id=\"$gpg_key_id\"" >> $CONFIG_FILE
        gpg --encrypt --recipient $gpg_key_id $CONFIG_FILE
        rm $CONFIG_FILE
        echo "Arquivo de configuração encriptado com sucesso!"
    else
        echo "username=\"$username\"" > $CONFIG_FILE
        echo "token=\"$token\"" >> $CONFIG_FILE
        echo "encrypt=false" >> $CONFIG_FILE
        echo "Arquivo de configuração não encriptado."
    fi
    echo "Perfil configurado com sucesso!"
}

#Verificar se o arquivo de configuração existe e carregar as informações de perfil se existir

if [[ -f "$CONFIG_FILE" ]]; then
echo "Arquivo de configuração encontrado. Deseja desencriptá-lo? Digite o número correspondente:"
echo "1. GPG"
echo "2. OpenSSL"
echo "3. GPG+OpenSSL"
echo "4. Não encriptado"
read encryption_option
case $encryption_option in
1)
decryption_method="gpg"
;;
2)
decryption_method="openssl"
;;
3)
decryption_method="gpg+openssl"
;;
*)
decryption_method="none"
;;
esac
if [ "$decryption_method" != "none" ]
then
read -s -p "Digite sua senha: " password
if ! $decryption_method $CONFIG_FILE -d -o temp_config_file; then
echo "Erro ao desencriptar o arquivo de configuração."
exit 1
fi
source temp_config_file
rm temp_config_file
else
source $CONFIG_FILE
fi
fi
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
