#!/bin/bash
# Kali Linux Theme for Termux
# Enhanced version with color selection and features
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

# Configuration
USERNAME="kali"
HOSTNAME="localhost"
SHOW_FULL_PATH=false  # Change to true for full path
COLOR_SCHEME="kali"   # Default color scheme
BACKUP_FILE="/data/data/com.termux/files/usr/etc/bash.bashrc.backup"
BASHRC_FILE="/data/data/com.termux/files/usr/etc/bash.bashrc"
MOTD_FILE="/data/data/com.termux/files/usr/etc/motd"
SCRIPT_DIR="$HOME/Termux-Kali-Shell"
SCRIPT_VERSION="3.0"

# Clear screen
clear

# Banner
show_banner() {
    echo ""
    echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${NC}                                                      ${RED}║${NC}"
    echo -e "${RED}║${NC}     ${GREEN}╦ ╦┌─┐┬  ┌─┐  ╔╦╗┌─┐┌─┐┬┌─┌─┐┬─┐${NC}                 ${RED}║${NC}"
    echo -e "${RED}║${NC}     ${GREEN}╠═╣├─┤│  ├┤    ║ │ ││ │├┴┐├┤ ├┬┘${NC}                 ${RED}║${NC}"
    echo -e "${RED}║${NC}     ${GREEN}╩ ╩┴ ┴┴─┘└─┘   ╩ └─┘└─┘┴ ┴└─┘┴└─${NC}                 ${RED}║${NC}"
    echo -e "${RED}║${NC}                                                      ${RED}║${NC}"
    echo -e "${RED}║${NC}         ${YELLOW}Termux Shell Customizer v${SCRIPT_VERSION}${NC}          ${RED}║${NC}"
    echo -e "${RED}║${NC}                                                      ${RED}║${NC}"
    echo -e "${RED}║${NC}            ${WHITE}Developer: @BestProger${NC}                ${RED}║${NC}"
    echo -e "${RED}║${NC}                                                      ${RED}║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Main Menu
main_menu() {
    show_banner
    echo -e "${WHITE}╭─── MAIN MENU ──────────────────────────────────────╮${NC}"
    echo ""
    echo -e "${GREEN}[1]${NC} Install Kali Theme"
    echo -e "${YELLOW}[2]${NC} Configure Settings"
    echo -e "${BLUE}[3]${NC} Install Custom Commands"
    echo -e "${PURPLE}[4]${NC} Change Color Scheme"
    echo -e "${CYAN}[5]${NC} Show Current Status"
    echo -e "${RED}[6]${NC} Uninstall Theme"
    echo -e "${RED}[7]${NC} Delete Script Completely"
    echo ""
    echo -e "${WHITE}[0]${NC} Exit"
    echo ""
    echo -e "${WHITE}╰─────────────────────────────────────────────────────╯${NC}"
    echo ""
    read -p "Select option [0-7]: " option
    
    case $option in
        1) install_theme ;;
        2) configure_settings ;;
        3) install_commands ;;
        4) color_scheme_menu ;;
        5) show_status ;;
        6) uninstall_theme ;;
        7) delete_script ;;
        0) exit_script ;;
        *) echo -e "${RED}[!] Invalid option!${NC}"; sleep 1; main_menu ;;
    esac
}

# Get current directory display
get_current_dir() {
    if [ "$SHOW_FULL_PATH" = true ]; then
        echo "$PWD"
    else
        local current_dir="${PWD/#$HOME/~}"
        if [ "$current_dir" = "~" ]; then
            echo "~"
        elif [ "${#current_dir}" -gt 30 ]; then
            echo "...${current_dir: -27}"
        else
            echo "$current_dir"
        fi
    fi
}

# Get color scheme
get_colors() {
    case $COLOR_SCHEME in
        "kali")
            USER_COLOR=$GREEN
            HOST_COLOR=$CYAN
            DIR_COLOR=$YELLOW
            PROMPT_COLOR=$RED
            ;;
        "matrix")
            USER_COLOR=$GREEN
            HOST_COLOR=$GREEN
            DIR_COLOR=$GREEN
            PROMPT_COLOR=$GREEN
            ;;
        "cyber")
            USER_COLOR=$CYAN
            HOST_COLOR=$PURPLE
            DIR_COLOR=$BLUE
            PROMPT_COLOR=$RED
            ;;
        "simple")
            USER_COLOR=$WHITE
            HOST_COLOR=$WHITE
            DIR_COLOR=$WHITE
            PROMPT_COLOR=$WHITE
            ;;
        "red")
            USER_COLOR=$RED
            HOST_COLOR=$RED
            DIR_COLOR=$YELLOW
            PROMPT_COLOR=$RED
            ;;
        "blue")
            USER_COLOR=$BLUE
            HOST_COLOR=$BLUE
            DIR_COLOR=$CYAN
            PROMPT_COLOR=$BLUE
            ;;
        *)
            USER_COLOR=$GREEN
            HOST_COLOR=$CYAN
            DIR_COLOR=$YELLOW
            PROMPT_COLOR=$RED
            ;;
    esac
}

