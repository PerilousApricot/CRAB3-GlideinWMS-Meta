export CRAB3_VERSION=DEV-INSTALL
export CRAB3_BASEPATH=`dirname ${BASH_SOURCE[0]}`
export CRAB3_BASEPATH=`readlink -e $CRAB3_BASEPATH`
# FIXME: Need to decide on CRAB or CRAB3 for env vars
export CRAB_DEV_BASE=$CRAB3_BASEPATH
if [[ ! -e $CRAB3_BASEPATH/CRAB3-externals.zip ]]; then
    pushd $CRAB3_BASEPATH
    export CRAB_OVERRIDE_SOURCE="$CRAB3_BASEPATH"
    $CRAB3_BASEPATH/CRABServer/bin/dagman_make_runtime.sh
    rm -f $CRAB3_BASEPATH/TaskManagerRun-DEV*.tar.gz $CRAB3_BASEPATH/CRAB3-gWMS.tar.gz
    popd
fi
export PATH=$CRAB3_BASEPATH/CRABClient/bin:$PATH
export PYTHONPATH=$CRAB3_BASEPATH/lib/python:$CRAB3_BASEPATH/CRAB3-externals.zip:$PYTHONPATH:$CRAB3_BASEPATH/WMCore/src/python:$CRAB3_BASEPATH/CRABServer/src/python:$CRAB3_BASEPATH/CRABClient/src/python:$CRAB3_BASEPATH/CAFTaskWorker/src/python:$CRAB3_BASEPATH/CAFUtilities/src/python
export LD_LIBRARY_PATH=$CRAB3_BASEPATH/lib:$CRAB3_BASEPATH/lib/condor:$LD_LIBRARY_PATH
if [ "x$CONDOR_CONFIG" = "x" ] && [ ! -e /etc/condor/condor_config ] && [ ! -e $HOME/.condor/condor_config ];
then
  export CONDOR_CONFIG=$CRAB3_BASEPATH/lib/fake_condor_config
fi
