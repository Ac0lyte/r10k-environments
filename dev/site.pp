hiera_include('classes')

# The dev environment...
# Or so they say.
$users = {
  'tschaller@localhost' => {
    ensure                   => 'present',
    max_connections_per_hour => '0',
    max_queries_per_hour     => '0',
    max_updates_per_hour     => '0',
    max_user_connections     => '0',
    password_hash            => '*04E417EA5B78A9981E2E9F7559EA596A3E8227A8',
  },
}

$grants = {
  'tschaller@localhost/*.*' => {
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ['ALL'],
    table      => '*.*',
    user       => 'tschaller@localhost',
  },
}

node default {
}

node 'admin-dev01.l-0-1424471637-kqqjd9kq97' {
  #include 'puppet-icinga2'
  #include '::mysql::server'

  class { '::mysql::server':
    root_password           => 'starcraft',
    old_root_password       => '',
    remove_default_accounts => true,
    users                   => $users,
    grants                  => $grants,
  }


#  mysql_user { 'tschaller@localhost':
#    ensure                   => 'present',
#    max_connections_per_hour => '0',
#    max_queries_per_hour     => '0',
#    max_updates_per_hour     => '0',
#    max_user_connections     => '0',
#  }

#  mysql_grant { 'tschaller@localhost/*.*':
#    ensure     => 'present',
#    privileges => ['ALL'],
#    table      => '*.*',
#    user       => 'tschaller@localhost',
#  }
}
