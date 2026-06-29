#!/bin/bash

# Verificar que sea root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como root (sudo ./instalar.sh)"
  exit
fi

echo "--- Iniciando instalación guiada de Sinergia ---"
echo "Por favor, sigue las instrucciones de ArchInstall para elegir tu disco."

# Ejecutamos archinstall utilizando tu config.json
archinstall --config config.json

echo "--- Instalación base finalizada ---"
echo "Ejecuta ./post-install.sh para terminar la configuración."
