#!/bin/bash

# Clear the screen
clear

# Color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Banner
echo -e "${RED}╔════════════════════════════════════════════╗"
echo -e "${RED}║${GREEN}   _____ _______ ___  ___  _____ _   _ ________ ${RED}║"
echo -e "${RED}║${GREEN}  |  ___|_   _|_  ||  \/  ||  ___| \ | |_   _|  \ ${RED}║"
echo -e "${RED}║${GREEN}  | |__   | |   | || .  . || |__ |  \| | | | | . \ ${RED}║"
echo -e "${RED}║${GREEN}  |  __|  | |   | || |\/| ||  __|| . \` | | | | | | |${RED}║"
echo -e "${RED}║${GREEN}  | |___ _| |_  | || |  | || |___| |\  |_| |_| |/ / ${RED}║"
echo -e "${RED}║${GREEN}  \____/ \___/ \___/\_|  |_/\____/\_| \_/\___/|___/  ${RED}║"
echo -e "${RED}║${PURPLE}             WiFi Password Finder Tool              ${RED}║"
echo -e "${RED}╚════════════════════════════════════════════╝"
echo -e "${CYAN}            Created by ${RED}F${GREEN}a${RED}z${BLUE}o${PURPLE}2${CYAN}8${NC}"

# Social media links
echo -e "\n${YELLOW}📱 Connect with me:${NC}"
echo -e "${BLUE}Telegram:${NC} https://t.me/mr_nobody"
echo -e "${GREEN}WhatsApp:${NC} https://wa.me/+255675007732"
echo -e "${PURPLE}GitHub:${NC} https://github.com/Old-hacker01"

# Main menu
echo -e "\n${WHITE}Select an option:${NC}"
echo -e "${GREEN}1. Find saved WiFi passwords"
echo -e "2. Scan for nearby WiFi networks"
echo -e "3. Show network information"
echo -e "4. Exit${NC}"

read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo -e "\n${YELLOW}Finding saved WiFi passwords...${NC}\n"
        if [ -f /data/misc/wifi/wpa_supplicant.conf ]; then
            echo -e "${GREEN}Saved WiFi networks and passwords:${NC}"
            cat /data/misc/wifi/wpa_supplicant.conf | grep -E 'ssid|psk'
        else
            echo -e "${RED}Error: WiFi configuration file not found or inaccessible.${NC}"
            echo -e "Make sure you have root permissions."
        fi
        ;;
    2)
        echo -e "\n${YELLOW}Scanning for nearby WiFi networks...${NC}\n"
        if command -v termux-wifi-scaninfo &> /dev/null; then
            termux-wifi-scaninfo
        else
            echo -e "${RED}Error: termux-wifi-scaninfo command not found.${NC}"
            echo -e "Make sure you have Termux API installed and configured."
        fi
        ;;
    3)
        echo -e "\n${YELLOW}Showing network information...${NC}\n"
        ifconfig
        echo -e "\n${GREEN}Current WiFi connection:${NC}"
        termux-wifi-connectioninfo
        ;;
    4)
        echo -e "\n${PURPLE}Thank you for using WiFi Password Finder by Fazo28!${NC}"
        exit 0
        ;;
    *)
        echo -e "\n${RED}Invalid choice. Please try again.${NC}"
        ;;
esac

echo -e "\n${BLUE}Press any key to return to the main menu...${NC}"
read -n 1 -s
exec "$0"
