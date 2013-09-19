class psacct::install (
  $packages,
  $enabled
) {
  $_ensure = $enabled ? {
    true  => present,
    false => absent
  }

  package { $packages:
    ensure => $_ensure,
  }
}
