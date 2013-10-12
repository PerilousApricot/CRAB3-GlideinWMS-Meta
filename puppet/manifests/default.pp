# import all the interesting classes. Assume the config comes from hiera

node default {
    # Don't add any parameters here, set them in hiera
    include autofs
    # Can the following be set in hiera?
    class { 'yum':
        my_class => 'site::my_yum',
    }
    include cvmfs
    include cms-httpg-base
    #Yum::Managedyum_repo <| |> -> Package <| provider != 'rpm' |>
    Yumrepo  <| |> -> Package <| provider != 'rpm' |>
}
