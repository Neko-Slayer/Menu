#!/bin/bash

# ===========================================
# MythicalDash Auto Installer
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
echo '  __  __       _   _ _       _   _    _     _          _     _   _ '
echo ' |  \/  |     | | | (_)     | | | |  | |   | |        | |   | | | |'
echo ' | \  / |_   _| |_| |_  __ _| |_| |__| | __| | ___  __| | __| | | |'
echo ' | |\/| | | | | __| | |/ _` | __|  __  |/ _` |/ _ \/ _` |/ _` | | |'
echo ' | |  | | |_| | |_| | | (_| | |_| |  | | (_| |  __/ (_| | (_| | |_|'
echo ' |_|  |_|\__, |\__|_|_|\__,_|\__|_|  |_|\__,_|\___|\__,_|\__,_|_ _|'
echo '          __/ |                                                    '
echo '         |___/                                                     '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           🎮 MythicalDash Auto Installer${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}[✘] This script must be run as root!${NC}"
   echo -e "${YELLOW}Usage: sudo bash $0${NC}\n"
   exit 1
fi

# ===========================================
# System Detection
# ===========================================
echo -e "${BLUE}[1/5] 🔍 Detecting system...${NC}"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VERSION=$VERSION_ID
    
    echo -e "${GREEN}[✓] OS: $OS $VERSION${NC}"
    
    # Check compatibility - MythicalDash requires Ubuntu/Debian [citation:1]
    if [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "debian" ]]; then
        echo -e "${GREEN}[✓] Compatible OS detected${NC}"
    else
        echo -e "${YELLOW}[!] Warning: MythicalDash officially supports Ubuntu/Debian${NC}"
        echo -e "${YELLOW}    Installation may still work but not guaranteed${NC}"
    fi
else
    echo -e "${YELLOW}[!] Could not detect OS${NC}"
fi
echo ""

# ===========================================
# Install Dependencies
# ===========================================
echo -e "${BLUE}[2/5] 📦 Installing dependencies...${NC}"

# Update package list
apt update -y

# Install required packages
apt install -y curl wget git unzip tar

# Check if curl is installed
if command -v curl &> /dev/null; then
    echo -e "${GREEN}[✓] curl installed${NC}"
else
    echo -e "${RED}[✘] Failed to install curl${NC}"
    exit 1
fi
echo ""

# ===========================================
# Show Installation Options
# ===========================================
echo -e "${BLUE}[3/5] ⚙️  Installation options...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}MythicalDash installer supports these options:${NC} [citation:1]"
echo -e " ${GREEN}•${NC} --skip-os-check        : Skip OS compatibility check"
echo -e " ${GREEN}•${NC} --force-arm            : Force ARM architecture"
echo -e " ${GREEN}•${NC} --skip-install-check   : Skip existing installation check"
echo -e " ${GREEN}•${NC} --skip-virt-check      : Skip virtualization check"
echo -e " ${GREEN}•${NC} --skip-system-update   : Skip apt update/upgrade"
echo -e " ${GREEN}•${NC} --dev                  : Install dev release (unstable) [citation:4]"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Ask for installation type
echo -e "${YELLOW}Choose installation type:${NC}"
echo -e " ${GREEN}1)${NC} Standard installation (recommended)"
echo -e " ${GREEN}2)${NC} Skip OS check"
echo -e " ${GREEN}3)${NC} Force ARM architecture"
echo -e " ${GREEN}4)${NC} Skip system update"
echo -e " ${GREEN}5)${NC} Dev release (⚠️  unstable - for testing only) [citation:4]"
read -p "Enter choice (1-5): " INSTALL_CHOICE

# Build options string
OPTIONS=""
case $INSTALL_CHOICE in
    1)
        echo -e "${GREEN}[✓] Standard installation selected${NC}"
        OPTIONS=""
        ;;
    2)
        echo -e "${YELLOW}[!] Skip OS check selected${NC}"
        OPTIONS="--skip-os-check"
        ;;
    3)
        echo -e "${YELLOW}[!] Force ARM selected${NC}"
        OPTIONS="--force-arm"
        ;;
    4)
        echo -e "${YELLOW}[!] Skip system update selected${NC}"
        OPTIONS="--skip-system-update"
        ;;
    5)
        echo -e "${RED}[!] Dev release selected - UNSTABLE${NC}"
        OPTIONS="--dev"
        ;;
    *)
        echo -e "${RED}[✘] Invalid choice, using standard installation${NC}"
        OPTIONS=""
        ;;
esac
echo ""

# ===========================================
# Run MythicalDash Installer
# ===========================================
echo -e "${BLUE}[4/5] 🚀 Running MythicalDash installer...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}The official MythicalDash installer will now run.${NC}"
echo -e "${WHITE}Logs will be saved to: ${CYAN}/var/www/mythicaldash/install.log${NC} [citation:1]"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Create log directory
mkdir -p /var/www/mythicaldash

# Download and run installer
if [ -z "$OPTIONS" ]; then
    # No options
    curl -fsSL https://raw.githubusercontent.com/MythicalLTD/MythicalDash/refs/heads/v3-remastered/installer/install.sh | bash
else
    # With options
    curl -fsSL https://raw.githubusercontent.com/MythicalLTD/MythicalDash/refs/heads/v3-remastered/installer/install.sh | bash -s -- $OPTIONS
