# Puppet Linux process accounting module

This module installs and enables Linux process accounting.

### Requirements

Module has been tested on:

* Puppet 3.2
* Debian 6,7 and RHEL/CentOS 6

Required modules:

* stdlib (https://github.com/puppetlabs/puppetlabs-stdlib)

# Quick Start

Setup process accouting

    include psacct

Full configuration options:

    class { 'psacct':
	  enabled     => true|false,  # enable state
	  logging     => 30,          # days to keep log history
	  etc_default => true|false,  # modify /etc/default/acct
	  logfile     => '...',       # accounting log file
	  packages    => [...],       # list of packages to install
	  service     => '...',       # service name
    }
