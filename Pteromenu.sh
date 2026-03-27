#!/bin/bash

set -e

######################################################################################
#                                                                                    #
#   ███╗   ██╗███████╗██╗  ██╗ ██████╗     ███████╗██╗   ██╗██╗   ██╗███████╗██████╗ #
#   ████╗  ██║██╔════╝██║ ██╔╝██╔═══██╗    ██╔════╝╚██╗ ██╔╝██║   ██║██╔════╝██╔══██╗#
#   ██╔██╗ ██║█████╗  █████╔╝ ██║   ██║    ███████╗ ╚████╔╝ ██║   ██║█████╗  ██████╔╝#
#   ██║╚██╗██║██╔══╝  ██╔═██╗ ██║   ██║    ╚════██║  ╚██╔╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗#
#   ██║ ╚████║███████╗██║  ██╗╚██████╔╝    ███████║   ██║    ╚████╔╝ ███████╗██║  ██║#
#   ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝     ╚══════╝   ╚═╝     ╚═══╝  ╚══════╝╚═╝  ╚═╝#
#                                                                                    #
#   ╔═══════════════════════════════════════════════════════════════════════════╗   #
#   ║  🚀🐉 PTERODACTYL MANAGEMENT MENU 🐉🚀                                    ║   #
#   ║  ═══════════════════════════════════════════════════════════════════════  ║   #
#   ║  🎨 Made with 💜 by NekoSlayer 🎨                                         ║   #
#   ║  🌟 The Ultimate Game Panel Management Solution 🌟                        ║   #
#   ║  🔥 Install | Configure | Remove | Manage 🔥                              ║   #
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

# Script URLs
PTERO_SCRIPT_URL="https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Ptero.sh"
WING_SCRIPT_URL="https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Wing.sh"
UNINSTALL_SCRIPT_URL="https://raw.githubusercontent.com/Neko-Slayer/Menu/main/Pterouni.sh"

# Function to print banner
print_banner() {
    clear
    echo -e "${PURPLE}"
    echo "╔═══════════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                                       ║"
    echo -e "║  ${PINK}███╗   ██╗███████╗██╗  ██╗ ██████╗     ███████╗██╗   ██╗██╗   ██╗███████╗██████╗${PURPLE}  ║"
    echo -e "║  ${HOTPINK}████╗  ██║██╔════╝██║ ██╔╝██╔═══██╗    ██╔════╝╚██╗ ██╔╝██║   ██║██╔════╝██╔══██╗${PURPLE} ║"
    echo -e "║  ${PINK}██╔██╗ ██║█████╗  █████╔╝ ██║   ██║    ███████╗ ╚████╔╝ ██║   ██║█████╗  ██████╔╝${PURPLE} ║"
    echo -e "║  ${HOTPINK}██║╚██╗██║██╔══╝  ██╔═██╗ ██║   ██║    ╚════██║  ╚██╔╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗${PURPLE} ║"
    echo -e "║  ${PINK}██║ ╚████║███████╗██║  ██╗╚██████╔╝    ███████║   ██║    ╚████╔╝ ███████╗██║  ██║${PURPLE} ║"
    echo -e "║  ${HOTPINK}╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝     ╚══════╝   ╚═╝     ╚═══╝  ╚══════╝╚═╝  ╚═╝${PURPLE} ║"
    echo "║                                                                                       ║"
    echo -e "║  ${GOLD}✨${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${GOLD}✨${PURPLE}  ║"
    echo "║                                                                                       ║"
    echo -e "║     ${BOLD}${WHITE}🚀🐉  PTERODACTYL MANAGEMENT MENU  🐉🚀${NC}${PURPLE}                           ║"
    echo "║                                                                                       ║"
    echo -e "║        ${ITALIC}${SILVER}Complete Installation & Management Solution${NC}${PURPLE}                       ║"
    echo "║                                                                                       ║"
    echo -e "║        ${HOTPINK}❤️${PINK}  Made with Love by ${BOLD}${WHITE}NEKOSLAYER${NC}${PURPLE}  ${HOTPINK}❤️${PURPLE}                           ║"
    echo "║                                                                                       ║"
    echo -e "║  ${GREEN}⚡ Available Options:${NC}                                                         ║"
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

print_header() {
    echo -e "\n${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GOLD}📌${NC} ${BOLD}${WHITE}$1${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Function to download and execute script
run_script() {
    local script_url=$1
    local script_name=$2
    
    print_status "Downloading $script_name..."
    
    # Create temporary file
    local tmp_script=$(mktemp)
    
    # Download script
    if curl -sSL "$script_url" -o "$tmp_script"; then
        print_success "$script_name downloaded successfully"
        
        # Make executable
        chmod +x "$tmp_script"
        
        # Execute script
        print_info "Starting $script_name..."
        bash "$tmp_script"
        
        # Clean up
        rm -f "$tmp_script"
        
        print_success "$script_name completed!"
    else
        print_error "Failed to download $script_name"
        return 1
    fi
}

# Function to check system requirements
check_system() {
    print_header "System Check"
    
    # Check if running as root
    if [[ $EUID -ne 0 ]]; then
        print_error "This script must be run as root!"
        exit 1
    fi
    print_success "Running as root"
    
    # Check OS
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        print_info "OS: $NAME $VERSION_ID"
    fi
    
    # Check internet connectivity
    if ping -c 1 google.com &> /dev/null; then
        print_success "Internet connection detected"
    else
        print_warning "No internet connection detected"
    fi
    
    echo ""
}

# Function to install Panel
install_panel() {
    print_header "Pterodactyl Panel Installation"
    print_warning "This will install the full Pterodactyl Panel with all dependencies"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -n -e "${HOTPINK}💀 Continue with Panel installation? (y/N): ${NC}"
    read -r confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        run_script "$PTERO_SCRIPT_URL" "Pterodactyl Panel Installer"
    else
        print_info "Panel installation cancelled"
    fi
}

# Function to install Wings
install_wings() {
    print_header "Pterodactyl Wings Installation"
    print_warning "This will install the Pterodactyl Wings daemon"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -n -e "${HOTPINK}💀 Continue with Wings installation? (y/N): ${NC}"
    read -r confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        run_script "$WING_SCRIPT_URL" "Pterodactyl Wings Installer"
    else
        print_info "Wings installation cancelled"
    fi
}

# Function to uninstall everything
uninstall_all() {
    print_header "Pterodactyl Uninstaller"
    print_warning "⚠️  THIS WILL COMPLETELY REMOVE PTERODACTYL! ⚠️"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}This will remove:${NC}"
    echo -e "  ${RED}•${NC} Panel files and configurations"
    echo -e "  ${RED}•${NC} Database and database users"
    echo -e "  ${RED}•${NC} Wings and Docker containers"
    echo -e "  ${RED}•${NC} System services (pteroq, redis)"
    echo -e "  ${RED}•${NC} Cron jobs and queues"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -n -e "${HOTPINK}💀 Are you absolutely sure? Type 'YES' to continue: ${NC}"
    read -r confirm
    
    if [[ "$confirm" == "YES" ]]; then
        run_script "$UNINSTALL_SCRIPT_URL" "Pterodactyl Uninstaller"
    else
        print_info "Uninstall cancelled"
    fi
}

# Function to show menu
show_menu() {
    echo -e "\n${GOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}${WHITE}📋 MAIN MENU${NC}"
    echo -e "${GOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "  ${GREEN}1)${NC} 🚀 ${WHITE}Install Pterodactyl Panel${NC}     - Complete panel installation with web UI"
    echo -e "  ${GREEN}2)${NC} 🪽 ${WHITE}Install Pterodactyl Wings${NC}     - Game server daemon installation"
    echo -e "  ${GREEN}3)${NC} 🗑️  ${WHITE}Uninstall Pterodactyl${NC}        - Complete removal (Panel + Wings)"
    echo -e "  ${GREEN}4)${NC} 🔧 ${WHITE}System Check${NC}                  - Verify system requirements"
    echo -e "  ${GREEN}5)${NC} ℹ️  ${WHITE}About${NC}                        - Information about this tool"
    echo -e "  ${GREEN}0)${NC} ❌ ${WHITE}Exit${NC}                          - Exit the menu"
    
    echo -e "\n${GOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -n -e "${CYAN}👉 Select an option [0-5]: ${NC}"
}

