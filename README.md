CRAB3-GlideinWMS - MetaPackage
==============================

This repository will install the CRAB3 source trees as well as the necessary 
dependencies, possibly in a (new) VM. Useful if you're
like me and manage to spill water on your laptop, but still want to
develop.

It's also a handy place to stick common CRAB3-GWMS tickets, CI configs
and example scripts, so things aren't spread out everywhere. The obvious
solution to having 5 repositories is to add a 6th.

To Start within a VM
--------
Within the VM installation, this repository will show up under /vagrant

  1. Install VirtualBox (virtualbox.org) and Vagrant (vagrantup.com) to
     your machine.
  2. Run ./bootstrap.sh -- this initializes the necessary git repositories
     and performs some minimal initialization tasks
  3. From within this directory (or a subdirectory), 
     run `vagrant up` to download/boot the VM
  4. (Optional) execute scripts/copy-credentials-to-vm.sh to move your ssh key
     and ~/.globus directory to within the VM
  4. From within this directory (or a subdirectory). run `vagrant ssh` to
     connect to the VM via ssh
  5. CVMFS will be installed, use that to get a CMSSW environment
  6. Source /vagrant/repos/setup-dev.sh to get the CRAB3 environment
  7. Hack the repositories under /vagrant/repos
  8. Use `vagrant suspend` to stop the VM or `vagrant destroy` to delete
     the VM

To Start outside a VM
--------

  1. Run ./bootstrap.sh -- this initializes the necessary git repositories
     and performs some minimal initialization tasks
  2. Get a CMSSW environment from your system
  3. Source repos/setup-dev.sh to get the CRAB3 environment
  4. Hack the repositories under repos/
  5. ???
  6. Profit!

Running CRAB3
-------------

Once you have the client installed, you can do the following to quickstart
using the client:

```bash
<repo path>/examples/bootstrap-cmssw-project.sh
```

This will make a blank CMSSW location, copy some example configurations,
pull down needed additional dependencies and give you a shell script to
source when you next log back in. From there, the `crab3` command will work
properly.

```
[brazil] $ vagrant ssh
Last login: Sun Oct 13 09:15:16 2013 from 10.0.2.2
$ . source-crab3-env.sh 
CRAB3 + CMSSW environment sourced
$ crab3 -h
Usage: crab [options] COMMAND [command-options] [args]

<snip>

For more information on how to run CRAB-3 please follow this link: 
 https://twiki.cern.ch/twiki/bin/view/CMS/RunningCRAB3
```
