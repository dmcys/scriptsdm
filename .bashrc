shall() {
    read -p "URL Of Base functions?: " url
    source <(curl -sSL "${url}")
}
shll() {
    source <(curl -sSL "https://github.com/defiminds/scripts/blob/main/shall/basefunctions.sh")
}
powers() {
list_functions() {
  # Download the script and extract all functions
  curl -sSL "https://github.com/defiminds/scripts/blob/main/shall/basefunctions.sh" \
  | grep '^function' \
  | awk '{print $2}'

  # Alternatively, if you only want to list the function names and not their content:
  # curl -sSL "https://github.com/defiminds/scripts/blob/main/shall/basefunctions.sh" \
  # | grep '^function' \
  # | awk '{print $2}' \
  # | sed 's/()//'
}
list_functions
}
