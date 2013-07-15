class psacct::config (
  $enable,
  $logging,
  $etc_default
) {
  if $etc_default == true {
    $_enable = bool2num($enable)

    augeas { 'etc_default_acct':
      context => '/files/etc/default/acct/',
      changes => [
        "set ACCT_ENABLE  '\"${_enable}\"'",
        "set ACCT_LOGGING '\"${logging}\"'"],
    }
  }
}
