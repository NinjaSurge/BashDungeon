#!/bin/bash

lives=3
layer=("┏━┛ ┗━┓" "┃     ┃" "┃     ┃" "┗━━━━━┛")
width=$layer
width=${#width}
height=${#layer[@]}

exitGame() {
  clear
  bash ./Launch.sh
  exit
}

map() {
 if [ "$1" == "center" ]
 then
   bash ./tools/center -n -t "\033[$[plwayerY-1];0f${layer[$playerY-2]}"
   bash ./tools/center -n -t "\033[${playerY};0f${layer[$playerY-1]}"
   bash ./tools/center -n -t "\033[$[playerY+1];0f${layer[$playerY]}"
   bash ./tools/center -n -t "\033[${playerY};${playerX}f@"
else
    echo -e "\033[$[playerY-1];0f${layer[$playerY-2]}"
    echo -e "\033[${playerY};0f${layer[$playerY-1]}"
    echo -e "\033[$[playerY+1];0f${layer[$playerY]}"
    echo -e "\033[${playerY};${playerX}f@"
  fi
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
  if [ $playerY -lt 2 ] && [ $playerX -ne $centerX ]
  then
    playerY=$[playerY+1]
  elif [ $playerY -gt $[height-1] ]
  then
    playerY=$[playerY-1]
  fi
}

nextRoom() {
  # Bottom Center Door
  if [ $playerX -eq $centerX ] && [ $playerY -eq 0 ]
  then
    bash ./rooms/room2.sh "room1"
    exit
  fi
}

handleInput() {
  if [ "$input" == 'q' ]
  then
    exitGame
  elif [ "$input" == 'r' ]
  then
    bash ./rooms/newRoom1.sh
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

information() {
  if [ "$1" == "debug" ]
  then
    echo -e "\033[${height};0f"
    echo -e "Lives: $lives"
    echo "PlayerX: $playerX "
    echo "PlayerY: $playerY "
    printf "Input: "
    read -d'' -s -n1 input
  else
    echo -e "\033[${height};0f"
    echo -e "Lives: $lives"
    printf "Input: "
    read -d'' -s -n1 input
  fi
}

preSetup() {
  clear
  if [ "$1" == "room2" ]
  then
    setPlayer 4 1
  else
    setPlayer 4 2
  fi
}

Game() {
  while true
  do
    printf '\033[0;0H'
    handleInput
    setPlayer $playerX $playerY
    boundries
    map # "center"
    nextRoom
    information "debug"
  done
}
preSetup $1
Game
