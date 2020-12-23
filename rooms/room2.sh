#!/bin/bash
# Arrays
layer=("┏━━━━━━━━━━━┓" "┃wwxwwwwwwww┃" "┃wwwwwwwwwww┃" "┃▒▒▒▒▒▒▒▒▒▒▒┃" "┃aaaaxaaaaaa┃" "┃aaaaaaaaaaa┃" "┃aaaaaaaaaaa┃" "┗━━━━┓a┏━━━━┛")
processThis=("w" "\\e[44m \\e[0m" "▒" "\\e[34m▒\\e[0m" "x" "\\e[31mx\\e[0m" "X" "\\e[31mW\\e[0m" "a" "\\e[30m \\e[0m")
hazardX=()
hazardY=()
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

this=()
preProcessMap() {
  for ((i=0; i <= $height; i++))
  do
    process=${layer[$i]}
    echo -e "\033[25;0f"
    if [[ "${layer[$i]}" == *x* ]]
    then
      Col=0
      Col=$(echo ${layer[$i]} | grep -aob 'x')
      Col=$(echo ${Col:0:1})
      Col=$[Col-1]
      hazardX+=($Col)
      hazardY+=($[i+1])
    fi
  done
}

processMap() {
  # echo -e "\033[25;0f"
  for ((i=0; i <= $height; i++))
  do
    process=${layer[$i]}
    for ((x=0; x <=${#processThis[@]}; x++))
    do
      I=$[x-1]
      process="${process//${processThis[I]}/${processThis[I+1]}}"
      # echo -e "\033[20;0f"
      # echo -e "\${#processThis[@]}: ${#processThis[@]}"
      # echo -e "\$x: $x"
      # echo -e "\$I: $I"
      # echo -e "\$process: $process"
    done
    layer[$i]="$process"
  done
}

render() {
  processMap
  yMod=1
  space=$(bash ./tools/center -r -t $layer)
  space=$[space+1]
  # bash ./tools/center -n -t " Bash Dungeon " -b "\033[47;3;31m" -e "\033[0m" -s -2
  echo -e "\033[1;40m    \033[0m"
  echo -e "\033[$[playerY-1+$yMod];${space}f${layer[$[playerY-2]]}"

  echo -e "\033[$[playerY+$[yMod]];${space}f${layer[$[playerY-1]]}"

  echo -e "\033[$[playerY+$[1+yMod]];${space}f${layer[$[playerY]]}"

  echo -e "\033[$[playerY+$yMod];$[playerX+$[space-1]]f@"
  # echo -e "\033[$[playerY-1];0f${layer[$[playerY-2]]}"
  #
  # echo -e "\033[$[playerY];0f${layer[$[playerY-1]]}"
  #
  # echo -e "\033[$[playerY+1];0f${layer[$[playerY]]}"
  #
  # echo -e "\033[$[playerY];$[playerX]f@"
  # if [ $debug -eq 1 ]
  # then
  #   echo -e "\033[20;0fLayer1:\t\t$[playerY-1+$yMod]"
  #   echo -e "\033[21;0fLayer2:\t\t$[playerY+$[yMod]]"
  #   echo -e "\033[22;0fLayer3:\t\t$[playerY+$[1+yMod]]"
  #   echo -e "\033[23;0fDrawn PlayerY:\t$[playerY+1+$yMod]"
  #   echo -e "\033[24;0fDrawn PlayerX:\t$[playerX+$[space-1]]"
  # fi
  # deprocessMap
}

preRender() {
  bash ./tools/center -n -t "BashDungeon" -b "\033[47;3;31m" -e "\033[0m"
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
  # echo -e "\033[20;0f\${#hazardX[@]}: ${#hazardX[@]}"
  moveFoward=35
  echo -e "\033[20;${moveFoward}f"
  echo -e "\033[${moveFoward}ChazardX: $hazardX"
  echo -e "\033[${moveFoward}ChazardX[@]: ${hazardX[@]}"
  echo -e "\033[${moveFoward}ChazardY: $hazardY"
  echo -e "\033[${moveFoward}ChazardY[@]: ${hazardY[@]}"
  I=0
  for i in ${hazardX[@]}
  do
    I=$[I+1]
    if [ $playerX -eq ${hazardX[$[I-1]]} ] && [ $playerY -eq ${hazardY[$[I-1]]} ]
    then
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
    echo -e "\033[$[height+$yMod];0f"
    # echo -e "height + yMod: $[height+$yMod]"
    echo -e "Lives: $lives"
    echo -e "PlayerX: $playerX "
    echo -e "PlayerY: $playerY "
    echo -e "width: $width"
    echo -e "height: $height"
    printf "Input: "
    # bash ./tools/center -n -t  "\033[${height};0f"
    # bash ./tools/center -n -t  "Lives: $lives"
    # bash ./tools/center -n -t  "PlayerX: $playerX "
    # bash ./tools/center -n -t  "PlayerY: $playerY "
    # bash ./tools/center -n -t  "width: $width"
    # bash ./tools/center -n -t "height: $height"
    # bash ./tools/center -t "Input: "
    read -d'' -s -n1 input
  else
    echo -e "\033[$[height+$yMod];0f"
    echo -e "Lives: $lives"
    printf "Input: "
    # echo -e "\033[$[height+$yMod];0f"
    # bash ./tools/center -n -s -24 -t "Lives: $lives"
    # bash ./tools/center -s -25 -t "Input: "
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
  preRender
  preProcessMap
}

Game() {
  while true
  do
    printf '\033[0;0H'
    handleInput
    hazards
    setPlayer $playerX $playerY
    boundries
    render
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
