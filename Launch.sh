#!/bin/bash
clear
bash ./tools/center -n -t "First Time? try the Help Menu"
bash ./tools/center -n -t "Welcome to"
bash ./tools/center -n -t "Bash Dungeon Crawler"
bash ./tools/center -n -t "┏━━━━━━━━━━┓" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┃ Options: ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┣━━━━━━━━━━┫" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┃ Start: s ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┃ Help:  h ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┃ Quit:  q ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "┗━━━━━━━━━━┛" -b "\033[1;30;47m" -e "\033[0m"
bash ./tools/center -n -t "   Choice:  " -b "\033[41m" -e "\033[0m"
bash ./tools/center -t ""
read -d'' -s -n1 input

if [ "$input" == "s" ]
then
  bash ./rooms/room1.sh
elif [ "$input" == "q" ]
then
  clear
  exit
elif [ "$input" == "h" ]
  then
    bash ./Menus/helpMenu.sh
    exit
else
  clear
  echo
  bash ./tools/center -n -t "Not a vaild Option!" -b "\033[30;41m" -e "\033[0m"
  sleep 1
  bash ./Launch.sh
  exit
fi
