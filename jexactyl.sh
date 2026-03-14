#!/bin/bash

# ===========================================
# Jexactyl Panel Auto Installer
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
echo '      _                 _   _   _               _ '
echo '     | |               | | | | | |             | |'
echo '     | | _____  ___ ___| |_| |_| | ___ __ _ ___| |_ _   _ _ __ '
echo ' _   | |/ _ \ \/ / __| __|  _  |/ _ \ _` / __| __| | | | '"'"'_ \ '
echo '| |__| |  __/>  <\__ \ |_| | | |  __/ (_| \__ \ |_| |_| | | | |'
echo ' \____/ \___/_/\_\___/\__\_| |_/\___\__,_|___/\__|\__,_|_| |_|'
echo '                                                              '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           🎮 Jexactyl Panel Auto Installer${NC}"
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
echo -e "${BLUE}[1/8] 🔍 Detecting system...${NC}"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VERSION=$VERSION_ID
    
    echo -e "${GREEN}[✓] OS: $OS $VERSION${NC}"
    
    # Check compatibility
    if [[ "$OS" == "ubuntu" ]]; then
        if [[ "$VERSION" == "20.04" || "$VERSION" == "22.04" || "$VERSION" == "24.04" ]]; then
            echo -e "${GREEN}[✓] Ubuntu $VERSION is supported${NC}"
        else
            echo -e "${YELLOW}[!] Ubuntu $VERSION may not be officially supported${NC}"
        fi
    elif [[ "$OS" == "debian" ]]; then
        if [[ "$VERSION" == "11" || "$VERSION" == "12" ]]; then
            echo -e "${GREEN}[✓] Debian $VERSION is supported${NC}"
        else
            echo -e "${YELLOW}[!] Debian $VERSION may not be officially supported${NC}"
        fi
    else
        echo -e "${YELLOW}[!] OS may not be officially supported${NC}"
    fi
fi
echo ""

# ===========================================
# Show Installation Options
# ===========================================
echo -e "${BLUE}[2/8] ⚙️  Installation options...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}Choose installation method:${NC}"
echo -e " ${GREEN}1)${NC} Community Installer (XezaDev) - Quick & Simple [Ubuntu 20.04] [citation:2]"
echo -e " ${GREEN}2)${NC} Official Manual Installation - Full control [All OS] [citation:8]"
echo -e " ${GREEN}3)${NC} linkea131 Installer - Feature-rich [Ubuntu/Debian/CentOS] [citation:6]"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p "Enter choice (1-3): " INSTALL_CHOICE
echo ""

