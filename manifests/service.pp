# == Class bussmtp::service
#
# This class is meant to be called from bussmtp.
# It ensure the service is running.
#
class bussmtp::service {

  service { $::bussmtp::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  service { $::bussmtp::web_service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
