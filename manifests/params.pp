# == Class bussmtp::params
#
# This class is meant to be called from bussmtp.
# It sets variables according to platform.
#
class bussmtp::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'bussmtp'
      $service_name = 'bussmtp'
    }
    'RedHat', 'Amazon': {
      $package_name = 'bussmtp'
      $service_name = 'bussmtp'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
