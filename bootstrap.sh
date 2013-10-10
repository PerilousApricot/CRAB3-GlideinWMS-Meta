#!/bin/bash
set -e

echo "Beginning to bootstrap CRAB3-GlideinWMS dev environment"
echo " + Pulling repositories (uses SSH auth, you must have your"
echo "   credentials in GitHub for this to work)"

[[ -d repos ]] || mkdir repos
[[ -d repos/CRABClient ]] || git clone -b dagman git@github.com:bbockelm/CRABClient.git repos/CRABClient 
[[ -d repos/CRABServer ]] || git clone -b dagman git@github.com:bbockelm/CRABServer.git repos/CRABServer
[[ -d repos/CAFUtilities ]] || git clone -b dagman git@github.com:bbockelm/CAFUtilities.git repos/CAFUtilities
[[ -d repos/CAFTaskWorker ]] || git clone -b dagman git@github.com:bbockelm/CAFTaskWorker.git repos/CAFTaskWorker
[[ -d repos/WMCore ]] || git clone -b crab3 git@github.com:bbockelm/WMCore.git repos/WMCore