case $INSTALL_CHOICE in
    1)
        # ===========================================
        # XezaDev Installer Method
        # ===========================================
        echo -e "${BLUE}[3/8] 🚀 Running XezaDev Jexactyl installer...${NC}"
        echo -e "${YELLOW}[!] Note: This installer is tested on Ubuntu 20.04 only${NC} [citation:2]\n"
        
        # Install curl if not present
        apt update -y
        apt install -y curl
        
        # Run installer
        bash <(curl -s https://raw.githubusercontent.com/XezaDev/Jexactyl/main/install.sh)
        
        if [ $? -eq 0 ]; then
            echo -e "\n${GREEN}[✓] XezaDev installer completed${NC}"
        else
            echo -e "\n${RED}[✘] Installer failed${NC}"
        fi
        ;;
        
    2)
        # ===========================================
        # Official Manual Installation
        # ===========================================
        echo -e "${BLUE}[3/8] 📦 Starting official Jexactyl installation...${NC}"
        echo -e "${YELLOW}[!] Following official Hetzner tutorial steps${NC} [citation:8]\n"
        
        # Step 1: Install prerequisites
        echo -e "${BLUE}[4/8] 🔧 Installing prerequisites...${NC}"
        
        # Ubuntu/Debian specific setup
        if [[ "$OS" == "ubuntu" ]]; then
            apt update && apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg
            LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
            
            if [[ "$VERSION" == "20.04" ]]; then
                curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
            fi
        elif [[ "$OS" == "debian" ]]; then
            apt update && apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg
            sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
            sudo wget -qO - https://packages.sury.org/php/apt.gpg -O /etc/apt/trusted.gpg.d/sury-php.gpg
        fi
        
        # Redis repository
        curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
        
        # Install packages
        apt update
        apt -y install php8.1 php8.1-{cli,gd,mysql,pdo,mbstring,tokenizer,bcmath,xml,fpm,curl,zip} mariadb-server nginx tar unzip git redis-server
        
        # Install Composer
        curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
        
        echo -e "${GREEN}[✓] Prerequisites installed${NC}\n"
        
        # Step 2: Download Jexactyl
        echo -e "${BLUE}[5/8] 📥 Downloading Jexactyl files...${NC}"
        mkdir -p /var/www/jexactyl
        cd /var/www/jexactyl
        
        # Get latest release
        curl -Lo panel.tar.gz https://github.com/jexactyl/jexactyl/releases/latest/download/panel.tar.gz
        tar -xzvf panel.tar.gz
        chmod -R 755 storage/* bootstrap/cache/
        echo -e "${GREEN}[✓] Jexactyl downloaded${NC}\n"
        
        # Step 3: Database setup
        echo -e "${BLUE}[6/8] 🗄️  Setting up database...${NC}"
        
        # Generate random password
        DB_PASSWORD=$(openssl rand -base64 16 | tr -d '=+/' | cut -c1-16)
        
        mysql <<EOF
CREATE USER IF NOT EXISTS 'jexactyl'@'127.0.0.1' IDENTIFIED BY '$DB_PASSWORD';
CREATE DATABASE IF NOT EXISTS panel;
GRANT ALL PRIVILEGES ON panel.* TO 'jexactyl'@'127.0.0.1' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
        
        echo -e "${GREEN}[✓] Database created${NC}"
        echo -e " ${WHITE}Database:${NC} panel"
        echo -e " ${WHITE}Username:${NC} jexactyl"
        echo -e " ${WHITE}Password:${NC} ${CYAN}$DB_PASSWORD${NC}\n"
        
        # Step 4: Environment setup
        echo -e "${BLUE}[7/8] ⚙️  Configuring environment...${NC}"
        cd /var/www/jexactyl
        cp .env.example .env
        
        # Install Composer dependencies
        composer install --no-dev --optimize-autoloader
        
        # Generate key
        php artisan key:generate --force
        
        # Configure database in .env
        sed -i "s/DB_DATABASE=.*/DB_DATABASE=panel/" .env
        sed -i "s/DB_USERNAME=.*/DB_USERNAME=jexactyl/" .env
        sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=$DB_PASSWORD/" .env
        
        # Get domain
        read -p "Enter your domain or IP (e.g., https://panel.example.com): " APP_URL
        sed -i "s|APP_URL=.*|APP_URL=$APP_URL|" .env
        
        # Run migrations
        php artisan migrate --seed --force
        
        echo -e "${GREEN}[✓] Environment configured${NC}\n"
        
        # Step 5: Create admin user
        echo -e "${BLUE}[8/8] 👤 Creating admin user...${NC}"
        php artisan p:user:make
        
        # Set permissions
        chown -R www-data:www-data /var/www/jexactyl/*
        echo -e "${GREEN}[✓] Admin user created${NC}\n"
        
        # Step 6: Setup queue worker
        echo -e "${BLUE}[+] Setting up queue worker...${NC}"
        
        cat > /etc/systemd/system/jexactyl.service << 'EOF'
[Unit]
Description=Jexactyl Queue Worker

[Service]
User=www-data
Group=www-data
Restart=always
ExecStart=/usr/bin/php /var/www/jexactyl/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3
StartLimitInterval=180
StartLimitBurst=30
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF
        
        systemctl enable jexactyl --now
        echo -e "${GREEN}[✓] Queue worker started${NC}\n"
        
        # Step 7: Nginx configuration
        echo -e "${BLUE}[+] Configuring Nginx...${NC}"
        
        # Install certbot
        apt install -y certbot python3-certbot-nginx
        
        # Remove default config
        rm -f /etc/nginx/sites-enabled/default
        
        # Create Nginx config
        cat > /etc/nginx/sites-available/jexactyl << EOF
server {
    listen 80;
    server_name _;
    
    root /var/www/jexactyl/public;
    index index.php index.html;
    
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }
    
    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
    
    location ~ /\.ht {
        deny all;
    }
}
EOF
        
        ln -sf /etc/nginx/sites-available/jexactyl /etc/nginx/sites-enabled/
        nginx -t && systemctl restart nginx
        echo -e "${GREEN}[✓] Nginx configured${NC}\n"
        ;;
        
    3)
        # ===========================================
        # linkea131 Installer Method
        # ===========================================
        echo -e "${BLUE}[3/8] 🚀 Running linkea131 Jexactyl installer...${NC}"
        echo -e "${YELLOW}[!] Feature-rich installer for Ubuntu/Debian/CentOS${NC} [citation:6]\n"
        
        # Install curl if not present
        apt update -y
        apt install -y curl
        
        # Run installer
        bash <(curl -s https://raw.githubusercontent.com/linkea131/jexactyl-installer/v1.11.3.3/install.sh)
        
        if [ $? -eq 0 ]; then
            echo -e "\n${GREEN}[✓] linkea131 installer completed${NC}"
        else
            echo -e "\n${RED}[✘] Installer failed${NC}"
        fi
        ;;
        
    *)
        echo -e "${RED}[✘] Invalid choice${NC}"
        exit 1
        ;;
esac

# ===========================================
# Final Message
# ===========================================
clear

# Final banner
echo -e "${CYAN}"
echo '      _                 _   _   _               _ '
echo '     | |               | | | | | |             | |'
echo '     | | _____  ___ ___| |_| |_| | ___ __ _ ___| |_ _   _ _ __ '
echo ' _   | |/ _ \ \/ / __| __|  _  |/ _ \ _` / __| __| | | | '"'"'_ \ '
echo '| |__| |  __/>  <\__ \ |_| | | |  __/ (_| \__ \ |_| |_| | | | |'
echo ' \____/ \___/_/\_\___/\__\_| |_/\___\__,_|___/\__|\__,_|_| |_|'
echo '                                                              '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ Jexactyl Installation Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Installation details
echo -e "${YELLOW}📌 INSTALLATION DETAILS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

case $INSTALL_CHOICE in
    1)
        echo -e " ${GREEN}•${NC} Installer: ${CYAN}XezaDev Community Installer${NC} [citation:2]"
        echo -e " ${GREEN}•${NC} Panel directory: ${CYAN}/var/www/jexactyl${NC}"
        ;;
    2)
        echo -e " ${GREEN}•${NC} Installer: ${CYAN}Official Manual Installation${NC} [citation:8]"
        echo -e " ${GREEN}•${NC} Panel directory: ${CYAN}/var/www/jexactyl${NC}"
        echo -e " ${GREEN}•${NC} Database: ${CYAN}panel${NC}"
        echo -e " ${GREEN}•${NC} DB User: ${CYAN}jexactyl${NC}"
        echo -e " ${GREEN}•${NC} DB Password: ${CYAN}$DB_PASSWORD${NC}"
        echo -e " ${GREEN}•${NC} Queue service: ${CYAN}systemctl status jexactyl${NC}"
        ;;
    3)
        echo -e " ${GREEN}•${NC} Installer: ${CYAN}linkea131 Feature-rich Installer${NC} [citation:6]"
        echo -e " ${GREEN}•${NC} Panel directory: ${CYAN}/var/www/jexactyl${NC}"
        ;;
esac
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Next steps
echo -e "${GREEN}📌 NEXT STEPS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " 1. Access Jexactyl at: ${CYAN}http://your-server-ip${NC}"
echo -e " 2. Login with admin credentials created during install"
echo -e " 3. Configure settings via admin dashboard"
echo -e " 4. Set up Wings daemon for server management [citation:6]"
echo -e " 5. Check documentation: ${CYAN}https://docs.jexactyl.com${NC} [citation:3]"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Features
echo -e "${GREEN}✨ JEXACTYL FEATURES:${NC} [citation:1][citation:5]"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${WHITE}•${NC} Built on Pterodactyl with enhanced features"
echo -e " ${WHITE}•${NC} Built-in billing system (Stripe & PayPal)"
echo -e " ${WHITE}•${NC} Advanced authentication methods"
echo -e " ${WHITE}•${NC} Clean, minimalistic UI"
echo -e " ${WHITE}•${NC} Server renewal system"
echo -e " ${WHITE}•${NC} Fully customizable via admin dashboard"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Useful commands
echo -e "${GREEN}📋 USEFUL COMMANDS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}→${NC} Check queue status: ${CYAN}systemctl status jexactyl${NC}"
echo -e " ${YELLOW}→${NC} View logs: ${CYAN}journalctl -u jexactyl -f${NC}"
echo -e " ${YELLOW}→${NC} Create new user: ${CYAN}cd /var/www/jexactyl && php artisan p:user:make${NC}"
echo -e " ${YELLOW}→${NC} List users: ${CYAN}php artisan p:user:list${NC}"
echo -e " ${YELLOW}→${NC} Nginx logs: ${CYAN}tail -f /var/log/nginx/error.log${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Final message
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           🚀 Jexactyl Panel is ready! 🚀${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           Well done! Your panel has been successfully installed.${NC}"
echo -e "${WHITE}           Send out the link and have people create servers!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
