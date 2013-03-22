class project {
    $utils = [ 'curl', 'git', 'acl', 'vim' ]
    # Make sure some useful utiliaries are present
    package {$utils:
        ensure => present,
    }

    Exec {
        path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
    }

    include apache
    include php
    include nginx
    include mongodb
}

include project