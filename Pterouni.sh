#!/bin/bash

set -e

######################################################################################
#                                                                                    #
#   ██╗   ██╗███╗   ██╗██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗#
#   ██║   ██║████╗  ██║██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝#
#   ██║   ██║██╔██╗ ██║██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  #
#   ██║   ██║██║╚██╗██║██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  #
#   ╚██████╔╝██║ ╚████║██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗#
#    ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝#
#                                                                                    #
#   ╔═══════════════════════════════════════════════════════════════════════════╗   #
#   ║  🗑️🐉 PTERODACTYL PANEL UNINSTALLER 🐉🗑️                                  ║   #
#   ║  ═══════════════════════════════════════════════════════════════════════  ║   #
#   ║  🎨 Made with 💜 by NekoSlayer 🎨                                           ║   #
#   ║  ⚠️  WARNING: This will completely remove Pterodactyl! ⚠️                  ║   #
#   ║  🔥 Clean removal of Panel, Wings, Database & Services 🔥                  ║   #
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
    echo -e "${RED}"
    echo "╔═══════════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                                       ║"
    echo -e "║  ${HOTPINK}██╗   ██╗███╗   ██╗██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗${RED}  ║"
    echo -e "║  ${PINK}██║   ██║████╗  ██║██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝${RED}  ║"
    echo -e "║  ${HOTPINK}██║   ██║██╔██╗ ██║██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ${RED}  ║"
    echo -e "║  ${PINK}██║   ██║██║╚██╗██║██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ${RED}  ║"
    echo -e "║  ${HOTPINK}╚██████╔╝██║ ╚████║██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗${RED}  ║"
    echo -e "║  ${PINK} ╚═════╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝${RED}  ║"
    echo "║                                                                                       ║"
    echo -e "║  ${GOLD}✨${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${GOLD}✨${RED}  ║"
    echo "║                                                                                       ║"
    echo -e "║     ${BOLD}${WHITE}🗑️🐉  PTERODACTYL UNINSTALLER  🐉🗑️${NC}${RED}                              ║"
    echo "║                                                                                       ║"
    echo -e "║        ${ITALIC}${SILVER}Complete Removal Tool for Pterodactyl Panel${NC}${RED}                    ║"
    echo "║                                                                                       ║"
    echo -e "║        ${HOTPINK}❤️${PINK}  Made with Love by ${BOLD}${WHITE}NEKOSLAYER${NC}${RED}  ${HOTPINK}❤️${RED}                           ║"
    echo "║                                                                                       ║"
    echo -e "║  ${YELLOW}⚠️  ${RED}${BOLD}WARNING: This will completely remove Pterodactyl!${NC}${RED}  ${YELLOW}⚠️${RED}     ║"
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
    echo -e "${GOLD}🗑️${NC} ${BOLD}${WHITE}$1${NC} ${GOLD}🗑️${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_list() {
    echo -e "${CYAN}📋 Available options:${NC}"
    echo "$1" | tr ' ' '\n' | while read -r item; do
        echo -e "  ${GREEN}•${NC} $item"
    done
}

# Confirmation prompt
confirm_uninstall() {
    print_warning "This action will permanently remove Pterodactyl Panel and all its components!"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}⚠️  This will remove:${NC}"
    echo -e "  ${RED}•${NC} Panel files and configurations"
    echo -e "  ${RED}•${NC} Database and database users"
    echo -e "  ${RED}•${NC} Wings and Docker containers"
    echo -e "  ${RED}•${NC} System services (pteroq, redis)"
    echo -e "  ${RED}•${NC} Cron jobs and queues"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -n -e "${HOTPINK}💀 Are you sure you want to continue? (y/N): ${NC}"
    read -r confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        print_info "Uninstall cancelled by user."
        exit 0
    fi
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

RM_PANEL="${RM_PANEL:-true}"
RM_WINGS="${RM_WINGS:-true}"

# Show what will be removed
print_status "Uninstall Configuration:"
echo -e "  ${GREEN}📦${NC} Remove Panel: ${WHITE}$RM_PANEL${NC}"
echo -e "  ${GREEN}🪽${NC} Remove Wings: ${WHITE}$RM_WINGS${NC}"
echo ""

