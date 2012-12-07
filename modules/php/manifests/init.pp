class php {
  # Make sure php5 is present
  package {'php5':
    ensure => '5.3.10-1ubuntu3.4',
  }
  package {'php5-fpm':
    ensure => installed,
  }
  package {'php-apc':
    ensure => '3.1.7-1',
    require => Package['php5'],
    notify  => Service['apache2'],
  }

  service {'php5-fpm':
    ensure => running,
    require => Package['php5-fpm']
  }

  # List php enhancers modules
  $php_enhancers = [ 'php5-intl', 'php5-mysql', 'php-pear' ]
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

  exec { 'pecl install mongo':
    notify => Service["php5-fpm"],
    command => '/usr/bin/pecl install --force mongo',
    logoutput => "on_failure",
    require => [Package[$php_enhancers]],
    before => [File['symfony2-php-conf']],
    unless => "/usr/bin/php -m | grep mongo",
  }

  exec { 'pear config-set auto_discover 1':
    command => '/usr/bin/pear config-set auto_discover 1',
    require => Package[$php_enhancers],
  }

}