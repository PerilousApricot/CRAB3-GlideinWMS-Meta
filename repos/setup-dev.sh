export CRAB3_VERSION=DEV-$(git rev-parse HEAD)
export CRAB3_BASEPATH=`dirname ${BASH_SOURCE[0]}`
export CRAB3_BASEPATH=`readlink -e $CRAB3_BASEPATH`
# FIXME: Need to decide on CRAB or CRAB3 for env vars

export CRAB_DEV_BASE=$CRAB3_BASEPATH
export PATH=$CRAB3_BASEPATH/CRABClient/bin:$PATH
export PYTHONPATH=$CRAB3_BASEPATH/lib/python:$PYTHONPATH
export LD_LIBRARY_PATH=$CRAB3_BASEPATH/lib:$CRAB3_BASEPATH/lib/condor:$LD_LIBRARY_PATH
if [ "x$CONDOR_CONFIG" = "x" ] && [ ! -e /etc/condor/condor_config ] && [ ! -e $HOME/.condor/condor_config ];
then
  export CONDOR_CONFIG=$CRAB3_BASEPATH/lib/fake_condor_config
fi
