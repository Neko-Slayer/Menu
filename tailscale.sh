#!/bin/bash

# ===========================================
# Tailscale Auto Installer & Setup
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
echo '  _____     _ _           _               '
echo ' |_   _|   | | |         | |              '
echo '   | | __ _| | | ___  ___| | __ _ _ __    '
echo '   | |/ _` | | |/ _ \/ __| |/ _` | '"'"'_ \   '
echo '   | | (_| | | |  __/\__ \ | (_| | | | |  '
echo '   \_/\__,_|_|_|\___||___/_|\__,_|_| |_|  '
echo '                                           '
echo '  ⚡ Simple, secure, zero-config VPN       '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           🔗 Tailscale Installer & Auto Connect${NC}"
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
echo -e "${BLUE}[1/6] 🔍 Detecting system...${NC}"

if [ -f /etc/debian_version ]; then
    echo -e "${GREEN}[✓] Debian/Ubuntu detected${NC}"
    DISTRO="debian"
elif [ -f /etc/redhat-release ]; then
    echo -e "${GREEN}[✓] RHEL/CentOS detected${NC}"
    DISTRO="rhel"
elif [ -f /etc/arch-release ]; then
    echo -e "${GREEN}[✓] Arch Linux detected${NC}"
    DISTRO="arch"
elif [ -f /etc/alpine-release ]; then
    echo -e "${GREEN}[✓] Alpine Linux detected${NC}"
    DISTRO="alpine"
else
    echo -e "${YELLOW}[!] Unknown distribution, trying generic install${NC}"
    DISTRO="unknown"
fi
echo ""

# ===========================================
# Install Tailscale
# ===========================================
echo -e "${BLUE}[2/6] ⬇️  Installing Tailscale...${NC}"

if command -v tailscale &> /dev/null; then
    echo -e "${GREEN}[✓] Tailscale already installed: $(tailscale version | head -n 1)${NC}"
else
    case $DISTRO in
        debian)
            curl -fsSL https://tailscale.com/install.sh | sh
            ;;
        rhel)
            curl -fsSL https://tailscale.com/install.sh | sh
            ;;
        arch)
            pacman -Sy --noconfirm tailscale
            ;;
        alpine)
            apk add tailscale
            ;;
        *)
            curl -fsSL https://tailscale.com/install.sh | sh
            ;;
    esac
    
    if command -v tailscale &> /dev/null; then
        echo -e "${GREEN}[✓] Tailscale installed: $(tailscale version | head -n 1)${NC}"
    else
        echo -e "${RED}[✘] Failed to install Tailscale${NC}"
        exit 1
    fi
fi
echo ""

# ===========================================
# Enable IP Forwarding
# ===========================================
echo -e "${BLUE}[3/6] 🔧 Enabling IP forwarding...${NC}"

# Enable IPv4 forwarding
echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
# Enable IPv6 forwarding
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.conf

# Apply changes
sysctl -p /etc/sysctl.conf

echo -e "${GREEN}[✓] IP forwarding enabled${NC}\n"

# ===========================================
# Start Tailscale Service
# ===========================================
echo -e "${BLUE}[4/6] ▶️  Starting Tailscale service...${NC}"

# Enable and start service
systemctl enable tailscaled
systemctl start tailscaled

# Check status
sleep 2
if systemctl is-active --quiet tailscaled; then
    echo -e "${GREEN}[✓] Tailscale service is running${NC}"
else
    echo -e "${RED}[✘] Tailscale service failed to start${NC}"
    exit 1
fi
echo ""

# ===========================================
# Tailscale Up (Authentication)
# ===========================================
echo -e "${BLUE}[5/6] 🔑 Setting up Tailscale authentication...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}Choose authentication method:${NC}"
echo -e " ${GREEN}1)${NC} Interactive login (browser)"
echo -e " ${GREEN}2)${NC} Auth key (for automation)"
echo -e " ${GREEN}3)${NC} Exit without connecting"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p "Enter choice (1-3): " AUTH_CHOICE

