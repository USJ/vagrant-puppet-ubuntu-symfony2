class php {
  # Make sure php5 is present
  package {'php5':
    ensure => present,
  }

  # List php enhancers modules
  $php_enhancers = [ 'php5-intl', 'php-apc', 'php5-mysql' ]
  # Make sure the php enhancers are installed
  package { $php_enhancers:
    ensure  => installed,
    require => Package['php5'],
    notify  => Service['apache2'],
  }

  # Create a php config file that meets the symfony2 requirements
  file {'symfony2-php-conf':
    ensure  => present,
    path    => '/etc/php5/conf.d/symfony2-php-conf.ini',
    owner   => 'root',
    group   => 'root',
    content => template('php/symfony2-php-conf.erb'),
    require => Package['php5'],
  }
}