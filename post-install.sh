#!/bin/bash

# Verificar que el script se ejecute como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como root (usando sudo)."
  exit
fi

echo "--- Iniciando configuración de Post-Instalación de Sinergia ---"

# 1. Configurar Chaotic-AUR
echo "Añadiendo repositorio Chaotic-AUR..."
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' --noconfirm
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' --noconfirm

# Añadir configuración al pacman.conf
if ! grep -q "chaotic-aur" /etc/pacman.conf; then
    cat >> /etc/pacman.conf <<EOF

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
    echo "Repositorio Chaotic-AUR añadido."
fi

# 2. Instalar yay y ventoy desde Chaotic-AUR
echo "Actualizando base de datos e instalando yay..."
pacman -Syu --noconfirm
pacman -S --noconfirm yay ventoy-bin

# 3. Asegurar servicios y Firewall
echo "Asegurando servicios y Firewall..."
systemctl enable --now bluetooth
systemctl enable --now cups
systemctl enable --now ufw
ufw enable

# 4. Instalar herramientas adicionales con yay (como usuario normal)
# Nota: $SUDO_USER recupera el usuario que llamó al script
echo "Instalando stacer-bin y ventoy-bin con yay..."
if [ -n "$SUDO_USER" ]; then
    sudo -u "$SUDO_USER" yay -S --noconfirm stacer-bin
else
    echo "Error: No se pudo detectar el usuario para ejecutar yay."
fi

echo "--- ¡Configuración de Sinergia finalizada con éxito! ---"
echo "Ya puedes usar 'yay' para instalar paquetes del AUR."
