#!/bin/sh
 
# Executing the following line in the shell will automatically
# download and install https://github.com/delphian/vagrant:
# curl -s https://raw.github.com/delphian/vagrant/master/scripts/bootstrap.sh | bash

echo ""
echo "Bootstrap is preparing directory structure and sample files..."
mkdir mywebsite && cd mywebsite
mkdir public_html
echo "<h1>Hello World</h1>" > public_html/index.html
echo ""
echo "Bootstrap is installing virtual machine with vagrant..."
echo "Cloning repository https://github.com/marcelovani/vagrant..."
echo ""
git clone --recursive git://github.com/marcelovani/vagrant.git
cd vagrant/scripts
./install.sh 33.33.33.36 site.local /var/www/site.local 256
echo "Bootstrap has finished installation."
echo ""

