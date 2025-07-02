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

# Configuration
PAYMENT_AMOUNT="1000"
PAYMENT_NUMBER="0622048500"
PAYMENT_DATABASE="payments.db"
ADMIN_DATABASE="admin.db"
SCRIPT_VERSION="3.0"
UPDATE_URL="https://raw.githubusercontent.com/Old-hacker01.com/Wifi-Hack/main/Wifi-finder.sh"
VERIFICATION_API="https://45shop.rf.gd/verify.php" # Replace with your actual URL

# Create databases if not exists
[ ! -f "$PAYMENT_DATABASE" ] && touch "$PAYMENT_DATABASE"
[ ! -f "$ADMIN_DATABASE" ] && { touch "$ADMIN_DATABASE"; echo "admin123" > "$ADMIN_DATABASE"; }

# ====== CORE FUNCTIONS ====== #

show_banner() {
    echo -e "${RED}╔════════════════════════════════════════════╗"
    echo -e "${RED}║${GREEN}   _____ _______ ___  ___  _____ _   _ ________ ${RED}║"
    echo -e "${RED}║${GREEN}  |  ___|_   _|_  ||  \/  ||  ___| \ | |_   _|  \ ${RED}║"
    echo -e "${RED}║${GREEN}  | |__   | |   | || .  . || |__ |  \| | | | | . \ ${RED}║"
    echo -e "${RED}║${GREEN}  |  __|  | |   | || |\/| ||  __|| . \` | | | | | | |${RED}║"
    echo -e "${RED}║${GREEN}  | |___ _| |_  | || |  | || |___| |\  |_| |_| |/ / ${RED}║"
    echo -e "${RED}║${GREEN}  \____/ \___/ \___/\_|  |_/\____/\_| \_/\___/|___/  ${RED}║"
    echo -e "${RED}║${PURPLE}           PREMIUM WIFI PASSWORD FINDER           ${RED}║"
    echo -e "${RED}║${PURPLE}                ${YELLOW}v$SCRIPT_VERSION | 0622048500        ${RED}║"
    echo -e "${RED}╚════════════════════════════════════════════╝"
    echo -e "${CYAN}           Created by ${RED}F${GREEN}a${YELLOW}z${BLUE}o${PURPLE}2${CYAN}8${NC}"
}

# ===== PAYMENT VERIFICATION ===== #

verify_payment() {
    echo -e "\n${YELLOW}🔒 PAYMENT VERIFICATION FOR 0622048500${NC}"
    echo -e "${GREEN}Amount: ${RED}1000 Tsh${NC}"
    echo -e "${BLUE}Send via: M-Pesa/Tigo Pesa/Airtel Money\n"
    
    # Get transaction details
    read -p "Enter transaction ID: " txn_id
    read -p "Enter sender phone (255xxxxxxxxx): " sender
    
    # Validate input format
    if ! [[ "$txn_id" =~ ^[A-Z0-9]{8,12}$ ]]; then
        echo -e "${RED}❌ Invalid transaction ID format!${NC}"
        return 1
    fi
    
    if ! [[ "$sender" =~ ^255[0-9]{9}$ ]]; then
        echo -e "${RED}❌ Use format 255xxxxxxxxx${NC}"
        return 1
    fi
    
    # Check if already used
    if grep -q "$txn_id" "$PAYMENT_DATABASE"; then
        echo -e "${RED}❌ This ID was already used!${NC}"
        return 1
    fi
    
    # Verify via API
    echo -e "\n${YELLOW}Verifying payment...${NC}"
    api_response=$(curl -s "${VERIFICATION_API}?txn_id=$txn_id&sender=$sender&amount=$PAYMENT_AMOUNT")
    
    if [[ "$api_response" == *"valid"* ]]; then
        echo "$txn_id" >> "$PAYMENT_DATABASE"
        echo -e "\n${GREEN}✅ Payment verified!${NC}"
        return 0
    else
        echo -e "\n${RED}❌ Payment not found!${NC}"
        echo -e "Please check:"
        echo -e "1. Correct transaction ID"
        echo -e "2. You sent EXACTLY 1000 Tsh"
        echo -e "3. Recipient: 0622048500"
        echo -e "\n${BLUE}Contact support if sure: https://wa.me/255675007732${NC}"
        return 1
    fi
}

