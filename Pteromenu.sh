#!/bin/bash

######################################################################################
#                                                                                    #
#  🚀🐉 PTERODACTYL MENU - NEKOSLAYER 🐉🚀                                           #
#                                                                                    #
######################################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'

# Banner
clear
echo -e "${PURPLE}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  ██████╗ ████████╗███████╗██████╗  ██████╗ ██████╗  █████╗   ║"
echo "║  ██╔══██╗╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗  ║"
echo "║  ██████╔╝   ██║   █████╗  ██║  ██║██║  ██║██████╔╝███████║  ║"
echo "║  ██╔═══╝    ██║   ██╔══╝  ██║  ██║██║  ██║██╔══██╗██╔══██║  ║"
echo "║  ██║        ██║   ███████╗██████╔╝╚██████╔╝██║  ██║██║  ██║  ║"
echo "║  ╚═╝        ╚═╝   ╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝  ║"
echo "╠════════════════════════════════════════════════════════════════╣"
echo "║          🚀 PTERODACTYL MANAGEMENT MENU 🚀                     ║"
echo "║              Made with ❤️ by NekoSlayer                        ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Menu
echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}  SELECT AN OPTION:${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
echo -e "  ${GREEN}[1]${NC} 🚀 ${WHITE}Install Pterodactyl Panel${NC}"
echo -e "  ${GREEN}[2]${NC} 🕊️  ${WHITE}Install Pterodactyl Wings${NC}"
echo -e "  ${GREEN}[3]${NC} 🗑️  ${WHITE}Uninstall Pterodactyl${NC}"
echo -e "  ${GREEN}[0]${NC} ❌ ${WHITE}Exit${NC}"
echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -ne "${YELLOW}👉 Enter your choice [0-3]: ${NC}"
read choice

case $choice in
    1)
        echo -e "\n${GREEN}🚀 Installing Pterodactyl Panel...${NC}\n"
        sudo bash <(curl -sSL https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Ptero.sh)
        ;;
    2)
        echo -e "\n${GREEN}🕊️ Installing Pterodactyl Wings...${NC}\n"
        sudo bash <(curl -sSL https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Wing.sh)
        ;;
    3)
        echo -e "\n${RED}⚠️  WARNING: This will completely remove Pterodactyl!${NC}"
        echo -ne "${YELLOW}💀 Are you sure? (y/N): ${NC}"
        read confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            sudo bash <(curl -sSL https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Pterouni.sh)
        else
            echo -e "${GREEN}Cancelled.${NC}"
        fi
        ;;
    0)
        echo -e "\n${GREEN}👋 Goodbye!${NC}"
        exit 0
        ;;
    *)
        echo -e "\n${RED}❌ Invalid option! Run again.${NC}"
        exit 1
        ;;
esac
