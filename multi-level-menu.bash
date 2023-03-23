#!/bin/bash

# Define the first level menu options
PS3="Please select an option: "
options=("Option 1" "Option 2" "Quit")

# Define the second level menu options
options1=("Option 1-1" "Option 1-2" "Back")
options2=("Option 2-1" "Option 2-2" "Back")

# Define a function to display the second level menu
function second_level_menu {
  local options=("$@")
  PS3="Please select an option: "
  select opt in "${options[@]}"
  do
    case $opt in
      "Option 1-1")
        echo "You chose Option 1-1"
        ;;
      "Option 1-2")
        echo "You chose Option 1-2"
        ;;
      "Option 2-1")
        echo "You chose Option 2-1"
        ;;
      "Option 2-2")
        echo "You chose Option 2-2"
        ;;
      "Back")
        break
        ;;
      *) echo "Invalid option. Please select again."
        ;;
    esac
  done
}

# Define the main menu loop
while true
do
  # Display the first level menu
  select opt in "${options[@]}"
  do
    case $opt in
      "Option 1")
        second_level_menu "${options1[@]}"
        break
        ;;
      "Option 2")
        second_level_menu "${options2[@]}"
        break
        ;;
      "Quit")
        exit
        ;;
      *) echo "Invalid option. Please select again."
        ;;
    esac
  done
done
