#!/bin/bash

set -e

######################################################################################
#                                                                                    #
#   ██╗    ██╗██╗███╗   ██╗ ██████╗ ███████╗                                        #
#   ██║    ██║██║████╗  ██║██╔════╝ ██╔════╝                                        #
#   ██║ █╗ ██║██║██╔██╗ ██║██║  ███╗███████╗                                        #
#   ██║███╗██║██║██║╚██╗██║██║   ██║╚════██║                                        #
#   ╚███╔███╔╝██║██║ ╚████║╚██████╔╝███████║                                        #
#    ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝                                        #
#                                                                                    #
#   ╔═══════════════════════════════════════════════════════════════════════════╗   #
#   ║  🚀🪽 PTERODACTYL WINGS INSTALLER 🪽🚀                                      ║   #
#   ║  ═══════════════════════════════════════════════════════════════════════  ║   #
#   ║  🎨 Made with 💜 by NekoSlayer 🎨                                           ║   #
#   ║  ⚡ Lightweight Game Server Daemon Installation ⚡                          ║   #
#   ║  🔥 High Performance | Easy Setup | Fully Automated 🔥                     ║   #
#   ╚═══════════════════════════════════════════════════════════════════════════╝   #
#                                                                                    #
######################################################################################

# Modern Color Scheme
BOLD="\033[1m"
DIM="\033[2m"
ITALIC="\033[3m"
UNDERLINE="\033[4m"
BLINK="\033[5m"
REVERSE="\033[7m"

# Vibrant Color Palette
RED="\033[38;5;196m"
ORANGE="\033[38;5;208m"
YELLOW="\033[38;5;226m"
GREEN="\033[38;5;82m"
TEAL="\033[38;5;80m"
CYAN="\033[38;5;51m"
SKY="\033[38;5;39m"
BLUE="\033[38;5;33m"
INDIGO="\033[38;5;63m"
PURPLE="\033[38;5;129m"
VIOLET="\033[38;5;141m"
PINK="\033[38;5;205m"
HOTPINK="\033[38;5;207m"
WHITE="\033[38;5;255m"
GRAY="\033[38;5;245m"
SILVER="\033[38;5;250m"
GOLD="\033[38;5;220m"

NC="\033[0m"

