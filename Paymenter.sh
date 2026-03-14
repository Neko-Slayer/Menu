#!/bin/bash

# ===========================================
# Paymenter Fixed Installer
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
echo '   ____                       _              '
echo '  |  _ \ ___ _ __ ___   ___  (_)___  ___ _ __ '
echo '  | |_) / _ \ '"'"_ ` _ \ / _ \ | / __|/ _ \ '"'"_ \ '
echo '  |  __/  __/ | | | | |  __/ | \__ \  __/ | | |'
echo '  |_|   \___|_| |_| |_|\___| |_|___/\___|_| |_|'
echo '                                              '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}           💰 Paymenter Fixed Installer${NC}"
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
echo -e "${BLUE}[1/10] 🔍 Detecting system...${NC}"

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
        echo -e "${RED}[✘] Paymenter requires Ubuntu/Debian${NC}"
        exit 1
    fi
fi
echo ""

# ===========================================
# Update System
# ===========================================
echo -e "${BLUE}[2/10] 📦 Updating system packages...${NC}"
apt update -y && apt upgrade -y
apt install -y curl wget git unzip tar software-properties-common
echo -e "${GREEN}[✓] System updated${NC}\n"

# ===========================================
# Install PHP 8.2
# ===========================================
echo -e "${BLUE}[3/10] 🐘 Installing PHP 8.2...${NC}"

# Add PHP repository
add-apt-repository -y ppa:ondrej/php
apt update -y

# Install PHP and extensions
apt install -y php8.2 php8.2-cli php8.2-common php8.2-mysql php8.2-zip php8.2-gd php8.2-mbstring php8.2-curl php8.2-xml php8.2-bcmath php8.2-fpm

echo -e "${GREEN}[✓] PHP 8.2 installed${NC}\n"

# ===========================================
# Install Composer
# ===========================================
echo -e "${BLUE}[4/10] 📦 Installing Composer...${NC}"

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

echo -e "${GREEN}[✓] Composer installed: $(composer --version | head -n 1)${NC}\n"

# ===========================================
# Install MySQL/MariaDB
# ===========================================
echo -e "${BLUE}[5/10] 🗄️  Installing MariaDB...${NC}"

apt install -y mariadb-server mariadb-client

# Start MySQL
systemctl start mariadb
systemctl enable mariadb

echo -e "${GREEN}[✓] MariaDB installed${NC}\n"

# ===========================================
# Create Database
# ===========================================
echo -e "${BLUE}[6/10] 🔧 Configuring database...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Generate random password
DB_PASSWORD=$(openssl rand -base64 16 | tr -d '=+/' | cut -c1-16)

# Secure MariaDB installation
mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
CREATE DATABASE IF NOT EXISTS paymenter;
CREATE USER IF NOT EXISTS 'paymenter'@'localhost' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON paymenter.* TO 'paymenter'@'localhost';
FLUSH PRIVILEGES;
EOF

echo -e "${GREEN}[✓] Database created${NC}"
echo -e " ${WHITE}Database:${NC} paymenter"
echo -e " ${WHITE}Username:${NC} paymenter"
echo -e " ${WHITE}Password:${NC} ${CYAN}$DB_PASSWORD${NC}"
echo -e " ${WHITE}Root Password:${NC} ${CYAN}$DB_PASSWORD${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Save credentials to file
cat > /root/paymenter_credentials.txt << EOF
PAYMENTER DATABASE CREDENTIALS
===============================
Database: paymenter
Username: paymenter
Password: $DB_PASSWORD
Root Password: $DB_PASSWORD
Installation Date: $(date)
===============================
EOF

chmod 600 /root/paymenter_credentials.txt

# ===========================================
# Install Nginx
# ===========================================
echo -e "${BLUE}[7/10] 🌐 Installing Nginx...${NC}"
apt install -y nginx
systemctl start nginx
systemctl enable nginx
echo -e "${GREEN}[✓] Nginx installed${NC}\n"

# ===========================================
# Download Paymenter
# ===========================================
echo -e "${BLUE}[8/10] 📥 Downloading Paymenter...${NC}"

# Create web directory
mkdir -p /var/www/paymenter
cd /var/www

# Clone from official repository
git clone https://github.com/paymenter/paymenter.git paymenter
cd paymenter

# Install dependencies
composer install --no-dev --optimize-autoloader

# Copy environment file
cp .env.example .env

# Generate key
php artisan key:generate

echo -e "${GREEN}[✓] Paymenter downloaded${NC}\n"

# ===========================================
# Configure Paymenter
# ===========================================
echo -e "${BLUE}[9/10] ⚙️  Configuring Paymenter...${NC}"

# Get domain
read -p "Enter your domain or IP (e.g., https://paymenter.example.com or http://server-ip): " APP_URL

# Configure database in .env
sed -i "s/DB_CONNECTION=.*/DB_CONNECTION=mysql/" .env
sed -i "s/# DB_HOST=.*/DB_HOST=127.0.0.1/" .env
sed -i "s/# DB_PORT=.*/DB_PORT=3306/" .env
sed -i "s/DB_DATABASE=.*/DB_DATABASE=paymenter/" .env
sed -i "s/DB_USERNAME=.*/DB_USERNAME=paymenter/" .env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=$DB_PASSWORD/" .env
sed -i "s|APP_URL=.*|APP_URL=$APP_URL|" .env

# Run migrations
php artisan migrate --force

# Create storage link
php artisan storage:link

# Set permissions
chown -R www-data:www-data /var/www/paymenter
chmod -R 755 /var/www/paymenter/storage
chmod -R 755 /var/www/paymenter/bootstrap/cache

echo -e "${GREEN}[✓] Paymenter configured${NC}\n"

# ===========================================
# Configure Nginx
# ===========================================
echo -e "${BLUE}[10/10] 🔧 Configuring Nginx...${NC}"

# Create Nginx config
cat > /etc/nginx/sites-available/paymenter << EOF
server {
    listen 80;
    listen [::]:80;
    
    server_name _;
    
    root /var/www/paymenter/public;
    index index.php index.html;
    
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";
    
    charset utf-8;
    
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }
    
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }
    
    error_page 404 /index.php;
    
    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;
    }
    
    location ~ /\.(?!well-known).* {
        deny all;
    }
}
EOF

# Enable site
ln -sf /etc/nginx/sites-available/paymenter /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test and reload
nginx -t
systemctl restart nginx

echo -e "${GREEN}[✓] Nginx configured${NC}\n"

# ===========================================
# Create Admin User
# ===========================================
echo -e "${BLUE}[+] Creating admin user...${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

cd /var/www/paymenter

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

# Create user via artisan
php artisan user:create --admin \
    --email="$ADMIN_EMAIL" \
    --username="$ADMIN_USERNAME" \
    --password="$ADMIN_PASSWORD"

echo -e "${GREEN}[✓] Admin user created${NC}\n"

# ===========================================
# Set up Queue Worker
# ===========================================
echo -e "${BLUE}[+] Setting up queue worker...${NC}"

# Create systemd service
cat > /etc/systemd/system/paymenter-queue.service << EOF
[Unit]
Description=Paymenter Queue Worker
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/var/www/paymenter
ExecStart=/usr/bin/php /var/www/paymenter/artisan queue:work --sleep=3 --tries=3 --max-time=3600
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# Create scheduler service
cat > /etc/systemd/system/paymenter-scheduler.service << EOF
[Unit]
Description=Paymenter Scheduler

[Service]
User=www-data
Group=wwww-data
WorkingDirectory=/var/www/paymenter
ExecStart=/usr/bin/php /var/www/paymenter/artisan schedule:work
Restart=always
RestartSec=3
EOF

# Start services
systemctl daemon-reload
systemctl enable paymenter-queue paymenter-scheduler
systemctl start paymenter-queue paymenter-scheduler

echo -e "${GREEN}[✓] Queue workers started${NC}\n"

# ===========================================
# Initialize Paymenter
# ===========================================
echo -e "${BLUE}[+] Running Paymenter initialization...${NC}"
cd /var/www/paymenter
php artisan app:init
echo -e "${GREEN}[✓] Paymenter initialized${NC}\n"

# ===========================================
# Final Message
# ===========================================
clear

# Final banner
echo -e "${CYAN}"
echo '   ____                       _              '
echo '  |  _ \ ___ _ __ ___   ___  (_)___  ___ _ __ '
echo '  | |_) / _ \ '"'"_ ` _ \ / _ \ | / __|/ _ \ '"'"_ \ '
echo '  |  __/  __/ | | | | |  __/ | \__ \  __/ | | |'
echo '  |_|   \___|_| |_| |_|\___| |_|___/\___|_| |_|'
echo '                                              '
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}          ✅ Paymenter Installation Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# Installation details
echo -e "${YELLOW}📌 INSTALLATION DETAILS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${GREEN}•${NC} Panel URL: ${CYAN}$APP_URL${NC}"
echo -e " ${GREEN}•${NC} Admin Email: ${CYAN}$ADMIN_EMAIL${NC}"
echo -e " ${GREEN}•${NC} Admin Username: ${CYAN}$ADMIN_USERNAME${NC}"
echo -e " ${GREEN}•${NC} Database Name: ${CYAN}paymenter${NC}"
echo -e " ${GREEN}•${NC} Database User: ${CYAN}paymenter${NC}"
echo -e " ${GREEN}•${NC} Database Password: ${CYAN}$DB_PASSWORD${NC}"
echo -e " ${GREEN}•${NC} Credentials saved: ${CYAN}/root/paymenter_credentials.txt${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Useful commands
echo -e "${GREEN}📋 USEFUL COMMANDS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}→${NC} Panel directory: ${CYAN}cd /var/www/paymenter${NC}"
echo -e " ${YELLOW}→${NC} Queue status: ${CYAN}systemctl status paymenter-queue${NC}"
echo -e " ${YELLOW}→${NC} Scheduler status: ${CYAN}systemctl status paymenter-scheduler${NC}"
echo -e " ${YELLOW}→${NC} Create user: ${CYAN}php artisan user:create${NC}"
echo -e " ${YELLOW}→${NC} List users: ${CYAN}php artisan user:list${NC}"
echo -e " ${YELLOW}→${NC} View logs: ${CYAN}tail -f /var/www/paymenter/storage/logs/*.log${NC}"
echo -e " ${YELLOW}→${NC} Nginx logs: ${CYAN}tail -f /var/log/nginx/error.log${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Features
echo -e "${GREEN}✨ PAYMENTER FEATURES:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${WHITE}•${NC} Free and open-source"
echo -e " ${WHITE}•${NC} User-Friendly client and admin area"
echo -e " ${WHITE}•${NC} Payment integrations: Stripe, PayPal, Mollie"
echo -e " ${WHITE}•${NC} Server integrations: Pterodactyl, Virtualizor, Virtfusion"
echo -e " ${WHITE}•${NC} Automatic billing"
echo -e " ${WHITE}•${NC} Built-in support center"
echo -e " ${WHITE}•${NC} Coupon system"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Next steps
echo -e "${GREEN}📌 NEXT STEPS:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " 1. Open browser and go to: ${CYAN}$APP_URL${NC}"
echo -e " 2. Login with admin credentials"
echo -e " 3. Configure payment gateways (Settings → Payments)"
echo -e " 4. Add server integrations (Settings → Servers)"
echo -e " 5. Create products and pricing"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Documentation
echo -e "${GREEN}📚 DOCUMENTATION:${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${CYAN}• GitHub: https://github.com/paymenter/paymenter${NC}"
echo -e " ${CYAN}• Website: https://paymenter.org${NC}"
echo -e " ${CYAN}• Discord: https://discord.gg/paymenter${NC}"
echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Final message
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           🚀 Paymenter is ready to use! 🚀${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
