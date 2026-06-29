#!/bin/bash

# Verificar si el script se ejecuta como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como root (sudo ./post-install.sh)"
  exit 1
fi

echo "--- Iniciando configuración post-instalación de Sinergia ---"

# 1. Habilitar Chaotic-AUR (Repositorio avanzado)
# Nota: Esto es solo un ejemplo de cómo activar repos, asegúrate de tener las keys
echo "Configurando repositorios..."
pacman -S --noconfirm --needed pacman-contrib

# 2. Actualizar sistema
pacman -Syu --noconfirm

# 3. Instalación de herramientas faltantes con pacman
# (Quitamos el intento de usar 'yay' aquí si aún no hay usuario creado)
echo "Instalando herramientas base..."
pacman -S --noconfirm --needed stacer-bin ventoy-bin

# 4. Configuración de servicios
# Estos comandos son seguros incluso si el servicio ya está habilitado
echo "Configurando servicios..."
systemctl enable --now bluetooth.service
systemctl enable --now cups.service
systemctl enable --now ufw.service

# 5. Configurar UFW (Firewall)
ufw default deny incoming
ufw default allow outgoing
ufw enable

echo "--- Configuración finalizada con éxito ---"
echo "Ya puedes disfrutar de Sinergia."
