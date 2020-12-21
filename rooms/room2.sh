#!/bin/bash
# Arrays
layer=("┏━━━━━━━━━━━┓" "┃wwwwwwwwwww┃" "┃wwwwwwwwwww┃" "┃▒▒▒▒▒▒▒▒▒▒▒┃" "┃   h       ┃" "┃           ┃" "┃           ┃" "┗━━━━┓ ┏━━━━┛")
processThis=("w" "\\e[44m \\e[0m" "▒" "\\e[34m▒\\e[0m" "h" "\\e[31mh\\e[0m")
hazardX=(2 5)
hazardY=(2 5)
# misc
lives=3
width=$layer
width=${#width}
height=${#layer[@]}
debug=1

exitGame() {
  clear
  bash ./Launch.sh
  exit
}


processMap() {
  echo -e "\033[20;0f"
  for ((i=0; i <= $height; i++))
  do
    process=${layer[$i]}
    process="${process//${processThis[0]}/${processThis[1]}}"
    process="${process//${processThis[2]}/${processThis[3]}}"
    process="${process//${processThis[4]}/${processThis[5]}}"
    layer[$i]="$process"
    if [ $debug -eq 1 ]
    then
      echo -e "$process"
    fi
  done
}

deprocessMap() {
  # echo -e "\033[20;0f"
  for ((i=0; i <= $height; i++))
  do
    process=${layer[$i]}
    process="${process//${processThis[5]}/${processThis[4]}}"
    process="${process//${processThis[3]}/${processThis[2]}}"
    process="${process//${processThis[1]}/${processThis[0]}}"
    layer[$i]="$process"
    # if [ $debug -eq 1 ]
    # then
    #   echo -e "$process"
    # fi
  done
}

map() {
  processMap
    echo -e "\033[$[playerY-1];0f${layer[$playerY-2]}"
    echo -e "\033[${playerY};0f${layer[$playerY-1]}"
    echo -e "\033[$[playerY+1];0f${layer[$playerY]}"
    echo -e "\033[${playerY};${playerX}f@"
  deprocessMap
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
  for i in ${#hazardX[@]}
  do
    ix=${hazardX[i-1]}
    echo -e "\033[18;0fix: $ix"
    iy=${hazardY[i-1]}
    echo -e "\033[19;0fiy: $iy"
    if [ $playerX -eq $ix ] && [ $playerY -eq $iy ]
    then
      # echo "$playerX $ix"
      # echo "$playerY $iy"
      lives=$[lives-1]
    fi
  done
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

information() {
  if [ $debug -eq 1 ]
  then
    echo -e "\033[${height};0f"
    echo -e "Lives: $lives"
    echo "PlayerX: $playerX "
    echo "PlayerY: $playerY "
    echo "width: $width"
    echo "height: $height"
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
    hazards
    setPlayer $playerX $playerY
    boundries
    map # "center"
    nextRoom
    information
    if [ $lives -lt 1 ]
    then
      bash ./Menus/gameOver.sh
      exit
    fi
    # clear
  done
}
preSetup $1
Game
