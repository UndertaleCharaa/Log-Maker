#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

start_logging() {
    clear
    echo -e "${CYAN}========================${RESET}"
    echo -e "${CYAN}   Termux Logger (EN)   ${RESET}"
    echo -e "${CYAN}========================${RESET}"
    echo -e " Exit: ${YELLOW}q${RESET} or ${YELLOW}exit${RESET}\n"
    echo -e " view logs: ${YELLOW}v${RESET} or ${YELLOW}view${RESET}\n"

    while true; do
        echo -ne "${GREEN}Log > ${RESET}"
        read input

        case "$input" in
            q|exit)
                echo -e "\n${YELLOW}Goodbye!${RESET}"
                break
                ;;
            v|view)
                cat ~/.activity.log
                read -p "press enter and go to log add mod agin."
                clear
                ;;
            "")
                continue
                ;;
            *)
                echo "$(date "+%Y-%m-%d %H:%M:%S") - $input" >> ~/.activity.log
                echo -e "${CYAN}[OK]${RESET} $(tail -n 1 ~/.activity.log)"
                echo "------------------------"
                ;;
        esac
    done
}

if [ -f "log_agree.check" ]; then
    start_logging
else
    echo -e "${YELLOW}[Notice]${RESET} Start logging?"
    sleep 1
    clear
    echo -e "${YELLOW}------------------------${RESET}"
    echo " Manual delete only."
    echo -e "${YELLOW}------------------------${RESET}"
    sleep 1

    echo -ne "Agree? (${GREEN}y${RESET}/${YELLOW}n${RESET}): "
    read a

    case "$a" in
        [yY]*)
            touch "log_agree.check"
            echo -e "${GREEN}Done!${RESET}"
            sleep 1
            start_logging
            ;;
        *)
            echo "Exit."
            exit
            ;;
    esac
fi
