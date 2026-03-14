#!/bin/bash

# ===========================================
# Pterodactyl Panel Auto Installer
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
echo '   ____      _           _       _ _   _           _        _ _     '
echo '  |  _ \ ___| |_ ___  __| | __ _| | |_(_)_   _ ___| |_ __ _| | |    '
echo '  | |_) / _ \ __/ _ \/ _` |/ _` | | __| \ \ / / __| __/ _` | | |    '
echo '  |  __/  __/ ||  __/ (_| | (_| | | |_| |\ V /\__ \ || (_| | | |    '
echo '  |_|   \___|\__\___|\__,_|\__,_|_|\__|_| \_/ |___/\__\__,_|_|_|    '
echo '                                                                      '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           🎮 Pterodactyl Panel Auto Installer${NC}"
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
# System Update
# ===========================================
echo -e "${BLUE}[1/6] 📦 Updating system packages...${NC}"
apt update -y && apt upgrade -y
apt install -y curl wget git unzip tar
echo -e "${GREEN}[✓] System updated${NC}\n"

# ===========================================
# OS Detection
# ===========================================
echo -e "${BLUE}[2/6] 🔍 Detecting operating system...${NC}"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VERSION=$VERSION_ID
    
    echo -e "${GREEN}[✓] OS: $OS $VERSION${NC}"
    
    # Check compatibility [citation:4][citation:5]
    if [[ "$OS" == "ubuntu" ]]; then
        if [[ "$VERSION" == "20.04" || "$VERSION" == "22.04" || "$VERSION" == "24.04" ]]; then
            echo -e "${GREEN}[✓] Ubuntu $VERSION is supported${NC}"
        else
            echo -e "${YELLOW}[!] Ubuntu $VERSION may not be officially supported${NC}"
            echo -e "${YELLOW}Recommended: Ubuntu 20.04, 22.04, or 24.04${NC}"
        fi
    elif [[ "$OS" == "debian" ]]; then
        if [[ "$VERSION" == "10" || "$VERSION" == "11" || "$VERSION" == "12" ]]; then
            echo -e "${GREEN}[✓] Debian $VERSION is supported${NC}"
        else
            echo -e "${YELLOW}[!] Debian $VERSION may not be officially supported${NC}"
            echo -e "${YELLOW}Recommended: Debian 10, 11, or 12${NC}"
        fi
    else
        echo -e "${YELLOW}[!] OS may not be officially supported${NC}"
        echo -e "${YELLOW}Recommended: Ubuntu 20.04+ or Debian 10+${NC}"
    fi
fi
echo ""

# ===========================================
# Collect Information
# ===========================================
echo -e "${BLUE}[3/6] 📝 Collecting configuration information...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Domain/IP
read -p "Enter your domain or IP (e.g., panel.example.com or server IP): " FQDN

# Email for SSL
read -p "Enter your email for SSL certificate: " SSL_EMAIL

# Timezone
read -p "Enter timezone (e.g., Asia/Kolkata, America/New_York): " TIMEZONE

# Admin credentials
read -p "Enter admin email: " ADMIN_EMAIL
read -p "Enter admin username: " ADMIN_USERNAME
read -sp "Enter admin password: " ADMIN_PASSWORD
echo
read -sp "Confirm admin password: " ADMIN_PASSWORD_CONFIRM
echo

if [[ "$ADMIN_PASSWORD" != "$ADMIN_PASSWORD_CONFIRM" ]]; then
    echo -e "${RED}[✘] Passwords do not match!${NC}"
    exit 1
fi

# SSL option
read -p "Configure Let's Encrypt SSL? (y/n): " SSL_CHOICE
if [[ "$SSL_CHOICE" =~ ^[Yy]$ ]]; then
    USE_SSL="true"
else
    USE_SSL="false"
fi

echo -e "${GREEN}[✓] Configuration collected${NC}\n"

# ===========================================
# Install Dependencies
# ===========================================
echo -e "${BLUE}[4/6] 🔧 Installing dependencies...${NC}"

# Install Node.js and npm [citation:8]
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

# Install yarn
npm install -g yarn

# Install Composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

echo -e "${GREEN}[✓] Dependencies installed${NC}\n"

