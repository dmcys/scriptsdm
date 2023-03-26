#!/bin/bash

# Function to modify IPFS config file to use only port 443/tcp
function use_only_443() {
  # Backup original config file
  cp ~/.ipfs/config ~/.ipfs/config.bak

  # Modify config file to use only port 443/tcp
  sed -i 's/.*"API": "\/.*\/tcp\/5001",/"API": "\/ip4\/0.0.0.0\/tcp\/443",/' ~/.ipfs/config
  sed -i 's/.*"Gateway": "\/.*\/tcp\/8080",/"Gateway": "\/ip4\/0.0.0.0\/tcp\/8080",/' ~/.ipfs/config
  sed -i 's/.*"Swarm".*/"Swarm": ["\/ip4\/0.0.0.0\/tcp\/4001"]/' ~/.ipfs/config

  # Restart IPFS daemon
  ipfs daemon --restart
}

# Function to restore original IPFS config file
function restore_config() {
  # Restore original config file
  cp ~/.ipfs/config.bak ~/.ipfs/config

  # Restart IPFS daemon
  ipfs daemon --restart
}

# Main menu
echo "IPFS Config Menu:"
echo "1. Use only port 443/tcp"
echo "2. Restore original config file"
echo "3. Exit"

read -p "Enter your choice (1-3): " choice

case $choice in
  1)
    echo "Modifying IPFS config file to use only port 443/tcp..."
    use_only_443
    echo "IPFS config file has been modified."
    ;;
  2)
    echo "Restoring original IPFS config file..."
    restore_config
    echo "IPFS config file has been restored to its original state."
    ;;
  3)
    echo "Exiting IPFS Config Menu..."
    exit 0
    ;;
  *)
    echo "Invalid choice. Please enter a number between 1 and 3."
    ;;
esac
