#!/bin/bash

# Pergunta ao usuário se ele deseja criar um novo projeto ou usar um existente
read -p "Você deseja criar um novo projeto (n) ou usar um projeto existente (u)? " choice
echo ""

# Cria a estrutura de pastas e arquivos para o novo projeto
if [ "$choice" = "n" ]; then
    # Pede ao usuário o nome do projeto e cria uma pasta com esse nome
    read -p "Digite o nome do novo projeto: " project_name
    mkdir -p "$project_name"

    # Cria as pastas para o código-fonte e recursos
    mkdir -p "$project_name/src"
    mkdir -p "$project_name/assets"

    # Cria o arquivo HTML e o diretório para os scripts JavaScript
    touch "$project_name/index.html"
    mkdir -p "$project_name/src/js"
    touch "$project_name/src/js/main.js"

    # Cria um arquivo básico de estilo CSS
    touch "$project_name/assets/style.css"

    # Imprime uma mensagem de sucesso
    echo "Projeto criado com sucesso! Acesse a pasta '$project_name' para começar a trabalhar."
    exit 0
fi

# Usa um projeto existente
if [ "$choice" = "u" ]; then
    # Pede ao usuário o caminho para o projeto existente e verifica se ele existe
    read -p "Digite o caminho para o projeto existente: " project_path
    if [ ! -d "$project_path" ]; then
        echo "O diretório especificado não existe."
        exit 1
    fi

    # Imprime uma mensagem de sucesso
    echo "Projeto encontrado! Acesse a pasta '$project_path' para começar a trabalhar."
    exit 0
fi

# Se a opção escolhida não for "n" nem "u", mostra uma mensagem de erro
echo "Opção inválida."
exit 1
