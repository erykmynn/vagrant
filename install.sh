#!/bin/bash

IP_ADDRESS=$1
DOMAIN=$2
DOCROOT=$3
SCRIPT=$3

if [ -z "$DOCROOT" ]; then
  echo ""
  echo "Usage: install.sh {ip_address} {domain} {/full/path/docroot} [script.sh]"
  echo "ip_address: ip address of the virtual machine."
  echo "domain: domain name that will be used to access virtual machine (site.local)"
  echo "docroot: full path to the document root inside the virtual machine"
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
sed -i "" -e "s/site.local/$DOCROOT/g" Vagrantfile
sed -i "" -e "s/site.local/$DOMAIN/g" puppet/manifests/init.pp

# Build VM.
vagrant destroy --force
vagrant up

# Run custom script inside the virtual machine.
PORT=`vagrant ssh-config | grep Port | grep -o '[0-9]\+'`
chmod 600 ~/.vagrant.d/insecure_private_key
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.vagrant.d/insecure_private_key vagrant@localhost -p $PORT 'bash -s' < scripts/vm-setup.sh
# Run any custom script specified by command line call.
if [ ! -z "$SCRIPT" ]; then
  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.vagrant.d/insecure_private_key vagrant@localhost -p $PORT 'bash -s' < $SCRIPT
fi

# Restore the repository to its normal state.
git reset --hard HEAD

