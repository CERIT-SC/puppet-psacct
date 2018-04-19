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
