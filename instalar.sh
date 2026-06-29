#!/bin/bash

# Verificar si el archivo de configuración existe
if [ ! -f "config.json" ]; then
    echo "Error: config.json no encontrado."
    exit 1
fi

echo "--- Iniciando Sinergia: Instalación automatizada ---"

# Ejecutar archinstall usando tu configuración
# La bandera --config le indica que use tu JSON
archinstall --config config.json

echo "--- Instalación base terminada ---"
echo "Ejecutando configuración post-instalación..."

# Aquí puedes llamar a tu script de post-instalación
if [ -f "post-install.sh" ]; then
    chmod +x post-install.sh
    ./post-install.sh
fi

echo "--- Sinergia instalado correctamente ---"
