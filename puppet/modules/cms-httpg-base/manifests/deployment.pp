class cms-httpg-base (
  $user  = params_lookup( 'user' ),
  $group = params_lookup( 'group' )
  ) inherits cms-httpg-base::params {
  file { "cms-httpg-base-bootstrap-file":
	ensure => file,
	path => '/tmp/cms-httpg-base-bootstrap.sh',
	source => 'puppet:///modules/cms-httpg-base/base-install.sh',
  }
  exec { "cms-httpg-base-bootstrap":
            command => "/tmp/xxcms-httpg-base-bootstrap.sh",
	    require => File['cms-httpg-base-bootstrap-file'],
	    unless  => "/bin/grep '_frontend' /etc/passwd | /bin/grep 'CMSWEB Front-End'",
		 }
}
