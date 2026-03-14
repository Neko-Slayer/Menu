#!/bin/bash

# ===========================================
# System Information Script
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
echo '  ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗'
echo '  ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║'
echo '  ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║'
echo '  ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║'
echo '  ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║'
echo '  ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝'
echo -e "${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}              📊 System Information Script${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"

# ===========================================
# SYSTEM INFORMATION
# ===========================================
echo -e "${GREEN}📌 SYSTEM INFORMATION${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# Hostname
echo -e " ${YELLOW}►${NC} Hostname        : ${CYAN}$(hostname)${NC}"
echo -e " ${YELLOW}►${NC} Domain          : ${CYAN}$(hostname -f 2>/dev/null || echo "N/A")${NC}"

# OS Information
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo -e " ${YELLOW}►${NC} OS              : ${CYAN}$PRETTY_NAME${NC}"
else
    echo -e " ${YELLOW}►${NC} OS              : ${CYAN}$(uname -o)${NC}"
fi

# Kernel
echo -e " ${YELLOW}►${NC} Kernel          : ${CYAN}$(uname -r)${NC}"

# Architecture
echo -e " ${YELLOW}►${NC} Architecture    : ${CYAN}$(uname -m)${NC}"

# Uptime
uptime_sec=$(awk '{print int($1)}' /proc/uptime)
days=$((uptime_sec / 86400))
hours=$(((uptime_sec % 86400) / 3600))
minutes=$(((uptime_sec % 3600) / 60))
echo -e " ${YELLOW}►${NC} Uptime          : ${CYAN}${days}d ${hours}h ${minutes}m${NC}"

# Load Average
loadavg=$(cat /proc/loadavg | awk '{print $1", "$2", "$3}')
echo -e " ${YELLOW}►${NC} Load Average    : ${CYAN}$loadavg${NC}"

# Date & Time
echo -e " ${YELLOW}►${NC} Current Time    : ${CYAN}$(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo -e " ${YELLOW}►${NC} Timezone        : ${CYAN}$(cat /etc/timezone 2>/dev/null || date +%Z)${NC}"

# Users logged in
users_logged=$(who | wc -l)
echo -e " ${YELLOW}►${NC} Users Logged    : ${CYAN}$users_logged${NC}"

# Last boot
echo -e " ${YELLOW}►${NC} Last Boot       : ${CYAN}$(who -b | awk '{print $3" "$4}')${NC}"
echo ""

# ===========================================
# CPU INFORMATION
# ===========================================
echo -e "${GREEN}💻 CPU INFORMATION${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# CPU Model
if [ -f /proc/cpuinfo ]; then
    cpu_model=$(grep "model name" /proc/cpuinfo | head -1 | cut -d':' -f2 | sed 's/^[ \t]*//')
    if [ -z "$cpu_model" ]; then
        cpu_model=$(grep "Processor" /proc/cpuinfo | head -1 | cut -d':' -f2 | sed 's/^[ \t]*//')
    fi
    echo -e " ${YELLOW}►${NC} CPU Model       : ${CYAN}$cpu_model${NC}"
fi

# CPU Cores
cpu_cores=$(nproc)
echo -e " ${YELLOW}►${NC} CPU Cores       : ${CYAN}$cpu_cores${NC}"

# CPU Frequency
if [ -f /proc/cpuinfo ]; then
    cpu_mhz=$(grep "cpu MHz" /proc/cpuinfo | head -1 | cut -d':' -f2 | sed 's/^[ \t]*//' | cut -d'.' -f1)
    if [ ! -z "$cpu_mhz" ]; then
        cpu_ghz=$(echo "scale=2; $cpu_mhz/1000" | bc)
        echo -e " ${YELLOW}►${NC} CPU Frequency   : ${CYAN}${cpu_ghz} GHz${NC}"
    fi
fi

# CPU Usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
if [ -z "$cpu_usage" ]; then
    cpu_usage=$(top -bn1 | grep "%Cpu" | awk '{print $2}')
fi
echo -e " ${YELLOW}►${NC} CPU Usage       : ${CYAN}$cpu_usage%${NC}"

# CPU Architecture bits
if [ "$(uname -m)" == "x86_64" ]; then
    echo -e " ${YELLOW}►${NC} CPU Mode        : ${CYAN}64-bit${NC}"
else
    echo -e " ${YELLOW}►${NC} CPU Mode        : ${CYAN}32-bit${NC}"
fi

# Virtualization
virt_type=$(systemd-detect-virt 2>/dev/null)
if [ ! -z "$virt_type" ] && [ "$virt_type" != "none" ]; then
    echo -e " ${YELLOW}►${NC} Virtualization  : ${CYAN}$virt_type${NC}"
