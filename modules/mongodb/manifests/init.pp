class mongodb {
    package { 'mongodb':
        ensure => '1:2.0.4-1ubuntu2',
    }

    # Make sure mongodb is running
    service {'mongodb':
        ensure  => running,
        # Make sure mongodb is installed before checking
        require => Package['mongodb'],
    }

    # Install PHP driver for mongo
    exec { 'php-mongo-driver':
        command => 'sudo pecl install mongo',
        path    => '/usr/bin/',
        require => [ Package['apache2'], Package['php5'], Package['php-pear'] ],
        notify  => Service['apache2'],
    }

    # Enable PHP driver for mongo
    file {'mongo-driver-enable':
        ensure  => present,
        path    => '/etc/php5/conf.d/mongo-driver-enable.ini',
        owner   => 'root',
        group   => 'root',
        content => 'extension=mongo.so',
        require => [ Package['apache2'], Package['php5'] ],
        notify  => Service['apache2'],
    }

    # mongodb.conf file, allows connection from host
    file {'mongodb-conf':
        ensure  => present,
        path    => '/etc/mongodb.conf',
        owner   => 'root',
        group   => 'root',
        content => template('mongodb/mongodb.conf.erb'),
        require => Package['mongodb'],
        notify  => Service['mongodb'],
    }
}