# Function to show about info
show_about() {
    print_header "About NekoSlayer Pterodactyl Manager"
    
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  🎨 ${WHITE}Pterodactyl Management Suite${CYAN}                              ║${NC}"
    echo -e "${CYAN}║  ${PINK}Version:${NC} 1.0.0                                            ${CYAN}║${NC}"
    echo -e "${CYAN}║  ${PINK}Author:${NC} NekoSlayer                                         ${CYAN}║${NC}"
    echo -e "${CYAN}║  ${PINK}License:${NC} MIT                                               ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                                   ║${NC}"
    echo -e "${CYAN}║  ${GREEN}📦 Included Scripts:${NC}                                      ${CYAN}║${NC}"
    echo -e "${CYAN}║    • Ptero.sh - Panel Installer                                   ${CYAN}║${NC}"
    echo -e "${CYAN}║    • Wing.sh - Wings Installer                                    ${CYAN}║${NC}"
    echo -e "${CYAN}║    • Pterouni.sh - Complete Uninstaller                           ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                                   ║${NC}"
    echo -e "${CYAN}║  🔗 ${WHITE}Links:${CYAN}                                                ║${NC}"
    echo -e "${CYAN}║    🐙 GitHub: ${BLUE}https://github.com/Neko-Slayer${CYAN}                 ║${NC}"
    echo -e "${CYAN}║    💬 Discord: ${BLUE}https://discord.gg/nekoslayer${CYAN}                ║${NC}"
    echo -e "${CYAN}║    📚 Documentation: ${BLUE}https://docs.nekoslayer.com${CYAN}            ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}\n"
    
    print_info "This tool provides a complete solution for managing Pterodactyl"
    print_info "Panel and Wings installations on your server."
    echo ""
    
    read -n 1 -s -r -p "$(echo -e ${CYAN}Press any key to return to menu...${NC})"
}

# Main function
main() {
    while true; do
        print_banner
        show_menu
        read -r choice
        
        case $choice in
            1)
                check_system
                install_panel
                ;;
            2)
                check_system
                install_wings
                ;;
            3)
                check_system
                uninstall_all
                ;;
            4)
                check_system
                ;;
            5)
                show_about
                ;;
            0)
                print_info "👋 Goodbye! Thanks for using NekoSlayer Pterodactyl Manager"
                exit 0
                ;;
            *)
                print_error "Invalid option. Please select 0-5"
                sleep 2
                ;;
        esac
        
        # Pause before showing menu again
        if [[ $choice != "0" && $choice != "5" ]]; then
            echo ""
            read -n 1 -s -r -p "$(echo -e ${CYAN}Press any key to return to menu...${NC})"
        fi
    done
}

# Run main function
main
