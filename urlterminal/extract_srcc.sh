#!/bin/bash

while true; do
  echo "Input URL that you need to extract the Src from:"
  read url

  echo "Input the name of the src file (e.g. index.html, default.css):"
  read src

  echo "Choose an action:"
  echo "1. Create folders/subfolders to move the archive"
  echo "2. Move to path folder the archive"
  echo "3. Exit"
  read fs

  case $fs in
    1)
      echo "Create the directory path that you need to create/move the file"
      echo "E.g. ./css/img/"
      read dir
      curl -o $src $url
      mkdir -p $dir
      mv $src $dir/$src
      ;;
    2)
      echo "Input the directory path that you need to move the file"
      echo "E.g. ./css/img/"
      read dir
      curl -o $src $url
      mv $src $dir/$src
      ;;
    3)
      break
      ;;
    *)
      echo "Invalid input. Please try again."
      ;;
  esac
done
