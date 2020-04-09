#!/bin/bash

#            __ _      _    _   
#  _ __ ___ / _| | ___| | _| |_ 
# | '__/ _ \ |_| |/ _ \ |/ / __|
# | | |  __/  _| |  __/   <| |_ 
# |_|  \___|_| |_|\___|_|\_\\__|
# Author: Kwest Ambani                             
# Created: 02.07.19

# download latest pacman mirrorlist
sudo curl -o /etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/

# copy clean mirrorlist to backup
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrolist.bak

# use reflector to pick the fastest mirrors
sudo reflector --verbose -c 'Australia' -f 10 -l 50 --sort rate --save /etc/pacman.d/mirrorlist

echo ''
echo 'Reflekt complete. Now using the fastest pacman mirrors'