# Install Kali Theme
install_theme() {
    clear
    show_banner
    echo -e "${GREEN}[*] Installing Kali Linux Theme...${NC}"
    echo ""
    
    # Check if already installed
    if grep -q "Kali Linux Theme for Termux" "$BASHRC_FILE" 2>/dev/null; then
        echo -e "${YELLOW}[!] Kali theme is already installed!${NC}"
        echo -e "[*] Use option 6 to uninstall first"
        echo ""
        read -p "Press Enter to continue..."
        main_menu
        return
    fi
    
    # Backup current bashrc
    if [ -f "$BASHRC_FILE" ]; then
        cp "$BASHRC_FILE" "$BACKUP_FILE"
        echo -e "${GREEN}[✓] Current bash.bashrc backed up${NC}"
    fi
    
    # Get current colors
    get_colors
    
    # Create new bashrc with Kali theme
    cat > "$BASHRC_FILE" << EOF
#!/data/data/com.termux/files/usr/bin/bash
# Kali Linux Theme for Termux
# Created by @BestProger
# Color Scheme: $COLOR_SCHEME

# Colors
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
BLUE='\033[1;94m'
PURPLE='\033[1;95m'
CYAN='\033[1;96m'
WHITE='\033[1;97m'
NC='\033[0m'

# Theme Colors
USER_COLOR='$USER_COLOR'
HOST_COLOR='$HOST_COLOR'
DIR_COLOR='$DIR_COLOR'
PROMPT_COLOR='$PROMPT_COLOR'

# Clear on start
clear

# Welcome Message
echo -e "\${PROMPT_COLOR}╔════════════════════════════════════════════╗\${NC}"
echo -e "\${PROMPT_COLOR}║\${NC}                                            \${PROMPT_COLOR}║\${NC}"
echo -e "\${PROMPT_COLOR}║\${NC}         \${USER_COLOR}K A L I   L I N U X\${NC}               \${PROMPT_COLOR}║\${NC}"
echo -e "\${PROMPT_COLOR}║\${NC}                                            \${PROMPT_COLOR}║\${NC}"
echo -e "\${PROMPT_COLOR}║\${NC}         \${DIR_COLOR}Color: $COLOR_SCHEME\${NC}                    \${PROMPT_COLOR}║\${NC}"
echo -e "\${PROMPT_COLOR}║\${NC}                                            \${PROMPT_COLOR}║\${NC}"
echo -e "\${PROMPT_COLOR}╚════════════════════════════════════════════╝\${NC}"
echo ""
echo -e "\${USER_COLOR}System Information:\${NC}"
echo -e "\${WHITE}════════════════════════════════════════════\${NC}"
echo -e "  \${BLUE}»\${NC} User: \${USER_COLOR}$USERNAME\${NC}"
echo -e "  \${BLUE}»\${NC} Host: \${HOST_COLOR}$HOSTNAME\${NC}"
echo -e "  \${BLUE}»\${NC} Time: \${YELLOW}\$(date +'%H:%M:%S')\${NC}"
echo -e "  \${BLUE}»\${NC} Date: \${PURPLE}\$(date +'%d/%m/%Y')\${NC}"
echo ""

# Custom Prompt Function
kali_prompt() {
    local exit_code=\$?
    local current_dir="\${PWD/#\$HOME/~}"
    
    # Shorten long paths
    if [ "\${#current_dir}" -gt 30 ]; then
        current_dir="...\${current_dir: -27}"
    fi
    
    # Git branch detection
    local git_branch=""
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git_branch="(\${GREEN}\$(git branch 2>/dev/null | grep '^\*' | cut -d' ' -f2)\${NC}) "
    fi
    
    # Show exit code if not 0
    local exit_display=""
    if [ \$exit_code != 0 ]; then
        exit_display="\${RED}[\$exit_code]\${NC} "
    fi
    
    # Set PS1 with Kali style
    PS1="\n\${PROMPT_COLOR}┌──\${NC}(\${USER_COLOR}$USERNAME\${NC}\${PROMPT_COLOR}@\${NC}\${HOST_COLOR}$HOSTNAME\${NC})\${PROMPT_COLOR}[\${NC}\${DIR_COLOR}\$current_dir\${NC}\${PROMPT_COLOR}]\${NC} \${exit_display}\${git_branch}"
    PS1+="\n\${PROMPT_COLOR}└─\${NC}\\\$ "
}

# Set prompt command
PROMPT_COMMAND=kali_prompt

# Basic Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias l='ls -CF'
alias cls='clear'
alias update='pkg update && pkg upgrade'
alias myip='curl ifconfig.me'
alias kali-theme='echo -e "\${USER_COLOR}Kali Linux Theme Active\${NC}\n\${DIR_COLOR}Color: $COLOR_SCHEME\${NC}"'
alias help-kali='echo -e "\${CYAN}Type 'my-commands' for all custom commands\${NC}"'

# Set terminal title
echo -ne "\033]0;$USERNAME@$HOSTNAME\007"
EOF
    
    # Create custom motd
    cat > "$MOTD_FILE" << EOF
=============================================
       Kali Linux Terminal Theme
       Color Scheme: $COLOR_SCHEME
       Developer: @BestProger
=============================================
EOF
    
    echo -e "${GREEN}[✓] Kali Linux theme installed successfully!${NC}"
    echo ""
    echo -e "${YELLOW}[!] Important:${NC}"
    echo -e "   • ${WHITE}Restart Termux to apply changes${NC}"
    echo -e "   • ${WHITE}Type 'kali-theme' to verify${NC}"
    echo -e "   • ${WHITE}Type 'help-kali' for help${NC}"
    echo ""
    echo -e "${BLUE}Your prompt will look like:${NC}"
    echo -e "${PROMPT_COLOR}┌──${NC}(${USER_COLOR}${USERNAME}${NC}${PROMPT_COLOR}@${NC}${HOST_COLOR}${HOSTNAME}${NC})${PROMPT_COLOR}[${NC}${DIR_COLOR}~${NC}${PROMPT_COLOR}]${NC}"
    echo -e "${PROMPT_COLOR}└─${NC}\$ "
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# Configure Settings
configure_settings() {
    clear
    show_banner
    echo -e "${YELLOW}[*] Configuration Settings${NC}"
    echo ""
    
    echo -e "${WHITE}Current Settings:${NC}"
    echo -e "  ${CYAN}Username:${NC} $USERNAME"
    echo -e "  ${CYAN}Hostname:${NC} $HOSTNAME"
    echo -e "  ${CYAN}Show Full Path:${NC} $SHOW_FULL_PATH"
    echo -e "  ${CYAN}Color Scheme:${NC} $COLOR_SCHEME"
    echo ""
    
    echo -e "${WHITE}What would you like to change?${NC}"
    echo ""
    echo -e "${GREEN}[1]${NC} Change Username (current: $USERNAME)"
    echo -e "${GREEN}[2]${NC} Change Hostname (current: $HOSTNAME)"
    echo -e "${GREEN}[3]${NC} Toggle Full Path Display (current: $SHOW_FULL_PATH)"
    echo -e "${GREEN}[4]${NC} Back to Main Menu"
    echo ""
    
    read -p "Select option [1-4]: " config_option
    
    case $config_option in
        1)
            echo ""
            read -p "Enter new username: " new_username
            if [ ! -z "$new_username" ]; then
                USERNAME="$new_username"
                echo -e "${GREEN}[✓] Username changed to: $USERNAME${NC}"
            fi
            ;;
        2)
            echo ""
            read -p "Enter new hostname: " new_hostname
            if [ ! -z "$new_hostname" ]; then
                HOSTNAME="$new_hostname"
                echo -e "${GREEN}[✓] Hostname changed to: $HOSTNAME${NC}"
            fi
            ;;
        3)
            if [ "$SHOW_FULL_PATH" = true ]; then
                SHOW_FULL_PATH=false
                echo -e "${GREEN}[✓] Full path display: OFF${NC}"
            else
                SHOW_FULL_PATH=true
                echo -e "${GREEN}[✓] Full path display: ON${NC}"
            fi
            ;;
        4)
            main_menu
            return
            ;;
        *)
            echo -e "${RED}[!] Invalid option${NC}"
            ;;
    esac
    
    # Ask to apply changes
    echo ""
    echo -e "${YELLOW}[?] Apply changes to current installation?${NC}"
    read -p "Type 'yes' to apply: " apply_changes
    
    if [[ $apply_changes == "yes" ]]; then
        if grep -q "Kali Linux Theme for Termux" "$BASHRC_FILE" 2>/dev/null; then
            install_theme
        else
            echo -e "${YELLOW}[!] Theme not installed. Changes saved for next installation.${NC}"
        fi
    fi
    
    sleep 2
    configure_settings
}