fi
echo ""

# ===========================================
# MEMORY INFORMATION
# ===========================================
echo -e "${GREEN}🧠 MEMORY INFORMATION${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# Total RAM
if [ -f /proc/meminfo ]; then
    total_ram=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    total_ram_gb=$(echo "scale=2; $total_ram/1024/1024" | bc)
    
    # Available RAM
    avail_ram=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
    if [ -z "$avail_ram" ]; then
        # Fallback for older kernels
        free_ram=$(grep MemFree /proc/meminfo | awk '{print $2}')
        buffers=$(grep Buffers /proc/meminfo | awk '{print $2}')
        cached=$(grep Cached /proc/meminfo | awk '{print $2}')
        avail_ram=$((free_ram + buffers + cached))
    fi
    avail_ram_gb=$(echo "scale=2; $avail_ram/1024/1024" | bc)
    
    used_ram_gb=$(echo "scale=2; $total_ram_gb - $avail_ram_gb" | bc)
    ram_percent=$(echo "scale=2; $used_ram_gb * 100 / $total_ram_gb" | bc)
    
    echo -e " ${YELLOW}►${NC} Total RAM       : ${CYAN}${total_ram_gb} GB${NC}"
    echo -e " ${YELLOW}►${NC} Used RAM        : ${CYAN}${used_ram_gb} GB${NC}"
    echo -e " ${YELLOW}►${NC} Available RAM   : ${CYAN}${avail_ram_gb} GB${NC}"
    echo -e " ${YELLOW}►${NC} RAM Usage       : ${CYAN}${ram_percent}%${NC}"
    
    # Swap
    total_swap=$(grep SwapTotal /proc/meminfo | awk '{print $2}')
    if [ $total_swap -gt 0 ]; then
        total_swap_gb=$(echo "scale=2; $total_swap/1024/1024" | bc)
        free_swap=$(grep SwapFree /proc/meminfo | awk '{print $2}')
        free_swap_gb=$(echo "scale=2; $free_swap/1024/1024" | bc)
        used_swap_gb=$(echo "scale=2; $total_swap_gb - $free_swap_gb" | bc)
        swap_percent=$(echo "scale=2; $used_swap_gb * 100 / $total_swap_gb" | bc)
        
        echo -e " ${YELLOW}►${NC} Total Swap      : ${CYAN}${total_swap_gb} GB${NC}"
        echo -e " ${YELLOW}►${NC} Used Swap       : ${CYAN}${used_swap_gb} GB${NC}"
        echo -e " ${YELLOW}►${NC} Swap Usage      : ${CYAN}${swap_percent}%${NC}"
    fi
fi
echo ""

# ===========================================
# DISK INFORMATION
# ===========================================
echo -e "${GREEN}💾 DISK INFORMATION${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# Main disk usage
df -h / | awk 'NR==2 {
    echo " ${YELLOW}►${NC} Root Partition  : ${CYAN}" $1 "${NC}"
    echo " ${YELLOW}►${NC} Total Space     : ${CYAN}" $2 "${NC}"
    echo " ${YELLOW}►${NC} Used Space      : ${CYAN}" $3 " (" $5 ")${NC}"
    echo " ${YELLOW}►${NC} Available Space : ${CYAN}" $4 "${NC}"
}'

# All mounted partitions
echo -e "\n ${YELLOW}►${NC} All Mount Points :"
df -h | grep -E '^/dev/' | while read line; do
    partition=$(echo $line | awk '{print $1}')
    mount=$(echo $line | awk '{print $6}')
    size=$(echo $line | awk '{print $2}')
    used=$(echo $line | awk '{print $3}')
    avail=$(echo $line | awk '{print $4}')
    use_percent=$(echo $line | awk '{print $5}')
    echo -e "    ${WHITE}→${NC} $mount : ${CYAN}$size${NC} (Used: $used, Avail: $avail, $use_percent)"
done

# Inode usage
inodes=$(df -i / | awk 'NR==2 {print $5}')
echo -e "\n ${YELLOW}►${NC} Inode Usage     : ${CYAN}$inodes${NC}"
echo ""

# ===========================================
# NETWORK INFORMATION
# ===========================================
echo -e "${GREEN}🌐 NETWORK INFORMATION${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# Hostname and domain
echo -e " ${YELLOW}►${NC} Hostname        : ${CYAN}$(hostname)${NC}"
echo -e " ${YELLOW}►${NC} Domain          : ${CYAN}$(hostname -d 2>/dev/null || echo "N/A")${NC}"

# IP Addresses
echo -e "\n ${YELLOW}►${NC} IP Addresses :"

