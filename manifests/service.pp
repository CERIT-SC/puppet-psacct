class psacct::service {
  assert_private()

  $_ensure = $psacct::enabled ? {
    true  => running,
    false => stopped,
  }

  # we think the process accounting is working correctly
  # if logfile has changed recently and is not empty
  exec { 'psacct::service::check':
    command => '/bin/true',  # dummy command, we need the exec for notify
    unless  => "perl -e 'exit((-z \"${psacct::logfile}\") || ((time-(stat(\"${psacct::logfile}\"))[9])>120))'",
    path    => '/bin:/usr/bin:/sbin:/usr/sbin',
    notify  => Service[$psacct::service],
  }

  service { $psacct::service:
    ensure => $_ensure,
    enable => $psacct::enabled,
  }
}
