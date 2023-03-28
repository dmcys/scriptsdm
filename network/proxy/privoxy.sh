#!bin/bash
install_privoxy() {
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
uninstall_privoxy() {
sudo systemctl stop privoxy
# Remove Privoxy package
sudo apt remove privoxy -y
# Remove Privoxy configuration files and directories
sudo rm -rf /etc/privoxy/
sudo rm -rf /var/log/privoxy/
echo "Privoxy configuration has been removed successfully."
}
#Menu principal
echo "Menu Privoxy"
echo "Choose"
echo "1. Install Privoxy"
echo "2. Uninstall Privoxy"
read choice
case $choice in
1)
install_privoxy
;;
2)
uninstall_privoxy
;;
*)
echo "Invalid option."
;;
esac
