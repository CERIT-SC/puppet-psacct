class psacct::params {
  $enabled = true
  $logging = 30

  case $::operatingsystem {
    debian,ubuntu: {
      $packages = ['acct']
      $service = 'acct'
      $etc_default = true
      $logfile = '/var/log/account/pacct'
    }

    fedora,redhat,centos,scientific,oraclelinux: {
      $packages = ['psacct']
      $service = 'psacct'
      $etc_default = false
      $logfile = '/var/account/pacct'
    }

    sles,sled: {
      $packages = ['acct']
      $service = 'acct'
      $etc_default = false
      $logfile = '/var/account/pacct'
    }

    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }
}
