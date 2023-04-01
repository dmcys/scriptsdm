#!bin/bash
polipo() {
install_polipo() {
install_polpo() {
# Install Polipo
echo "Installing Polipo..."
sudo apt update
sudo apt install polipo -y
# Set up configuration file
echo "Configuring Polipo..."
sudo cp /etc/polipo/config{,.bak}
# Prompt user for HTTP proxy port
read -p "Enter HTTP proxy port [default: 8123]: " http_port
http_port=${http_port:-8123}
# Prompt user for allowed clients
read -p "Enter allowed clients (separate multiple IPs with a space) [default: 127.0.0.1]: " allowed_clients
allowed_clients=${allowed_clients:-127.0.0.1}
# Prompt user for proxy name
read -p "Enter a name for this proxy [default: MyPolipoProxy]: " proxy_name
proxy_name=${proxy_name:-MyPolipoProxy}
# Update configuration file with user input
sudo sed -i "s/proxyPort =.*/proxyPort = ${http_port}/" /etc/polipo/config
sudo sed -i "s/allowedClients =.*/allowedClients = ${allowed_clients}/" /etc/polipo/config
sudo sed -i "s/proxyName =.*/proxyName = \"${proxy_name}\"/" /etc/polipo/config
# Restart Polipo service
echo "Restarting Polipo service..."
sudo systemctl restart polipo
echo "Polipo has been installed and configured!"
}
# Ask user for input
read -p "Do you want to install polipo? (y/n) " choice
# Check user input
if [[ "$choice" == [yY] ]]; then
  install_polpo
else
  echo "polipo installation canceled by user"
fi
}

uninstall_polipo() {
uninstall_polpo() {
# Stop the Polipo service
sudo systemctl stop polipo.service
# Remove the Polipo package and its configuration files
sudo apt-get remove --purge polipo -y
# Remove the Polipo logs
sudo rm -rf /var/log/polipo
# Remove the Polipo system user
sudo userdel -r polipo
# Remove the Polipo system group
sudo groupdel polipo
# Reload the systemd daemon
sudo systemctl daemon-reload
echo "Polipo has been completely removed from your system."
}
# Ask user for input
read -p "Do you want to uninstall polipo? (y/n) " choice
# Check user input
if [[ "$choice" == [yY] ]]; then
  uninstall_polpo
else
  echo "polipo uninstallation canceled by user"
fi
}

while true; do
read -p "1) install polipo, 2) uninstall polipo, q) Exit " choice
if [ $choice == "1" ]; then
install_polipo
elif [ $choice == "2" ]; then
uninstall_polipo
elif [ $choice == "q" ]; then
exit;;
fi
esac
done
}
polipo
