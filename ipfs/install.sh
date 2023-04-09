#!/bin/bash
instipfs() {
# Check if IPFS is installed
if ! command -v ipfs &> /dev/null
then
    echo "IPFS is not installed on your system."
    
    # Prompt user to install IPFS
    read -p "Do you want to install and configure IPFS? (y/n): " choice
    case "$choice" in 
        y|Y ) 
            # Install IPFS
            echo "Installing IPFS..."
            curl -L https://dist.ipfs.io/go-ipfs/v0.19.0/go-ipfs_v0.19.0_linux-amd64.tar.gz | tar xz
            cd go-ipfs && sudo ./install.sh
            
            # Configure IPFS
            read -p "Do you want to configure IPFS with default settings? (y/n): " config_choice
            case "$config_choice" in
                y|Y )
                    # Initialize IPFS with default settings
                    echo "Initializing IPFS with default settings..."
                    ipfs init
                    ;;
                n|N )
                    # Initialize IPFS with custom settings
                    read -p "Enter the IPFS config file path (default: ~/.ipfs/config): " config_path
                    ipfs init --config $config_path
                    ;;
                * )
                    echo "Invalid input. IPFS configuration skipped."
                    ;;
            esac
            ;;
        n|N )
            echo "IPFS installation skipped."
            ;;
        * )
            echo "Invalid input. IPFS installation skipped."
            ;;
    esac
else
    echo "IPFS is already installed on your system."
fi
}
instipfs
