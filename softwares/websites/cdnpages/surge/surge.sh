#!/bin/bash

# Function to create a new project
create_project() {
  clear
  echo "============================="
  echo "  WELCOME TO PROJECT CREATOR  "
  echo "============================="
  read -p "Enter project name: " project_name
  mkdir "$project_name"
  cd "$project_name"
  touch index.html style.css script.js
  echo -ne -n -e "<!DOCTYPE html>\n<html>\n<head>\n<title></title>\n<link rel='stylesheet' type='text/css' href='style.css'>\n<script type='text/javascript' src='script.js'></script>\n</head>\n<body>\n</body>\n</html>" > index.html
  echo -ne -n -e "/* Add your CSS code here */" > style.css
  echo -ne -n -e "// Add your JavaScript code here" > script.js
  echo "Project created successfully."
  sleep 2
  main_menu
}

# Function to edit HTML files
edit_html_files() {
  clear
  echo "============================="
  echo "  WELCOME TO HTML EDITOR  "
  echo "============================="
  read -p "Enter the file name to edit: " file_name
  if [ ! -f "$file_name" ]; then
    echo "File does not exist."
    sleep 2
    edit_project_menu
  else
    vi "$file_name"
    echo "File saved successfully."
    sleep 2
    edit_project_menu
  fi
}

# Function to edit CSS files
edit_css_files() {
  clear
  echo "============================="
  echo "  WELCOME TO CSS EDITOR  "
  echo "============================="
  read -p "Enter the file name to edit: " file_name
  if [ ! -f "$file_name" ]; then
    echo "File does not exist."
    sleep 2
    edit_project_menu
  else
    vi "$file_name"
    echo "File saved successfully."
    sleep 2
    edit_project_menu
  fi
}

# Function to edit JavaScript files
edit_js_files() {
  clear
  echo "============================="
  echo "  WELCOME TO JAVASCRIPT EDITOR  "
  echo "============================="
  read -p "Enter the file name to edit: " file_name
  if [ ! -f "$file_name" ]; then
    echo "File does not exist."
    sleep 2
    edit_project_menu
  else
    vi "$file_name"
    echo "File saved successfully."
    sleep 2
    edit_project_menu
  fi
}

# Function to download a project from a Surge domain
download_project() {
  clear
  echo "============================="
  echo " DOWNLOAD PROJECT FROM DOMAIN "
  echo "============================="

  # Prompt the user for the domain name and directory to save the project to
  read -p "Enter the domain name: " domain_name
  read -p "Enter the directory to save the project to: " save_directory

  # Download the project files from the domain and save them to the specified directory
  surge fetch $domain_name $save_directory

  echo "Project downloaded successfully."
  sleep 2
  main_menu
}

# Function to display the project edit menu
edit_project_menu() {
  clear
  echo "============================="
  echo "  WELCOME TO PROJECT EDITOR  "
  echo "============================="
  echo "1. Edit HTML files"
  echo "2. Edit CSS files"
  echo "3. Edit JavaScript files"
  echo "4. Back to Main Menu"
  read -p "Enter your choice: " choice
  case $choice in
    1) edit_html_files;;
    2) edit_css_files;;
    3) edit_js_files;;
    4) main_menu;;
    *) echo "Invalid choice."
       sleep 2
       edit_project_menu;;
  esac
}

# Function to display the main menu
main_menu() {
  clear
  echo "============================="
  echo "  WELCOME TO PROJECT MANAGER  "
  echo "============================="
  echo "1. Create a new project"
  echo "2. Edit an existing project"
  echo "3. Upload project to a domain"
  echo "4. Download project from a domain"
  echo "5. Exit"

  read -p "Enter your choice [1-5]: " choice
  case $choice in
    1) create_project;;
    2) edit_project_menu;;
    3) upload_project;;
    4) download_project;;
    5) exit;;
    *) echo "Invalid choice."
       sleep 2
       main_menu;;
  esac
}

#Call the main menu function to start the program
main_menu
