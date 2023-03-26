#!/bin/bash

# Check if IPFS is installed
if command -v ipfs &> /dev/null
then
    # Stop IPFS daemon if it's running
    if pgrep ipfs &> /dev/null
    then
        echo "Stopping IPFS daemon..."
        ipfs shutdown
    fi

    # Uninstall IPFS
    echo "Uninstalling IPFS..."
    sudo rm -rf /usr/local/bin/ipfs /usr/local/lib/ipfs

    # Remove IPFS data and configuration files
    read -p "Do you want to remove IPFS data and configuration files? (y/n): " choice
    case "$choice" in 
        y|Y ) 
            echo "Removing IPFS data and configuration files..."
            rm -rf ~/.ipfs
            ;;
        n|N )
            echo "IPFS data and configuration files were not removed."
            ;;
        * )
            echo "Invalid input. IPFS data and configuration files were not removed."
            ;;
    esac

    echo "IPFS has been completely uninstalled from your system."
else
    echo "IPFS is not installed on your system."
fi
