class apache {
  # Make sure apache is present
  package {'apache2':
    ensure => '2.2.22-1ubuntu1.3',
  }

  # Make sure apache is running
  service {'apache2':
    ensure  => running,
    # Make sure apache is installed before checking
    require => Package['apache2'],
  }

  # Create the logs folder to put the log files of the vhost
  file {'myusj-vhost-logs':
    ensure => 'directory',
    path   => '/srv/www/myusj/logs',
  }

  # Create a virtual host file for our website
  file {'myusj-vhost':
    ensure  => present,
    path    => '/etc/apache2/sites-available/myusj.conf',
    owner   => 'root',
    group   => 'root',
    content => template('apache/vhost.erb'),
    # Make sure apache is installed before creating the file
    require => [ Package['apache2'], File ['myusj-vhost-logs'] ],
  }

  # Enable our virtual host
  file {'myusj-vhost-enable':
    ensure  => link,
    path    => '/etc/apache2/sites-enabled/myusj.conf',
    target  => '/etc/apache2/sites-available/myusj.conf',
    # Make sure apache and the vhost file are there before symlink
    require => [ Package['apache2'], File['myusj-vhost'] ],
    # Notify apache to restart
    notify  => Service['apache2'],
  }

  # Replace the apache user to vagrant
  file {'apache-envvars':
    ensure  => present,
    path    => '/etc/apache2/envvars',
    owner   => 'root',
    group   => 'root',
    content => template('apache/envvars.erb'),
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  exec { 'apache_lockfile_permissions':
    command => 'chown -R vagrant:www-data /var/lock/apache2',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }
}