#!/bin/bash
export SCRAM_ARCH=slc5_amd64_gcc462
CMSSW_VER=CMSSW_5_3_11
(
set -e
echo "Sourcing CMSSW environment"
. /cvmfs/cms.cern.ch/cmsset_default.sh
if [[ ! -d $CMSSW_VER ]]; then
    echo "Making CMSSW project"
    scram p $CMSSW_VER
fi
echo "Copying example scripts"
cp $(dirname ${BASH_SOURCE[0]})/*.py .
)
DEVPATH=$(dirname ${BASH_SOURCE[0]})/../repos/setup-dev.sh
cat <<EOF > source-crab3-env.sh
export SCRAM_ARCH=$SCRAM_ARCH
source /cvmfs/cms.cern.ch/cmsset_default.sh
pushd $CMSSW_VER/src 2>&1 > /dev/null
cmsenv
popd 2>&1 > /dev/null
source $DEVPATH
echo "CRAB3 + CMSSW environment sourced"
EOF
echo "A blank CMSSW release has been created, to test CRAB3, "
echo "source source-crab3-env.sh"
echo ""
echo "An example configuration is crabConfig.py"
echo "ex: crab3 submit -c crabConfig.py"
