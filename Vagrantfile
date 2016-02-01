# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
apt-get install git
sudo mkdir /var/www
sudo mkdir /var/www/myapp
sudo mkdir /var/www/myapp/shared
sudo mkdir /var/www/myapp/shared/config
cd /var/www/myapp/shared/config
sudo chown -R vagrant /var/www
sudo touch database.yml
sudo touch secrets.yml
exec $SHELL
cd /vagrant
gem install bundler
rbenv rehash
bundle install
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use Ubuntu 14.04 Trusty Tahr 64-bit as our operating system
  config.vm.box = "ubuntu/trusty64"

  # Configurate the virtual machine to use 2GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end



  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "vim"
    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::client"
    chef.add_recipe "nginx"
    chef.add_recipe "my_cookbook"
   

    # Install Ruby 2.2.1 and Bundler
    # Set an empty root password for MySQL to make things simple
    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.1.3"],
          global: "2.1.3",
          gems: {
            "2.1.3" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      mysql: {
        server_root_password: ''
      }
    }
  end


  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3000
 
  config.vm.network :forwarded_port, guest: 22, host: 12222, id: "ssh"
  config.ssh.guest_port = 12222
  config.vm.provision "shell", inline: $script
end