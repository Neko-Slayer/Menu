#!/bin/bash

# ===========================================
# Cloudflare Simple Installer
# ===========================================
# Made by NekoSlayer_
# ===========================================

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Clear screen
clear

# Banner
echo -e "${CYAN}"
echo '   ______ _                 __ _           _       _   _               '
echo '  / ____| |               / _| |         | |     | | (_)              '
echo ' | |    | | ___  _   _ ___| |_| |_   _ ___| | __ _| |_ _  ___  _ __   '
echo ' | |    | |/ _ \| | | / __|  _| | | | / __| |/ _` | __| |/ _ \| '"'"'_ \  '
echo ' | |____| | (_) | |_| \__ \ | | | |_| \__ \ | (_| | |_| | (_) | | | | '
echo '  \_____|_|\___/ \__,_|___/_| |_|\__,_|___/_|\__,_|\__|_|\___/|_| |_| '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           🌩️  Cloudflare Simple Installer${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[✘] This script must be run as root!${NC}"
   echo -e "${YELLOW}Usage: sudo bash $0${NC}\n"
   exit 1
fi

# Step 1: Update system
echo -e "${BLUE}[1/5] 📦 Updating system packages...${NC}"
apt update -y
echo -e "${GREEN}[✓] System updated${NC}\n"

# Step 2: Create keyrings directory
echo -e "${BLUE}[2/5] 📁 Creating keyrings directory...${NC}"
sudo mkdir -p --mode=0755 /usr/share/keyrings
echo -e "${GREEN}[✓] Directory created${NC}\n"

# Step 3: Add Cloudflare GPG key
echo -e "${BLUE}[3/5] 🔑 Adding Cloudflare GPG key...${NC}"
curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg | sudo tee /usr/share/keyrings/cloudflare-public-v2.gpg >/dev/null
echo -e "${GREEN}[✓] GPG key added${NC}\n"

# Step 4: Add Cloudflare repository
echo -e "${BLUE}[4/5] 📝 Adding Cloudflare repository...${NC}"
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list
echo -e "${GREEN}[✓] Repository added${NC}\n"

# Step 5: Install cloudflared
echo -e "${BLUE}[5/5] ⬇️  Installing cloudflared...${NC}"
sudo apt-get update && sudo apt-get install cloudflared -y
echo -e "${GREEN}[✓] cloudflared installed successfully${NC}\n"

# Check installation
echo -e "${BLUE}[✓] Verifying installation...${NC}"
if command -v cloudflared &> /dev/null; then
    VERSION=$(cloudflared --version | head -n 1)
    echo -e "${GREEN}✅ $VERSION${NC}"
else
    echo -e "${RED}❌ Installation failed${NC}"
fi

echo ""

# Final message
clear

echo -e "${CYAN}"
echo '   ______ _                 __ _           _       _   _               '
echo '  / ____| |               / _| |         | |     | | (_)              '
echo ' | |    | | ___  _   _ ___| |_| |_   _ ___| | __ _| |_ _  ___  _ __   '
echo ' | |    | |/ _ \| | | / __|  _| | | | / __| |/ _` | __| |/ _ \| '"'"'_ \  '
echo ' | |____| | (_) | |_| \__ \ | | | |_| \__ \ | (_| | |_| | (_) | | | | '
echo '  \_____|_|\___/ \__,_|___/_| |_|\__,_|___/_|\__,_|\__|_|\___/|_| |_| '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ Cloudflare Installation Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Next steps
echo -e "${YELLOW}📌 NEXT STEPS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${WHITE}1.${NC} Login to Cloudflare: ${CYAN}cloudflared tunnel login${NC}"
echo -e " ${WHITE}2.${NC} Create tunnel: ${CYAN}cloudflared tunnel create <name>${NC}"
echo -e " ${WHITE}3.${NC} Route DNS: ${CYAN}cloudflared tunnel route dns <name> <domain>${NC}"
echo -e " ${WHITE}4.${NC} Create config: ${CYAN}nano ~/.cloudflared/config.yml${NC}"
echo -e " ${WHITE}5.${NC} Run tunnel: ${CYAN}cloudflared tunnel run <name>${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Useful commands
echo -e "${GREEN}📋 USEFUL COMMANDS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}→${NC} Check version: ${CYAN}cloudflared --version${NC}"
echo -e " ${YELLOW}→${NC} List tunnels: ${CYAN}cloudflared tunnel list${NC}"
echo -e " ${YELLOW}→${NC} Delete tunnel: ${CYAN}cloudflared tunnel delete <name>${NC}"
echo -e " ${YELLOW}→${NC} Help: ${CYAN}cloudflared --help${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Installation info
echo -e "${GREEN}📂 INSTALLATION INFO:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${WHITE}•${NC} Binary location: ${CYAN}$(which cloudflared)${NC}"
echo -e " ${WHITE}•${NC} Config directory: ${CYAN}/etc/cloudflared/${NC}"
echo -e " ${WHITE}•${NC} Repo file: ${CYAN}/etc/apt/sources.list.d/cloudflared.list${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Final message
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           🚀 cloudflared is ready to use! 🚀${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
