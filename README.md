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
