#!/bin/bash
install_shadowsocks() {
install_shadowscks() {
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
# Ask user for input
read -p "Do you want to install Shadowsocks? (y/n) " choice
# Check user input
if [[ "$choice" == [yY] ]]; then
  install_shadowscks
else
  echo "Shadowsocks installation canceled by user"
fi
}
install_shadowsocks

uninstall_shadowsocks() {
uninstall_shadowscks() {
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
# Ask user for input
read -p "Do you want to uninstall Shadowsocks? (y/n) " choice
# Check user input
if [[ "$choice" == [yY] ]]; then
  uninstall_shadowscks
else
  echo "Shadowsocks uninstallation canceled by user"
fi
}
uninstall_shadowsocks
