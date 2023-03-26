#!/bin/bash

# Function to display the main menu
main_menu() {
  clear
  echo "===================================="
  echo "  WELCOME TO PROJECT EDITOR SCRIPT  "
  echo "===================================="
  echo "1. Create new project"
  echo "2. Edit existing project"
  echo "3. Remove existing project"
  echo "4. Exit"
  echo "------------------------------------"
  read -p "Enter your choice [1-4]: " choice
  case $choice in
    1)
      create_project
      ;;
    2)
      edit_project_menu
      ;;
    3)
      remove_project
      ;;
    4)
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a number between 1 and 4."
      sleep 2
      main_menu
      ;;
  esac
}

# Function to create new project
create_project() {
  read -p "Enter the project name: " project_name
  mkdir "$project_name"
  cd "$project_name"
  mkdir css js img
  touch index.html css/style.css js/script.js
  echo "<!DOCTYPE html>" > index.html
  echo "<html>" >> index.html
  echo "<head>" >> index.html
  echo "  <title>$project_name</title>" >> index.html
  echo '  <link rel="stylesheet" type="text/css" href="css/style.css">' >> index.html
  echo "</head>" >> index.html
  echo "<body>" >> index.html
  echo "  <h1>Welcome to $project_name</h1>" >> index.html
  echo '  <script type="text/javascript" src="js/script.js"></script>' >> index.html
  echo "</body>" >> index.html
  echo "</html>" >> index.html
  echo "Project created successfully."
  sleep 2
  main_menu
}

# Function to display the edit project menu
edit_project_menu() {
  clear
  echo "==================================="
  echo "  WELCOME TO PROJECT EDITOR MENU  "
  echo "==================================="
  echo "1. Edit HTML files"
  echo "2. Edit CSS files"
  echo "3. Edit JavaScript files"
  echo "4. Main Menu"
  echo "-----------------------------------"
  read -p "Enter your choice [1-4]: " choice
  case $choice in
    1)
      edit_html_files
      ;;
    2)
      edit_css_files
      ;;
    3)
      edit_js_files
      ;;
    4)
      main_menu
      ;;
    *)
      echo "Invalid choice. Please enter a number between 1 and 4."
      sleep 2
      edit_project_menu
      ;;
  esac
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
#Function to edit CSS files
edit_css_files() {
clear
echo "============================="
echo " WELCOME TO CSS EDITOR "
echo "============================="
echo ""
echo "Please enter the name of the CSS file you want to edit (including the extension):"
read css_file
#Check if file exists
if [ ! -f "$project_dir/css/$css_file" ]; then
echo "$css_file does not exist in the project directory."
sleep 2
edit_project_menu
fi
#Open file in editor
$editor $project_dir/css/$css_file
#Prompt user to save changes
echo "Do you want to save changes to $css_file? (y/n)"
read save_changes

if [ $save_changes == "y" ]; then
# Upload file to Surge
surge_up $project_dir
echo ""
echo "CSS file saved and uploaded to Surge successfully!"
sleep 2
else
echo "Changes to $css_file were not saved."
sleep 2
fi

edit_project_menu
}
#Function to edit JavaScript files
edit_js_files() {
clear
echo "============================="
echo " WELCOME TO JS EDITOR "
echo "============================="
echo ""
echo "Please enter the name of the JS file you want to edit (including the extension):"
read js_file
#Check if file exists
if [ ! -f "$project_dir/js/$js_file" ]; then
echo "$js_file does not exist in the project directory."
sleep 2
edit_project_menu
fi
#Open file in editor
$editor $project_dir/js/$js_file
#Prompt user to save changes
echo "Do you want to save changes to $js_file? (y/n)"
read save_changes

if [ $save_changes == "y" ]; then
# Upload file to Surge
surge_up $project_dir
echo ""
echo "JS file saved and uploaded to Surge successfully!"
sleep 2

else
echo "Changes to $js_file were not saved."
sleep 2
fi

edit_project_menu
}
#Function to delete project
delete_project() {
clear
echo "=================================="
echo " WARNING: DELETE PROJECT "
echo "=================================="
echo ""
echo "Are you sure you want to delete this project and all its contents? (y/n)"
read confirm_delete

if [ $confirm_delete == "y" ]; then
# Remove project directory
rm -rf $project_dir
echo ""
echo "Project deleted successfully."
sleep 2
else
echo ""
echo "Project deletion cancelled."
sleep 2
fi

main_menu
}
#Function to exit program
exit_program() {
clear
echo "=================================="
echo " THANK YOU FOR USING SURGE EDIT "
echo "=================================="
echo ""
exit 0
}
#Run main menu on program start
main_menu
