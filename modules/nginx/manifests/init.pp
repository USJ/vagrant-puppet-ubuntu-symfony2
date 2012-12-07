class nginx {
    package { 'nginx':
        ensure => present,
    }

	file { 'www.conf':
	    path    => '/etc/php5/fpm/pool.d/www.conf',
		owner  => root,
		group  => root,
		force  => true,
		ensure => present,
	    content => template('nginx/www.erb'),
		require => Package['nginx'],
	}

	file { 'myusj.conf':
	    path    => '/etc/nginx/conf.d/myusj.conf',
		owner  => root,
		group  => root,
		force  => true,
		ensure => present,
	    content => template('nginx/myusj.erb'),
	    notify  => Package['nginx'],
	}
}