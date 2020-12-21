#!/bin/bash
clear
bash ./center -n -t "┏━━━━━Paused━━━━━┓" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Resume: e or b ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Help:     h    ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┗━━━━━━━━━━━━━━━━┛" -b "\033[1;30;47m" -e "\033[0m"

read -d'' -s -n1 input
if [ "$input" == "e" ] || [ "$input" == 'b' ]
then
  clear
  exit
elif [ "$input" == "h" ]
  then
    bash ./helpMenu.sh "Menu"
    exit
else
  clear
  echo
  bash ./center -n -t "Not a vaild Option!"
  sleep 1
  bash ./Menu.sh
  exit
fi
