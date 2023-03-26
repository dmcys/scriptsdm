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
  echo "<!DOCTYPE html>
<html>
<head>
	<title></title>
	<link rel='stylesheet' type='text/css' href='style.css'>
	<script type='text/javascript' src='script.js'></script>
</head>
<body>

</body>
</html>" > index.html
  echo "/* Add your CSS code here */" > style.css
  echo "// Add your JavaScript code here" > script.js
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
  echo "3. Exit"
echo "Please enter your choice:"
read choice
case $choice in
1) create_new_project ;;
2) edit_project_menu ;;
3) exit ;;
*) echo "Invalid choice, please try again."
sleep 2
main_menu ;;
esac
}
#Call the main menu function to start the program
main_menu
