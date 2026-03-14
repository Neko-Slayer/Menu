#!/bin/bash

# ===========================================
# NEKO ULTIMATE MENU
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

# Function to clear screen and show menu
show_menu() {
    clear
    
    # Bada NEKO Banner (ASCII Art)
    echo -e "${CYAN}"
    echo ' ███╗   ██╗███████╗██╗  ██╗ ██████╗ '
    echo ' ████╗  ██║██╔════╝██║ ██╔╝██╔═══██╗'
    echo ' ██╔██╗ ██║█████╗  █████╔╝ ██║   ██║'
    echo ' ██║╚██╗██║██╔══╝  ██╔═██╗ ██║   ██║'
    echo ' ██║ ╚████║███████╗██║  ██╗╚██████╔╝'
    echo ' ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ '
    echo -e "${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${WHITE}              🚀 NEKO ULTIMATE MENU 🚀${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}                Made by NekoSlayer_${NC}"
    echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
    
    # Menu Options
    echo -e "${GREEN}📌 AVAILABLE OPTIONS:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e " ${CYAN}[1]${NC} ${WHITE}Panels Menu${NC}       - Install Feather/Ptero/Paymenter/Mythical/Jexactyl"
    echo -e " ${CYAN}[2]${NC} ${WHITE}Tailscale${NC}         - Install & configure Tailscale VPN"
    echo -e " ${CYAN}[3]${NC} ${WHITE}Cloudflare${NC}        - Install Cloudflare Tunnel (cloudflared)"
    echo -e " ${CYAN}[4]${NC} ${WHITE}System Info${NC}       - Display detailed system information"
    echo -e " ${CYAN}[5]${NC} ${WHITE}SSH + SFTP Fixer${NC}  - Secure SSH & install SpireCloud MOTD"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e " ${RED}[0]${NC} ${WHITE}Exit${NC}              - Close menu"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Function to run Panels menu
run_panels() {
    echo -e "\n${BLUE}[+] Opening Panels Installation Menu...${NC}"
    sleep 1
    bash <(curl -fsSL https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Panels)
}

# Function to run Tailscale installer
run_tailscale() {
    echo -e "\n${BLUE}[+] Running Tailscale installer...${NC}"
    sleep 1
    bash <(curl -fsSL https://raw.githubusercontent.com/Neko-Slayer/Menu/main/tailscale.sh)
}

# Function to run Cloudflare installer
run_cloudflare() {
    echo -e "\n${BLUE}[+] Running Cloudflare installer...${NC}"
    sleep 1
    bash <(curl -fsSL https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Cloudflareinstaller.sh)
}

# Function to run System Info
run_info() {
    echo -e "\n${BLUE}[+] Fetching System Information...${NC}"
    sleep 1
    bash <(curl -fsSL https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Info.sh)
}

# Function to run SSH + SFTP Fixer
run_ssh_fixer() {
    echo -e "\n${BLUE}[+] Running SSH + SFTP Fixer...${NC}"
    sleep 1
    bash <(curl -fsSL https://raw.githubusercontent.com/Neko-Slayer/Sshfixer/main/Ssh.sh)
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[✘] This script must be run as root!${NC}"
   echo -e "${YELLOW}Usage: sudo bash $0${NC}\n"
   exit 1
fi

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo -e "${YELLOW}[!] curl not found. Installing...${NC}"
    apt update -y && apt install curl -y
fi

# Main loop
while true; do
    show_menu
    
    # Get user choice
    read -p "Enter your choice [0-5]: " choice
    
    case $choice in
        1)
            run_panels
            ;;
        2)
            run_tailscale
            ;;
        3)
            run_cloudflare
            ;;
        4)
            run_info
            ;;
        5)
            run_ssh_fixer
            ;;
        0)
            echo -e "\n${GREEN}👋 Goodbye! Thanks for using Neko Ultimate Menu!${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${RED}[✘] Invalid choice! Please enter 0-5${NC}"
            sleep 2
            ;;
    esac
    
    # After script runs, ask to continue or exit
    echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    read -p "Press Enter to return to main menu or 'q' to quit: " continue_choice
    if [[ "$continue_choice" == "q" ]]; then
        echo -e "\n${GREEN}👋 Goodbye! Thanks for using Neko Ultimate Menu!${NC}\n"
        exit 0
    fi
done
