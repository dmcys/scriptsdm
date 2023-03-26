read -p "Enter the path to the project directory: " project_path

if [ ! -d "$project_path" ]; then
  echo "Project directory does not exist."
  sleep 2
  upload_project
else
  cd "$project_path"
  surge --project .
fi
