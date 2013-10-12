#!/bin/bash
#        tk compat-libstdc++-33 'ca_*' dummy-ca-certs lcg-CA \
#        fetch-crl edg-mkgridmap git-all stgit colordiff libXpm-devel finger \
#        $(yum -q list compat-{readline5,libtermcap} perl-ExtUtils-Embed 2>/dev/null | \
#          grep -v -e '^Installed' -e '^Available' | awk '{print $1}')
#
#      # Install myproxy and voms tools as there is no slc6 build for it in AFS.
#      # Only gets the voms configuration from AFS.
#      sudo yum -y install myproxy
#      sudo rsync -cavu \
#        /afs/cern.ch/project/gd/LCG-share/current/glite/etc/vomses/ /etc/vomses/
#      sudo rsync -cavu \
#        /afs/cern.ch/project/gd/LCG-share/current/external/etc/grid-security/vomsdir/ \
#        /etc/grid-security/vomsdir/
#      sudo chown -R root:root /etc/vomses /etc/grid-security/vomsdir
#

set -x
rm -rf /tmp/foo
mkdir -p /tmp/foo
cd /tmp/foo
(git clone git://github.com/dmwm/deployment.git cfg && cd cfg && git reset --hard HG1305a)
sudo -l  # this is so the following won't prompt
for THING in "      sudo rsync -cavu" "      sudo wget -q -O /etc/yum.repos.d/egi-trustanchors.repo" "        http://repository.egi.eu/sw/production/cas/1/current/repo-files/egi-trustanchors.repo" "        /afs/cern.ch/project/gd" "        /etc/grid-security/vomsdir/"; do
	perl -p -i -e "s!^$THING!#$THING!" cfg/system/deploy
done
perl -p -i -e "s!dummy-ca-certs lcg-CA!!" cfg/system/deploy
perl -p -i -e  "s#'ca_\*'##" cfg/system/deploy
cfg/Deploy -t dummy -s post $PWD system/devvm
