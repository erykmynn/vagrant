#!/bin/bash

IP_ADDRESS=$1
DOMAIN=$2
SCRIPT=$3

if [ -z "$DOMAIN" ]; then
  echo ""
  echo "Usage: install.sh {ip_address} {domain} [script.sh]"
  echo "ip_address: ip address of the virtual machine."
  echo "domain: domain name that will be used to access virtual machine (site.local)"
  echo ""
  exit 1
fi

# Install local site in hosts file.
HAS_SUDO=`command -v sudo 2>/dev/null`

# Locate hosts file.
if [ -f "/etc/hosts" ]; then
  FILE_HOSTS="/etc/hosts"
fi
if [ -f "/cygdrive/c/windows/system32/drivers/etc/hosts" ]; then
  FILE_HOSTS="/cygdrive/c/windows/system32/drivers/etc/hosts"
fi
if [ -z "$FILE_HOSTS" ]; then
  echo "Can not find hosts file."
  exit 1
fi
echo "Hosts file found at: $FILE_HOSTS"

# Check if hosts file has our site.local in it.
HOST_ENTRY=`cat $FILE_HOSTS | grep $DOMAIN`
if [ -z "$HOST_ENTRY" ]; then
  echo "Adding $DOMAIN to hosts file."
  if [ ! -z "$HAS_SUDO" ]; then
    sudo -- sh -c "echo '$IP_ADDRESS $DOMAIN' >> $FILE_HOSTS"
  else
    sh -c "echo '$IP_ADDRESS $DOMAIN' >> $FILE_HOSTS"
  fi
else
  echo "Host entry already found: $HOST_ENTRY"
fi

# Replace constants in Vagrantfile and puppet scripts.
git checkout Vagrantfile
git checkout puppet/manifests/init.pp
sed -i "" -e "s/33.33.33.66/$IP_ADDRESS/g" Vagrantfile
sed -i "" -e "s/site.local/$DOMAIN/g" Vagrantfile
sed -i "" -e "s/site.local/$DOMAIN/g" puppet/manifests/init.pp

# Build VM.
vagrant destroy --force
vagrant up

