#!/bin/bash

# IPFS menu function
function ipfs_menu() {
    echo "IPFS Firewall Menu:"
    echo "1. Open IPFS firewall ports"
    echo "2. Close IPFS firewall ports"
    echo "3. Exit"

    read -p "Enter your choice (1-3): " choice
    echo ""
    case $choice in
        1)
            # Open ports for IPFS in firewall
            echo "Opening IPFS firewall ports..."
            sudo iptables -A OUTPUT -p tcp --dport 4001 -j ACCEPT
            sudo iptables -A OUTPUT -p udp --dport 4001 -j ACCEPT
            sudo iptables -A OUTPUT -p tcp --dport 5001 -j ACCEPT
            sudo iptables -A OUTPUT -p udp --dport 5001 -j ACCEPT
            sudo iptables -A OUTPUT -p tcp --dport 8080 -j ACCEPT
            sudo iptables -A OUTPUT -p udp --dport 8080 -j ACCEPT
            echo "IPFS firewall ports opened successfully."
            echo ""
            ipfs_menu
            ;;
        2)
            # Close ports for IPFS in firewall
            echo "Closing IPFS firewall ports..."
            sudo iptables -D OUTPUT -p tcp --dport 4001 -j ACCEPT
            sudo iptables -D OUTPUT -p udp --dport 4001 -j ACCEPT
            sudo iptables -D OUTPUT -p tcp --dport 5001 -j ACCEPT
            sudo iptables -D OUTPUT -p udp --dport 5001 -j ACCEPT
            sudo iptables -D OUTPUT -p tcp --dport 8080 -j ACCEPT
            sudo iptables -D OUTPUT -p udp --dport 8080 -j ACCEPT
            sudo iptables -I OUTPUT -p tcp --dport 4001 -j DROP
            sudo iptables -I OUTPUT -p udp --dport 4001 -j DROP
            sudo iptables -I OUTPUT -p tcp --dport 5001 -j DROP
            sudo iptables -I OUTPUT -p udp --dport 5001 -j DROP
            sudo iptables -I OUTPUT -p tcp --dport 8080 -j DROP
            sudo iptables -I OUTPUT -p udp --dport 8080 -j DROP
            echo "IPFS firewall ports closed successfully."
            echo ""
            ipfs_menu
            ;;
        3)
            echo "Exiting IPFS Firewall Menu..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 3."
            echo ""
            ipfs_menu
            ;;
    esac
}

# Run IPFS Firewall menu
ipfs_menu
