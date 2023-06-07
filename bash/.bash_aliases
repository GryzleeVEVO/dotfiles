#!/bin/bash

# Useful defaults

# Some aliases use GNU-specific flags
if [[ $(uname) == Linux ]]; then

    alias ls='ls --color=auto --human-readable --group-directories-first'
    alias l='ls'
    alias la='ls --all'
    alias ll='ls --all -l'

fi
