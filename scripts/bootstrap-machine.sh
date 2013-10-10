#!/bin/bash

# Some silly tasks that have to be done as root when bootstrapping

TARGET_USER='vagrant'
INSTALL_DIR='/data'

while getopts "u-:d-:" optchar; do
    case "${optchar}" in
        u) TARGET_USER="$OPTARG" ;;
        d) INSTALL_DIR="$OPTARG" ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
done

echo "Beginning bootstrap"

if [[ ! -d $INSTALL_DIR ]]; then
    mkdir -p $INSTALL_DIR
fi

echo "Installing basic grid deps"
yum install -y yum-priorities
rpm -Uvh http://repo.grid.iu.edu/osg-el6-release-latest.rpm
yum install -y --nogpgcheck osg-wn-client osg-ca-certs
/sbin/chkconfig fetch-crl-boot on
/sbin/chkconfig fetch-crl-cron on

echo "Installing CMS-required system packages"
# FIXME: This is hardcoded, figure out how to pull from the driver
# http://cmsrep.cern.ch/cmssw/comp.pre/slc5_amd64_gcc461-driver.txt
yum install -y glibc coreutils bash tcsh zsh perl tcl tk readline openssl ncurses e2fsprogs krb5-libs freetype compat-readline5 ncurses-libs perl-libs perl-ExtUtils-Embed fontconfig compat-libstdc++-33 libidn libX11 libXmu libSM libICE libXcursor libXext libXrandr libXft mesa-libGLU mesa-libGL e2fsprogs-libs libXi libXinerama libXft libXrender libXpm libcom_err

# FIXME: This is needed for some reason because of:
#error: Failed dependencies:
#        perl(Test::Harness) is needed by external+mod_perl2+2.0.7-1-1.x86_64
#        perl(Test::More) is needed by external+mod_perl2+2.0.7-1-1.x86_64
#E: Sub-process /data/cmsweb-install/install/sw.pre/slc5_amd64_gcc461/external/apt/429-comp/bin/rpm-wrapper returned an error code (18)
yum install -y perl-Test-Harness

# get cron
command -v cron /dev/null 2>&1 && {
    # and very very stripped down VM images don't have cron
    yum install -y cronie
}
# get condor
command -v condor_q >/dev/null 2>&1 && {
    echo "Installing condor"
    wget http://research.cs.wisc.edu/htcondor/yum/repo.d/htcondor-stable-rhel6.repo
    mv htcondor-stable-rhel6.repo /etc/yum/repos.d
    yum install -y condor
    service condor start
    /sbin/chkconfig condor on
}

# get puppet
command -v puppet >/dev/null 2>&1 && {
    curl https://raw.github.com/hashicorp/puppet-bootstrap/master/centos_6_x.sh | bash
}

chown $TARGET_USER $INSTALL_DIR
if [[ "X" = "X$@" ]]; then
    echo "Done with the root stuff, appears nothing else is here"
    exit 0
else
    echo "Done as root, continuing on as user $TARGET_USER"
    set -x
    set -e
    su $TARGET_USER -c $@
    exit $?   
fi

echo "If we got here, something terrible happened"
exit 1
