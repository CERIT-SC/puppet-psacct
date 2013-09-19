class psacct::service (
  $enabled,
  $service,
  $logfile
) {
  $_ensure = $enabled ? {
    true  => running,
    false => stopped,
  }

  service { $service:
    ensure => $_ensure,
    enable => $enabled,

    #VH: we think the process accounting is working if
    #logfile has been changed recently and is not empty
    status => "perl -e 'exit((-z \"${logfile}\") || ((time-(stat(\"${logfile}\"))[9])>120))'",
  }
}
