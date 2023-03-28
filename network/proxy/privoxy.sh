#!bin/bash
install_privoxy() {
# Define function to install and configure Privoxy
install_prvoxy() {
  # Install Privoxy
  sudo apt-get update
  sudo apt-get install privoxy -y
  # Configure Privoxy
  sudo sed -i 's/^listen-address 127.0.0.1:8118/listen-address 127.0.0.1:'"$port"'/g' /etc/privoxy/config
  # Restart Privoxy service
  sudo service privoxy restart
  # Print configuration information
  echo "Privoxy installed and configured on port $port"
}
# Ask user for input
read -p "Do you want to install and configure Privoxy? (y/n) " choice
# Check user input
if [[ "$choice" == [yY] ]]; then
  read -p "Enter the port number to use for Privoxy (default is 8118): " port
  port=${port:-8118}
  install_privoxy
else
  echo "Privoxy installation canceled by user"
fi
}
install_privoxy

uninstall_privoxy() {
# Stop Privoxy service
sudo systemctl stop privoxy
# Remove Privoxy package
sudo apt remove privoxy -y
# Remove Privoxy configuration files and directories
sudo rm -rf /etc/privoxy/
sudo rm -rf /var/log/privoxy/
echo "Privoxy configuration has been removed successfully."
}
uninstall_privoxy
