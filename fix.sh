#!/bin/bash

#############################################################
# This script fix shh connection issue - permission denied  #
# Just Run it in the same directory                         #
# Made by Maksim Kulikov, 2022                              #
#############################################################

# COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Yellow='\033[0;33m'       # Yellow
Red='\033[0;31m'          # Red
# Other directives

# Start fixing
echo -e "$Yellow \n Start fixing... $Color_Off"
  exec 2>logs+errors
find . -type f -name '*.pem' -ctime -15 -exec cp {} ~/.ssh/ \;
sleep 1
find ~/.ssh/ -type f -name '*.pem' -ctime -15 -exec chmod 600 {} \;
find ~/.ssh/ -type f -name '*.pem' -ctime -15 -exec ssh-add {} ~/.ssh/ \;
  >&2
sleep 1
echo -e "$Red \n EXECUTE! $Color_Off"
