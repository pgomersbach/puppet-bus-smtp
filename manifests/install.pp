# == Class bussmtp::install
#
# This class is called from bussmtp for install.
#
class bussmtp::install {

  package { $::bussmtp::package_name:
    ensure   => present,
    provider => 'gem',
  }
}