# Confirm uninstall
confirm_uninstall

# ---------- Uninstallation functions ---------- #

rm_panel_files() {
    print_step "Removing Panel Files"
    
    print_status "Removing panel directory and composer..."
    rm -rf /var/www/pterodactyl /usr/local/bin/composer
    print_success "Panel files removed"
    
    print_status "Removing nginx configurations..."
    [ "$OS" != "centos" ] && [ -L /etc/nginx/sites-enabled/pterodactyl.conf ] && unlink /etc/nginx/sites-enabled/pterodactyl.conf
    [ "$OS" != "centos" ] && [ -f /etc/nginx/sites-available/pterodactyl.conf ] && rm -f /etc/nginx/sites-available/pterodactyl.conf
    [ "$OS" != "centos" ] && [ ! -L /etc/nginx/sites-enabled/default ] && [ -f /etc/nginx/sites-available/default ] && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
    [ "$OS" == "centos" ] && [ -f /etc/nginx/conf.d/pterodactyl.conf ] && rm -f /etc/nginx/conf.d/pterodactyl.conf
    print_success "Nginx configurations removed"
    
    print_status "Restarting nginx..."
    systemctl restart nginx
    print_success "Nginx restarted"
}

rm_docker_containers() {
    print_step "Removing Docker Containers"
    
    if command -v docker &> /dev/null; then
        print_status "Removing all docker containers and images..."
        docker system prune -a -f
        print_success "Docker containers and images removed"
    else
        print_warning "Docker not found, skipping..."
    fi
}

rm_wings_files() {
    print_step "Removing Wings"
    
    print_status "Stopping and disabling wings service..."
    systemctl disable --now wings 2>/dev/null || true
    
    print_status "Removing wings service file..."
    [ -f /etc/systemd/system/wings.service ] && rm -rf /etc/systemd/system/wings.service
    
    print_status "Removing wings directories..."
    [ -d /etc/pterodactyl ] && rm -rf /etc/pterodactyl
    [ -f /usr/local/bin/wings ] && rm -rf /usr/local/bin/wings
    [ -d /var/lib/pterodactyl ] && rm -rf /var/lib/pterodactyl
    
    print_success "Wings files removed"
}

rm_services() {
    print_step "Removing System Services"
    
    print_status "Removing pteroq service..."
    systemctl disable --now pteroq 2>/dev/null || true
    rm -rf /etc/systemd/system/pteroq.service
    
    case "$OS" in
    debian | ubuntu)
        print_status "Removing redis-server service..."
        systemctl disable --now redis-server 2>/dev/null || true
        ;;
    centos | rocky | almalinux)
        print_status "Removing redis service..."
        systemctl disable --now redis 2>/dev/null || true
        print_status "Removing php-fpm configuration..."
        systemctl disable --now php-fpm 2>/dev/null || true
        rm -rf /etc/php-fpm.d/www-pterodactyl.conf 2>/dev/null || true
        ;;
    esac
    
    print_success "Services removed"
}

rm_cron() {
    print_step "Removing Cron Jobs"
    
    print_status "Removing pterodactyl cron jobs..."
    crontab -l 2>/dev/null | grep -vF "* * * * * php /var/www/pterodactyl/artisan schedule:run >> /dev/null 2>&1" | crontab - 2>/dev/null || true
    print_success "Cron jobs removed"
}

