#!/bin/bash
clear
bash ./center -n -t "┏━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┓" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃\e[1;30;40m   Movement:    \e[1;30;47m┃\e[1;30;40m     Misc:      \e[1;30;47m┃" -b "\033[1;30;47m" -e "\033[0m" -s 44
bash ./center -n -t "┣━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━┫" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Move Up:    w  ┃    You Are:    ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Move Left:  a  ┃      \e[0m @ \e[1;30;47m       ┃" -b "\033[1;30;47m" -e "\033[0m" -s 16
bash ./center -n -t "┃ Move Down:  s  ┃                ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Move Right: d  ┃                ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┣━━━━━━━━━━━━━━━━┫                ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃\e[1;30;40m  Other Keys:   \e[1;30;47m┃                ┃" -b "\033[1;30;47m" -e "\033[0m" -s 22
bash ./center -n -t "┣━━━━━━━━━━━━━━━━┫                ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃ Pause:      e  ┃                ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┣━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━┫" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┃        Hit 'b' to go back       ┃" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛" -b "\033[1;30;47m" -e "\033[0m"
bash ./center -n -t "              Choice:              " -b "\033[41m" -e "\033[0m"
bash ./center -t ""
read -d'' -s -n1 input

if [ "$1" == "Menu" ]
then
  if [ "$input" != "" ]
  then
    clear
    bash ./Menu.sh
    exit
  fi
else
  if [ $input == "b" ]
  then
    clear
    bash ./Launch.sh
    exit
  elif [ "$input" == 'r' ]
  then
    bash ./helpMenu.sh
    exit
  else
    clear
    echo
    bash ./center -n -t "Not a vaild Option!"
    sleep 1
    bash ./helpMenu.sh
    exit
  fi
fi