# ===== ADMIN FUNCTIONS ===== #

admin_login() {
    read -sp "Enter admin password: " attempt
    stored=$(cat "$ADMIN_DATABASE")
    [ "$attempt" == "$stored" ] && return 0 || return 1
}

admin_panel() {
    clear
    echo -e "${RED}╔════════════════════════════╗"
    echo -e "${RED}║   ${WHITE}ADMIN CONTROL PANEL   ${RED}║"
    echo -e "${RED}╚════════════════════════════╝${NC}"
    
    while true; do
        echo -e "\n${GREEN}1. View all payments"
        echo -e "2. Add manual payment"
        echo -e "3. Remove payment"
        echo -e "4. Change admin password"
        echo -e "5. Back to main menu${NC}"
        
        read -p "Select option: " choice
        
        case $choice in
            1)
                echo -e "\n${YELLOW}PAYMENT RECORDS:${NC}"
                cat "$PAYMENT_DATABASE" || echo "No payments yet"
                ;;
            2)
                read -p "Enter transaction ID to add: " new_id
                echo "$new_id" >> "$PAYMENT_DATABASE"
                echo -e "${GREEN}✅ Added successfully!${NC}"
                ;;
            3)
                read -p "Enter ID to remove: " del_id
                grep -v "$del_id" "$PAYMENT_DATABASE" > temp && mv temp "$PAYMENT_DATABASE"
                echo -e "${GREEN}✅ Removed successfully!${NC}"
                ;;
            4)
                read -sp "Enter new admin password: " new_pass
                echo "$new_pass" > "$ADMIN_DATABASE"
                echo -e "\n${GREEN}✅ Password changed!${NC}"
                ;;
            5)
                return
                ;;
            *)
                echo -e "${RED}Invalid option!${NC}"
                ;;
        esac
    done
}

# ===== MAIN MENU ===== #

auto_update() {
    curl -s "$UPDATE_URL" -o "$0.tmp" && mv "$0.tmp" "$0" && chmod +x "$0"
    echo -e "${GREEN}✅ Script updated to latest version${NC}"
}

main_menu() {
    while true; do
        clear
        show_banner
        
        echo -e "\n${YELLOW}📱 Contact Support:${NC}"
        echo -e "${BLUE}WhatsApp: https://wa.me/255675007732"
        echo -e "Telegram: @mr_nobody${NC}"
        
        echo -e "\n${WHITE}MAIN MENU:${NC}"
        echo -e "${GREEN}1. Find WiFi passwords (Premium)"
        echo -e "2. Scan nearby networks (Free)"
        echo -e "3. Network information (Free)"
        echo -e "4. Admin login"
        echo -e "5. Exit${NC}"
        
        read -p "Choose (1-5): " option
        
        case $option in
            1)
                if verify_payment; then
                    echo -e "\n${YELLOW}Finding passwords...${NC}"
                    # Add your password finding code here
                    termux-wifi-showpasswords || echo "Failed - try with root"
                fi
                ;;
            2)
                termux-wifi-scaninfo || echo "Enable Termux API first!"
                ;;
            3)
                ifconfig && termux-wifi-connectioninfo
                ;;
            4)
                if admin_login; then
                    admin_panel
                else
                    echo -e "\n${RED}ACCESS DENIED!${NC}"
                    sleep 2
                fi
                ;;
            5)
                echo -e "\n${PURPLE}Thanks for using! ${RED}F${GREEN}a${YELLOW}z${BLUE}o${PURPLE}2${CYAN}8${NC}"
                exit 0
                ;;
            *)
                echo -e "\n${RED}Invalid choice!${NC}"
                ;;
        esac
        
        echo -e "\n${BLUE}Press any key to continue...${NC}"
        read -n 1 -s
    done
}

# Start the tool
main_menu
