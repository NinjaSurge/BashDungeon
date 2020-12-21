#!/bin/bash

exitGame() {
  clear
  bash ./Launch.sh
  exit
}

map() {
  echo "┏━┛ ┗━┓"
  echo "┃     ┃"
  echo "┃     ┃"
  echo "┗━━━━━┛"
  # bash ./tools/center -n -t "┏━┛ ┗━┓"
  # bash ./tools/center -n -t "┃     ┃"
  # bash ./tools/center -n -t "┃     ┃"
  # bash ./tools/center -n -t "┗━━━━━┛"
}

boundries() {
  if [ $playerX -lt 2 ]
  then
    playerX=$[playerX+1]
  elif [ $playerX -gt 6 ]
  then
    playerX=$[playerX-1]
  fi
  if [ $playerY -lt 2 ] && [ $playerX -ne 4 ]
  then
    playerY=$[playerY+1]
  elif [ $playerY -gt 3 ]
  then
    playerY=$[playerY-1]
  fi
}

nextRoom() {
  if [ $playerX -eq 4 ] && [ $playerY -eq 0 ]
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
    bash ./rooms/room1.sh
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
  fi
}

setPlayer() {
  playerX=$1
  playerY=$2
  printf "\033[${playerY};${playerX}H@"
}

handlePlayer() {
  handleInput
  boundries
  setPlayer $playerX $playerY
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
    map
    handlePlayer
    nextRoom
    echo -e "\033[8;0f"
    echo "PlayerX: $playerX"
    echo "PlayerY: $playerY"
    printf "Input: "
    read -d'' -s -n1 input
    clear
  done
}
preSetup $1
Game
