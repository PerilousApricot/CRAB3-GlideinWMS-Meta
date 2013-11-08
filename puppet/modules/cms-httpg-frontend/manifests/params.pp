# Class: cms-httpg-frontend::params
#
# This class defines default parameters used by the main module class cms-httpg-frontend
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to cms-httpg-frontend class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class cms-httpg-frontend::params {
    $deployment_repo   = '/data/cfg'
    $scram_arch = 'slc6_amd64_gcc481'
    $httpg_tag  = "HG1310f"
    $repo       = ""
    $rpm_host   = "cmsrep.cern.ch"
    $frontend_version = ""
    $httpg_install = "/data"
    $user = "vagrant"
    $group = "vagrant"
    $disable_mkauthmap_cron = 0
    $disable_mkvomsmap_cron = 0
    $authmap_source = ""
    $vomsmap_source = ""
    $services_onboot = ""
}
