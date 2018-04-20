# psacct::config
#
# Private class to configure process accounting
#
# @summary Private class to configure process accounting
class psacct::config {
  assert_private()

  if $psacct::etc_default == true {
    $_enabled = bool2num($psacct::enabled)

    augeas { 'etc_default_acct':
      incl    => '/etc/default/acct',
      lens    => 'Shellvars.lns',
      context => '/files/etc/default/acct/',
      changes => [
        "set ACCT_ENABLE  '\"${_enabled}\"'",
        "set ACCT_LOGGING '\"${psacct::logging}\"'"],
    }
  }
}
