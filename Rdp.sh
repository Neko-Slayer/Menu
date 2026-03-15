#!/bin/bash

# ===========================================
# Universal RDP Installer
# ===========================================
# Made by NekoSlayer_
# Supports: Ubuntu/Debian & Windows Server
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
echo '  ██████╗ ██████╗ ██████╗ '
echo '  ██╔══██╗██╔══██╗██╔══██╗'
echo '  ██████╔╝██████╔╝██║  ██║'
echo '  ██╔══██╗██╔═══╝ ██║  ██║'
echo '  ██║  ██║██║     ██████╔╝'
echo '  ╚═╝  ╚═╝╚═╝     ╚═════╝ '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           🖥️  Universal RDP Installer${NC}"
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
# OS Detection
# ===========================================
echo -e "${BLUE}[1/5] 🔍 Detecting operating system...${NC}"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VERSION=$VERSION_ID
        echo -e "${GREEN}[✓] Linux Detected: $PRETTY_NAME${NC}"
        
        if [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "debian" ]]; then
            echo -e "${GREEN}[✓] Compatible Linux distribution${NC}"
            OS_TYPE="linux"
        else
            echo -e "${YELLOW}[!] Non-Debian Linux detected (may still work)${NC}"
            OS_TYPE="linux-other"
        fi
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ -f /c/Windows/System32/cmd.exe ]]; then
    echo -e "${GREEN}[✓] Windows Detected${NC}"
    OS_TYPE="windows"
else
    echo -e "${RED}[✘] Unsupported operating system${NC}"
    exit 1
fi
echo ""

# ===========================================
# Installation Method Selection
# ===========================================
if [[ "$OS_TYPE" == "linux" ]]; then
    # ===========================================
    # Linux RDP Installation (Ubuntu/Debian)
    # ===========================================
    echo -e "${BLUE}[2/5] 📦 Installing Linux RDP (xrdp)...${NC}"
    
    # Update system
    apt update -y && apt upgrade -y
    
    # Install lightweight GUI (Xfce) [citation:5]
    echo -e "${YELLOW}[!] Installing Xfce desktop (lightweight)...${NC}"
    apt install -y xfce4 xfce4-goodies
    
    # Set Xfce as default session [citation:5]
    echo "xfce4-session" > ~/.xsession
    
    # Install xrdp [citation:5]
    echo -e "${YELLOW}[!] Installing xrdp...${NC}"
    apt install -y xrdp
    
    # Add user to ssl-cert group [citation:5]
    adduser xrdp ssl-cert
    
    # Configure xrdp to use Xfce
    echo "xfce4-session" > /etc/xrdp/startwm.sh
    chmod +x /etc/xrdp/startwm.sh
    
    # Restart xrdp [citation:5]
    systemctl restart xrdp
    systemctl enable xrdp
    
    # Configure firewall [citation:5]
    echo -e "${YELLOW}[!] Configuring firewall...${NC}"
    if command -v ufw &> /dev/null; then
        ufw allow 3389/tcp
        ufw reload
        echo -e "${GREEN}[✓] Firewall rule added for port 3389${NC}"
    fi
    
    echo -e "${GREEN}[✓] xrdp installed and configured${NC}\n"
    
elif [[ "$OS_TYPE" == "windows" ]]; then
    # ===========================================
    # Windows RDP Installation (PowerShell)
    # ===========================================
    echo -e "${BLUE}[2/5] 📦 Preparing Windows RDP installation...${NC}"
    
    # Create PowerShell script for Windows RDP setup
    cat > /tmp/enable-rdp.ps1 << 'EOF'
# Windows RDP Enabler Script
# Based on community scripts [citation:1][citation:2]

Write-Host "🔧 Windows RDP Configuration" -ForegroundColor Cyan

# Check if running as administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "❌ This script must be run as Administrator!" -ForegroundColor Red
    exit 1
}

# Enable RDP via registry [citation:2]
Write-Host "📝 Enabling RDP in registry..." -ForegroundColor Yellow
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

# Enable RDP via Windows command [citation:1]
Write-Host "🔓 Enabling RDP via Windows features..." -ForegroundColor Yellow
& 'C:\Windows\System32\cscript.exe' 'C:\Windows\System32\SCregEdit.wsf' /ar 0

