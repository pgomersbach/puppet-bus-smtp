# == Class bussmtp::install
#
# This class is called from bussmtp for install.
#
class bussmtp::install {

  $packages = [
    $::bussmtp::web_package_name,
    'git',
    'ruby'
  ]
  ensure_packages($packages)

  # create /opt
  file { '/opt':
    ensure => directory,
  }

  # clone bussmtp repo
  vcsrepo { '/opt/bussmtp':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/pgomersbach/bus-smtp.git',
    require  => File['/opt'],
  }

  # install application gems
  package { [ 'mini-smtp-server', 'net-ping' ]:
    ensure   => installed,
    provider => gem,
  }
}
