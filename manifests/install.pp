class psacct::install (
  $packages
) {
  package { $packages:
    ensure => installed,
  }
}
