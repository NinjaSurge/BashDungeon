#!/bin/bash

lives=3

layer=("┏━━━━━━━━━━━┓" "┃\033[44m           \033[0m┃" "┃\033[44m           \033[0m┃" "┃\033[34m▒▒▒▒▒▒▒▒▒▒▒\033[0m┃" "┃           ┃" "┃           ┃" "┃           ┃" "┗━━━━┓ ┏━━━━┛")
width=$layer
width=${#width}
height=${#layer[@]}

exitGame() {
  clear
  bash ./Launch.sh
  exit
}

map() {
  echo -e "\033[$[playerY-1];0f${layer[$playerY-2]}"
  echo -e "\033[${playerY};0f${layer[$playerY-1]}"
  echo -e "\033[$[playerY+1];0f${layer[$playerY]}"
  echo -e "\033[${playerY};${playerX}f@"
}

boundries() {
  centerX=$[$[width+1]/2]
  # X wall handling
  if [ $playerX -eq 1 ]
  then
    playerX=$[playerX+1]
  elif [ $playerX -eq $width ]
  then
    playerX=$[playerX-1]
  fi
  # Y wall handling
  if [ $playerY -lt 2 ]
  then
    playerY=$[playerY+1]
  elif [ $playerY -gt $[height-1] ] && [ $playerX -ne $centerX ]
  then
    playerY=$[playerY-1]
  fi
}

nextRoom() {
  # Bottom Center Door
  if [ $playerX -eq $centerX ] && [ $playerY -eq $[height+1] ]
  then
    bash ./rooms/room1.sh "room2"
    exit
  fi
}

hazards() {
  if [ $playerX -eq 4 ] && [ $playerY -eq 2 ]
  then
    bash ./gameOver.sh
    exit
  fi
}

handleInput() {
  if [ "$input" == 'q' ]
  then
    exitGame
  elif [ "$input" == 'r' ]
  then
    bash ./rooms/room2.sh
    exit
  elif [ "$input" == 'w' ]
  then
    playerY=$[playerY-1]
  elif [ "$input" == 's' ]
  then
    playerY=$[playerY+1]
  elif [ "$input" == 'd' ]
  then
    playerX=$[playerX+1]
  elif [ "$input" == 'a' ]
  then
    playerX=$[playerX-1]
  elif [ "$input" == 'e' ]
  then
    bash ./Menus/Menu.sh
  fi
}

setPlayer() {
  playerX=$1
  playerY=$2
  # printf "\033[${playerY};${playerX}f@"
}

preSetup() {
  clear
  if [ "$1" == "room1" ]
  then
    setPlayer 7 8
  else
    setPlayer 7 7
  fi
}

Game() {
  while true
  do
    printf '\033[0;0H'
    handleInput
    setPlayer $playerX $playerY
    boundries
    map
    nextRoom
    # hazards
    echo -e "\033[${height};0f"
    echo -e "Lives: $lives"
    echo "PlayerX: $playerX "
    echo "PlayerY: $playerY "
    printf "Input: "
    read -d'' -s -n1 input
    # clear
  done
}
preSetup $1
Game