# Color Scheme Menu
color_scheme_menu() {
    clear
    show_banner
    echo -e "${PURPLE}[*] Select Color Scheme${NC}"
    echo ""
    
    echo -e "${WHITE}Current scheme: $COLOR_SCHEME${NC}"
    echo ""
    
    echo -e "${GREEN}[1]${NC} Kali (default)    ${GREEN}██${NC} ${CYAN}██${NC} ${YELLOW}██${NC} ${RED}██${NC}"
    echo -e "${GREEN}[2]${NC} Matrix           ${GREEN}██${NC} ${GREEN}██${NC} ${GREEN}██${NC} ${GREEN}██${NC}"
    echo -e "${GREEN}[3]${NC} Cyber            ${CYAN}██${NC} ${PURPLE}██${NC} ${BLUE}██${NC} ${RED}██${NC}"
    echo -e "${GREEN}[4]${NC} Simple           ${WHITE}██${NC} ${WHITE}██${NC} ${WHITE}██${NC} ${WHITE}██${NC}"
    echo -e "${GREEN}[5]${NC} Red Theme        ${RED}██${NC} ${RED}██${NC} ${YELLOW}██${NC} ${RED}██${NC}"
    echo -e "${GREEN}[6]${NC} Blue Theme       ${BLUE}██${NC} ${BLUE}██${NC} ${CYAN}██${NC} ${BLUE}██${NC}"
    echo -e "${GREEN}[7]${NC} Back to Main Menu"
    echo ""
    
    read -p "Select color scheme [1-7]: " color_option
    
    case $color_option in
        1) COLOR_SCHEME="kali" ;;
        2) COLOR_SCHEME="matrix" ;;
        3) COLOR_SCHEME="cyber" ;;
        4) COLOR_SCHEME="simple" ;;
        5) COLOR_SCHEME="red" ;;
        6) COLOR_SCHEME="blue" ;;
        7) main_menu; return ;;
        *) echo -e "${RED}[!] Invalid option${NC}"; sleep 1; color_scheme_menu; return ;;
    esac
    
    echo -e "${GREEN}[✓] Color scheme changed to: $COLOR_SCHEME${NC}"
    
    # Ask to apply changes
    echo ""
    echo -e "${YELLOW}[?] Apply changes to current installation?${NC}"
    read -p "Type 'yes' to apply: " apply_color
    
    if [[ $apply_color == "yes" ]]; then
        if grep -q "Kali Linux Theme for Termux" "$BASHRC_FILE" 2>/dev/null; then
            install_theme
        else
            echo -e "${YELLOW}[!] Theme not installed. Changes saved for next installation.${NC}"
            sleep 2
        fi
    fi
    
    color_scheme_menu
}

