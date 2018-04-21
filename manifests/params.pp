# psacct::params
#
# Private class with module parameters
#
# @summary Private class with module parameters
class psacct::params {
  $enabled = true
  $logging = 30

  case $facts['os']['name'] {
    'Debian', 'Ubuntu': {
      $packages = ['acct']
      $service = 'acct'
      $manage_etc_default_acct = true
      $logfile = '/var/log/account/pacct'
    }

    'Fedora', 'RedHat', 'CentOS', 'Scientific', 'OracleLinux': {
      $packages = ['psacct']
      $service = 'psacct'
      $manage_etc_default_acct = false
      $logfile = '/var/account/pacct'
    }

    'SLES', 'SLED': {
      $packages = ['acct']
      $service = 'acct'
      $manage_etc_default_acct = false
      $logfile = '/var/account/pacct'
    }

    default: {
      fail("Unsupported OS: ${facts['os']['name']}")
    }
  }
}