rm_database() {
    print_step "Removing Database"
    
    print_status "Checking for existing databases..."
    valid_db=$(mariadb -u root -e "SELECT schema_name FROM information_schema.schemata;" 2>/dev/null | grep -v -E -- 'schema_name|information_schema|performance_schema|mysql')
    
    if [[ -z "$valid_db" ]]; then
        print_warning "No valid databases found."
        return
    fi
    
    print_warning "Be careful! This database will be deleted!"
    
    local DATABASE=""
    
    if [[ "$valid_db" == *"panel"* ]]; then
        echo -n -e "${YELLOW}⚠️  Database called 'panel' detected. Is it the Pterodactyl database? (y/N): ${NC}"
        read -r is_panel
        if [[ "$is_panel" =~ [Yy] ]]; then
            DATABASE="panel"
        else
            print_list "$valid_db"
        fi
    else
        print_list "$valid_db"
    fi
    
    while [ -z "$DATABASE" ] && [[ "$valid_db" != *"$DATABASE"* ]]; do
        echo -n -e "${CYAN}📝 Choose the panel database (press Enter to skip): ${NC}"
        read -r database_input
        if [[ -n "$database_input" ]]; then
            if [[ "$valid_db" == *"$database_input"* ]]; then
                DATABASE="$database_input"
            else
                print_warning "Invalid database name. Try again."
            fi
        else
            break
        fi
    done
    
    if [[ -n "$DATABASE" ]]; then
        print_status "Dropping database $DATABASE..."
        mariadb -u root -e "DROP DATABASE $DATABASE;" 2>/dev/null || print_warning "Failed to drop database $DATABASE."
        print_success "Database dropped"
    else
        print_info "No database selected, skipping removal."
    fi
    
    print_status "Checking for database users..."
    valid_users=$(mariadb -u root -e "SELECT user FROM mysql.user;" 2>/dev/null | grep -v -E -- 'user|root')
    
    if [[ -z "$valid_users" ]]; then
        print_warning "No valid database users found."
        return
    fi
    
    print_warning "Be careful! This user will be deleted!"
    
    local DB_USER=""
    
    if [[ "$valid_users" == *"pterodactyl"* ]]; then
        echo -n -e "${YELLOW}⚠️  User 'pterodactyl' detected. Is it the Pterodactyl user? (y/N): ${NC}"
        read -r is_user
        if [[ "$is_user" =~ [Yy] ]]; then
            DB_USER="pterodactyl"
        else
            print_list "$valid_users"
        fi
    else
        print_list "$valid_users"
    fi
    
    while [ -z "$DB_USER" ] && [[ "$valid_users" != *"$DB_USER"* ]]; do
        echo -n -e "${CYAN}📝 Choose the panel user (press Enter to skip): ${NC}"
        read -r user_input
        if [[ -n "$user_input" ]]; then
            if [[ "$valid_users" == *"$user_input"* ]]; then
                DB_USER=$user_input
            else
                print_warning "Invalid username. Try again."
            fi
        else
            break
        fi
    done
    
    if [[ -n "$DB_USER" ]]; then
        print_status "Removing database user $DB_USER..."
        mariadb -u root -e "DROP USER '$DB_USER'@'127.0.0.1';" 2>/dev/null || mariadb -u root -e "DROP USER '$DB_USER'@'localhost';" 2>/dev/null || print_warning "Failed to drop user $DB_USER."
        print_success "Database user removed"
    else
        print_info "No user selected, skipping removal."
    fi
    
    print_status "Flushing privileges..."
    mariadb -u root -e "FLUSH PRIVILEGES;" 2>/dev/null
    print_success "Database cleanup completed"
}

# --------------- Main functions --------------- #

perform_uninstall() {
    print_step "Starting Uninstallation Process"
    
    if [ "$RM_PANEL" == true ]; then
        rm_panel_files
        rm_cron
        rm_database
        rm_services
    fi
    
    if [ "$RM_WINGS" == true ]; then
        rm_docker_containers
        rm_wings_files
    fi
    
    print_step "Uninstallation Complete! 🎉"
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ✅ Pterodactyl has been successfully uninstalled!             ║${NC}"
    echo -e "${GREEN}║                                                                ║${NC}"
    echo -e "${GREEN}║  🧹 All components have been removed from your system         ║${NC}"
    echo -e "${GREEN}║  🔄 System has been cleaned up                                ║${NC}"
    echo -e "${GREEN}║                                                                ║${NC}"
    echo -e "${GREEN}║  💜 Made with love by NekoSlayer                               ║${NC}"
    echo -e "${GREEN}║  🐙 GitHub: github.com/nekoslayer                              ║${NC}"
    echo -e "${GREEN}║  💬 Discord: discord.gg/nekoslayer                             ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}\n"
    
    print_warning "You may want to reboot your system to complete cleanup."
    
    return 0
}

# ------------------ Uninstall ----------------- #

perform_uninstall