# Install Custom Commands (оставляем как было, но обновим)
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

# System Commands
alias sysinfo='echo -e "${GREEN}System Info:${NC}\nUser: $(whoami)\nHost: $(hostname)\nOS: $(uname -o)\nKernel: $(uname -r)"'
alias disk-usage='df -h'
alias meminfo='free -h'
alias battery='termux-battery-status 2>/dev/null || echo "Battery info not available"'

# Network Commands
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'
alias portscan='echo "Scanning common ports..." && nmap -sS localhost 2>/dev/null || echo "nmap not installed"'
alias myip='curl ifconfig.me; echo'

# Utility Commands
alias weather='curl wttr.in?format=3'
alias crypto='curl rate.sx 2>/dev/null | head -10'
alias qr='echo "Create QR: echo "text" | qrencode -o qr.png"'

# File Operations
alias sizeof='du -sh'
alias findbig='find . -type f -exec du -h {} + | sort -rh | head -10'
alias count='find . -type f | wc -l'

# Security
alias genpass='openssl rand -base64 12 2>/dev/null || echo "openssl not installed"'
alias hash-md5='echo "Usage: echo -n text | md5sum"'
alias hash-sha='echo "Usage: echo -n text | sha256sum"'

# Termux Specific
alias pkg-clean='pkg autoclean && pkg clean'
alias pkg-list='pkg list-installed'
alias storage='termux-setup-storage'

