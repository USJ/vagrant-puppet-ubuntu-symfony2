class project {

  # Make sure apache is present
  package {'apache2':
    ensure => present,
  }

  # Make sure apache is running
  service {'apache2':
    ensure  => running,
    # Make sure apache is installed before checking
    require => Package['apache2'],
  }

  # Create a virtual host file for our website
  file {'ums2-vhost':
    ensure  => present,
    path    => '/etc/apache2/sites-available/vagrant.conf',
    owner   => 'root',
    group   => 'root',
    content => template('project/vhost.erb'),
    # Make sure apache is installed before creating the file
    require => Package['apache2'],
  }

  # Enable our virtual host
  file {'ums2-vhost-enable':
    ensure  => link,
    path    => '/etc/apache2/sites-enabled/vagrant.conf',
    target  => '/etc/apache2/sites-available/vagrant.conf',
    # Make sure apache and the vhost file are there before symlink
    require => [ Package['apache2'], File['ums2-vhost'] ],
    # Notify apache to restart
    notify  => Service['apache2'],
  }

  # Replace the apache user to vagrant
  file {'apache-envvars':
    ensure  => present,
    path    => '/etc/apache2/envvars',
    owner   => 'root',
    group   => 'root',
    content => template('project/envvars.erb'),
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

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
    content => template('project/symfony2-php-conf.erb'),
    require => Package['php5'],
  }

  $utils = [ 'curl', 'git', 'acl', 'vim' ]
  # Make sure some useful utiliaries are present
  package {$utils:
    ensure => present,
  }
}

include project