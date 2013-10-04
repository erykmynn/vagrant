#!/bin/bash

# Setup a few things inside the virtual machine.

# Copy hosts public and private keys into virtual machine.
echo 'Copying system host keys into virtual machine'
cp -r ~/.ssh/host/* ~/.ssh

cd /var/www
sudo rm -rf html
sudo ln -s /vagrant/Websites Websites

