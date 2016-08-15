# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "750"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
  end

  config.vm.box = "ARTACK/debian-jessie"
  config.vm.hostname = "ferengi"

  config.vm.synced_folder "home/share", "/home/share"
  config.vm.synced_folder "root", "/root", owner: "root", group: "root"
  config.vm.synced_folder "home/git", "/home/git"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # config.vm.provision "shell", path: 'provision.sh'

  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = "home/git/data-team/data-team-devbox/cookbooks"
    chef.nodes_path = "home/git/data-team/data-team-devbox/nodes"
    chef.add_recipe "ta_wrapper_perl::all"
    chef.node_name = "devbox"
  end
end
