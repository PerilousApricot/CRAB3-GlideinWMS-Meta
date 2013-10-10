# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos64_64_melo1"
  config.vm.box_url = "https://se1.accre.vanderbilt.edu:8080/file-read/centos_64_x64_v1.box"

  config.vm.define :client do |client|
    client.vm.provision :shell, :path => "scripts/purple52-librarian-puppet-vagrant.sh"
    #client.vm.provision :shell, :path => "scripts/bootstrap-machine.sh",\
    #                        :args => "/vagrant/scripts/install-crab3.sh"
    client.vm.provision :puppet do |puppet|
        puppet.module_path = [ 'puppet/modules' ]
        puppet.options = [ "--debug" ]
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'default.pp'
        puppet.hiera_config_path = 'puppet/hieradir/hiera.yaml'
        puppet.working_directory = '/vagrant/puppet'
    end
  end
  config.vm.provider :virtualbox do |vb|
    # This allows symlinks to be created within the /vagrant root directory, 
    # which is something librarian-puppet needs to be able to do. This might
    # be enabled by default depending on what version of VirtualBox is used.
    # needed by librarian-puppet-vagrant
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end
end
