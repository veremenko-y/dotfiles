#!/bin/bash -i
echo "====================================="
echo "Explicitly update packages on log in"
echo "====================================="
read -p "Press enter to continue"
echo ""
echo "### Checking pacman and AUR"
yay
echo "### Checking flatpak"
flatpak update
echo ""
echo "====================================="
echo " Update check complete. Press any key"
echo "====================================="
read -s -n 1