# IPv4
ipv4s=$(hostname -I 2>/dev/null)
for ip in $ipv4s; do
    if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo -e "    ${WHITE}→${NC} IPv4 : ${CYAN}$ip${NC}"
    fi
done

# IPv6
ipv6s=$(ip -6 addr show | grep inet6 | grep -v fe80 | awk '{print $2}' | cut -d'/' -f1)
for ip in $ipv6s; do
    echo -e "    ${WHITE}→${NC} IPv6 : ${CYAN}$ip${NC}"
done

# Public IP (optional - comment out if you don't want)
echo -e "\n ${YELLOW}►${NC} Fetching Public IP..."
public_ip=$(curl -s -4 ifconfig.co 2>/dev/null || curl -s ipinfo.io/ip 2>/dev/null)
if [ ! -z "$public_ip" ]; then
    echo -e "    ${WHITE}→${NC} Public IPv4 : ${CYAN}$public_ip${NC}"
fi

# Network interfaces
echo -e "\n ${YELLOW}►${NC} Network Interfaces :"
ip -br addr show | grep -v LOOPBACK | while read line; do
    iface=$(echo $line | awk '{print $1}')
    status=$(echo $line | awk '{print $2}')
    ip_addr=$(echo $line | awk '{print $3}')
    echo -e "    ${WHITE}→${NC} $iface : ${CYAN}$status${NC} - $ip_addr"
done

# Bandwidth usage (rough estimate)
echo -e "\n ${YELLOW}►${NC} Bandwidth Usage (approx) :"
rx_bytes=$(cat /sys/class/net/*/statistics/rx_bytes 2>/dev/null | awk '{sum += $1} END {print sum}')
tx_bytes=$(cat /sys/class/net/*/statistics/tx_bytes 2>/dev/null | awk '{sum += $1} END {print sum}')

if [ ! -z "$rx_bytes" ]; then
    rx_mb=$(echo "scale=2; $rx_bytes/1024/1024" | bc)
    tx_mb=$(echo "scale=2; $tx_bytes/1024/1024" | bc)
    echo -e "    ${WHITE}→${NC} Received : ${CYAN}${rx_mb} MB${NC}"
    echo -e "    ${WHITE}→${NC} Sent     : ${CYAN}${tx_mb} MB${NC}"
fi
echo ""

# ===========================================
# PROCESS INFORMATION
# ===========================================
echo -e "${GREEN}⚙️  PROCESS INFORMATION${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# Total processes
total_procs=$(ps aux | wc -l)
echo -e " ${YELLOW}►${NC} Total Processes : ${CYAN}$total_procs${NC}"

# Running processes
running_procs=$(ps aux | grep -v grep | wc -l)
echo -e " ${YELLOW}►${NC} Running Procs   : ${CYAN}$running_procs${NC}"

# Top 5 CPU processes
echo -e "\n ${YELLOW}►${NC} Top 5 CPU Processes :"
ps aux --sort=-%cpu | head -6 | tail -5 | while read line; do
    user=$(echo $line | awk '{print $1}')
    cpu=$(echo $line | awk '{print $3}')
    mem=$(echo $line | awk '{print $4}')
    cmd=$(echo $line | awk '{for(i=11;i<=NF;i++) printf "%s ", $i; print ""}' | cut -c1-40)
    echo -e "    ${WHITE}→${NC} ${CYAN}$cpu%${NC} CPU | ${CYAN}$mem%${NC} MEM | $user | $cmd"
done

# Top 5 Memory processes
echo -e "\n ${YELLOW}►${NC} Top 5 Memory Processes :"
ps aux --sort=-%mem | head -6 | tail -5 | while read line; do
    user=$(echo $line | awk '{print $1}')
    cpu=$(echo $line | awk '{print $3}')
    mem=$(echo $line | awk '{print $4}')
    cmd=$(echo $line | awk '{for(i=11;i<=NF;i++) printf "%s ", $i; print ""}' | cut -c1-40)
    echo -e "    ${WHITE}→${NC} ${CYAN}$mem%${NC} MEM | ${CYAN}$cpu%${NC} CPU | $user | $cmd"
done
echo ""

# ===========================================
# SERVICE INFORMATION
# ===========================================
echo -e "${GREEN}🔧 SERVICE INFORMATION${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# Check common services
services=("ssh" "nginx" "apache2" "mysql" "mariadb" "postgresql" "docker" "redis" "php8.1-fpm" "php-fpm")

