# Puppet module: cms-httpg-base

This is a Puppet module for cms-httpg-base based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-cms-httpg-base

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install cms-httpg-base with default settings

        class { 'cms-httpg-base': }

* Install a specific version of cms-httpg-base package

        class { 'cms-httpg-base':
          version => '1.0.1',
        }

* Disable cms-httpg-base service.

        class { 'cms-httpg-base':
          disable => true
        }

* Remove cms-httpg-base package

        class { 'cms-httpg-base':
          absent => true
        }

* Enable auditing without without making changes on existing cms-httpg-base configuration *files*

        class { 'cms-httpg-base':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'cms-httpg-base':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'cms-httpg-base':
          source => [ "puppet:///modules/example42/cms-httpg-base/cms-httpg-base.conf-${hostname}" , "puppet:///modules/example42/cms-httpg-base/cms-httpg-base.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'cms-httpg-base':
          source_dir       => 'puppet:///modules/example42/cms-httpg-base/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'cms-httpg-base':
          template => 'example42/cms-httpg-base/cms-httpg-base.conf.erb',
        }

* Automatically include a custom subclass

        class { 'cms-httpg-base':
          my_class => 'example42::my_cms-httpg-base',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'cms-httpg-base':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'cms-httpg-base':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'cms-httpg-base':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'cms-httpg-base':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-cms-httpg-base.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-cms-httpg-base]
