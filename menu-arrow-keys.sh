#!/bin/bash

# Define the menu options
options=("Option 1" "Option 2" "Option 3" "Quit")
menu_length=${#options[@]}

# Set the initial selection to the first option
selected=0

# Define a function to update the selected option based on arrow key input
function update_selected {
  read -rsn1 input
  if [[ $input = "" ]]; then
    return  # Enter key was pressed, do nothing
  elif [[ $input = $'\x1b' ]]; then
    # Arrow key was pressed, read next two characters to determine direction
    read -rsn2 input
    if [[ $input = "[A" && $selected -gt 0 ]]; then
      ((selected--))
    elif [[ $input = "[B" && $selected -lt $((menu_length - 1)) ]]; then
      ((selected++))
    fi
  fi
}

# Define the main menu loop
while true
do
  # Clear the screen and display the menu
  clear
  for i in "${!options[@]}"; do
    if [[ $i -eq $selected ]]; then
      printf "\e[1m>\e[0m %s\n" "${options[$i]}"
    else
      printf "  %s\n" "${options[$i]}"
    fi
  done

  # Wait for user input and update selected option if necessary
  update_selected

  # Handle user input
  if [[ $input = "" && $selected -eq $((menu_length - 1)) ]]; then
    # Quit option selected, exit the script
    exit
  elif [[ $input = "" ]]; then
    # Other option selected, execute the appropriate code
    case $selected in
      0) echo "You chose Option 1";;
      1) echo "You chose Option 2";;
      2) echo "You chose Option 3";;
    esac
  fi
done
