#!/bin/bash

# (c) 2013, The MITRE Corporation.  All rights reserved.
# Source code distributed pursuant to license agreement.

PYBIN=`which python`

ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
echo -e "Architecture: $ARCH"

if [ $ARCH -ne '64' ]; then
    echo "** Non 64-bit system detected **"
    echo "These dependencies are for a 64-bit system."
    echo "Exiting.."
    exit
fi

# Using lsb-release because os-release not available on Ubuntu 10.04
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/redhat-release ]; then
    OS=$(cat /etc/redhat-release | sed 's/ Enterprise.*//')
    VER=$(cat /etc/redhat-release | sed 's/.*release //;s/ .*$//')
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

OS="$(tr "[:upper:]" "[:lower:]" <<< "$OS")"
VER="$(tr "[:upper:]" "[:lower:]" <<< "$VER")"

if [ "$OS" == 'ubuntu' ]
then
	echo "Installing Apache and mod-wsgi..."
	sudo apt-get -y install apache2 libapache2-mod-wsgi
	echo "Installing Build-Essential..."
	sudo apt-get -y install build-essential
	echo "Installing PCRE-dev..."
	sudo apt-get -y install libpcre3-dev
	echo "Installing Numactl..."
	sudo apt-get -y install numactl
	echo "Installing cURL..."
	sudo apt-get -y install curl
	echo "Installing zip, 7zip, and unrar..."
	sudo apt-get -y install zip p7zip-full unrar
	echo "Installing libpcap-dev..."
	sudo apt-get -y install libpcap-dev
	echo "Installing Python requirements..."
	sudo apt-get -y install python-simplejson python-pycurl python-dev python-pydot python-pyparsing python-yaml python-setuptools python-numpy python-matplotlib python-lxml
	echo "Installing UPX"
	sudo apt-get -y install upx
	echo "Installing M2Crypto"
	sudo apt-get -y install m2crypto
    echo "Installing local debs..."
    cd Ubuntu && sudo dpkg -i *.deb
    cd ..
# TODO: Need to test centos dependencies
# elif [ "$OS" == 'centos' ] || [ "$OS" == 'redhat' ]
elif [ "$OS" == 'red hat' ]
then
	echo "Installing Apache and mod-wsgi..."
	sudo yum install httpd mod_wsgi mod_ssl
	echo "Installing Build-Essential..."
	sudo yum install make gcc gcc-c++ kernel-devel
	echo "Installing PCRE-dev..."
	sudo yum install pcre pcre-devel
	echo "Installing cURL..."
	sudo yum install curl
	echo "Installing zip, 7zip, and unrar..."
	sudo yum install zip unzip gzip bzip2
	sudo rpm -i p7zip-9.20.1-2.el6.rf.x86_64.rpm
	sudo rpm -i unrar-4.2.3-1.el6.rf.x86_64.rpm
	echo "Installing libpcap-devel..."
	sudo yum install libpcap-devel
	echo "Installing Python requirements..."
	sudo yum install python-pycurl python-dateutil python-devel python-setuptools
	sudo yum install numpy matplotlib
    echo "Installing local rpms..."
    cd RedHat && sudo rpm -i *.rpm
    cd ..
else
	echo "Unknown distro!"
	echo -e "Detected: $OS $VER"
	exit
fi

echo "Installing MongoDB 2.6.1..."
sudo cp mongodb-linux-x86_64-2.6.1/bin/* /usr/local/bin/
echo "Dependency installations complete!"
