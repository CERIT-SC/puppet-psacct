class psacct::params {
  $enabled = true
  $logging = 30

  case $facts['os']['name'] {
    'Debian', 'Ubuntu': {
      $packages = ['acct']
      $service = 'acct'
      $etc_default = true
      $logfile = '/var/log/account/pacct'
    }

    'Fedora', 'RedHat', 'CentOS', 'Scientific', 'OracleLinux': {
      $packages = ['psacct']
      $service = 'psacct'
      $etc_default = false
      $logfile = '/var/account/pacct'
    }

    'SLES', 'SLED': {
      $packages = ['acct']
      $service = 'acct'
      $etc_default = false
      $logfile = '/var/account/pacct'
    }

    default: {
      fail("Unsupported OS: ${facts['os']['name']}")
    }
  }
}