# Configure firewall for RDP [citation:1][citation:2]
Write-Host "🛡️ Configuring firewall for RDP (port 3389)..." -ForegroundColor Yellow
New-NetFirewallRule -DisplayName "RDP" -Direction Inbound -LocalPort 3389 -Protocol TCP -Action Allow

# Set appropriate security layer
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 1

# Restart Terminal Services
Write-Host "🔄 Restarting Terminal Services..." -ForegroundColor Yellow
Restart-Service TermService -Force

Write-Host "✅ RDP has been successfully enabled!" -ForegroundColor Green
Write-Host "ℹ️ You can now connect via port 3389" -ForegroundColor Cyan
EOF
    
    echo -e "${GREEN}[✓] PowerShell script created${NC}\n"
    
    # Check if running in Windows environment
    if [[ -f /c/Windows/System32/cmd.exe ]] || [[ "$OSTYPE" == "msys" ]]; then
        echo -e "${BLUE}[3/5] 🚀 Running PowerShell script...${NC}"
        powershell.exe -ExecutionPolicy Bypass -File /tmp/enable-rdp.ps1
    else
        echo -e "${YELLOW}[!] Please run the PowerShell script manually on Windows:${NC}"
        echo -e "    ${CYAN}powershell -ExecutionPolicy Bypass -File enable-rdp.ps1${NC}"
    fi
fi

# ===========================================
# Additional Configuration (Linux only)
# ===========================================
if [[ "$OS_TYPE" == "linux" ]]; then
    echo -e "${BLUE}[3/5] 🔧 Additional configuration...${NC}"
    
    # Ask for custom port
    read -p "Change RDP port from default 3389? (y/n): " CHANGE_PORT
    if [[ "$CHANGE_PORT" == "y" ]]; then
        read -p "Enter new port number: " RDP_PORT
        if [[ "$RDP_PORT" =~ ^[0-9]+$ ]]; then
            # Configure xrdp to use custom port
            sed -i "s/port=3389/port=$RDP_PORT/" /etc/xrdp/xrdp.ini
            systemctl restart xrdp
            
            # Update firewall
            if command -v ufw &> /dev/null; then
                ufw allow $RDP_PORT/tcp
                ufw reload
            fi
            echo -e "${GREEN}[✓] RDP port changed to $RDP_PORT${NC}"
        fi
    fi
    
    # Ask for static IP configuration [citation:2]
    read -p "Configure static IP? (y/n): " STATIC_IP
    if [[ "$STATIC_IP" == "y" ]]; then
        # Get current IP info
        CURRENT_IP=$(hostname -I | awk '{print $1}')
        CURRENT_GATEWAY=$(ip route | grep default | awk '{print $3}')
        
        read -p "Enter static IP address [$CURRENT_IP]: " NEW_IP
        NEW_IP=${NEW_IP:-$CURRENT_IP}
        
        read -p "Enter gateway [$CURRENT_GATEWAY]: " GATEWAY
        GATEWAY=${GATEWAY:-$CURRENT_GATEWAY}
        
        read -p "Enter DNS (e.g., 8.8.8.8): " DNS
        DNS=${DNS:-"8.8.8.8"}
        
        # Get interface name
        INTERFACE=$(ip route | grep default | awk '{print $5}')
        
        # Configure static IP via netplan (Ubuntu) or interfaces (Debian)
        if [[ "$OS" == "ubuntu" ]] && [[ -d /etc/netplan ]]; then
            cat > /etc/netplan/01-netcfg.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      addresses:
        - $NEW_IP/24
      routes:
        - to: default
          via: $GATEWAY
      nameservers:
        addresses: [$DNS]
EOF
            netplan apply
        else
            echo -e "${YELLOW}[!] Static IP configuration not implemented for this OS${NC}"
        fi
        echo -e "${GREEN}[✓] Static IP configured${NC}"
    fi
fi

# ===========================================
# Create RDP User (Linux only)
# ===========================================
if [[ "$OS_TYPE" == "linux" ]]; then
    echo -e "${BLUE}[4/5] 👤 Creating RDP user...${NC}"
    read -p "Create a new user for RDP access? (y/n): " CREATE_USER
    
    if [[ "$CREATE_USER" == "y" ]]; then
        read -p "Enter username: " RDP_USER
        useradd -m -s /bin/bash $RDP_USER
        passwd $RDP_USER
        
        # Add user to necessary groups
        usermod -aG sudo $RDP_USER
        
        echo -e "${GREEN}[✓] User $RDP_USER created${NC}"
    fi
