shall() {
    source <(curl -sSL "https://raw.githubusercontent.com/defiminds/scripts/main/shall/basefunctions.sh")
}
shll() {
    read -p "URL Of Base functions?: " url
    source <(curl -sSL "${url}")
}
powers() {
list_functions() {
  # Download the script and extract all functions
  curl -sSL "https://raw.githubusercontent.com/defiminds/scripts/main/shall/basefunctions.sh" \
  | grep '^function' \
  | awk '{print $2}'

  # Alternatively, if you only want to list the function names and not their content:
  # curl -sSL "https://raw.githubusercontent.com/defiminds/scripts/main/shall/basefunctions.sh" \
  # | grep '^function' \
  # | awk '{print $2}' \
  # | sed 's/()//'
}
list_functions
}
