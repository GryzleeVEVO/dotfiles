#!/bin/sh

DIRS=$(ls -d */)

case $1 in
simulate)
    stow --simulate --target=$HOME ${DIRS}
    ;;

restow)
    stow --restow --target=$HOME ${DIRS}
    ;;
*)
    stow --target=$HOME ${DIRS}
    ;;
esac

stow --restow --target=$HOME
