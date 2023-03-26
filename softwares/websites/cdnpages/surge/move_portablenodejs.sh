#!/bin/bash

# Get the current path of the Node.js installation
echo "What the root path containing all path/files of nodejs?";
echo "Ex: ./myportableproject/";echo '';
echo "this is referent the root dir of portables project that have, nodejs/node_modules paths and project folder";
read -p "Ex: ./myportableproject/" CURRENT_PATH;

# Prompt the user for the new path of the Node.js installation
read -p "Enter the new path of the Node.js installation: " NEW_PATH

# Move the Node.js installation to the new path
sudo mv "$CURRENT_PATH" "$NEW_PATH"

# Update the PATH environment variable
export PATH="$NEW_PATH/bin:$PATH"

# Update the symbolic links for npm and npx and surge
sudo ln "$NEW_PATH/node_modules/bin/npm" /usr/bin/npm
sudo ln "$NEW_PATH/node_modules/bin/npx" /usr/bin/npx
sudo ln -s "$NEW_PATH/node_modules/bin/surge" /usr/bin/surge

# Update the symbolic link for node
sudo ln "$NEW_PATH/nodejs/bin/node" /usr/bin/node

# Update the reference file for node-portable
sudo echo -ne -n -e "$NEW_PATH/\n" > /usr/bin/node.ref

# Reinstall global packages
npm ls -g --depth=0 | awk -F/ '/node_modules/ && !/\/npm$/ {print $NF}' | xargs npm -g install --force

echo "Node.js installation moved to $NEW_PATH!"
