This is intended to be included as a submodule in another project, providing a standardized VM for LAMP project development.

1. Create a project directory: `mkdir mywebsite && cd mywebsite`
2. Clone this repo: `git clone git://github.com/delphian/vagrant.git`
3. Create the html document root `mkdir site`
4. Put an example html file into the document root `echo "<h1>Hello World!</h1>" > site/index.html`
5. Run the installation script `./install.sh`

The installation script will attempt to update the hosts file so that site.local will resolve to 33.33.33.36 (the IP of the VM).

Open a browser and hit the new website: http://site.local
