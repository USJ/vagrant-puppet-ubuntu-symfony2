class php {
  # Make sure php5 is present
  package {'php5':
    ensure => '5.3.10-1ubuntu3.6',
  }

  package {'php-apc':
    ensure => '3.1.7-1',
    require => Package['php5'],
    notify  => Service['apache2'],
  }

  package {'php-pear':
    ensure => present,
    require => Package['php5'],
  }

  # List php enhancers modules
  $php_enhancers = [ 'php5-intl', 'php5-mysql', 'php5-fpm' ]
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