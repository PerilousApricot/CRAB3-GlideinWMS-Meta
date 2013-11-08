# import all the interesting classes. Assume the config comes from hiera
node 'common' {
    # Make root partitions larger than default
    logical_volume { "LogVol00":
        ensure => present,
	    volume_group => "VolGroup",
	    size => "10G"
    }
    exec { "expandRoot":
	    command => "/sbin/resize2fs /dev/VolGroup/LogVol00",
	    unless => '/bin/df | grep 10321208'
    }
    Logical_Volume['LogVol00'] -> Exec['expandRoot']
    include cms-gridcert
}
node 'frontend.local' inherits 'common' {
    # Don't add any parameters here, set them in hiera
    include autofs
    include cvmfs
    include cms-httpg-base
    include cms-httpg-frontend
    Class['cms-gridcert'] ~> Class['cms-httpg-base']
    Class['cms-httpg-base'] ~> Class['cms-httpg-frontend']
}
node 'backend.local' {
    include autofs
    include cvmfs
    physical_volume { "/dev/sda2":
	ensure => present
    }
    volume_group { "VolGroup":
	ensure => present,
	physical_volumes => "/dev/sda2",
    }
    logical_volume { "extraSwap":
	ensure => present,
	volume_group => "VolGroup",
	size => "1600M"
    }
    exec { "formatSwap":
	command => "/sbin/mkswap /dev/VolGroup/extraSwap || true",
	unless => "/sbin/swapon -s | /bin/grep 1638392",
    }
    exec { "addSwap":
	command => "/sbin/swapon /dev/VolGroup/extraSwap",
	unless => "/sbin/swapon -s | /bin/grep 1638392",
    }
    Physical_Volume['/dev/sda2'] -> Logical_Volume['extraSwap'] -> Exec['formatSwap'] -> Exec['addSwap']
    class { 'oracle-xe' :
    	password => 'veryinsecure',
    	require => Exec['addSwap']
    }
    Yumrepo  <| |> -> Package <| provider != 'rpm' |>
}
