"""
This is a test example of configuration file for CRAB-3 client
"""

from WMCore.Configuration import Configuration

config = Configuration()

## General options for the client
config.section_("General")
config.General.standalone = True

#
# To enable direct submission, uncomment the below and turn
# config.General.enableGsissh to false.
#
# config.General.condorPool = "glidein.unl.edu"
# config.General.condorScheddList = ["glidein.unl.edu"]
#

config.General.enableGsissh = True
config.section_("BossAir")
config.BossAir.remoteUserHost = "submit-5.t2.ucsd.edu"

config.General.requestName   = 'bbockelm_crab3_2'
config.General.serverUrl = 'cmsweb.cern.ch'

## Specific option of the job type
config.section_("JobType")
config.JobType.pluginName  = 'Analysis'
config.JobType.psetName    = 'pset.py'

## Specific data options
config.section_("Data")
config.Data.inputDataset = '/GenericTTbar/HC-CMSSW_5_3_1_START53_V5-v1/GEN-SIM-RECO'
config.Data.publishDataName = 'crab_bbockelm_3'
config.Data.unitsPerJob = 50

## User options
config.section_("User")
config.User.email = ''

config.section_("Site")
config.Site.storageSite = 'T2_US_Nebraska'
