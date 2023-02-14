#!/bin/bash
# History configuration for bash

# Number of remembered commands
HISTSIZE=1000
HISTFILESIZE=2000

# Ignore duplicates, delete leading whitespaces
HISTCONTROL=ignoreboth

# Append new entries instead of overwriting after exit
shopt -s histappend

# If no match with !, return prompt with command 
shopt -s histreedit

# If command has history substitution, don't execute inmediately
shopt -s histverify