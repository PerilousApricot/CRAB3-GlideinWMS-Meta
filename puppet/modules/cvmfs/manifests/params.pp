# Class: cvmfs::params
#
# This class defines default parameters used by the main module class cvmfs
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to cvmfs class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class cvmfs::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'cvmfs',
  }

  $service = $::operatingsystem ? {
    default => 'cvmfs',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'cvmfs',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'cvmfs',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/cvmfs',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/cvmfs/default.local',
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
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/cvmfs',
    default                   => '/etc/sysconfig/cvmfs',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/cvmfs.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/cvmfs',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/cvmfs',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/cvmfs/cvmfs.log',
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

  ### my configs
  $user =  "cvmfs"
  $group = "cvmfs"
}
