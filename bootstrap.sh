#!/bin/bash
set -e

echo "Beginning to bootstrap CRAB3-GlideinWMS dev environment"
echo " + Pulling repositories (uses SSH auth, you must have your"
echo "   credentials in GitHub for this to work)"

[[ -d repos ]] || mkdir repos
[[ -d repos/CRABClient ]] || git clone -b dagman git@github.com:bbockelm/CRABClient.git repos/CRABClient 
[[ -d repos/CRABServer ]] || git clone -b htcondor_poc git@github.com:dmwm/CRABServer.git repos/CRABServer
[[ -d repos/WMCore ]] || git clone -b crab3 git@github.com:bbockelm/WMCore.git repos/WMCore
[[ -d repos/AsyncStageout ]] || git clone -b master https://github.com/dmwm/AsyncStageout.git repos/AsyncStageout
[[ -d repos/cfg ]] || git clone -b master https://github.com/dmwm/deployment.git cfg
