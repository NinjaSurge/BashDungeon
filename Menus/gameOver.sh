#!/bin/bash
clear
bash ./tools/center -n -t "┏━━━━━━Dead━━━━━━┓" -b "\033[30;41m" -e "\033[0m"
bash ./tools/center -n -t "┃ Restart:   r   ┃" -b "\033[30;41m" -e "\033[0m"
bash ./tools/center -n -t "┃ Help:      h   ┃" -b "\033[30;41m" -e "\033[0m"
bash ./tools/center -n -t "┃ quit:      q   ┃" -b "\033[30;41m" -e "\033[0m"
bash ./tools/center -n -t "┗━━━━━━━━━━━━━━━━┛" -b "\033[30;41m" -e "\033[0m"
bash ./tools/center -n -t "   Choice:  " -b "\033[41m" -e "\033[0m"
bash ./tools/center -t ""
read -d'' -s -n1 input

if [ "$input" == "q" ]
then
  clear
  exit
elif [ "$input" == "r" ]
  then
    bash ./Launch.sh
    exit
elif [ "$input" == "h" ]
  then
    bash ./Menus/helpMenu.sh "gameOver"
    exit
else
  clear
  echo
  bash ./tools/center -n -t "Not a vaild Option!" -b "\033[30;41m" -e "\033[0m"
  sleep 1
  bash ./Menus/gameOver.sh
  exit
fi
