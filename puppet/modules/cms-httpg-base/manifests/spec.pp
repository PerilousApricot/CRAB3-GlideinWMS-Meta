# Class: cms-httpg-base::spec
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
class cms-httpg-base::spec inherits cms-httpg-base {

  # This just a test to override the arguments of an existing resource
  # Note that you can achieve this same result with just:
  # class { "cms-httpg-base": template => "cms-httpg-base/spec.erb" }

  File['cms-httpg-base.conf'] {
    content => template('cms-httpg-base/spec.erb'),
  }

}
