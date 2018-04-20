# psacct::install
#
# Private class to (un)install process accounting packages
#
# @summary Private class to (un)install process accounting packages
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
