class php {

  package { "php5-curl":
    require => [
      Package['curl'],
      EXEC["enable-mod-php5"],
    ],
    notify => Service["apache2"],
  }

}