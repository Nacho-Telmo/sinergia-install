#!/bin/bash

# Aseguramos que el script se ejecute como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecútalo como root"
  exit
fi

echo "Iniciando la instalación de Sinergia..."

# Verificamos que el archivo JSON exista en la misma carpeta
if [ -f "./config.json" ]; then
    # Lanzamos archinstall apuntando al JSON
    archinstall --config ./config.json
else
    echo "Error: No se encuentra config.json en este directorio."
    exit 1
fi

echo "Instalación completada. Recuerda ejecutar el script de post-instalación."
