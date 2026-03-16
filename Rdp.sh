#!/bin/bash

# RDP Installer Script
# Ye script XFCE desktop aur xRDP install karega

echo "=================================="
echo "RDP Installer Script Started"
echo "=================================="

# System update aur upgrade
echo "[1/5] System update aur upgrade ho raha hai..."
sudo apt update && sudo apt upgrade -y

# XFCE aur xRDP install
echo "[2/5] XFCE desktop aur xRDP install ho raha hai..."
sudo apt install xfce4 xfce4-goodies xrdp -y

# Xsession configure
echo "[3/5] Xsession configure ho raha hai..."
echo "startxfce4" > ~/.xsession
sudo chown $(whoami):$(whoami) ~/.xsession

# xRDP service enable aur restart
echo "[4/5] xRDP service start ho rahi hai..."
sudo systemctl enable xrdp
sudo systemctl restart xrdp

# Firefox browser install
echo "[5/5] Firefox browser install ho raha hai..."
sudo apt install firefox-esr -y

echo "=================================="
echo "RDP Installer Script Completed!"
echo "=================================="
echo "Aap ab Remote Desktop se connect kar sakte hain"
echo "IP Address: $(hostname -I | awk '{print $1}')"
echo "Port: 3389"
echo "=================================="
