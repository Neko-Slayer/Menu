#!/bin/bash

# ===========================================
# FeatherPanel Auto Installer
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
echo '  ______     _   _               ____            _       '
echo ' |  ____|   | | | |             |  _ \          | |      '
echo ' | |__   ___| |_| |__   ___ _ __| |_) | __ _ ___| | __   '
echo ' |  __| / _ \ __| '"'"_ \ / _ \ '"'"__|  _ < / _` / __| |/ /   '
echo ' | |___|  __/ |_| | | |  __/ |  | |_) | (_| \__ \   <    '
echo ' |______\___|\__|_| |_|\___|_|  |____/ \__,_|___/_|\_\   '
echo '                                                          '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           🪶 FeatherPanel Auto Installer${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[✘] This script must be run as root!${NC}"
   echo -e "${YELLOW}Usage: sudo bash $0${NC}\n"
   exit 1
fi

# Step 1: Show info
echo -e "${BLUE}[1/3] 📦 Preparing FeatherPanel installation...${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}→${NC} Repository: ${CYAN}MythicalLTD/FeatherPanel${NC}"
echo -e " ${YELLOW}→${NC} Installer: ${CYAN}https://get.featherpanel.com/installer.sh${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Step 2: Install curl if not present
echo -e "${BLUE}[2/3] 🔧 Checking dependencies...${NC}"
if ! command -v curl &> /dev/null; then
    echo -e "${YELLOW}[!] curl not found. Installing curl...${NC}"
    apt update -y && apt install curl -y
    echo -e "${GREEN}[✓] curl installed${NC}"
else
    echo -e "${GREEN}[✓] curl is already installed${NC}"
fi
echo ""

# Step 3: Run FeatherPanel installer
echo -e "${BLUE}[3/3] 🚀 Running FeatherPanel installer...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}The official FeatherPanel installer will now run.${NC}"
echo -e "${WHITE}Please follow the prompts to complete installation.${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Run the exact command you provided
curl -sSL https://get.featherpanel.com/installer.sh | bash

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}[✓] FeatherPanel installer completed successfully!${NC}"
else
    echo -e "\n${RED}[✘] FeatherPanel installer encountered an error!${NC}"
    echo -e "${YELLOW}Please check the output above for details.${NC}"
fi
echo ""

# ===========================================
# Final Message
# ===========================================
clear

# Final banner
echo -e "${CYAN}"
echo '  ______     _   _               ____            _       '
echo ' |  ____|   | | | |             |  _ \          | |      '
echo ' | |__   ___| |_| |__   ___ _ __| |_) | __ _ ___| | __   '
echo ' |  __| / _ \ __| '"'"_ \ / _ \ '"'"__|  _ < / _` / __| |/ /   '
echo ' | |___|  __/ |_| | | |  __/ |  | |_) | (_| \__ \   <    '
echo ' |______\___|\__|_| |_|\___|_|  |____/ \__,_|___/_|\_\   '
echo '                                                          '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ FeatherPanel Installation Process Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Next steps
echo -e "${YELLOW}📌 NEXT STEPS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " 1. Follow the installer prompts if any"
echo -e " 2. After installation, access FeatherPanel at:"
echo -e "    ${CYAN}http://your-server-ip:8080${NC} (or configured port)"
echo -e " 3. Check FeatherPanel documentation for more info:"
echo -e "    ${CYAN}https://github.com/MythicalLTD/FeatherPanel${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Useful commands
echo -e "${GREEN}📋 USEFUL COMMANDS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}→${NC} Check FeatherPanel status: ${CYAN}systemctl status featherpanel${NC} (if applicable)"
echo -e " ${YELLOW}→${NC} View logs: ${CYAN}journalctl -u featherpanel -f${NC} (if applicable)"
echo -e " ${YELLOW}→${NC} Restart FeatherPanel: ${CYAN}systemctl restart featherpanel${NC} (if applicable)"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Final message
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           🚀 FeatherPanel installation triggered! 🚀${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
