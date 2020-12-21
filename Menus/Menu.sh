#!/bin/bash
clear
bash ./tools/center -n -t "┏━━━━━Paused━━━━━┓" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┃ Resume: e or b ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┃ Help:     h    ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┗━━━━━━━━━━━━━━━━┛" -b "\033[1;30;47m" -e "\033[0m"

read -d'' -s -n1 input
if [ "$input" == "e" ] || [ "$input" == 'b' ]
then
  clear
  exit
elif [ "$input" == "h" ]
  then
    bash ./Menus/helpMenu.sh "Menu"
    exit
else
  clear
  echo
  bash ./tools/center -n -t "Not a vaild Option!"
  sleep 1
  bash ./Menus/Menu.sh
  exit
fi
