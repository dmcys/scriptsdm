#!/bin/bash

# Set the Node.js version to install
NODE_VERSION="14.17.6"

# Create the directories for the Node.js installation
mkdir -p nodejs
mkdir -p node_modules

# Download and extract Node.js
curl -sL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" | tar xJ -C nodejs --strip-components=1

# Set the PATH environment variable to use the locally installed Node.js
export PATH="$(pwd)/nodejs/bin:$PATH"

# Install npm in the project directory
npm config set prefix "$(pwd)/node_modules"
npm install -g npm@latest

# Create a symbolic link for npm and npx in the project directory
sudo ln -s "$(pwd)/node_modules/bin/npm" /usr/local/bin/npm
sudo ln -s "$(pwd)/node_modules/bin/npx" /usr/local/bin/npx
sudo ln -s "$(pwd)/nodejs/bin/node" /usr/local/bin/node

# Print success message
echo "Node.js and npm installed successfully!"
