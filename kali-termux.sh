#!/bin/bash
# Kali Linux Theme for Termux
# One-file solution with menu
# Developer: Sardor
# Telegram: @BestProger

# Colors
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
BLUE='\033[1;94m'
PURPLE='\033[1;95m'
CYAN='\033[1;96m'
WHITE='\033[1;97m'
NC='\033[0m' # No Color

# Variables
BACKUP_FILE="/data/data/com.termux/files/usr/etc/bash.bashrc.backup"
BASHRC_FILE="/data/data/com.termux/files/usr/etc/bash.bashrc"
MOTD_FILE="/data/data/com.termux/files/usr/etc/motd"
SCRIPT_VERSION="2.0"
DEVELOPER="Sardor @BestProger"

# Clear screen
clear

# Banner
show_banner() {
    echo ""
    echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${NC}                                                      ${RED}║${NC}"
    echo -e "${RED}║${NC}   ${GREEN}██╗  ██╗ █████╗ ██╗     ██╗${NC}                           ${RED}║${NC}"
    echo -e "${RED}║${NC}   ${GREEN}██║ ██╔╝██╔══██╗██║     ██║${NC}                           ${RED}║${NC}"
    echo -e "${RED}║${NC}   ${GREEN}█████╔╝ ███████║██║     ██║${NC}                           ${RED}║${NC}"
    echo -e "${RED}║${NC}   ${GREEN}██╔═██╗ ██╔══██║██║     ██║${NC}                           ${RED}║${NC}"
    echo -e "${RED}║${NC}   ${GREEN}██║  ██╗██║  ██║███████╗███████╗${NC}                       ${RED}║${NC}"
    echo -e "${RED}║${NC}   ${GREEN}╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝${NC}                       ${RED}║${NC}"
    echo -e "${RED}║${NC}                                                      ${RED}║${NC}"
    echo -e "${RED}║${NC}           ${YELLOW}Termux Shell Customizer v${SCRIPT_VERSION}${NC}          ${RED}║${NC}"
    echo -e "${RED}║${NC}                 ${CYAN}Kali Linux Style${NC}                     ${RED}║${NC}"
    echo -e "${RED}║${NC}                                                      ${RED}║${NC}"
    echo -e "${RED}║${NC}            ${WHITE}Developer: ${DEVELOPER}${NC}                ${RED}║${NC}"
    echo -e "${RED}║${NC}                                                      ${RED}║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Main Menu
main_menu() {
    show_banner
    echo -e "${WHITE}Select an option:${NC}"
    echo ""
    echo -e "${GREEN}[1]${NC} Install Kali Linux Theme"
    echo -e "${RED}[2]${NC} Uninstall Kali Linux Theme"
    echo -e "${YELLOW}[3]${NC} Install Custom Commands"
    echo -e "${BLUE}[4]${NC} Show Current Status"
    echo -e "${PURPLE}[5]${NC} About & Help"
    echo -e "${CYAN}[6]${NC} Exit"
    echo ""
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    read -p "Choose option [1-6]: " option
    
    case $option in
        1) install_theme ;;
        2) uninstall_theme ;;
        3) install_commands ;;
        4) show_status ;;
        5) about_help ;;
        6) exit_script ;;
        *) echo -e "${RED}[!] Invalid option!${NC}"; sleep 2; main_menu ;;
    esac
}