# Banner function
print_banner() {
    clear
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                                       ║"
    echo -e "║  ${SKY}██╗    ██╗██╗███╗   ██╗ ██████╗ ███████╗${CYAN}                                        ║"
    echo -e "║  ${BLUE}██║    ██║██║████╗  ██║██╔════╝ ██╔════╝${CYAN}                                        ║"
    echo -e "║  ${SKY}██║ █╗ ██║██║██╔██╗ ██║██║  ███╗███████╗${CYAN}                                        ║"
    echo -e "║  ${BLUE}██║███╗██║██║██║╚██╗██║██║   ██║╚════██║${CYAN}                                        ║"
    echo -e "║  ${SKY}╚███╔███╔╝██║██║ ╚████║╚██████╔╝███████║${CYAN}                                        ║"
    echo -e "║  ${BLUE} ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝${CYAN}                                        ║"
    echo "║                                                                                       ║"
    echo -e "║  ${GOLD}✨${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${GOLD}✨${CYAN}  ║"
    echo "║                                                                                       ║"
    echo -e "║     ${BOLD}${WHITE}🚀🪽  PTERODACTYL WINGS INSTALLER  🪽🚀${NC}${CYAN}                           ║"
    echo "║                                                                                       ║"
    echo -e "║        ${ITALIC}${SILVER}Lightweight Game Server Daemon for Pterodactyl Panel${NC}${CYAN}               ║"
    echo "║                                                                                       ║"
    echo -e "║        ${HOTPINK}❤️${PINK}  Made with Love by ${BOLD}${WHITE}NEKOSLAYER${NC}${CYAN}  ${HOTPINK}❤️${CYAN}                           ║"
    echo "║                                                                                       ║"
    echo -e "║  ${GREEN}⚡ Features:${NC}                                                              ║"
    echo -e "║    ${CYAN}•${NC} Automatic Docker Installation      ${CYAN}•${NC} Systemd Service Setup                ║"
    echo -e "║    ${CYAN}•${NC} Firewall Configuration            ${CYAN}•${NC} MySQL/MariaDB Support                ║"
    echo -e "║    ${CYAN}•${NC} SSL Support (Let's Encrypt)       ${CYAN}•${NC} High Performance                     ║"
    echo "║                                                                                       ║"
    echo "╚═══════════════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Function to print colored output
print_status() {
    echo -e "${BLUE}[${CYAN}➜${BLUE}]${NC} $1"
}

print_success() {
    echo -e "${GREEN}✅${NC} ${GREEN}$1${NC}"
}

print_error() {
    echo -e "${RED}❌${NC} ${RED}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️${NC} ${YELLOW}$1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ️${NC} ${CYAN}$1${NC}"
}

print_step() {
    echo -e "\n${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GOLD}🚀${NC} ${BOLD}${WHITE}$1${NC} ${GOLD}🚀${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Loading animation
loading_animation() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Check if script is loaded, load if not or fail otherwise.
fn_exists() { declare -F "$1" >/dev/null; }
if ! fn_exists lib_loaded; then
    source /tmp/lib.sh || source <(curl -sSL "$GITHUB_BASE_URL/$GITHUB_SOURCE"/lib/lib.sh)
    ! fn_exists lib_loaded && print_error "Could not load lib script" && exit 1
fi

# Display banner
print_banner

# ------------------ Variables ----------------- #

INSTALL_MARIADB="${INSTALL_MARIADB:-false}"

# firewall
CONFIGURE_FIREWALL="${CONFIGURE_FIREWALL:-false}"

# SSL (Let's Encrypt)
CONFIGURE_LETSENCRYPT="${CONFIGURE_LETSENCRYPT:-false}"
FQDN="${FQDN:-}"
EMAIL="${EMAIL:-}"

# Database host
CONFIGURE_DBHOST="${CONFIGURE_DBHOST:-false}"
CONFIGURE_DB_FIREWALL="${CONFIGURE_DB_FIREWALL:-false}"
MYSQL_DBHOST_HOST="${MYSQL_DBHOST_HOST:-127.0.0.1}"
MYSQL_DBHOST_USER="${MYSQL_DBHOST_USER:-pterodactyluser}"
MYSQL_DBHOST_PASSWORD="${MYSQL_DBHOST_PASSWORD:-}"

if [[ $CONFIGURE_DBHOST == true && -z "${MYSQL_DBHOST_PASSWORD}" ]]; then
    print_error "MySQL database host user password is required"
    exit 1
fi

# Show configuration
print_status "Wings Installation Configuration:"
echo -e "  ${GREEN}📦${NC} Install MariaDB: ${WHITE}$INSTALL_MARIADB${NC}"
echo -e "  ${GREEN}🔥${NC} Configure Firewall: ${WHITE}$CONFIGURE_FIREWALL${NC}"
echo -e "  ${GREEN}🔒${NC} Configure Let's Encrypt: ${WHITE}$CONFIGURE_LETSENCRYPT${NC}"
[ -n "$FQDN" ] && echo -e "  ${GREEN}🌐${NC} Domain: ${WHITE}$FQDN${NC}"
[ -n "$EMAIL" ] && echo -e "  ${GREEN}📧${NC} Email: ${WHITE}$EMAIL${NC}"
echo -e "  ${GREEN}🗄️${NC} Configure Database Host: ${WHITE}$CONFIGURE_DBHOST${NC}"
if [ "$CONFIGURE_DBHOST" == true ]; then
    echo -e "  ${GREEN}🖥️${NC} DB Host: ${WHITE}$MYSQL_DBHOST_HOST${NC}"
    echo -e "  ${GREEN}👤${NC} DB User: ${WHITE}$MYSQL_DBHOST_USER${NC}"
fi
echo ""

# ----------- Installation functions ----------- #

enable_services() {
    print_status "Enabling services..."
    [ "$INSTALL_MARIADB" == true ] && systemctl enable mariadb && print_success "MariaDB enabled"
    [ "$INSTALL_MARIADB" == true ] && systemctl start mariadb && print_success "MariaDB started"
    systemctl start docker && print_success "Docker started"
    systemctl enable docker && print_success "Docker enabled"
}

dep_install() {
    print_step "Installing System Dependencies"
    print_status "Installing dependencies for $OS $OS_VER..."

    [ "$CONFIGURE_FIREWALL" == true ] && install_firewall && firewall_ports

    case "$OS" in
    ubuntu | debian)
        print_status "Configuring Docker repository for $OS..."
        install_packages "ca-certificates gnupg lsb-release"

        mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg

        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$OS \
            $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null
        print_success "Docker repository configured"
        ;;

    rocky | almalinux)
        print_status "Configuring Docker repository for $OS..."
        install_packages "dnf-utils"
        dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
        print_success "Docker repository configured"

        [ "$CONFIGURE_LETSENCRYPT" == true ] && install_packages "epel-release" && print_success "EPEL repository installed"

        install_packages "device-mapper-persistent-data lvm2"
        ;;
    esac

    # Update the new repos
    print_status "Updating repositories..."
    update_repos
    print_success "Repositories updated"

    # Install dependencies
    print_status "Installing Docker and dependencies..."
    install_packages "docker-ce docker-ce-cli containerd.io"
    print_success "Docker installed"

    # Install mariadb if needed
    if [ "$INSTALL_MARIADB" == true ]; then
        print_status "Installing MariaDB..."
        install_packages "mariadb-server"
        print_success "MariaDB installed"
    fi
    
    if [ "$CONFIGURE_LETSENCRYPT" == true ]; then
        print_status "Installing Certbot..."
        install_packages "certbot"
        print_success "Certbot installed"
    fi

    enable_services

    print_success "Dependencies installed successfully!"
}

