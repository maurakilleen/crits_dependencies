#!/bin/bash

ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
echo -e "Architecture: $ARCH"

if [ $ARCH -ne '64' ]; then
    echo "** Non 64-bit system detected **"
    echo "These dependencies are for a 64-bit system."
    echo "Exiting.."
    exit
fi

# Using lsb-release because os-release not available in 10.04
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/redhat-release ]; then
    OS=$(cat /etc/redhat-release | sed 's/ release.*//')
    VER=$(cat /etc/redhat-release | sed 's/.*release //;s/ .*$//')
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

OS="$(tr [:upper:] [:lower:] <<< "$OS")"
VER="$(tr [:upper:] [:lower:] <<< "$VER")"

echo "Operating System: $OS"
echo "Version: $VER"
