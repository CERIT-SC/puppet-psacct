class psacct (
  $enable      = $psacct::params::enable,
  $logging     = $psacct::params::logging,
  $etc_default = $psacct::params::etc_default,
  $logfile     = $psacct::params::logfile,
  $packages    = $psacct::params::packages,
  $service     = $psacct::params::service
) inherits psacct::params {

  validate_bool($enable)
  validate_bool($etc_default)

  class { 'psacct::install':
    packages => $packages,
  }

  class { 'psacct::config':
    enable      => $enable,
    logging     => $logging,
    etc_default => $etc_default,
  }

  class { 'psacct::service':
    service => $service,
    enable  => $enable,
    logfile => $logfile,
  }

  anchor { 'psacct::begin': ; }
    -> Class['psacct::install']
    -> Class['psacct::config']
    ~> Class['psacct::service']
    -> anchor { 'psacct::end': ; }
}