# Fun Commands
alias matrix='cmatrix 2>/dev/null || echo "Install: pkg install cmatrix"'
alias cowsay='cowsay "Hello from Kali Termux!" 2>/dev/null || echo "Install: pkg install cowsay"'
alias fortune='fortune 2>/dev/null || echo "Install: pkg install fortune"'

# Git Shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# Show all commands
alias my-commands='echo -e "${GREEN}╔════════════════════════════════════════════╗\n║            AVAILABLE COMMANDS             ║\n╚════════════════════════════════════════════╝${NC}\
\n\n${CYAN}System:${NC} sysinfo, disk-usage, meminfo, battery\
\n${CYAN}Network:${NC} myip, speedtest, portscan\
\n${CYAN}Files:${NC} sizeof, findbig, count\
\n${CYAN}Security:${NC} genpass, hash-md5, hash-sha\
\n${CYAN}Termux:${NC} pkg-clean, pkg-list, storage\
\n${CYAN}Fun:${NC} matrix, cowsay, fortune\
\n${CYAN}Git:${NC} gs, ga, gc, gp, gl\
\n${CYAN}Theme:${NC} kali-theme, help-kali"'
EOF
        
        echo -e "${GREEN}[✓] 40+ custom commands installed!${NC}"
        echo -e "${YELLOW}[*] Restart Termux or type: source $BASHRC_FILE${NC}"
    else
        echo -e "${YELLOW}[!] Custom commands already installed${NC}"
    fi
    
    echo ""
    echo -e "${WHITE}Type 'my-commands' to see all available commands${NC}"
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# Show Status
show_status() {
    clear
    show_banner
    echo -e "${CYAN}[*] System Status${NC}"
    echo ""
    
    # Theme status
    if grep -q "Kali Linux Theme for Termux" "$BASHRC_FILE" 2>/dev/null; then
        echo -e "${GREEN}[✓] Kali Theme: INSTALLED${NC}"
        
        # Get current color scheme from bashrc
        current_color=$(grep "Color Scheme:" "$BASHRC_FILE" | head -1 | cut -d: -f2 | xargs)
        if [ ! -z "$current_color" ]; then
            echo -e "    ${WHITE}Color: $current_color${NC}"
        fi
    else
        echo -e "${RED}[✗] Kali Theme: NOT INSTALLED${NC}"
    fi
    
    # Backup status
    if [ -f "$BACKUP_FILE" ]; then
        echo -e "${GREEN}[✓] Backup: EXISTS${NC}"
    else
        echo -e "${YELLOW}[!] Backup: NOT FOUND${NC}"
    fi
    
    # Commands status
    if grep -q "Custom Commands Section" "$BASHRC_FILE" 2>/dev/null; then
        echo -e "${GREEN}[✓] Custom Commands: INSTALLED${NC}"
    else
        echo -e "${RED}[✗] Custom Commands: NOT INSTALLED${NC}"
    fi
    
    echo ""
    echo -e "${WHITE}Current Settings:${NC}"
    echo -e "  ${YELLOW}Username:${NC} $USERNAME"
    echo -e "  ${YELLOW}Hostname:${NC} $HOSTNAME"
    echo -e "  ${YELLOW}Show Full Path:${NC} $SHOW_FULL_PATH"
    echo -e "  ${YELLOW}Color Scheme:${NC} $COLOR_SCHEME"
    echo ""
    echo -e "${WHITE}System Info:${NC}"
    echo -e "  ${BLUE}User:${NC} $(whoami)"
    echo -e "  ${BLUE}Host:${NC} $(hostname)"
    echo -e "  ${BLUE}Termux Home:${NC} $HOME"
    echo -e "  ${BLUE}Script Dir:${NC} $SCRIPT_DIR"
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# Uninstall Theme
uninstall_theme() {
    clear
    show_banner
    echo -e "${RED}[*] Uninstalling Kali Theme...${NC}"
    echo ""
    
    # Check if installed
    if ! grep -q "Kali Linux Theme for Termux" "$BASHRC_FILE" 2>/dev/null; then
        echo -e "${YELLOW}[!] Kali theme is not installed!${NC}"
        read -p "Press Enter to continue..."
        main_menu
        return
    fi
    
    echo -e "${RED}[!] WARNING: This will remove Kali theme${NC}"
    echo -e "${YELLOW}[?] Are you sure?${NC}"
    echo ""
    echo -e "${GREEN}[1]${NC} Yes, uninstall theme"
    echo -e "${RED}[2]${NC} No, cancel"
    echo ""
    
    read -p "Select option [1-2]: " confirm
    
    if [ "$confirm" != "1" ]; then
        echo -e "${GREEN}[*] Uninstallation cancelled${NC}"
        sleep 1
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

# Set prompt
PS1='\$ '

# Basic aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
EOF
        echo -e "${YELLOW}[!] Backup not found, created default config${NC}"
    fi
    
    # Remove motd
    if [ -f "$MOTD_FILE" ]; then
        rm "$MOTD_FILE"
        echo -e "${GREEN}[✓] MOTD file removed${NC}"
    fi
    
    echo ""
    echo -e "${GREEN}[✓] Kali theme uninstalled successfully!${NC}"
    echo -e "${YELLOW}[!] Restart Termux to apply changes${NC}"
    echo ""
    
    read -p "Press Enter to return to main menu..."
    main_menu
}

# Delete Script Completely
delete_script() {
    clear
    show_banner
    echo -e "${RED}[!] DANGER ZONE - DELETE SCRIPT${NC}"
    echo ""
    echo -e "${RED}This will:${NC}"
    echo -e "  1. Delete the script directory: $SCRIPT_DIR"
    echo -e "  2. Remove all script files"
    echo -e "  3. ${RED}CANNOT BE UNDONE${NC}"
    echo ""
    echo -e "${YELLOW}Note: This does NOT uninstall the theme${NC}"
    echo -e "      Use option 6 to uninstall theme first"
    echo ""
    
    echo -e "${RED}[?] Are you absolutely sure?${NC}"
    echo ""
    echo -e "${GREEN}[1]${NC} Yes, delete everything"
    echo -e "${RED}[2]${NC} No, cancel"
    echo ""
    
    read -p "Type 'DELETE' to confirm: " confirm
    
    if [ "$confirm" != "DELETE" ]; then
        echo -e "${GREEN}[*] Deletion cancelled${NC}"
        sleep 1
        main_menu
        return
    fi
    
    # Double confirmation
    echo ""
    echo -e "${RED}[!] LAST WARNING: This will delete:$NC"
    echo -e "  $SCRIPT_DIR/"
    echo ""
    read -p "Type 'CONFIRM' to proceed: " final_confirm
    
    if [ "$final_confirm" != "CONFIRM" ]; then
        echo -e "${GREEN}[*] Deletion cancelled${NC}"
        sleep 1
        main_menu
        return
    fi
    
    # Delete script directory
    if [ -d "$SCRIPT_DIR" ]; then
        rm -rf "$SCRIPT_DIR"
        echo -e "${GREEN}[✓] Script directory deleted${NC}"
    else
        echo -e "${YELLOW}[!] Script directory not found${NC}"
    fi
    
    # Delete current script if running from different location
    if [ "$(pwd)" != "$SCRIPT_DIR" ] && [ -f "./kali-termux.sh" ]; then
        rm -f ./kali-termux.sh
        echo -e "${GREEN}[✓] Script file deleted${NC}"
    fi
    
    echo ""
    echo -e "${RED}[!] Script deleted completely${NC}"
    echo -e "${YELLOW}[*] Closing in 3 seconds...${NC}"
    sleep 3
    exit 0
}

# Exit Script
exit_script() {
    clear
    show_banner
    echo ""
    echo -e "${GREEN}Thank you for using Kali Termux Shell!${NC}"
    echo ""
    echo -e "${CYAN}Telegram: @BestProger${NC}"
    echo -e "${YELLOW}GitHub: YourUsername${NC}"
    echo ""
    echo -e "${WHITE}Restart Termux to see theme changes${NC}"
    echo ""
    exit 0
}

# Check if running in Termux
check_termux() {
    if [ ! -d "/data/data/com.termux/files/usr" ]; then
        echo -e "${RED}[!] Error: This script must be run in Termux!${NC}"
        echo -e "${YELLOW}[*] Please run in Termux app${NC}"
        exit 1
    fi
}

# Initialize
check_termux
main_menu
