#!/bin/bash
portnodejs() {
# Set the Node.js version to install
read -p "What the version of NodeJS you wan install? Ex: 14.17.6 " NODE_VERSION;

# Create the directories for the Node.js installation
mkdir -p nodejs
mkdir -p node_modules

# Download and extract Node.js
wget "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" | tar xJ -C nodejs --strip-components=1

# Set the PATH environment variable to use the locally installed Node.js
export PATH="$(pwd)/nodejs/bin:$PATH"

# Create a symbolic link for npm and npx in the project directory
sudo ln -s "$(pwd)/node_modules/bin/npm" /usr/bin/npm
sudo ln -s "$(pwd)/node_modules/bin/npx" /usr/bin/npx
sudo ln -s "$(pwd)/nodejs/bin/node" /usr/bin/node

#Create the reference of node-portable path on /usr/bin
sudo echo -ne -n -e "${pwd}/" > /usr/bin/node.ref

# Get the name of the user's terminal emulator
TERMINAL_EMULATOR=$(basename "$SHELL")

# Open a new shell with bash -u and execute the npm installation in the new shell
case "$TERMINAL_EMULATOR" in
"gnome-terminal"|"tilix"|"xfce4-terminal"|"konsole"|"terminator"|"mate-terminal")
"$TERMINAL_EMULATOR" -- bash -c 'npm config set prefix "$(pwd)/node_modules"; npm install -g npm@latest; exec bash'
;;
"xterm"|"rxvt"|"urxvt"|"st"|"sakura"|"eterm"|"lilyterm"|"terminology"|"terminix"|"cool-retro-term"|"deepin-terminal"|"tilda")
"$TERMINAL_EMULATOR" -e bash -c 'npm config set prefix "$(pwd)/node_modules"; npm install -g npm@latest; exec bash'
;;
*)
echo "Unable to open a new terminal. Please open a new terminal manually and run the following command:"
echo "npm config set prefix "$(pwd)/node_modules"; npm install -g npm@latest"
;;
esac

# rerun npm in the project directory
npm config set prefix "$(pwd)/node_modules"
npm install -g npm@latest


# Print success message
echo "Node.js and npm installed successfully!"
}
portnodejs
