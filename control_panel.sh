#!/bin/bash

# https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
# https://github.com/dysfunc/ascii-emoji

PS3='=> What to do? '
PSNEXT='=> What to do next? '

options=("Start" "Tail logs" "Update" "Connect" "Generate all" "Stop" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Start")
            echo "(∩｀-´)⊃━☆ﾟ.*･｡ﾟ"
            docker rm -f diagrams-wrapper; docker compose up -d --force-recreate
            ;;
        "Tail logs")
            echo "(っ▀¯▀)つ"
            docker logs -f diagrams-wrapper
            ;;
        "Update")
            echo "ヽ( •_)ᕗ"
            docker compose pull
            echo "Image pulled, restart (1) is needed!"
            ;;
        "Connect")
            echo "ح(•̀ж•́)ง † "
            docker exec -w /diagrams-data -it diagrams-wrapper /bin/ash -l
            ;;
        "Generate all")
            echo "ヽ(´ー｀)ノ"
            docker exec diagrams-wrapper sh -c '/bin/sh /diagrams-scripts/runall.sh'
            ;;
        "Stop")
            echo "(╯°□°）╯︵ ┻━┻"
            docker rm -f diagrams-wrapper
            echo "Stopped!"
            ;;
        "Exit")
            echo "¯\_(⊙︿⊙)_/¯"
            break
            ;;
        *)
          echo "t(-_-t)"
          echo "Invalid option: $REPLY";;
    esac
    PS3=$PSNEXT
done