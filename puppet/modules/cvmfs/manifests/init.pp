# = Class: cvmfs
#
# This is the main cvmfs class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, cvmfs class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $cvmfs_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, cvmfs main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $cvmfs_source
#
# [*source_dir*]
#   If defined, the whole cvmfs configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $cvmfs_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $cvmfs_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, cvmfs main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $cvmfs_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $cvmfs_options
#
# [*service_autorestart*]
#   Automatically restarts the cvmfs service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $cvmfs_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $cvmfs_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $cvmfs_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $cvmfs_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for cvmfs checks
#   Can be defined also by the (top scope) variables $cvmfs_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $cvmfs_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $cvmfs_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $cvmfs_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $cvmfs_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for cvmfs port(s)
#   Can be defined also by the (top scope) variables $cvmfs_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling cvmfs. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $cvmfs_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $cvmfs_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $cvmfs_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $cvmfs_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in cvmfs::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of cvmfs package
#
# [*service*]
#   The name of cvmfs service
#
# [*service_status*]
#   If the cvmfs service init script supports status argument
#
# [*process*]
#   The name of cvmfs process
#
# [*process_args*]
#   The name of cvmfs arguments. Used by puppi and monitor.
#   Used only in case the cvmfs process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user cvmfs runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $cvmfs_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $cvmfs_protocol
#
#
# See README for usage patterns.
#
class cvmfs (
        $my_class            = params_lookup( 'my_class' ),
        $source              = params_lookup( 'source' ),
        $source_dir          = params_lookup( 'source_dir' ),
        $source_dir_purge    = params_lookup( 'source_dir_purge' ),
        $template            = params_lookup( 'template' ),
        $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
        $options             = params_lookup( 'options' ),
        $version             = params_lookup( 'version' ),
        $absent              = params_lookup( 'absent' ),
        $disable             = params_lookup( 'disable' ),
        $disableboot         = params_lookup( 'disableboot' ),
        $monitor             = params_lookup( 'monitor' , 'global' ),
        $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
        $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
        $puppi               = params_lookup( 'puppi' , 'global' ),
        $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
        $firewall            = params_lookup( 'firewall' , 'global' ),
        $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
        $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
        $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
        $debug               = params_lookup( 'debug' , 'global' ),
        $audit_only          = params_lookup( 'audit_only' , 'global' ),
        $noops               = params_lookup( 'noops' ),
        $package             = params_lookup( 'package' ),
        $service             = params_lookup( 'service' ),
        $service_status      = params_lookup( 'service_status' ),
        $process             = params_lookup( 'process' ),
        $process_args        = params_lookup( 'process_args' ),
        $process_user        = params_lookup( 'process_user' ),
        $config_dir          = params_lookup( 'config_dir' ),
        $config_file         = params_lookup( 'config_file' ),
        $config_file_mode    = params_lookup( 'config_file_mode' ),
        $config_file_owner   = params_lookup( 'config_file_owner' ),
        $config_file_group   = params_lookup( 'config_file_group' ),
        $config_file_init    = params_lookup( 'config_file_init' ),
        $pid_file            = params_lookup( 'pid_file' ),
        $data_dir            = params_lookup( 'data_dir' ),
        $log_dir             = params_lookup( 'log_dir' ),
        $log_file            = params_lookup( 'log_file' ),
        $port                = params_lookup( 'port' ),
        $protocol            = params_lookup( 'protocol' ),
        $user                = params_lookup( 'user' ),
        $group               = params_lookup( 'group' ),
        ) inherits cvmfs::params {

            $bool_source_dir_purge=any2bool($source_dir_purge)
                $bool_service_autorestart=any2bool($service_autorestart)
                $bool_absent=any2bool($absent)
                $bool_disable=any2bool($disable)
                $bool_disableboot=any2bool($disableboot)
                $bool_monitor=any2bool($monitor)
                $bool_puppi=any2bool($puppi)
                $bool_firewall=any2bool($firewall)
                $bool_debug=any2bool($debug)
                $bool_audit_only=any2bool($audit_only)
                $bool_noops=any2bool($noops)

### Definition of some variables used in the module
                $manage_package = $cvmfs::bool_absent ? {
                    true  => 'absent',
                    false => $cvmfs::version,
                }

            $manage_service_enable = $cvmfs::bool_disableboot ? {
                true    => false,
                        default => $cvmfs::bool_disable ? {
                            true    => false,
                            default => $cvmfs::bool_absent ? {
                                true  => false,
                                false => true,
                            },
                        },
            }

            $manage_service_ensure = $cvmfs::bool_disable ? {
                true    => 'stopped',
                        default =>  $cvmfs::bool_absent ? {
                            true    => 'stopped',
                            default => 'running',
                        },
            }

            $manage_service_autorestart = $cvmfs::bool_service_autorestart ? {
                true    => Service[cvmfs],
                        false   => undef,
            }

            $manage_file = $cvmfs::bool_absent ? {
                true    => 'absent',
                        default => 'present',
            }

            if $cvmfs::bool_absent == true
                or $cvmfs::bool_disable == true
                    or $cvmfs::bool_disableboot == true {
                        $manage_monitor = false
                    } else {
                        $manage_monitor = true
                    }

            if $cvmfs::bool_absent == true
                or $cvmfs::bool_disable == true {
                    $manage_firewall = false
                } else {
                    $manage_firewall = true
                }

            $manage_audit = $cvmfs::bool_audit_only ? {
                true  => 'all',
                      false => undef,
            }

            $manage_file_replace = $cvmfs::bool_audit_only ? {
                true  => false,
                      false => true,
            }

            $manage_file_source = $cvmfs::source ? {
                ''        => undef,
                    default   => $cvmfs::source,
            }

            $manage_file_content = $cvmfs::template ? {
                ''        => undef,
                    default   => template($cvmfs::template),
            }

### Managed resources
            package { "fuse":
                name    => "fuse.x86_64",
                        ensure  => present,
            }

# we run cvmfs as a dedicated user
            group { "cvmfs":
                name => "group",
                     ensure => present,
                     system => true,
            }

            user { "cvmfs":
                name => "${cvmfs::user}",
                     ensure => present,
                     system => true,
                     gid => "${cvmfs::group}",
#groups => ["fuse"],
                     require => [Group["cvmfs"], Package["fuse"]],
                     managehome => false,
                     shell => '/sbin/nologin',
            }
            package { $cvmfs::package:
                ensure  => $cvmfs::manage_package,
                        noop    => $cvmfs::bool_noops,
                        notify  => Service["autofs"],
                        require => User["cvmfs"]
            }


# is above
#package { "cvmfs":
#    name    => "${cvmfs::params::cvmfs_package_name}",
#    ensure  => latest,
#  require => User["cvmfs"],
#notify  => Service["autofs"],
#}


## Run daily fsck
##
            file { '/etc/cron.daily/cvmfs_fsck_all':
                mode    => "0755",
                        owner   => "root",
                        group   => "root",
                        source  => "puppet:///modules/cvmfs/cvmfs_fsck_all",
                        ensure  => present,
                        require => Package["cvmfs"],
            }

## Files for talking to UW's CVMFS.
##
            file { "wisc_pubkey":
                path    => "/etc/cvmfs/keys/cms.hep.wisc.edu.pub",
                        mode    => "0644",
                        owner   => "root",
                        group   => "root",
                        source  => "puppet:///modules/cvmfs/cms.hep.wisc.edu.pub",
                        ensure  => present,
                        require => Package["cvmfs"],
            }

            file { "wisc_conf":
                path    => "/etc/cvmfs/config.d/cms.hep.wisc.edu.conf",
                        mode    => "0644",
                        owner   => "root",
                        group   => "root",
                        source  => "puppet:///modules/cvmfs/cms.hep.wisc.edu.conf",
                        ensure  => present,
                        require => Package["cvmfs"],
            }

## Files for talking to OSG's CVMFS.
##
            file { "osg_pubkey":
                path    => "/etc/cvmfs/keys/oasis.opensciencegrid.org.pub",
                        mode    => "0644",
                        owner   => "root",
                        group   => "root",
                        source  => "puppet:///modules/cvmfs/oasis.opensciencegrid.org.pub",
                        ensure  => present,
                        require => Package["cvmfs"],
            }

            file { "osg_conf":
                path    => "/etc/cvmfs/config.d/oasis.opensciencegrid.org.conf",
                        mode    => "0644",
                        owner   => "root",
                        group   => "root",
                        source  => "puppet:///modules/cvmfs/oasis.opensciencegrid.org.conf",
                        ensure  => present,
                        require => Package["cvmfs"],
            }

            file { "default.local":
                        path    => "${cvmfs::config_file}",
                        mode    => "0644",
                        owner   => "root",
                        group   => "root",
                        source  => "puppet:///modules/cvmfs/default.local",
                        require => Package["cvmfs"],
                        ensure  => present,
            }

### Files for talking to CERN Belle
# FIXME: Should edit domain.d/cern.ch to only include mirrors that host all
#        CVMFS repos, then create config.d/cms.cern.ch.conf with additional
#        mirror URLs.
            file { "/etc/cvmfs/config.d/belle.cern.ch.conf":
                mode    => "0644",
                        owner   => "root",
                        group   => "root",
                        source  => "puppet:///modules/cvmfs/belle.cern.ch.conf",
                        ensure  => present,
                        require => Package["cvmfs"],
            }

## Files for making CMS CVMFS work.
##
            file { "SITECONF_dir":
                path    => "/etc/cvmfs/SITECONF",
                        mode    => "0644", owner => "root", group => "root",
                        recurse => true,
                        ensure  => directory,
                        require => Package["cvmfs"],
            }

            file { "JobConfig_dir":
                path    => "/etc/cvmfs/SITECONF/JobConfig",
                        mode    => "0644", owner => "root", group => "root",
                        recurse => true,
                        ensure  => directory,
                        require => File["SITECONF_dir"],
            }

            file { "site-local-config.xml":
                path    => "/etc/cvmfs/SITECONF/JobConfig/site-local-config.xml",
                        source  => "puppet:///modules/cvmfs/site-local-config.xml",
                        mode    => "0644", owner => "root", group => "root",
                        ensure  => present,
                        require => File["JobConfig_dir"],
            }

            file { "PhEDEx_dir":
                path    => "/etc/cvmfs/SITECONF/PhEDEx",
                        mode    => "0644", owner => "root", group => "root",
                        recurse => true,
                        ensure  => directory,
                        require => File["SITECONF_dir"],
            }

            file { "PhEDEx_storage.xml":
                path    => "/etc/cvmfs/SITECONF/PhEDEx/storage.xml",
                        source  => "puppet:///modules/cvmfs/PhEDEx_storage.xml",
                        mode    => "0644", owner => "root", group => "root",
                        ensure  => present,
                        require => File["PhEDEx_dir"],
            }

## Use FNAL stratum one
##
            file { "FNAL_stratum_one":
                path    => "/etc/cvmfs/domain.d/cern.ch.local",
                        source  => "puppet:///modules/cvmfs/cern.ch.local",
                        mode    => "0644", owner => "root", group => "root",
                        ensure  => present,
                        require => Package["cvmfs"],
            }

            file { "fuse.conf":
                path    => "/etc/fuse.conf",
                        mode    => "0644",
                        owner   => "root",
                        group   => "root",
                        source  => "puppet:///modules/cvmfs/fuse.conf",
                        ensure  => present,
            }

            file { "cvmfs_cache":
                path    => "/var/cache/cvmfs2",
                        ensure  => directory,
                        owner   => "cvmfs",
                        group   => "cvmfs",
                        mode    => 0700,
                        require => [User["cvmfs"], Group["cvmfs"], Package["cvmfs"]],
            }

# The whole cvmfs configuration directory can be recursively overriden
            if $cvmfs::source_dir {
                file { 'cvmfs.dir':
                    ensure  => directory,
                            path    => $cvmfs::config_dir,
                            require => Package[$cvmfs::package],
                            notify  => $cvmfs::manage_service_autorestart,
                            source  => $cvmfs::source_dir,
                            recurse => true,
                            purge   => $cvmfs::bool_source_dir_purge,
                            force   => $cvmfs::bool_source_dir_purge,
                            replace => $cvmfs::manage_file_replace,
                            audit   => $cvmfs::manage_audit,
                            noop    => $cvmfs::bool_noops,
                }
            }


### Include custom class if $my_class is set
            if $cvmfs::my_class {
                include $cvmfs::my_class
            }


### Provide puppi data, if enabled ( puppi => true )
            if $cvmfs::bool_puppi == true {
                $classvars=get_class_args()
                    puppi::ze { 'cvmfs':
                        ensure    => $cvmfs::manage_file,
                                  variables => $classvars,
                                  helper    => $cvmfs::puppi_helper,
                                  noop      => $cvmfs::bool_noops,
                    }
            }


### Service monitoring, if enabled ( monitor => true )
            if $cvmfs::bool_monitor == true {
                if $cvmfs::port != '' {
                    monitor::port { "cvmfs_${cvmfs::protocol}_${cvmfs::port}":
                        protocol => $cvmfs::protocol,
                                 port     => $cvmfs::port,
                                 target   => $cvmfs::monitor_target,
                                 tool     => $cvmfs::monitor_tool,
                                 enable   => $cvmfs::manage_monitor,
                                 noop     => $cvmfs::bool_noops,
                    }
                }
                if $cvmfs::service != '' {
                    monitor::process { 'cvmfs_process':
                        process  => $cvmfs::process,
                                 service  => $cvmfs::service,
                                 pidfile  => $cvmfs::pid_file,
                                 user     => $cvmfs::process_user,
                                 argument => $cvmfs::process_args,
                                 tool     => $cvmfs::monitor_tool,
                                 enable   => $cvmfs::manage_monitor,
                                 noop     => $cvmfs::bool_noops,
                    }
                }
            }


### Debugging, if enabled ( debug => true )
            if $cvmfs::bool_debug == true {
                file { 'debug_cvmfs':
                    ensure  => $cvmfs::manage_file,
                            path    => "${settings::vardir}/debug-cvmfs",
                            mode    => '0640',
                            owner   => 'root',
                            group   => 'root',
                            content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
                            noop    => $cvmfs::bool_noops,
                }
            }
                autofs::mount{ '/cvmfs':
                map => '/etc/auto.cvmfs'}
                notify { "suck it, andre":}
                package { "cvmfs-keys":
                    name    => "cvmfs-keys",
                            ensure  => present,
                            require => Package["cvmfs"],
                }
    } 
