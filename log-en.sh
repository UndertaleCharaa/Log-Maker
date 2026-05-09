#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

start_logging() {
    clear
    echo -e "${CYAN}===================================${RESET}"
    echo -e "${CYAN}      Simple Activity Logger       ${RESET}"
    echo -e "${CYAN}===================================${RESET}"
    echo -e " (Commands: ${YELLOW}q${RESET} or ${YELLOW}exit${RESET} to quit)\n"
    echo -e " (view logs: ${YELLOW}v${RESET} or ${YELLOW}view${RESET})\n"

    while true; do
        echo -ne "${GREEN}Log > ${RESET}"
        read input

        case "$input" in
            q|exit)
                echo -e "\n${YELLOW}Exiting program.${RESET}"
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

                echo -e "${CYAN}[SAVED]${RESET} $(tail -n 1 ~/.activity.log)"
                echo "-----------------------------------"
                ;;
        esac
    done
}

if [ -f "log_agree.check" ]; then
    start_logging
else
    echo -e "${YELLOW}[Notice]${RESET} This program creates activity logs."
    sleep 1
    clear
    echo -e "${YELLOW}------------------------------------------------------------${RESET}"
    echo " Logs cannot be undone. You must delete them manually."
    echo " System activities may be recorded."
    echo -e "${YELLOW}------------------------------------------------------------${RESET}"
    sleep 1

    echo -ne "Do you agree to these terms? (${GREEN}y${RESET}/${YELLOW}n${RESET}): "
    read a

    case "$a" in
        [yY]*)
            touch "log_agree.check"
            echo -e "${GREEN}Setup complete!${RESET} Entering log mode..."
            sleep 1
            start_logging
            ;;
        *)
            echo "Exiting program."
            exit
            ;;
    esac
fi
