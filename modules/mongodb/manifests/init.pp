class mongodb {
    package { 'mongodb':
        ensure => '1:2.0.4-1ubuntu2',
    }
}