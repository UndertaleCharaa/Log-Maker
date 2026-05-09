#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

start_logging() {
    clear
    echo -e "${CYAN}========================${RESET}"
    echo -e "${CYAN}     Termux 기록기      ${RESET}"
    echo -e "${CYAN}========================${RESET}"
    echo -e " 종료: ${YELLOW}q${RESET} 또는 ${YELLOW}exit${RESET}\n"

    while true; do
        echo -ne "${GREEN}입력 > ${RESET}"
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
                echo -e "${CYAN}[완료]${RESET} $(tail -n 1 ~/.activity.log)"
                echo "------------------------"
                ;;
        esac
    done
}

if [ -f "log_agree.check" ]; then
    start_logging
else
    echo -e "${YELLOW}[안내]${RESET} 로그 기록을 시작할까요?"
    sleep 1
    clear
    echo -e "${YELLOW}------------------------${RESET}"
    echo " 삭제는 직접 해야 합니다."
    echo -e "${YELLOW}------------------------${RESET}"
    sleep 1

    echo -ne "동의하십니까? (${GREEN}y${RESET}/${YELLOW}n${RESET}): "
    read a

    case "$a" in
        [yY]*)
            touch "log_agree.check"
            echo -e "${GREEN}설정 완료!${RESET}"
            sleep 1
            start_logging
            ;;
        *)
            echo "종료합니다."
            exit
            ;;
    esac
fi
