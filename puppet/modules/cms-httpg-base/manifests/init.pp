class cms-httpg-base (
  $user  = params_lookup( 'user' ),
  $group = params_lookup( 'group' )
  ) inherits cms-httpg-base::params {
  exec { "cms-httpg-base-bootstrap":
            command => "puppet:///modules/cms-httpg-base/base-install.sh" }
}
