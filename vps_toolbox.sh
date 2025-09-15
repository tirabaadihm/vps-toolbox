#!/bin/bash
# VPS Toolbox Manager v1.3 (Multi-language: FA/EN) with VPN Panels Installer
# Author: Alex

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

ok() { echo -e "${GREEN}[✔]${RESET} $1"; }
err() { echo -e "${RED}[✖]${RESET} $1"; }
warn() { echo -e "${YELLOW}[!]${RESET} $1"; }
info() { echo -e "${BLUE}[i]${RESET} $1"; }

# Language selection
clear
echo "Select Language / انتخاب زبان:"
echo "1) English"
echo "2) فارسی"
read -p "Choice / انتخاب: " lang

if [ "$lang" == "1" ]; then
    L="EN"
elif [ "$lang" == "2" ]; then
    L="FA"
else
    echo "Invalid choice / انتخاب نامعتبر"
    exit 1
fi

# Texts
if [ "$L" == "EN" ]; then
    TITLE="VPS Toolbox Manager v1.3"
    MENU1="Resource Monitoring"
    MENU2="System Cleanup"
    MENU3="Change DNS"
    MENU4="Change Timezone"
    MENU5="Swap Management"
    MENU6="Search"
    MENU7="VPN Panels Installer"
    MENU0="Exit"
    LANG_CONTINUE="Press Enter to continue..."
    LANG_CONFIRM="Do you want to execute this command? (y/n): "
else
    TITLE="مدیر جعبه ابزار VPS v1.3"
    MENU1="مانیتورینگ منابع"
    MENU2="پاکسازی سیستم"
    MENU3="تغییر DNS"
    MENU4="تغییر Timezone"
    MENU5="مدیریت Swap"
    MENU6="جستجو"
    MENU7="نصب پنل‌های VPN"
    MENU0="خروج"
    LANG_CONTINUE="ادامه بده (Enter)..."
    LANG_CONFIRM="میخوای این دستور اجرا بشه؟ (y/n): "
fi

# Fetch server IP and datacenter
IP=$(curl -s https://ipinfo.io/ip)
DATACENTER=$(curl -s https://ipinfo.io/org)

# Display header
echo "============================="
echo "     $TITLE"
echo "IP: $IP"
echo "Datacenter: $DATACENTER"
echo "============================="

# Helper to confirm command execution
confirm_exec() {
    read -p "$LANG_CONFIRM" choice
    case "$choice" in
        y|Y) eval "$1";;
        *) warn "Cancelled";;
    esac
}

# Dummy placeholders for existing functions (to be fully implemented)
monitoring() { echo "Monitoring..."; read -p "$LANG_CONTINUE" _; }
cleanup() { echo "Cleaning..."; read -p "$LANG_CONTINUE" _; }
change_dns() { echo "Changing DNS..."; read -p "$LANG_CONTINUE" _; }
change_timezone() { echo "Changing Timezone..."; read -p "$LANG_CONTINUE" _; }
swap_manager() { echo "Managing Swap..."; read -p "$LANG_CONTINUE" _; }
search_menu() { echo "Searching..."; read -p "$LANG_CONTINUE" _; }
vpn_panels() {
    echo "$MENU7"
    echo "1) Install Marzban"
    echo "2) Install Hiddify"
    echo "3) Install 3x-ui"
    echo "4) Install SPanel/X-Panel"
    echo "5) Check installed panels"
    echo "6) Remove a panel"
    echo "0) $MENU0"
    read -p "Choice: " v
    case $v in
        1) confirm_exec "echo Installing Marzban...";;
        2) confirm_exec "echo Installing Hiddify...";;
        3) confirm_exec "echo Installing 3x-ui...";;
        4) confirm_exec "echo Installing SPanel/X-Panel...";;
        5) echo "Checking installed panels..."; read -p "$LANG_CONTINUE" _;;
        6) echo "Removing selected panel..."; read -p "$LANG_CONTINUE" _;;
        0) return;;
        *) err "Invalid choice";;
    esac
}

# Main menu
main_menu() {
    while true; do
        echo ""
        echo "1) $MENU1"
        echo "2) $MENU2"
        echo "3) $MENU3"
        echo "4) $MENU4"
        echo "5) $MENU5"
        echo "6) $MENU6"
        echo "7) $MENU7"
        echo "0) $MENU0"
        read -p "Choice: " c
        case $c in
            1) monitoring;;
            2) cleanup;;
            3) change_dns;;
            4) change_timezone;;
            5) swap_manager;;
            6) search_menu;;
            7) vpn_panels;;
            0) exit 0;;
            *) err "Invalid choice";;
        esac
    done
}

main_menu
