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
      $web_package_name = 'apache2'
      $web_service_name = 'apache2'
    }
    'RedHat', 'Amazon': {
      $package_name = 'bussmtp'
      $service_name = 'bussmtp'
      $web_package_name = 'httpd'
      $web_service_name = 'httpd'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
