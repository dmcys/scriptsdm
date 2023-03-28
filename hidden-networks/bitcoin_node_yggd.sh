#!/bin/bash
bitcoin_node_yggd() {
bitcoin_node_ygd() {
echo "1) To Config BTC-YGGD Node"
echo "2) To Del Config of Node"
read choose
if [ $choose == "1" ]; then
# Generate a new Yggdrasil address
PRIVATE_KEY=$(openssl rand -hex 32)
PUBLIC_KEY=$(echo -n "$PRIVATE_KEY" | openssl dgst -sha256 -binary | openssl dgst -rmd160 | cut -c10-)
YGGDRASIL_ADDRESS=$(echo -n "$PUBLIC_KEY" | sed 's/^/tth\//;s/$/\/btcp/')
# Configure Bitcoin to use the Yggdrasil network
sudo sh -c "echo 'listen=1' >> /etc/bitcoin/bitcoin.conf"
sudo sh -c "echo 'bind=127.0.0.1' >> /etc/bitcoin/bitcoin.conf"
sudo sh -c "echo 'onlynet=yggdrasil' >> /etc/bitcoin/bitcoin.conf"
sudo sh -c "echo 'connect=$YGGDRASIL_ADDRESS' >> /etc/bitcoin/bitcoin.conf"
# Start Bitcoin
sudo service bitcoind start
# Display the Yggdrasil address for reference
echo "Yggdrasil address: $YGGDRASIL_ADDRESS"
else
#Retrieve the Yggdrasil address used by Bitcoin
YGGDRASIL_ADDRESS=$(sudo grep -oP 'connect=\K.*' /etc/bitcoin/bitcoin.conf)
#Stop Bitcoin
sudo service bitcoind stop
#Remove the Yggdrasil network configuration from Bitcoin
sudo sed -i '/^listen=1/d' /etc/bitcoin/bitcoin.conf
sudo sed -i '/^bind=127.0.0.1/d' /etc/bitcoin/bitcoin.conf
sudo sed -i '/^onlynet=yggdrasil/d' /etc/bitcoin/bitcoin.conf
sudo sed -i '/^connect=/d' /etc/bitcoin/bitcoin.conf
#Display the Yggdrasil address for reference
echo "Yggdrasil address removed: $YGGDRASIL_ADDRESS"
fi
}
# Ask user for input
read -p "Do you want to install bitcoin node yggd ? (y/n) " choice
# Check user input
if [[ "$choice" == [yY] ]]; then
  bitcoin_node_ygd
else
  echo "bitcoin node yggd installation canceled by user"
fi
}
bitcoin_node_yggd
