class psacct::install {
  assert_private()

  $_ensure = $psacct::enabled ? {
    true  => present,
    false => absent
  }

  package { $psacct::packages:
    ensure => $_ensure,
  }
}
