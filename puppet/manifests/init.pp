import "classes/*.pp"
$site_domain = "site.local"
$mysql_password = "root"

group { "puppet":
  ensure => "present",
}


exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
Exec["apt-update"] -> Package <| |>

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  source => "/vagrant/puppet/manifests/files/motd.txt"
}
file { '/home/vagrant/.bash_profile':
  source => "/vagrant/puppet/manifests/files/bash_profile.txt"
}

package { 'vim': ensure => present }
package { 'git-core': ensure => present }
package { 'rubygems': ensure => present }
package { 'unzip': ensure => present }
package { 'curl' : ensure => present }
package { 'php5-memcached' : ensure => present }
package { 'php-apc' : ensure => present }

include apache
include mysql::server
include drupal
include pear
include xdebug
include xhprof
include postfix
include php
include libssh2
include memcached

# Install the site.
apache::site { $site_domain:
  documentroot => ""
}


file { '/var/www/${site_domain}':
  owner => 'vagrant',
  group => 'www-data',
  mode => 0777,
  recurse => true,
}