fi

# Check installation status
INSTALL_EXIT=$?
if [ $INSTALL_EXIT -eq 0 ]; then
    echo -e "\n${GREEN}[✓] MythicalDash installer completed successfully!${NC}"
else
    echo -e "\n${RED}[✘] MythicalDash installer failed with exit code: $INSTALL_EXIT${NC}"
    echo -e "${YELLOW}Check logs at: /var/www/mythicaldash/install.log${NC}"
    echo -e "${YELLOW}Need help? Join Discord: ${CYAN}https://discord.mythical.systems${NC} [citation:1]"
fi
echo ""

# ===========================================
# Show Installation Info
# ===========================================
echo -e "${BLUE}[5/5] 📊 Installation information...${NC}"

# Check if installation was successful by looking for common directories
if [ -d "/var/www/mythicaldash" ]; then
    echo -e "${GREEN}[✓] MythicalDash directory found at /var/www/mythicaldash${NC}"
    
    # Try to get version if possible
    if [ -f "/var/www/mythicaldash/version" ]; then
        VERSION=$(cat /var/www/mythicaldash/version 2>/dev/null)
        echo -e "${GREEN}[✓] Version: $VERSION${NC}"
    fi
else
    echo -e "${YELLOW}[!] MythicalDash directory not found. Installation may have failed.${NC}"
fi
echo ""

# ===========================================
# Final Message
# ===========================================
clear

# Final banner
echo -e "${CYAN}"
echo '  __  __       _   _ _       _   _    _     _          _     _   _ '
echo ' |  \/  |     | | | (_)     | | | |  | |   | |        | |   | | | |'
echo ' | \  / |_   _| |_| |_  __ _| |_| |__| | __| | ___  __| | __| | | |'
echo ' | |\/| | | | | __| | |/ _` | __|  __  |/ _` |/ _ \/ _` |/ _` | | |'
echo ' | |  | | |_| | |_| | | (_| | |_| |  | | (_| |  __/ (_| | (_| | |_|'
echo ' |_|  |_|\__, |\__|_|_|\__,_|\__|_|  |_|\__,_|\___|\__,_|\__,_|_ _|'
echo '          __/ |                                                    '
echo '         |___/                                                     '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ MythicalDash Installation Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Installation details
echo -e "${YELLOW}📌 INSTALLATION DETAILS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${GREEN}•${NC} Installation directory: ${CYAN}/var/www/mythicaldash${NC}"
echo -e " ${GREEN}•${NC} Log file: ${CYAN}/var/www/mythicaldash/install.log${NC}"
echo -e " ${GREEN}•${NC} Documentation: ${CYAN}https://docs.mythical.systems${NC} [citation:4]"
echo -e " ${GREEN}•${NC} Discord: ${CYAN}https://discord.mythical.systems${NC} [citation:1]"
echo -e " ${GREEN}•${NC} Website: ${CYAN}https://www.mythical.systems${NC} [citation:4]"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Next steps
echo -e "${GREEN}📌 NEXT STEPS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " 1. Access MythicalDash at: ${CYAN}http://your-server-ip${NC} (or configured domain)"
echo -e " 2. Follow the setup wizard to configure:"
echo -e "    • Admin account creation"
echo -e "    • Database connection"
echo -e "    • Pterodactyl panel integration [citation:3]"
echo -e " 3. Configure billing and payment gateways [citation:3]"
echo -e " 4. Set up client area and themes"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Useful commands
echo -e "${GREEN}📋 USEFUL COMMANDS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}→${NC} Check installation logs: ${CYAN}cat /var/www/mythicaldash/install.log${NC}"
echo -e " ${YELLOW}→${NC} View MythicalDash status: ${CYAN}systemctl status mythicaldash${NC} (if applicable)"
echo -e " ${YELLOW}→${NC} Restart service: ${CYAN}systemctl restart mythicaldash${NC} (if applicable)"
echo -e " ${YELLOW}→${NC} View logs: ${CYAN}journalctl -u mythicaldash -f${NC} (if applicable)"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Features
echo -e "${GREEN}✨ MYTHICALDASH FEATURES:${NC} [citation:4]"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${WHITE}•${NC} Pterodactyl client area"
echo -e " ${WHITE}•${NC} Billing & payment integration (Stripe, PayPal)"
echo -e " ${WHITE}•${NC} J4R (Join for Rewards) & L4R (Linkvertise)"
echo -e " ${WHITE}•${NC} Advanced ticket system"
echo -e " ${WHITE}•${NC} Firewall (AntiVPN, AntiAlting, AntiProxy)"
echo -e " ${WHITE}•${NC} 2FA Security"
echo -e " ${WHITE}•${NC} Multiple language support"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Warning for dev release
if [[ "$OPTIONS" == *"--dev"* ]]; then
    echo -e "${RED}⚠️  WARNING: You installed a DEV release${NC}"
    echo -e "${YELLOW}   Dev releases are unstable and NOT recommended for production!${NC} [citation:4]"
    echo -e "${YELLOW}   Use with caution and expect bugs.${NC}\n"
fi

# Final message
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           🚀 Congratulations! MythicalDash is ready! 🚀${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           Well done! You have successfully installed MythicalDash.${NC} [citation:2]"
echo -e "${WHITE}           Send out the link and have people create servers!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
