# psacct::config
#
# Private class to configure process accounting
#
# @summary Private class to configure process accounting
class psacct::config {
  assert_private()

  if $psacct::manage_etc_default_acct == true {
    $_enabled = bool2num($psacct::enabled)

    augeas { 'psacct::config::etc_default_acct':
      incl    => '/etc/default/acct',
      lens    => 'Shellvars.lns',
      context => '/files/etc/default/acct/',
      changes => [
        "set ACCT_ENABLE '\"${_enabled}\"'",
        "set ACCT_LOGGING '\"${psacct::logging}\"'"],
    }
  }
}
