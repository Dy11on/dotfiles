#!/bin/bash

#download latest mirrors
sudo curl -o /etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/

#make backup
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlistbackup

sudo reflector -c 'United States' --latest 100 --sort rate --protocol https --save /etc/pacman.d/mirrorlist

echo "88888888"
echo "Done ;0"