ptdl_dl() {
    print_step "Downloading Pterodactyl Wings"
    
    print_status "Creating Pterodactyl directory..."
    mkdir -p /etc/pterodactyl
    print_success "Directory created"
    
    print_status "Downloading Wings binary for architecture: $ARCH..."
    curl -L -o /usr/local/bin/wings "$WINGS_DL_BASE_URL$ARCH"
    print_success "Wings binary downloaded"

    print_status "Setting executable permissions..."
    chmod u+x /usr/local/bin/wings
    print_success "Permissions set"

    print_success "Pterodactyl Wings downloaded successfully!"
}

systemd_file() {
    print_step "Configuring Systemd Service"
    
    print_status "Installing systemd service file..."
    curl -o /etc/systemd/system/wings.service "$GITHUB_URL"/configs/wings.service
    print_success "Service file installed"
    
    print_status "Reloading systemd daemon..."
    systemctl daemon-reload
    print_success "Systemd reloaded"
    
    print_status "Enabling wings service..."
    systemctl enable wings
    print_success "Wings service enabled"

    print_success "Systemd service configured!"
}

firewall_ports() {
    print_status "Configuring firewall ports..."
    
    print_status "Opening port 22 (SSH)..."
    [ "$CONFIGURE_LETSENCRYPT" == true ] && firewall_allow_ports "80 443" && print_success "Ports 80, 443 opened"
    [ "$CONFIGURE_DB_FIREWALL" == true ] && firewall_allow_ports "3306" && print_success "Port 3306 opened"

    firewall_allow_ports "22" && print_success "Port 22 opened"
    firewall_allow_ports "8080" && print_success "Port 8080 opened (Wings)"
    firewall_allow_ports "2022" && print_success "Port 2022 opened (SFTP)"

    print_success "Firewall ports opened!"
}

