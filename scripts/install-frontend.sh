#
# Script to get a working, single-user, mysql deploy of as many services as possible
#   Things (like single-user) are technically cheating, but this script is intended to:
#      1) Be testable. Single-user stuff is *much* easier to hook up to jenkins
#      2) Be iterated. Once we get one variant working, the others are easier to follow
#
cd /data


###### CONFIG 
# TODO: MAKE THIS CONFIGURABLE
set -x
set -e
export http_proxy="http://fs1.accre.vanderbilt.edu:3128"
REPO_DEPLOYMENT_PATH=/vagrant/repos/deployment
INSTALL_PWD=$PWD
FRONTEND_EXTRA_CERTIFICATES=/vagrant/misc/extra-certificates.txt
FRONTEND_SITEDB_MAPPING=''
FRONTEND_HOSTCERT=/vagrant/certs/hostcert.pem
FRONTEND_HOSTKEY=/vagrant/certs/hostkey.pem
WMAGENT_INSTALL_POSTFIX=wmagent-install
CMSWEB_INSTALL_POSTFIX=cmsweb-install
WMAGENT_INSTALL_LOCATION=$PWD/$WMAGENT_INSTALL_POSTFIX
CMSWEB_INSTALL_LOCATION=$PWD/$CMSWEB_INSTALL_POSTFIX
WMCORE_SOURCE_TREE=/home/meloam/analysis/WMCore
WMCORE_TAG=0.9.26
CMSWEB_TAG=HG1303a
MY_HOSTNAME=`hostname -f`

REPO='-r comp=comp.pre'
export SCRAM_ARCH=slc6_amd64_gcc461

if [ ! -e $INSTALL_PWD/cfg ]; then
    ln -s $REPO_DEPLOYMENT_PATH $INSTALL_PWD/cfg
fi

###### Stop Frontend
if [ -e $CMSWEB_INSTALL_LOCATION/current ]; then
  echo "Stopping existing frontend services"

  # stop frontend
  if [ -e $CMSWEB_INSTALL_LOCATION/current/apps/frontend/etc/profile.d/init.sh ]; then
      echo "Stopping frontend.."
      set +x
      ./$CMSWEB_INSTALL_LOCATION/current/config/frontend/manage stop
      set -x
  fi
fi

# remove old cronjobs
#crontab -r || true # dont die if no old crontab

# stop old processes
pkill -9 -f $CMSWEB_INSTALL_LOCATION || true

###### INSTALL REQMGR

