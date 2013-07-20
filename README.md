This is intended to be included as a submodule in another project, providing a standardized VM for LAMP project development.

### Prerequisites
1. Download and install install virtualbox for [Windows](http://download.virtualbox.org/virtualbox/4.2.6/VirtualBox-4.2.6-82870-Win.exe) or [Mac](http://download.virtualbox.org/virtualbox/4.2.6/VirtualBox-4.2.6-82870-OSX.dmg).
2. Download and install vagrant for [Windows](http://files.vagrantup.com/packages/476b19a9e5f499b5d0b9d4aba5c0b16ebe434311/Vagrant.msi) or [Mac](http://files.vagrantup.com/packages/476b19a9e5f499b5d0b9d4aba5c0b16ebe434311/Vagrant.dmg)
3. If you are on windows please download and install [Cygwin](http://cygwin.com/setup.exe). See [Cygwin Setup](http://cygwin.com/cygwin-ug-net/setup-net.html#setup-packages) for help. Make sure to install ssh and git packages.

### Installation instructions
1. Open bash and create a project directory: `mkdir mywebsite && cd mywebsite`
2. Clone this repo: `git clone git://github.com/delphian/vagrant.git`
3. Create the html document root `mkdir public_html`
4. Put an example html file into the document root `echo "<h1>Hello World!</h1>" > site/index.html`
5. Run the installation script `cd vagrant && ./install.sh`

The installation script will attempt to update the hosts file so that site.local will resolve to 33.33.33.66 (the IP of the VM).

Open a browser and hit the new website: http://site.local
