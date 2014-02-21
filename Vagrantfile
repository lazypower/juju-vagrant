# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu-trusty-alpha2"
  #Note! the size of this box is not trivial - coming in at 801 mb
  config.vm.box_url = "http://dasroot.net/ubuntu-trusty-alpha2.box"
  #Perform the provisioner tasks of doing setup
  config.vm.provision "shell",
    path: "juju-vagrant-setup.sh"
end
