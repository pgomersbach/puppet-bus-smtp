# == Class: bussmtp
#
# Full description of class bussmtp here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class bussmtp
(
  $package_name = $::bussmtp::params::package_name,
  $service_name = $::bussmtp::params::service_name,
) inherits ::bussmtp::params {

  # validate parameters here

  class { '::bussmtp::install': } ->
  class { '::bussmtp::config': } ~>
  class { '::bussmtp::service': } ->
  Class['::bussmtp']
}
