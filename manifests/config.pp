# == Class bussmtp::config
#
# This class is called from bussmtp for service config.
#
class bussmtp::config {
  file { "${::bussmtp::service_name}.init":
    path   => "/etc/init.d/${::bussmtp::service_name}",
    mode   => '0755',
    source => "puppet:///modules/${module_name}/${::bussmtp::service_name}.init",
  }

  file { "${::bussmtp::service_name}configdir":
    ensure => directory,
    path   => "/etc/${::bussmtp::service_name}",
  }

  file { "${::bussmtp::service_name}.yaml":
    path    => "/etc/${::bussmtp::service_name}/${::bussmtp::service_name}.yaml",
    content => template("${::bussmtp::service_name}/${::bussmtp::service_name}.yaml.erb"),
    require => File[ "${::bussmtp::service_name}configdir" ],
  }

  logrotate::rule { "${::bussmtp::service_name}.logrotate":
    path          => "/var/log/${::bussmtp::service_name}/*.log",
    rotate        => 3,
    rotate_every  => 'day',
    missingok     => true,
    compress      => false,
    create        => true,
    sharedscripts => true,
  }

}
