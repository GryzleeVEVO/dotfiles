#!/bin/sh

case $1 in
simulate)
    stow --simulate --target=$HOME */
    ;;

restow)
    stow --restow --target=$HOME */
    ;;
*)
    stow --target=$HOME */
    ;;
esac
