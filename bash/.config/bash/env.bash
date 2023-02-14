#!/bin/bash
#
# Environmental variables for bash
#

# Use neovim as the default editor, if available
[ -x "$(command -v nvim)" ] && export EDITOR='nvim'
