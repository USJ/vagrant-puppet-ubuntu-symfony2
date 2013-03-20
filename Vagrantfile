# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://mirror.usj.edu.mo/vagrant-boxes/ubuntu-12.04.1-server-amd64-vb4.2.4.box"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "10.11.12.13"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 80, 4567
  config.vm.forward_port 27017, 27018

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.share_folder("www", "/srv/www/myusj/public_html", "../ums2", :nfs => true, :create => true)

  # Set the Timezone to something useful
  # config.vm.provision :shell, :inline => "echo \"Asia/Macau\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"
  # Update the server
  config.vm.provision :shell, :inline => "apt-get update --fix-missing"
  
  # Puppet provisioning
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file  = "project.pp"
  end
end