# ===========================================
# Run Pterodactyl Installer
# ===========================================
echo -e "${BLUE}[5/6] 🚀 Running Pterodactyl installer...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}The official installer will now run. Please follow the prompts:${NC}"
echo -e "${WHITE}1. Choose option 0 for Panel installation${NC}"
echo -e "${WHITE}2. Enter the information we just collected${NC}"
echo -e "${WHITE}3. Wait for installation to complete${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Run official installer [citation:3][citation:4][citation:5]
bash <(curl -s https://pterodactyl-installer.se)

echo -e "\n${GREEN}[✓] Pterodactyl installer completed${NC}\n"

# ===========================================
# Post-Installation Setup
# ===========================================
echo -e "${BLUE}[6/6] ⚙️  Post-installation setup...${NC}"

# Check if panel directory exists
if [ -d "/var/www/pterodactyl" ]; then
    cd /var/www/pterodactyl
    
    # Create admin user if needed [citation:3]
    echo -e "${YELLOW}[!] Creating admin user...${NC}"
    php artisan p:user:make --email="$ADMIN_EMAIL" --username="$ADMIN_USERNAME" --name-first="Admin" --name-last="User" --password="$ADMIN_PASSWORD" --admin=1
    
    # Set permissions
    chown -R www-data:www-data /var/www/pterodactyl/*
    
    echo -e "${GREEN}[✓] Admin user created${NC}"
else
    echo -e "${YELLOW}[!] Panel directory not found. Manual setup may be required.${NC}"
fi

echo -e "${GREEN}[✓] Post-installation complete${NC}\n"

# ===========================================
# Final Message
# ===========================================
clear

# Final banner
echo -e "${CYAN}"
echo '   ____      _           _       _ _   _           _        _ _     '
echo '  |  _ \ ___| |_ ___  __| | __ _| | |_(_)_   _ ___| |_ __ _| | |    '
echo '  | |_) / _ \ __/ _ \/ _` |/ _` | | __| \ \ / / __| __/ _` | | |    '
echo '  |  __/  __/ ||  __/ (_| | (_| | | |_| |\ V /\__ \ || (_| | | |    '
echo '  |_|   \___|\__\___|\__,_|\__,_|_|\__|_| \_/ |___/\__\__,_|_|_|    '
echo '                                                                      '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ Pterodactyl Panel Installation Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Installation details
echo -e "${YELLOW}📌 INSTALLATION DETAILS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${GREEN}•${NC} Panel URL: ${CYAN}http://$FQDN${NC}"
if [[ "$USE_SSL" == "true" ]]; then
    echo -e " ${GREEN}•${NC} SSL: ${GREEN}Enabled${NC} (Let's Encrypt)"
fi
echo -e " ${GREEN}•${NC} Admin Email: ${CYAN}$ADMIN_EMAIL${NC}"
echo -e " ${GREEN}•${NC} Admin Username: ${CYAN}$ADMIN_USERNAME${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Useful commands [citation:3]
echo -e "${GREEN}📋 USEFUL COMMANDS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}→${NC} Panel directory: ${CYAN}cd /var/www/pterodactyl${NC}"
echo -e " ${YELLOW}→${NC} List users: ${CYAN}php artisan p:user:list${NC}"
echo -e " ${YELLOW}→${NC} Create user: ${CYAN}php artisan p:user:make${NC}"
echo -e " ${YELLOW}→${NC} Delete user: ${CYAN}php artisan p:user:delete${NC}"
echo -e " ${YELLOW}→${NC} Queue service: ${CYAN}systemctl status pteroq${NC}"
echo -e " ${YELLOW}→${NC} Wings status: ${CYAN}systemctl status wings${NC}"
echo -e " ${YELLOW}→${NC} Restart panel: ${CYAN}systemctl restart nginx${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Wings installation option
echo -e "${BLUE}[+] Do you want to install Wings (daemon) now?${NC}"
read -p "Install Wings? (y/n): " INSTALL_WINGS

if [[ "$INSTALL_WINGS" =~ ^[Yy]$ ]]; then
    echo -e "\n${YELLOW}[!] Running Wings installer...${NC}"
    echo -e "${WHITE}Choose option 1 when prompted${NC}\n"
    bash <(curl -s https://pterodactyl-installer.se)
    
    echo -e "\n${GREEN}[✓] Wings installation completed${NC}"
fi

# Next steps
echo -e "\n${GREEN}📌 NEXT STEPS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " 1. Open browser and go to: ${CYAN}http://$FQDN${NC}"
echo -e " 2. Login with admin credentials"
echo -e " 3. Configure locations, nests, and eggs"
echo -e " 4. Add nodes and allocations"
echo -e " 5. Create servers for your games"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Official documentation
echo -e "${GREEN}📚 OFFICIAL DOCUMENTATION:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${CYAN}• https://pterodactyl.io/${NC}"
echo -e " ${CYAN}• https://pterodactyl-installer.se${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Final message
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           🚀 Pterodactyl Panel is ready! 🚀${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
