#!/bin/bash

# Function to open IPFS ports in the firewall
function open_ipfs_ports() {
    # Allow incoming traffic to IPFS
    sudo iptables -A OUTPUT -p tcp --dport 4001 -j ACCEPT
    sudo iptables -A OUTPUT -p udp --dport 4001 -j ACCEPT
    sudo iptables -A OUTPUT -p tcp --dport 5001 -j ACCEPT
    sudo iptables -A OUTPUT -p udp --dport 5001 -j ACCEPT
    sudo iptables -A OUTPUT -p tcp --dport 8080 -j ACCEPT
    sudo iptables -A OUTPUT -p udp --dport 8080 -j ACCEPT
}

# Function to close IPFS ports in the firewall
function close_ipfs_ports() {
    # Block incoming traffic to IPFS
    sudo iptables -A OUTPUT -p tcp --dport 4001 -j DROP
    sudo iptables -A OUTPUT -p udp --dport 4001 -j DROP
    sudo iptables -A OUTPUT -p tcp --dport 5001 -j DROP
    sudo iptables -A OUTPUT -p udp --dport 5001 -j DROP
    sudo iptables -A OUTPUT -p tcp --dport 8080 -j DROP
    sudo iptables -A OUTPUT -p udp --dport 8080 -j DROP
}

# IPFS menu function
function ipfs_menu() {
    echo "IPFS Menu:"
    echo "1. Create IPFS repository"
    echo "2. Add file to IPFS"
    echo "3. Upload file to IPFS"
    echo "4. Remove pinned file from IPFS"
    echo "5. Exit"

    read -p "Enter your choice (1-5): " choice
    echo ""
    case $choice in
        1)
            open_ipfs_ports
            read -p "Enter the name of the repository: " repo_name
            ipfs init "$repo_name"
            echo "Repository $repo_name has been created."
            echo ""
            close_ipfs_ports
            ipfs_menu
            ;;
        2)
            open_ipfs_ports
            read -p "Enter the file path to add to IPFS: " file_path
            ipfs add "$file_path"
            echo ""
            close_ipfs_ports
            ipfs_menu
            ;;
        3)
            open_ipfs_ports
            read -p "Enter the file path to upload to IPFS: " file_path
            ipfs add "$file_path" --pin=true
            echo ""
            close_ipfs_ports
            ipfs_menu
            ;;
        4)
            open_ipfs_ports
            read -p "Enter the CID of the pinned file you want to remove: " cid
            ipfs pin rm "$cid"
            echo ""
            close_ipfs_ports
            ipfs_menu
            ;;
        5)
            echo "Exiting IPFS Menu..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 5."
            echo ""
            ipfs_menu
            ;;
    esac
}

# Run IPFS menu
ipfs_menu
