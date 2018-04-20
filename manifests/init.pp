# psacct
#
# Install, configure and start the process accounting.
#
# @summary Manage process accounting.
#
# @param enabled Enable state.
# @param logging Days to keep log history.
# @param etc_default Enable modification of /etc/default/acct.
# @param logfile Accounting log file.
# @param packages List of packages to install.
# @param service Service name.
#
# @example
#   include psacct
class psacct (
  Boolean $enabled              = $psacct::params::enabled,
  Integer $logging              = $psacct::params::logging,
  Boolean $etc_default          = $psacct::params::etc_default,
  Stdlib::Absolutepath $logfile = $psacct::params::logfile,
  Array[String[1], 1] $packages = $psacct::params::packages,
  String[1] $service            = $psacct::params::service
) inherits psacct::params {

  contain psacct::install
  contain psacct::service

  if $enabled {
    contain psacct::config

    Class['psacct::install']
      -> Class['psacct::config']
      ~> Class['psacct::service']

    Class['psacct::install']
      ~> Class['psacct::service']
  } else {
    Class['psacct::service']
      -> Class['psacct::install']
  }
}