letsencrypt() {
    print_step "Setting up Let's Encrypt SSL"
    
    FAILED=false

    print_status "Configuring Let's Encrypt for $FQDN..."

    # Stop nginx if running
    if systemctl is-active --quiet nginx; then
        print_status "Stopping nginx temporarily..."
        systemctl stop nginx || true
    fi

    # Obtain certificate
    print_status "Obtaining SSL certificate..."
    certbot certonly --no-eff-email --email "$EMAIL" --standalone -d "$FQDN" || FAILED=true

    # Start nginx if it was running
    if systemctl is-enabled --quiet nginx 2>/dev/null; then
        print_status "Starting nginx..."
        systemctl start nginx || true
    fi

    # Check if it succeeded
    if [ ! -d "/etc/letsencrypt/live/$FQDN/" ] || [ "$FAILED" == true ]; then
        print_warning "Let's Encrypt certificate setup failed!"
        print_info "You can still run Wings without SSL, or configure it manually later."
    else
        print_success "SSL certificate obtained successfully!"
        print_info "Certificate location: /etc/letsencrypt/live/$FQDN/"
    fi
}

configure_mysql() {
    print_step "Configuring MySQL/MariaDB Database"
    
    print_status "Creating database user: $MYSQL_DBHOST_USER..."
    create_db_user "$MYSQL_DBHOST_USER" "$MYSQL_DBHOST_PASSWORD" "$MYSQL_DBHOST_HOST"
    print_success "Database user created"
    
    print_status "Granting all privileges to user..."
    grant_all_privileges "*" "$MYSQL_DBHOST_USER" "$MYSQL_DBHOST_HOST"
    print_success "Privileges granted"

    if [ "$MYSQL_DBHOST_HOST" != "127.0.0.1" ]; then
        print_status "Configuring MySQL for remote connections..."
        
        case "$OS" in
        debian | ubuntu)
            sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
            ;;
        rocky | almalinux)
            sed -ne 's/^#bind-address=0.0.0.0$/bind-address=0.0.0.0/' /etc/my.cnf.d/mariadb-server.cnf
            ;;
        esac

        print_status "Restarting MySQL service..."
        systemctl restart mysqld
        print_success "MySQL configured for remote connections"
    fi

    print_success "MySQL configuration completed!"
}

# --------------- Main functions --------------- #

perform_install() {
    print_step "Starting Pterodactyl Wings Installation"
    echo -e "${CYAN}⚡ This might take a few minutes... please wait!${NC}\n"
    
    dep_install
    ptdl_dl
    systemd_file
    
    if [ "$CONFIGURE_DBHOST" == true ]; then
        configure_mysql
    fi
    
    if [ "$CONFIGURE_LETSENCRYPT" == true ]; then
        letsencrypt
    fi

    print_step "Installation Complete! 🎉"
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✅ Pterodactyl Wings has been installed successfully!         ║${NC}"
    echo -e "${GREEN}║                                                                ║${NC}"
    echo -e "${GREEN}║  🚀 Wings is ready to be configured                           ║${NC}"
    echo -e "${GREEN}║  📁 Configuration: ${CYAN}/etc/pterodactyl/config.yml${GREEN}                    ║${NC}"
    echo -e "${GREEN}║  🛠️  Service: ${CYAN}systemctl {start|stop|restart} wings${GREEN}               ║${NC}"
    echo -e "${GREEN}║  📊 Status: ${CYAN}systemctl status wings${GREEN}                               ║${NC}"
    echo -e "${GREEN}║  📋 Logs: ${CYAN}journalctl -u wings -f${GREEN}                                ║${NC}"
    echo -e "${GREEN}║                                                                ║${NC}"
    echo -e "${GREEN}║  💜 Made with love by NekoSlayer                               ║${NC}"
    echo -e "${GREEN}║  🐙 GitHub: github.com/nekoslayer                              ║${NC}"
    echo -e "${GREEN}║  💬 Discord: discord.gg/nekoslayer                             ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}\n"
    
    print_warning "Don't forget to configure your wings config.yml file!"
    print_info "You can generate a configuration from your Pterodactyl Panel"

    return 0
}

# ---------------- Installation ---------------- #

perform_install
