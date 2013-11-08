class cms-gridcert (
    $generate_missing = params_lookup( 'generate_missing' ),
    $ca_cert = params_lookup( 'ca_cert' ),
    $ca_key  = params_lookup( 'ca_key' ),
    ) inherits cms-gridcert::params {
    # Either loads a cert from somewhere or generates a newone
    if $generate_missing {
        exec { "cms-gridcert-makehost-key":
            provider => "shell",
            command => "openssl genrsa -out /etc/grid-security/hostkey.pem 1024",
            creates => "/etc/grid-security/hostkey.pem",
            subscribe => [File[ "/etc/grid-security/dummy-signing-ca-cert.pem"],
                          File["/etc/grid-security/dummy-signing-ca-key.pem"]]
        }
        file { "/etc/grid-security/dummy-signing-ca-cert.pem":
            source => $ca_cert,
        }
        file { "/etc/grid-security/dummy-signing-ca-key.pem":
            source => $ca_key,
        }
        exec { "cms-gridcert-makehost-cert":
            provider => "shell",
            command => "openssl req -new -key /etc/grid-security/hostkey.pem \
                        -subj /DC=ch/DC=cern/OU=computers/CN=${::fqdn} | \
                        openssl x509 -req -days 365 \
                        -signkey /etc/grid-security/hostkey.pem \
                        -out /etc/grid-security/hostcert.pem \
                        -CA /etc/grid-security/dummy-signing-ca-cert.pem \
                        -CAkey /etc/grid-security/dummy-signing-ca-key.pem \
                        -CAcreateserial",
            creates => "/etc/grid-security/hostcert.pem",
            subscribe => [ Exec["cms-gridcert-makehost-key"] ]
        }
    }



}
