# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "ubuntu", primary: true do |ubuntu|
    ubuntu.vm.box = "bento/ubuntu-16.04"
    ubuntu.vm.network :forwarded_port, guest: 22, host: 2216, id: "ssh"
    ubuntu.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y xfce4 build-essential lintian terminator
    SHELL
  end

  config.vm.define "centos", autostart: false do |centos|
    centos.vm.box = "bento/centos-7"
    centos.vm.network :forwarded_port, guest: 22, host: 2207, id: "ssh"
    centos.vm.provision "shell", inline: <<-SHELL
      yum update
      yum -y install epel-release
      yum -y group install xfce X11
      # echo "exec /usr/bin/xfce4-session" >> ~/.xinitrc # add this line to make startx work as regular user
      yum -y install git terminator gvim vim gcc-c++ rpmdevtools rpmlint
    SHELL
  end

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "2048"
  end
end
