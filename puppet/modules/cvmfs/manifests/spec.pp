# Class: cvmfs::spec
#
# This class is used only for rpsec-puppet tests
# Can be taken as an example on how to do custom classes but should not
# be modified.
#
# == Usage
#
# This class is not intended to be used directly.
# Use it as reference
#
class cvmfs::spec inherits cvmfs {

  # This just a test to override the arguments of an existing resource
  # Note that you can achieve this same result with just:
  # class { "cvmfs": template => "cvmfs/spec.erb" }

  File['cvmfs.conf'] {
    content => template('cvmfs/spec.erb'),
  }

}
