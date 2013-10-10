# import all the interesting classes. Assume the config comes from hiera

node default {
    # Don't add any parameters here, set them in hiera
    include autofs
    include cvmfs
}
