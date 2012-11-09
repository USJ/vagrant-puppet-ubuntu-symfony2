class project {
  $utils = [ 'curl', 'git', 'acl', 'vim' ]
  # Make sure some useful utiliaries are present
  package {$utils:
    ensure => present,
  }

  include apache
  include php
}

include project