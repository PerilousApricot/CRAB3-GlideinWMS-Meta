class cms-httpg-frontend (
    $deployment_repo   = params_lookup( 'deployment_repo' ),
    $scram_arch = params_lookup( 'scram_arch' ),
    $httpg_tag  = params_lookup( 'httpg_tag' ),
    $repo       = params_lookup( 'repo' ),
    $rpm_host   = params_lookup( 'rpm_host' ),
    $needed_software = params_lookup( 'needed_software' ),
    $httpg_install = params_lookup( 'httpg_install' ),
    $user       = params_lookup( 'user' ),
    $group      = params_lookup( 'group' ),
    $disable_mkauthmap_cron = params_lookup( 'disable_mkauthmap_cron' ),
    $disable_mkvomsmap_cron = params_lookup( 'disable_mkvomsmap_cron' ),
    $vomsmap_source = params_lookup( 'vomsmap_source' ),
    $authmap_source = params_lookup( 'authmap_source' ),
    $services_onboot = params_lookup( 'services_onboot' ),
    $crabserver_auth_source = params_lookup( 'services_onboot' ),
    $services_enabled = params_lookup( 'services_enabled' )
    ) inherits cms-httpg-frontend::params {
        include cms-httpg-base
        Class['cms-httpg-base'] -> Class['cms-httpg-frontend']
        # make dirs recursively
        file { "cms-httpg-frontend-dir":
            path => "$httpg_install/auth/wmcore",
            owner => "$user",
            group => "$group",
            ensure => "directory",
        }
        
        # InstallDev isn't idempotent, doublecheck things are in the right
        # place 
        $install_string =  "${deployment_repo}/admin/InstallDev -A $scram_arch -R cmsweb@$httpg_tag -s image -v $httpg_tag $repo -w $rpm_host -p \"${needed_software}\""
        exec { "cms-httpg-frontend-deploy":
            command => "${install_string} && /bin/echo 'Removing this file will trigger a puppet rerun. Command to install was ${install_string}' > ${httpg_install}/${httpg_tag}/puppet-dont-reinstall",
            cwd => "$httpg_install",
            require => [ File["cms-httpg-frontend-dir"] ],
            user => $user,
            creates => "${httpg_install}/${httpg_tag}/puppet-dont-reinstall"
        }
            
        # FIXME: split this into subclasses 
        if member($services_enabled, 'frontend') {
            
            if $disable_mkauthmap_cron {
                exec { "cms-httpg-frontend-remove-mkauthmap-cron":
                    command => "/usr/bin/crontab -l | /bin/grep -v '${httpg_install}/current/config/frontend/mkauthmap' | /usr/bin/crontab",
                    user => $user,
                    subscribe => Exec["cms-httpg-frontend-deploy"]
                }
            }
    
            if $disable_mkvomsmap_cron {
                exec { "cms-httpg-frontend-remove-mkvomsmap-cron":
                    command => "/usr/bin/crontab -l | /bin/grep -v '${httpg_install}/current/config/frontend/mkvomsmap' | /usr/bin/crontab",
                    user => $user,
                    subscribe => Exec["cms-httpg-frontend-deploy"]
                }
            }
            if $vomsmap_source {
                file { "${httpg_install}/state/frontend/etc/voms-gridmap.txt":
                    source => $vomsmap_source,
                    owner => $user,
                    subscribe => Exec["cms-httpg-frontend-deploy"]
                }
            }
            if $authmap_source {
                file { "${httpg_install}/state/frontend/etc/authmap.json":
                    source => $authmap_source,
                    owner => $user,
                    subscribe => Exec["cms-httpg-frontend-deploy"]
                }
            }/*
            if 0 { #member($services_onboot, 'frontend') {
                exec { "cms-httpg-frontend-start-onboot":
                    command => "/usr/bin/crontab -l | /bin/grep -v '${httpg_install}/current/config/frontend/manage start' | /usr/bin/crontab - && /bin/cat <(/usr/bin/crontab -l) <(/bin/echo '@reboot .  ${httpg_install}/current/config/admin/init.sh && /data/current/config/frontend/manage start') | /usr/bin/crontab -",
                    provider => 'shell',
                    user => $user,
                    require => Exec["cms-httpg-frontend-deploy"]
                }
                exec { "cms-httpg-frontend-start-frontend":
                    command => "/data/current/config/frontend/manage start",
                    user => $user,
                    require => Exec["cms-httpg-frontend-deploy"]
                }
            }*/
        } # endif frontend
        if member($services_enabled, 'crabserver') {
            file { "${httpg_install}/current/config/crabserver/config.py":
                content => template("cms-httpg-frontend/config.py.erb"),
                owner => '_sw',
                group => '_config',
                subscribe => Exec["cms-httpg-frontend-deploy"]
            }
            file { "${httpg_install}/auth/crabserver/CRABServerAuth.py":
                source => $crabserver_auth_source,
                subscribe => Exec["cms-httpg-frontend-deploy"]
            }
        }
}
