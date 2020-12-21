#!/bin/bash
clear
bash ./center -n -t "First Time? try the Help Menu"
bash ./center -n -t "Welcome to"
bash ./center -n -t "Bash Dungeon Crawler"
bash ./center -n -t "┏━━━━━━━━━━┓" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Options: ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┣━━━━━━━━━━┫" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Start: s ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Help:  h ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Quit:  q ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┗━━━━━━━━━━┛" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "   Choice:  " -b "\033[41m" -e "\033[0m"
bash ./center -t ""
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
    bash ./helpMenu.sh
    exit
else
  clear
  echo
  bash ./center -n -t "Not a vaild Option!"
  sleep 1
  bash ./Launch.sh
  exit
fi
