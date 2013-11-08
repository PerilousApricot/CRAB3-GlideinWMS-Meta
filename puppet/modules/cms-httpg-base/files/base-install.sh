#!/bin/bash
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
chown -R vagrant:vagrant /tmp/foo
su -- vagrant cfg/Deploy -t dummy -s post $PWD system/devvm
rm -rf /tmp/foo/cfg
