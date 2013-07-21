This is intended to be included as a submodule in another project, providing a
standardized Virtual Machine for LAMP project development. The virtual machine
shares the directory which serves the html pages (public_html) with the host
system, allowing editing of the files on the host system.

The shared directory `../public_html` is expected to be found (outside of this
repository) and must be provided by the containing repository or project. See
[Vagrant Drupal 7](https://github.com/delphian/vagrant-drupal-7) for an example
of a project making use of this vagrant submodule.

#### Prerequisites ####

1. Download and install install virtualbox for [Windows](http://download.virtualbox.org/virtualbox/4.2.6/VirtualBox-4.2.6-82870-Win.exe) or [Mac](http://download.virtualbox.org/virtualbox/4.2.6/VirtualBox-4.2.6-82870-OSX.dmg).
2. Download and install vagrant for [Windows](http://files.vagrantup.com/packages/476b19a9e5f499b5d0b9d4aba5c0b16ebe434311/Vagrant.msi) or [Mac](http://files.vagrantup.com/packages/476b19a9e5f499b5d0b9d4aba5c0b16ebe434311/Vagrant.dmg)
3. If you use Windows please download and install [Cygwin](http://cygwin.com/setup.exe). See [Cygwin Setup](http://cygwin.com/cygwin-ug-net/setup-net.html#setup-packages) for help. Make sure to install ssh and git packages.

#### Installation ####

Copy and paste this into your shell to install everything:

```
curl -s https://raw.github.com/delphian/vagrant/master/scripts/bootstrap.sh | bash
```

Installation script will:

 * Create a virtual box on 33.33.33.36
 * Modify hosts file mapping site.local to 33.33.33.36

Or install manually by:

 * `git clone --recursive git://github.com/delphian/vagrant.git`
 * `cd vagrant`
 * `./install.sh 33.33.33.36 site.local` install.sh {ip address} {domain} [script.sh to run inside vm].

#### Usage ####

After installation script is finished open a browser and navigate to http://site.local

#### Database management ####

SequelPro may be used to access the mysql server inside vagrant:

 * Use the key located at : ~/.vagrant.d/insecure_private_key
 * Configure the ip address to : 33.33.33.66

#### Normal ssh ####

A normal ssh session can be invoked with the following commands:

```
PORT=`vagrant ssh-config | grep Port | grep -o '[0-9]\+'`
chmod 600 ~/.vagrant.d/insecure_private_key
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.vagrant.d/insecure_private_key vagrant@localhost -p $PORT
```
