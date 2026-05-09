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
    echo -e " (종료 명령: ${YELLOW}q${RESET} 또는 ${YELLOW}exit${RESET})\n"

    while true; do
        echo -ne "${GREEN}Log > ${RESET}"
        read input

        case "$input" in
            q|exit)
                echo -e "\n${YELLOW}프로그램을 종료합니다.${RESET}"
                break
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
    echo -e "${YELLOW}[안내]${RESET} 이 프로그램은 로그를 생성합니다."
    sleep 1
    clear
    echo -e "${YELLOW}------------------------------------------------------------${RESET}"
    echo " 기록된 로그는 직접 삭제해야 하며, 시스템 활동이 기록될 수 있습니다."
    echo -e "${YELLOW}------------------------------------------------------------${RESET}"
    sleep 1

    echo -ne "위 사항에 동의하십니까? (${GREEN}y${RESET}/${YELLOW}n${RESET}): "
    read a

    case "$a" in
        [yY]*)
            touch "log_agree.check"
            echo -e "${GREEN}설정 완료!${RESET} 잠시 후 로그 모드로 진입합니다."
            sleep 1
            start_logging
            ;;
        *)
            echo "프로그램을 종료합니다."
            exit
            ;;
    esac
fi