case $AUTH_CHOICE in
    1)
        echo -e "\n${BLUE}[+] Starting interactive login...${NC}"
        echo -e "${YELLOW}👉 A URL will open. Please login with your Google/Microsoft/GitHub account.${NC}\n"
        
        # Run tailscale up
        tailscale up
        
        # Check connection status
        sleep 3
        if tailscale status &> /dev/null; then
            echo -e "\n${GREEN}[✓] Successfully connected to Tailscale!${NC}"
        else
            echo -e "\n${RED}[✘] Failed to connect. Please check the login process.${NC}"
        fi
        ;;
    2)
        echo -e "\n${BLUE}[+] Auth key method selected${NC}"
        read -p "Enter your Tailscale auth key: " AUTH_KEY
        
        # Run tailscale up with auth key
        tailscale up --authkey=$AUTH_KEY
        
        if [ $? -eq 0 ]; then
            echo -e "\n${GREEN}[✓] Successfully connected with auth key!${NC}"
        else
            echo -e "\n${RED}[✘] Failed to connect with provided auth key${NC}"
        fi
        ;;
    3)
        echo -e "\n${YELLOW}[!] Skipping Tailscale connection${NC}"
        echo -e "You can connect later with: ${CYAN}tailscale up${NC}"
        ;;
    *)
        echo -e "\n${RED}[✘] Invalid choice. Skipping connection.${NC}"
        ;;
esac
echo ""

# ===========================================
# Show Status
# ===========================================
echo -e "${BLUE}[6/6] 📊 Checking Tailscale status...${NC}"

if tailscale status &> /dev/null; then
    echo -e "${GREEN}✓ Tailscale is connected${NC}\n"
    
    # Get Tailscale IP
    TS_IP=$(tailscale ip -4)
    echo -e "${WHITE}Your Tailscale IP:${NC} ${CYAN}$TS_IP${NC}"
    
    # Show status
    echo -e "\n${WHITE}Connected peers:${NC}"
    tailscale status | grep -v "tailscale0" | tail -n +2 | head -n 5
else
    echo -e "${YELLOW}⚠ Tailscale is installed but not connected${NC}"
    echo -e "Run: ${CYAN}tailscale up${NC} to connect"
fi
echo ""

# ===========================================
# Final Message
# ===========================================
clear

# Final banner
echo -e "${CYAN}"
echo '  _____     _ _           _               '
echo ' |_   _|   | | |         | |              '
echo '   | | __ _| | | ___  ___| | __ _ _ __    '
echo '   | |/ _` | | |/ _ \/ __| |/ _` | '"'"'_ \   '
echo '   | | (_| | | |  __/\__ \ | (_| | | | |  '
echo '   \_/\__,_|_|_|\___||___/_|\__,_|_| |_|  '
echo '                                           '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ Tailscale Installation Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Installation summary
echo -e "${YELLOW}📌 INSTALLATION SUMMARY:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${GREEN}✓${NC} Tailscale installed"
echo -e " ${GREEN}✓${NC} IP forwarding enabled"
echo -e " ${GREEN}✓${NC} Service started & enabled"

if tailscale status &> /dev/null; then
    echo -e " ${GREEN}✓${NC} Connected to Tailscale"
    echo -e " ${GREEN}✓${NC} IP: $(tailscale ip -4)"
else
    echo -e " ${YELLOW}⚠${NC} Not connected (run 'tailscale up')"
fi
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Useful commands
echo -e "${GREEN}📋 USEFUL COMMANDS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}→${NC} Check status: ${CYAN}tailscale status${NC}"
echo -e " ${YELLOW}→${NC} Your IP: ${CYAN}tailscale ip${NC}"
echo -e " ${YELLOW}→${NC} Connect: ${CYAN}tailscale up${NC}"
echo -e " ${YELLOW}→${NC} Disconnect: ${CYAN}tailscale down${NC}"
echo -e " ${YELLOW}→${NC} Web UI: ${CYAN}http://100.100.100.100:8088${NC}"
echo -e " ${YELLOW}→${NC} Logs: ${CYAN}journalctl -u tailscaled -f${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Network info
echo -e "${GREEN}🌐 NETWORK INFO:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${WHITE}•${NC} Local IP: ${CYAN}$(hostname -I | awk '{print $1}')${NC}"
if tailscale status &> /dev/null; then
    echo -e " ${WHITE}•${NC} Tailscale IP: ${CYAN}$(tailscale ip -4)${NC}"
    echo -e " ${WHITE}•${NC} Tailscale IPv6: ${CYAN}$(tailscale ip -6)${NC}"
fi
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Service management
echo -e "${GREEN}⚙️  SERVICE MANAGEMENT:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${WHITE}•${NC} Restart: ${CYAN}systemctl restart tailscaled${NC}"
echo -e " ${WHITE}•${NC} Stop: ${CYAN}systemctl stop tailscaled${NC}"
echo -e " ${WHITE}•${NC} Start: ${CYAN}systemctl start tailscaled${NC}"
echo -e " ${WHITE}•${NC} Status: ${CYAN}systemctl status tailscaled${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Final message
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           🚀 Tailscale is ready to use! 🚀${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
if ! tailscale status &> /dev/null; then
    echo -e "${YELLOW}👉 Run '${NC}${CYAN}tailscale up${NC}${YELLOW}' to connect to your network${NC}"
fi
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