# Install Kali Theme
install_theme() {
    clear
    show_banner
    echo -e "${YELLOW}[*] Installing Kali Linux Theme...${NC}"
    echo ""
    
    # Check if already installed
    if grep -q "Kali Linux Theme for Termux" "$BASHRC_FILE" 2>/dev/null; then
        echo -e "${RED}[!] Kali theme is already installed!${NC}"
        echo -e "${YELLOW}[*] Use option 2 to uninstall first${NC}"
        sleep 3
        main_menu
        return
    fi
    
    # Backup current bashrc
    if [ -f "$BASHRC_FILE" ]; then
        cp "$BASHRC_FILE" "$BACKUP_FILE"
        echo -e "${GREEN}[✓] Current bash.bashrc backed up${NC}"
    fi
    
    # Create new bashrc with Kali theme
    cat > "$BASHRC_FILE" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
# Kali Linux Theme for Termux
# Created by @BestProger

# Colors
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
BLUE='\033[1;94m'
PURPLE='\033[1;95m'
CYAN='\033[1;96m'
WHITE='\033[1;97m'
NC='\033[0m'

# Clear on start
clear

# Welcome Message
echo -e "${RED}╔════════════════════════════════════════════╗${NC}"
echo -e "${RED}║${NC}                                            ${RED}║${NC}"
echo -e "${RED}║${NC}         ${GREEN}K A L I   L I N U X${NC}               ${RED}║${NC}"
echo -e "${RED}║${NC}         ${YELLOW}T E R M U X   T H E M E${NC}           ${RED}║${NC}"
echo -e "${RED}║${NC}                                            ${RED}║${NC}"
echo -e "${RED}║${NC}            ${CYAN}Developer: @BestProger${NC}          ${RED}║${NC}"
echo -e "${RED}╚════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}System Information:${NC}"
echo -e "${WHITE}════════════════════════════════════════════${NC}"
echo -e "  ${BLUE}»${NC} User: ${GREEN}$(whoami)${NC}"
echo -e "  ${BLUE}»${NC} Host: ${CYAN}$(hostname)${NC}"
echo -e "  ${BLUE}»${NC} Date: ${YELLOW}$(date +'%A, %d %B %Y')${NC}"
echo -e "  ${BLUE}»${NC} Time: ${PURPLE}$(date +'%H:%M:%S')${NC}"
echo ""

# Custom Prompt Function
kali_prompt() {
    local exit_code=$?
    local user="kali"
    local host="localhost"
    local current_dir="${PWD/#$HOME/~}"
    
    # Git branch detection
    local git_branch=""
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git_branch="(${GREEN}$(git branch 2>/dev/null | grep '^\*' | cut -d' ' -f2)${NC}) "
    fi
    
    # Set PS1 with Kali style
    PS1="\n${RED}┌──${NC}(${GREEN}${user}${NC}${RED}@${NC}${CYAN}${host}${NC})${RED}[${NC}${YELLOW}${current_dir}${NC}${RED}]${NC} ${git_branch}"
    
    # Show exit code if not 0
    if [ $exit_code != 0 ]; then
        PS1+="${RED}[${exit_code}]${NC}\n"
    else
        PS1+="\n"
    fi
    
    PS1+="${RED}└─${NC}\$ "
}

# Set prompt command
PROMPT_COMMAND=kali_prompt

# Custom Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias l='ls -CF'
alias cls='clear'
alias update='pkg update && pkg upgrade'
alias myip='curl ifconfig.me'
alias kali='echo -e "${GREEN}Kali Linux Theme Active${NC}"'
alias help-kali='echo -e "${CYAN}Custom Commands:${NC}\nupdate - Update packages\nmyip - Get IP\nkali - Theme status\nhelp-kali - This help"'
alias net-scan='echo "Scanning..." && nmap -sP 192.168.1.0/24 2>/dev/null || echo "nmap not installed"'
alias termux-theme='echo -e "${RED}Kali${GREEN}Linux${NC} Theme by @BestProger"'

# Set terminal title
echo -ne "\033]0;Kali@Termux\007"
EOF
    
    # Create custom motd
    cat > "$MOTD_FILE" << 'EOF'
=============================================
       Kali Linux Terminal Theme
       Customized for Termux
       Developer: @BestProger
=============================================
EOF
    
    echo -e "${GREEN}[✓] Kali Linux theme installed successfully!${NC}"
    echo ""
    echo -e "${YELLOW}[!] Important:${NC}"
    echo -e "${WHITE}   • Restart Termux to apply changes${NC}"
    echo -e "${WHITE}   • Type 'help-kali' for custom commands${NC}"
    echo ""
    echo -e "${BLUE}Your prompt will look like:${NC}"
    echo -e "${RED}┌──${NC}(${GREEN}kali${NC}${RED}@${NC}${CYAN}localhost${NC})${RED}[${NC}${YELLOW}~${NC}${RED}]${NC}"
    echo -e "${RED}└─${NC}\$ "
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# Uninstall Theme
uninstall_theme() {
    clear
    show_banner
    echo -e "${RED}[*] Uninstalling Kali Linux Theme...${NC}"
    echo ""
    
    # Check if installed
    if ! grep -q "Kali Linux Theme for Termux" "$BASHRC_FILE" 2>/dev/null; then
        echo -e "${YELLOW}[!] Kali theme is not installed!${NC}"
        read -p "Press Enter to continue..."
        main_menu
        return
    fi
    
    echo -e "${YELLOW}[?] Are you sure you want to uninstall?${NC}"
    read -p "Type 'yes' to confirm: " confirm
    
    if [[ $confirm != "yes" ]]; then
        echo -e "${RED}[!] Uninstallation cancelled${NC}"
        sleep 2
        main_menu
        return
    fi
    
    # Restore from backup
    if [ -f "$BACKUP_FILE" ]; then
        cp "$BACKUP_FILE" "$BASHRC_FILE"
        rm "$BACKUP_FILE"
        echo -e "${GREEN}[✓] Original configuration restored${NC}"
    else
        # Create default bashrc
        cat > "$BASHRC_FILE" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
# Default Termux bash.bashrc

# Source global bash config
if [ -f /data/data/com.termux/files/usr/etc/bash.bashrc ]; then
	. /data/data/com.termux/files/usr/etc/bash.bashrc
fi

# Set prompt
PS1='\$ '
EOF
        echo -e "${YELLOW}[!] Backup not found, created default config${NC}"
    fi
    
    # Remove motd
    if [ -f "$MOTD_FILE" ]; then
        rm "$MOTD_FILE"
        echo -e "${GREEN}[✓] MOTD file removed${NC}"
    fi
    
    echo ""
    echo -e "${GREEN}[✓] Kali Linux theme uninstalled successfully!${NC}"
    echo -e "${YELLOW}[!] Restart Termux to apply changes${NC}"
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# Install Custom Commands
install_commands() {
    clear
    show_banner
    echo -e "${BLUE}[*] Installing Custom Commands...${NC}"
    echo ""
    
    # Check if bashrc exists
    if [ ! -f "$BASHRC_FILE" ]; then
        echo -e "${RED}[!] bash.bashrc not found!${NC}"
        echo -e "${YELLOW}[*] Install theme first${NC}"
        sleep 2
        main_menu
        return
    fi
    
    # Add custom commands to bashrc if not already there
    if ! grep -q "Custom Commands Section" "$BASHRC_FILE" 2>/dev/null; then
        cat >> "$BASHRC_FILE" << 'EOF'

# ============================================
# Custom Commands Section
# ============================================

# System Info Commands
alias sysinfo='echo -e "${GREEN}System Info:${NC}\nCPU: $(uname -m)\nOS: $(uname -o)\nKernel: $(uname -r)"'
alias disk-usage='df -h'
alias termux-info='echo -e "${CYAN}Termux Info:${NC}\nVersion: $(termux-info | grep "TERMUX_VERSION")\nArch: $(uname -m)"'

# Network Commands
alias ping-google='ping -c 4 8.8.8.8'
alias check-net='curl -I --connect-timeout 5 https://google.com 2>/dev/null || echo "No internet"'
alias wifi-scan='termux-wifi-scaninfo 2>/dev/null || echo "WiFi scanning not available"'

# Utility Commands
alias weather='curl wttr.in 2>/dev/null || echo "Weather service unavailable"'
alias cheat='function _cheat() { curl "cheat.sh/$1"; }; _cheat'
alias crypto='curl "rate.sx" 2>/dev/null | head -20'

# Security Commands (if tools installed)
alias hash-md5='echo "Usage: echo -n "text" | md5sum"'
alias hash-sha='echo "Usage: echo -n "text" | sha256sum"'

# Fun Commands
alias matrix='cmatrix 2>/dev/null || echo "Install cmatrix: pkg install cmatrix"'
alias figlet-text='function _fig() { figlet "$@"; }; _fig'
alias quote='curl "https://api.quotable.io/random" 2>/dev/null | grep -o "\"content\":\"[^\"]*\"" | cut -d"\"" -f4'

# Quick Package Management
alias install='pkg install'
alias remove='pkg uninstall'
alias search='pkg search'
alias cleanup='pkg autoclean && pkg clean'

# Show all custom commands
alias my-commands='echo -e "${GREEN}Available Custom Commands:${NC}\
\n${CYAN}System:${NC} sysinfo, disk-usage, termux-info\
\n${CYAN}Network:${NC} myip, ping-google, check-net, wifi-scan\
\n${CYAN}Utils:${NC} weather, cheat, crypto\
\n${CYAN}Security:${NC} hash-md5, hash-sha\
\n${CYAN}Fun:${NC} matrix, figlet-text, quote\
\n${CYAN}Packages:${NC} install, remove, search, cleanup\
\n${CYAN}Theme:${NC} kali, help-kali, termux-theme"'
EOF
        
        echo -e "${GREEN}[✓] Custom commands added!${NC}"
        echo -e "${YELLOW}[*] Restart Termux or type: source ~/.bashrc${NC}"
    else
        echo -e "${YELLOW}[!] Custom commands already installed${NC}"
    fi
    
    echo ""
    echo -e "${WHITE}Type 'my-commands' to see all available commands${NC}"
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# Show Current Status
show_status() {
    clear
    show_banner
    echo -e "${CYAN}[*] Checking Current Status...${NC}"
    echo ""
    
    # Check theme installation
    if grep -q "Kali Linux Theme for Termux" "$BASHRC_FILE" 2>/dev/null; then
        echo -e "${GREEN}[✓] Kali Linux theme: INSTALLED${NC}"
    else
        echo -e "${RED}[✗] Kali Linux theme: NOT INSTALLED${NC}"
    fi
    
    # Check backup
    if [ -f "$BACKUP_FILE" ]; then
        echo -e "${GREEN}[✓] Backup file: EXISTS${NC}"
    else
        echo -e "${YELLOW}[!] Backup file: NOT FOUND${NC}"
    fi
    
    # Check custom commands
    if grep -q "Custom Commands Section" "$BASHRC_FILE" 2>/dev/null; then
        echo -e "${GREEN}[✓] Custom commands: INSTALLED${NC}"
    else
        echo -e "${RED}[✗] Custom commands: NOT INSTALLED${NC}"
    fi
    
    # Check motd
    if [ -f "$MOTD_FILE" ]; then
        echo -e "${GREEN}[✓] MOTD file: EXISTS${NC}"
    else
        echo -e "${YELLOW}[!] MOTD file: NOT FOUND${NC}"
    fi
    
    echo ""
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}System Information:${NC}"
    echo -e "  ${YELLOW}»${NC} User: $(whoami)"
    echo -e "  ${YELLOW}»${NC} Host: $(hostname)"
    echo -e "  ${YELLOW}»${NC} Termux: $(pkg list-installed termux-tools 2>/dev/null | grep termux-tools || echo "Unknown")"
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# About & Help
about_help() {
    clear
    show_banner
    echo -e "${PURPLE}[*] About & Help Information${NC}"
    echo ""
    echo -e "${CYAN}Kali Linux Theme for Termux v${SCRIPT_VERSION}${NC}"
    echo ""
    echo -e "${WHITE}Description:${NC}"
    echo "This script transforms your Termux terminal to look"
    echo "like Kali Linux command line interface."
    echo ""
    echo -e "${WHITE}Features:${NC}"
    echo "• Kali-style prompt: ┌──(kali@localhost)[~]"
    echo "• Custom colors and design"
    echo "• System information display"
    echo "• Useful aliases and commands"
    echo "• Git branch detection"
    echo "• Backup/restore functionality"
    echo ""
    echo -e "${WHITE}Usage Tips:${NC}"
    echo "1. Install theme first (Option 1)"
    echo "2. Install custom commands (Option 3)"
    echo "3. Restart Termux after installation"
    echo "4. Type 'my-commands' to see all commands"
    echo ""
    echo -e "${WHITE}Developer:${NC}"
    echo "Name: Sardor"
    echo "Telegram: @BestProger"
    echo ""
    echo -e "${RED}⚠ Important:${NC}"
    echo "This only changes the appearance, not functionality."
    echo "Your Termux commands will work as usual."
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# Exit Script
exit_script() {
    clear
    show_banner
    echo ""
    echo -e "${GREEN}Thank you for using Kali Termux Theme!${NC}"
    echo ""
    echo -e "${CYAN}Telegram: @BestProger${NC}"
    echo -e "${YELLOW}Have a nice day! 👋${NC}"
    echo ""
    exit 0
}

# Check if running in Termux
check_termux() {
    if [ ! -d "/data/data/com.termux/files/usr" ]; then
        echo -e "${RED}[!] Error: This script must be run in Termux!${NC}"
        echo -e "${YELLOW}[*] Please run this in Termux app${NC}"
        exit 1
    fi
}

# Check root
check_root() {
    if [ "$(whoami)" = "root" ]; then
        echo -e "${YELLOW}[!] Warning: Running as root${NC}"
        echo -e "${RED}[!] Not recommended for Termux${NC}"
        sleep 2
    fi
}

# Main
check_termux
check_root
main_menu
