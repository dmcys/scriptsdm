#!/bin/bash
shadowsocks() {
install_shadowsocks() {
# Prompt the user for the Shadowsocks configuration
read -p "Enter the server IP address: " server_ip
read -p "Enter the server port number: " server_port
read -p "Enter the encryption method (default: aes-256-cfb): " encryption_method
encryption_method=${encryption_method:-aes-256-cfb}
read -p "Enter the password: " password

# Install Shadowsocks and its dependencies
sudo apt-get update
sudo apt-get install -y shadowsocks-libev

# Create the Shadowsocks configuration file
sudo tee /etc/shadowsocks-libev/config.json > /dev/null <<EOF
{
    "server":"$server_ip",
    "server_port":$server_port,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"$password",
    "timeout":60,
    "method":"$encryption_method"
}
EOF

# Restart the Shadowsocks service to apply the new configuration
sudo systemctl restart shadowsocks-libev

echo "Shadowsocks has been successfully installed and configured!"
}

uninstall_shadowsocks() {
# Stop Shadowsocks service
systemctl stop shadowsocks-libev
# Uninstall Shadowsocks
apt remove shadowsocks-libev -y
# Remove Shadowsocks configuration file
rm -rf /etc/shadowsocks-libev
# Remove Shadowsocks log files
rm -rf /var/log/shadowsocks-libev
# Remove Shadowsocks service file
rm -rf /etc/systemd/system/shadowsocks-libev.service
# Reload systemd
systemctl daemon-reload
echo "Shadowsocks has been completely uninstalled and logs cleaned."
}

configure_shadowsocks() {
    echo "Configuring Shadowsocks..."
    
    # Default values
    SERVER="0.0.0.0"
    SERVER_PORT=8388
    LOCAL_ADDRESS="127.0.0.1"
    LOCAL_PORT=1080
    PASSWORD="your_password_here"
    TIMEOUT=300
    METHOD="chacha20-ietf-poly1305"

    # Read input from user
    read -p "Enter server IP address (default: $SERVER): " input_server
    read -p "Enter server port (default: $SERVER_PORT): " input_server_port
    read -p "Enter local address (default: $LOCAL_ADDRESS): " input_local_address
    read -p "Enter local port (default: $LOCAL_PORT): " input_local_port
    read -p "Enter password strong (default: 35): " input_passwordstr
    input_password=$(openssl rand -base64 ${input_passwordstr})
    #read -p "Enter password (default: $PASSWORD): " input_password
    read -p "Enter timeout in seconds (default: $TIMEOUT): " input_timeout
    read -p "Enter encryption method (default: $METHOD): " input_method

    # Set values to input or default
    SERVER=${input_server:-$SERVER}
    SERVER_PORT=${input_server_port:-$SERVER_PORT}
    LOCAL_ADDRESS=${input_local_address:-$LOCAL_ADDRESS}
    LOCAL_PORT=${input_local_port:-$LOCAL_PORT}
    PASSWORD=${input_password:-$PASSWORD}
    TIMEOUT=${input_timeout:-$TIMEOUT}
    METHOD=${input_method:-$METHOD}

    # Write configuration file
    cat > /etc/shadowsocks-libev/config.json <<EOF
{
    "server":"$SERVER",
    "server_port":$SERVER_PORT,
    "local_address":"$LOCAL_ADDRESS",
    "local_port":$LOCAL_PORT,
    "password":"$PASSWORD",
    "timeout":$TIMEOUT,
    "method":"$METHOD"
}
EOF

    echo "Shadowsocks configuration file written to /etc/shadowsocks-libev/config.json"
    echo -ne -n -e "Shadowsocks Password: ${input_password}"
}

whonix() {
# Install Shadowsocks
sudo apt-get update
sudo apt-get install shadowsocks-libev -y
configure_shadowsocks

# Start Shadowsocks
sudo systemctl start shadowsocks-libev
# Allow incoming connections to Shadowsocks port
sudo ufw allow 8388
# Allow outgoing connections to Tor ports
sudo ufw allow out 9150
sudo ufw allow out 9050
# Set up Tor as the default gateway
sudo sed -i '/DisableNetwork/c\DisableNetwork 0' /etc/tor/torrc
sudo sed -i '/TransPort/c\TransPort 9040' /etc/tor/torrc
sudo sed -i '/TransListenAddress/c\TransListenAddress 127.0.0.1' /etc/tor/torrc
sudo sed -i '/DNSPort/c\DNSPort 5353' /etc/tor/torrc
sudo sed -i '/DNSListenAddress/c\DNSListenAddress 127.0.0.1' /etc/tor/torrc
sudo systemctl restart tor
# Allow incoming connections to Tor SocksPort
sudo ufw allow 9050
# Enable UFW firewall
sudo ufw --force enable
# Print configuration information
echo "Shadowsocks server running on port 8388"
echo "Make sure to configure your Shadowsocks client to connect to this server"
}

firewall() {
# porta do Shadowsocks (altere caso necessário)
local PORTA=1080
# verifica se o serviço Shadowsocks está em execução
if systemctl is-active shadowsocks > /dev/null; then
  echo "Shadowsocks em execução. Liberando porta $PORTA no firewall..."
# libera a porta no firewall
  sudo ufw allow $PORTA
 else
  echo "Shadowsocks não está em execução. Fechando porta $PORTA no firewall..."
# fecha a porta no firewall
  sudo ufw delete allow $PORTA
fi
}

#Menu principal

echo "ShadowSocks Menu"
echo "Inser your choose:"
echo "1. Install ShadowSocks"
echo "2. Uninstall ShadowSocks"
echo "3. Configure ShadowSocks"
echo "4. Whonix"
echo "5. Firewall"
echo ""
echo "q. Quit"
read choice

case $choice in
1)
install_shadowsocks
;;
2)
uninstall_shadowsocks
;;
3)
configure_shadowsocks
;;
4)
whonix
;;
5)
firewall
;;
q)
clear
exit;;
*)
echo "Opção inválida, por favor selecione uma opção válida"
;;
esac
}
shadowsocks