# skip sudo usage - just adds to /etc etc.
# FIXME have this work both ways
#perl -p -i -e 's/.*sudo.*/:/' $PWD/cfg/frontend/deploy
(
    mkdir -p $CMSWEB_INSTALL_LOCATION
    cd $CMSWEB_INSTALL_LOCATION
    # link to hostcert
    if [ ! -e certs ]; then
      mkdir -p certs
    fi
    if [ ! -r $FRONTEND_HOSTCERT ]; then
        echo "ERROR: Grid certificates must be readable!"
        echo "  (a future update will self-generate dummy certificates)"
    fi

    [ -e certs/hostcert.pem ] || $(sudo cp $FRONTEND_HOSTCERT certs/hostcert.pem)
    [ -e certs/hostkey.pem ] || $(sudo cp $FRONTEND_HOSTKEY certs/hostkey.pem)
    
    #[ -e certs/hostcert.pem ] || $(sudo cp ~/.globus/usercert.pem certs/hostcert.pem)
    #[ -e certs/hostkey.pem ] || $(sudo cp ~/.globus/userkey.pem certs/hostkey.pem)


    sudo chown `id -un`:`id -gn` certs/host*.pem
    chmod 600 certs/host*.pem
    
    export X509_USER_CERT=$PWD/certs/hostcert.pem
    export X509_USER_KEY=$PWD/certs/hostkey.pem
    
    # note single user install (which will be fixed)
    # need couchdb to get couchdb manage commands
    # need to support doing things with secrets
    $INSTALL_PWD/cfg/Deploy -R cmsweb@${CMSWEB_TAG} -t install -r comp=comp.pre -A $SCRAM_ARCH -s 'prep sw' $PWD admin frontend
    
    # Hotpatch the RPM before we go any further
    if [ $WMCORE_SOURCE_TREE -a -e $WMCORE_SOURCE_TREE ]; then
        (
            set +x
            . current/apps/workqueue/etc/profile.d/init.sh && \
            cd $WMCORE_SOURCE_TREE && \
            wmc-dist-patch -s workqueue --skip-docs | grep -v -e '^copying' \
                                                              -e '^creating' \
                                                              -e '^byte-compiling'
        )
        (
            set +x
            . current/apps/reqmgr/etc/profile.d/init.sh && \
            cd $WMCORE_SOURCE_TREE && \
            wmc-dist-patch -s reqmgr --skip-docs | grep -v -e '^copying' \
                                                           -e '^creating' \
                                                           -e '^byte-compiling'
        )
    fi
    
    $INSTALL_PWD/cfg/Deploy -R cmsweb@${CMSWEB_TAG} -t install -r comp=comp.pre -A $SCRAM_ARCH -s post $PWD admin frontend
    
   
    # get auth going

    # FIME this should be the host cert instead

    # add in acdc couchapps - needed for integration tests
    #grep -q ACDC state/couchdb/stagingarea/acdc || echo "couchapp push $PWD/WMCore/src/couchapps/ACDC http://localhost:5984/wmagent_acdc" >> state/couchdb/stagingarea/acdc
    #grep -q GroupUser state/couchdb/stagingarea/acdc || echo "couchapp push $PWD/WMCore/src/couchapps/GroupUser http://localhost:5984/wmagent_acdc" >> state/couchdb/stagingarea/acdc
    
    # standard deploy assumes running as root - need to change a few things
    HTTPD_CONF=$CMSWEB_INSTALL_LOCATION/state/frontend/server.conf
    
    # run under current user
    #perl -p -i -e 's/^User/#User/' ${HTTPD_CONF}
    #perl -p -i -e 's/^Group/#Group/' ${HTTPD_CONF}
    
    # non-privileged port
    #perl -p -i -e 's/Listen 80/Listen 8080/' ${HTTPD_CONF}
    #perl -p -i -e 's/\*:80/\*:8080/' ${HTTPD_CONF}
    
    #perl -p -i -e 's/Listen 443/Listen 8443/' ${HTTPD_CONF}
    #perl -p -i -e 's/\*:443/\*:8443/' ${HTTPD_CONF}
 
    # non-rootowned key
    #perl -p -i -e "s#SSLCertificateFile.*#SSLCertificateFile $CMSWEB_INSTALL_LOCATION/certs/hostcert.pem#" ${HTTPD_CONF}
    #perl -p -i -e "s#SSLCertificateKeyFile.*#SSLCertificateKeyFile $CMSWEB_INSTALL_LOCATION/certs/hostkey.pem#" ${HTTPD_CONF}


    # add test cert credentials
    # TODO: FIX ME (what goes in extra-certificates.txt?)
    # drop existing stuff in the database

    if [ -e $FRONTEND_EXTRA_CERTIFICATES ]; then
        # make sure te timestamp gets bumped
        cat $FRONTEND_EXTRA_CERTIFICATES > current/config/frontend/extra-certificates.txt
    fi

    if [ $FRONTEND_SITEDB_MAPPING -a -e $FRONTEND_SITEDB_MAPPING ]; then
        cp ../sitedb-mapping.py . && chmod +x sitedb-mapping.py && (set +x ;. current/apps/frontend/etc/profile.d/init.sh && set -x && ./sitedb-mapping.py --mapping-file=../sitedb-mapping.txt current/auth/frontend/users.db )
    fi
    
    set -x
    dn=$(openssl x509 -noout -subject -in $CMSWEB_INSTALL_LOCATION/certs/hostcert.pem | cut -f2- -d\ )
    echo "
INSERT OR IGNORE INTO contact('surname', 'forename', 'username', 'dn') VALUES ('local','host','localhost','$dn');
INSERT OR IGNORE INTO role('title') VALUES('admin');
INSERT OR IGNORE INTO user_group('name') VALUES('reqmgr');
INSERT OR IGNORE INTO group_responsibility('contact', 'role', 'user_group') VALUES ( (SELECT id FROM contact WHERE dn='$dn'), (SELECT id FROM role WHERE title='admin'), (SELECT id from user_group WHERE name='reqmgr') );
INSERT OR IGNORE INTO group_responsibility('contact', 'role', 'user_group') VALUES ( (SELECT id FROM contact WHERE dn='$dn'), (SELECT id FROM role WHERE title='_admin'), (SELECT id from user_group WHERE name='CouchDB') );


" | sqlite3 current/auth/frontend/users.db
#    echo "INSERT INTO group_responsibility('contact', 'role', 'user_group') VALUES ( (SELECT id FROM contact WHERE dn='/DC=org/DC=doegrids/OU=People/CN=Andrew Malone Melo 788499'), (SELECT id FROM role WHERE title='admin'), (SELECT id from user_group WHERE name='reqmgr') );" | sqlite3 current/auth/frontend/users.db

    if [ -e ~/.globus/usercert.pem ]; then
        echo "
INSERT OR IGNORE INTO contact('surname', 'forename', 'username', 'dn') VALUES ('local','user','localuser','$dn');
INSERT OR IGNORE INTO group_responsibility('contact', 'role', 'user_group') VALUES ( (SELECT id FROM contact WHERE dn='$dn'), (SELECT id FROM role WHERE title='admin'), (SELECT id from user_group WHERE name='reqmgr') );
INSERT OR IGNORE INTO group_responsibility('contact', 'role', 'user_group') VALUES ( (SELECT id FROM contact WHERE dn='$dn'), (SELECT id FROM role WHERE title='_admin'), (SELECT id from user_group WHERE name='CouchDB') );


" | sqlite3 current/auth/frontend/users.db
    fi
    
    # update authmap
    (
    set +x
    source $CMSWEB_INSTALL_LOCATION/current/apps/frontend/etc/profile.d/init.sh && PYTHONPATH=$CMSWEB_INSTALL_LOCATION/current/auth/frontend:$PYTHONPATH $CMSWEB_INSTALL_LOCATION/current/config/frontend/mkauthmap -q -c sitedbread.db -o $CMSWEB_INSTALL_LOCATION/state/frontend/etc/authmap.json
    )

    #start frontend (manage assumes root so cant be used) (again, to be fixed)
    set +x
    echo "Starting frontend.."
    ./current/config/frontend/manage start
    set -x
    # temporarily make a vomsmapfile for before cron fires
    dn=$(openssl x509 -noout -subject -in $CMSWEB_INSTALL_LOCATION/certs/hostcert.pem | cut -f2- -d\ )
    # not sure if this is even ncessary since we have extra-certificates.txt
    # but until it gets bootstrapped, things dont work
    echo "\"$dn\" cms" >> state/frontend/etc/voms-gridmap.txt
    if [ -e ~/.globus/usercert.pem ]; then
         dn=$(openssl x509 -noout -subject -in ~/.globus/usercert.pem | cut -f2- -d\ )
         echo "\"$dn\" cms" >> state/frontend/etc/voms-gridmap.txt
    fi
)
