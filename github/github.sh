# Função para configurar o perfil do usuário
configure_profile() {
    echo "How would you like to encrypt the configuration file? Enter the corresponding number:"
    echo "1. GPG"
    echo "2. OpenSSL"
    echo "3. GPG+OpenSSL"
    echo "4. Not encrypt"
    read encryption_option
    case $encryption_option in
        1)
            encryption_method="gpg"
            ;;
        2)
            encryption_method="openssl"
            echo "Enter a password to encrypt the file:"
            read -s openssl_passphrase
            ;;
        3)
            encryption_method="gpg+openssl"
            echo "Enter a password to encrypt the file with OpenSSL:"
            read -s openssl_passphrase
            ;;
        *)
            encryption_method="none"
            ;;
    esac
    echo "Enter your Git username:"
    read username
    echo "Enter your Git access token:"
    read token
    if [ "$encryption_method" = "gpg" ]
    then
        echo "username=\"$username\"" | gpg --encrypt --armor --recipient $USER_ID > $CONFIG_FILE
        echo "token=\"$token\"" | gpg --encrypt --armor --recipient $USER_ID >> $CONFIG_FILE
    elif [ "$encryption_method" = "openssl" ]
    then
        echo -e "$openssl_passphrase\n$openssl_passphrase" | openssl aes-256-cbc -salt -in <(echo -e "username=\"$username\"\ntoken=\"$token\"") -out $CONFIG_FILE
    elif [ "$encryption_method" = "gpg+openssl" ]
    then
        echo -e "$openssl_passphrase\n$openssl_passphrase" | openssl aes-256-cbc -salt -in <(echo -e "username=\"$username\"\ntoken=\"$token\"") | gpg --encrypt --armor --recipient $USER_ID > $CONFIG_FILE
    else
        echo "username=\"$username\"" > $CONFIG_FILE
        echo "token=\"$token\"" >> $CONFIG_FILE
    fi
    echo "Profile set up successfully!"
}
