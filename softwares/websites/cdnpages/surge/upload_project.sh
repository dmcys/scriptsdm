#!/bin/bash

# Função para criar um novo projeto
function create_project() {
  read -p "Digite o nome do projeto: " project_name
  read -p "Digite a descrição do projeto: " project_description

  # Cria a estrutura básica de pastas do projeto
  mkdir -p $project_name/css
  mkdir -p $project_name/js

  # Cria arquivos básicos de HTML e CSS
  touch $project_name/index.html
  touch $project_name/css/style.css

  # Cria arquivo básico de JavaScript
  touch $project_name/js/script.js

  # Insere conteúdo nos arquivos criados
  echo "<!DOCTYPE html>" > $project_name/index.html
  echo "<html>" >> $project_name/index.html
  echo "  <head>" >> $project_name/index.html
  echo "    <meta charset='UTF-8'>" >> $project_name/index.html
  echo "    <title>$project_name</title>" >> $project_name/index.html
  echo "    <link rel='stylesheet' href='css/style.css'>" >> $project_name/index.html
  echo "  </head>" >> $project_name/index.html
  echo "  <body>" >> $project_name/index.html
  echo "    <h1>Bem-vindo ao $project_name</h1>" >> $project_name/index.html
  echo "    <script src='js/script.js'></script>" >> $project_name/index.html
  echo "  </body>" >> $project_name/index.html
  echo "</html>" >> $project_name/index.html

  echo "body {" > $project_name/css/style.css
  echo "  margin: 0;" >> $project_name/css/style.css
  echo "  padding: 0;" >> $project_name/css/style.css
  echo "}" >> $project_name/css/style.css

  echo "console.log('Olá, mundo!');" > $project_name/js/script.js

  echo "Projeto $project_name criado com sucesso!"
}

# Função para configurar o projeto no surge.sh e fazer o upload
function configure_project() {
  read -p "Digite o nome do projeto: " project_name
  read -p "Digite o caminho completo do diretório do projeto: " project_path
  read -p "Digite o nome do domínio que deseja atribuir ao projeto: " domain_name

  # Entra na pasta do projeto
  cd $project_path/$project_name

  # Instala o surge globalmente
  npm install -g surge

  # Configura o projeto no surge.sh e faz o upload
  surge --domain $domain_name
}

# Menu principal
echo "Selecione uma opção:"
echo "1. Criar um novo projeto"
echo "2. Configurar um projeto no surge.sh e fazer o upload"
read -p "Opção: " choice

case $choice in
  1)
    create_project
    ;;
  2)
    configure_project
    ;;
  *)
    echo "Opção inválida."
    ;;
esac