fi

# ===========================================
# Status Check
# ===========================================
echo -e "${BLUE}[5/5] 📊 Checking RDP status...${NC}"

if [[ "$OS_TYPE" == "linux" ]]; then
    systemctl status xrdp --no-pager | grep "Active:" | sed 's/^/ /'
    
    # Check if port is listening
    if command -v netstat &> /dev/null; then
        RDP_PORT=$(grep port /etc/xrdp/xrdp.ini | grep -v "port=" | head -1 | cut -d'=' -f2)
        RDP_PORT=${RDP_PORT:-3389}
        echo -e " ${WHITE}→${NC} RDP port ${CYAN}$RDP_PORT${NC} is $(netstat -tlnp | grep :$RDP_PORT > /dev/null && echo "${GREEN}listening${NC}" || echo "${RED}not listening${NC}")"
    fi
    
    # Check firewall
    if command -v ufw &> /dev/null; then
        echo -e " ${WHITE}→${NC} Firewall status: $(ufw status | grep Status | cut -d' ' -f2)"
    fi
elif [[ "$OS_TYPE" == "windows" ]]; then
    echo -e " ${YELLOW}→${NC} Check RDP status manually on Windows:"
    echo -e "   ${CYAN}Get-Service TermService${NC}"
fi
echo ""

# ===========================================
# Final Message
# ===========================================
clear

echo -e "${CYAN}"
echo '  ██████╗ ██████╗ ██████╗ '
echo '  ██╔══██╗██╔══██╗██╔══██╗'
echo '  ██████╔╝██████╔╝██║  ██║'
echo '  ██╔══██╗██╔═══╝ ██║  ██║'
echo '  ██║  ██║██║     ██████╔╝'
echo '  ╚═╝  ╚═╝╚═╝     ╚═════╝ '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ RDP Installation Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

if [[ "$OS_TYPE" == "linux" ]]; then
    # Connection info
    IP=$(hostname -I | awk '{print $1}')
    RDP_PORT=$(grep port /etc/xrdp/xrdp.ini | grep -v "port=" | head -1 | cut -d'=' -f2)
    RDP_PORT=${RDP_PORT:-3389}
    
    echo -e "${GREEN}📌 CONNECTION DETAILS:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e " ${WHITE}•${NC} Server IP    : ${CYAN}$IP${NC}"
    echo -e " ${WHITE}•${NC} Port         : ${CYAN}$RDP_PORT${NC}"
    echo -e " ${WHITE}•${NC} Desktop      : ${CYAN}Xfce${NC}"
    echo -e " ${WHITE}•${NC} Protocol     : ${CYAN}RDP (xrdp)${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${GREEN}📋 CONNECTION COMMAND:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e " ${YELLOW}→${NC} Windows: ${CYAN}mstsc /v:$IP:$RDP_PORT${NC}"
    echo -e " ${YELLOW}→${NC} Linux:   ${CYAN}xfreerdp /v:$IP:$RDP_PORT /u:username${NC}"
    echo -e " ${YELLOW}→${NC} macOS:   ${CYAN}Microsoft Remote Desktop app${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${GREEN}🔧 USEFUL COMMANDS:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e " ${YELLOW}→${NC} Restart xrdp: ${CYAN}systemctl restart xrdp${NC}"
    echo -e " ${YELLOW}→${NC} Check logs:   ${CYAN}tail -f /var/log/xrdp.log${NC}"
    echo -e " ${YELLOW}→${NC} Test config:  ${CYAN}xrdp-sesadmin -c${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
elif [[ "$OS_TYPE" == "windows" ]]; then
    echo -e "${GREEN}📌 WINDOWS RDP INFORMATION:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e " ${WHITE}•${NC} RDP has been enabled via PowerShell"
    echo -e " ${WHITE}•${NC} Default port: ${CYAN}3389${NC}"
    echo -e " ${WHITE}•${NC} Firewall rule added for RDP"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${GREEN}🔧 VERIFICATION COMMANDS:${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e " ${YELLOW}→${NC} Check service: ${CYAN}Get-Service TermService${NC}"
    echo -e " ${YELLOW}→${NC} Check port:    ${CYAN}netstat -an | findstr 3389${NC}"
    echo -e " ${YELLOW}→${NC} Check config:  ${CYAN}Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
fi

# Final message
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           🚀 RDP is ready to use! 🚀${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
