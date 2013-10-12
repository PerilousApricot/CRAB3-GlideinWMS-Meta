# Class: cms-httpg-base::params
#
# This class defines default parameters used by the main module class cms-httpg-base
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to cms-httpg-base class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class cms-httpg-base::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'cms-httpg-base',
  }

  $service = $::operatingsystem ? {
    default => 'cms-httpg-base',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'cms-httpg-base',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'cms-httpg-base',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/cms-httpg-base',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/cms-httpg-base/cms-httpg-base.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/cms-httpg-base',
    default                   => '/etc/sysconfig/cms-httpg-base',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/cms-httpg-base.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/cms-httpg-base',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/cms-httpg-base',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/cms-httpg-base/cms-httpg-base.log',
  }

  $port = '42'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}