for service in "${services[@]}"; do
    if systemctl is-active --quiet $service 2>/dev/null; then
        echo -e " ${GREEN}✓${NC} $service : ${GREEN}Running${NC}"
    elif systemctl is-active --quiet $service 2>/dev/null; then
        echo -e " ${GREEN}✓${NC} $service : ${GREEN}Running${NC}"
    elif systemctl list-unit-files | grep -q $service 2>/dev/null; then
        echo -e " ${RED}✗${NC} $service : ${RED}Stopped${NC}"
    fi
done
echo ""

# ===========================================
# SECURITY INFORMATION
# ===========================================
echo -e "${GREEN}🔐 SECURITY INFORMATION${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# Firewall status
if command -v ufw &> /dev/null; then
    ufw_status=$(ufw status | grep Status | awk '{print $2}')
    echo -e " ${YELLOW}►${NC} UFW Firewall    : ${CYAN}$ufw_status${NC}"
elif command -v iptables &> /dev/null; then
    iptables_rules=$(iptables -L | wc -l)
    echo -e " ${YELLOW}►${NC} IPTables Rules  : ${CYAN}$iptables_rules rules${NC}"
fi

# Fail2ban status
if systemctl is-active --quiet fail2ban 2>/dev/null; then
    echo -e " ${YELLOW}►${NC} Fail2ban        : ${GREEN}Active${NC}"
fi

# SSH config
if [ -f /etc/ssh/sshd_config ]; then
    ssh_port=$(grep -E "^Port" /etc/ssh/sshd_config | awk '{print $2}')
    if [ -z "$ssh_port" ]; then
        ssh_port=22
    fi
    ssh_root=$(grep -E "^PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
    if [ -z "$ssh_root" ]; then
        ssh_root="(default)"
    fi
    echo -e " ${YELLOW}►${NC} SSH Port        : ${CYAN}$ssh_port${NC}"
    echo -e " ${YELLOW}►${NC} Root Login      : ${CYAN}$ssh_root${NC}"
fi

# Last logins
echo -e "\n ${YELLOW}►${NC} Last 3 Failed Logins :"
lastb -n 3 2>/dev/null | head -3 | while read line; do
    echo -e "    ${WHITE}→${NC} $line"
done

echo -e "\n ${YELLOW}►${NC} Last 3 Successful Logins :"
last -n 3 | head -3 | while read line; do
    echo -e "    ${WHITE}→${NC} $line"
done
echo ""

# ===========================================
# INSTALLED SOFTWARE
# ===========================================
echo -e "${GREEN}📦 INSTALLED SOFTWARE${NC}"
echo -e "${WHITE}───────────────────────────────────────────────────────────────${NC}"

# Package manager info
if command -v dpkg &> /dev/null; then
    pkg_count=$(dpkg -l | grep -c "^ii")
    echo -e " ${YELLOW}►${NC} Debian packages : ${CYAN}$pkg_count${NC}"
elif command -v rpm &> /dev/null; then
    pkg_count=$(rpm -qa | wc -l)
    echo -e " ${YELLOW}►${NC} RPM packages    : ${CYAN}$pkg_count${NC}"
fi

# PHP version
if command -v php &> /dev/null; then
    php_version=$(php -v | head -1 | cut -d' ' -f2)
    echo -e " ${YELLOW}►${NC} PHP Version     : ${CYAN}$php_version${NC}"
fi

# Python version
if command -v python3 &> /dev/null; then
    python_version=$(python3 --version | cut -d' ' -f2)
    echo -e " ${YELLOW}►${NC} Python Version  : ${CYAN}$python_version${NC}"
fi

# Node.js version
if command -v node &> /dev/null; then
    node_version=$(node --version | cut -c2-)
    echo -e " ${YELLOW}►${NC} Node.js Version : ${CYAN}$node_version${NC}"
fi

# Docker version
if command -v docker &> /dev/null; then
    docker_version=$(docker --version | cut -d' ' -f3 | cut -d',' -f1)
    echo -e " ${YELLOW}►${NC} Docker Version  : ${CYAN}$docker_version${NC}"
fi

# MySQL/MariaDB version
if command -v mysql &> /dev/null; then
    mysql_version=$(mysql --version | cut -d' ' -f6 | cut -d',' -f1)
    echo -e " ${YELLOW}►${NC} MySQL Version   : ${CYAN}$mysql_version${NC}"
fi

# Nginx version
if command -v nginx &> /dev/null; then
    nginx_version=$(nginx -v 2>&1 | cut -d'/' -f2)
    echo -e " ${YELLOW}►${NC} Nginx Version   : ${CYAN}$nginx_version${NC}"
fi
echo ""

# ===========================================
# FOOTER
# ===========================================
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}           📊 System Information Complete!${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${WHITE}                Made by NekoSlayer_${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}            Generated on: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo -e "${PURPLE}═══════════════════════════════════════════════════════════════${NC}\n"
