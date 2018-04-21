# Puppet Linux process accounting module

This module enables Linux process accounting.

### Requirements

Module has been tested on:

* Puppet 5.5
* Debian 7,8,9 and RHEL/CentOS 6,7 and SLES/SLED

Required modules:

* [puppetlabs-stdlib](https://github.com/puppetlabs/puppetlabs-stdlib)

# Quick Start

Setup process accouting

```puppet
include psacct
```

Full configuration options:

```puppet
class { 'psacct':
  enabled                 => true|false,  # enable state
  logging                 => 30,          # days to keep log history
  manage_etc_default_acct => true|false,  # modify /etc/default/acct
  logfile                 => '...',       # accounting log file
  packages                => [...],       # list of packages to install
  service                 => '...',       # service name
}
```

# Contributors

* Rob Ruma <robruma@gmail.com>
* Pat Riehecky <riehecky@fnal.gov>

***

CERIT Scientific Cloud, <support@cerit-sc.cz>
