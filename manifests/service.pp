class psacct::service (
  $enable,
  $service,
  $logfile
) {
  $_ensure = $enable ? {
    true  => running,
    false => stopped,
  }

  service { $service:
    ensure => $_ensure,
    enable => $enable,

    #VH: we think the process accounting is working if
    #logfile has been changed recently and is not empty
    status => "perl -e 'exit((-z \"${logfile}\") || ((time-(stat(\"${logfile}\"))[9])>120))'",
  }
}
