class xdebug { 

  package { "php5-xdebug":
    ensure => installed,
    require => [
      Package['php-pear'],
      Package['php5-dev'],
    ],
    notify => Service["apache2"],
  }

  file { "/etc/php5/apache2/conf.d/xdebug.ini":
    owner => "root",
    group => "root",
    mode => 444,
    content => "xdebug.default_enable = On\nxdebug.show_exception_trace = Off\nxdebug.show_local_vars = 1\nxdebug.var_display_max_depth = 6\nxdebug.dump_once = On\nxdebug.dump_globals = On\nxdebug.dump_undefined = On\nxdebug.dump.REQUEST = *\nxdebug.dump.SERVER = REQUEST_METHOD,REQUEST_URI,HTTP_USER_AGENT\n",
    notify => Service["apache2"],
    require => Package["libapache2-mod-php5"]
  }

}
