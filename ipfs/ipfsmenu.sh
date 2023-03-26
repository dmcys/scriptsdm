#!/bin/bash

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
            read -p "Enter the name of the repository: " repo_name
            ipfs init "$repo_name"
            echo "Repository $repo_name has been created."
            echo ""
            ipfs_menu
            ;;
        2)
            read -p "Enter the file path to add to IPFS: " file_path
            ipfs add "$file_path"
            echo ""
            ipfs_menu
            ;;
        3)
            read -p "Enter the file path to upload to IPFS: " file_path
            ipfs add "$file_path" --pin=true
            echo ""
            ipfs_menu
            ;;
        4)
            read -p "Enter the CID of the pinned file you want to remove: " cid
            ipfs pin rm "$cid"
            echo ""
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
