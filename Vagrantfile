# -*- mode: ruby -*-
# vi: set ft=ruby :

# Config Github Settings
github_username = "fideloper"
github_repo     = "Vaprobash"
github_branch   = "1.4.0"
github_url      = "https://raw.githubusercontent.com/#{github_username}/#{github_repo}/#{github_branch}"

# Because this:https://developer.github.com/changes/2014-12-08-removing-authorizations-token/
# https://github.com/settings/tokens
github_pat          = ""

# Server Configuration

hostname        = "vaprobash.dev"

# Set a local private network IP address.
# See http://en.wikipedia.org/wiki/Private_network for explanation
# You can use the following IP ranges:
#   10.0.0.1    - 10.255.255.254
#   172.16.0.1  - 172.31.255.254
#   192.168.0.1 - 192.168.255.254
server_ip             = "192.168.22.10"
server_cpus           = "1"   # Cores
server_memory         = "1024" # MB
server_swap           = "1024" # Options: false | int (MB) - Guideline: Between one or two times the server_memory

# UTC        for Universal Coordinated Time
# EST        for Eastern Standard Time
# US/Central for American Central
# US/Eastern for American Eastern
server_timezone  = "UTC"

# Database Configuration
pgsql_root_password   = "root"   # We'll assume user "root"

# Languages and Packages
ruby_version          = "2.2.2" # Choose what ruby version should be installed (will also be the default version)
ruby_gems             = [        # List any Ruby Gems that you want to install
  "bundler",
]

public_folder = "/vagrant/public"

Vagrant.configure("2") do |config|

  # Set server to Ubuntu 14.04
  config.vm.box = "ubuntu/trusty64"

  config.vm.define "Classroom" do |vapro|
  end

  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = false
  end

  # Create a hostname, don't forget to put it to the `hosts` file
  # This will point to the server's default virtual host
  # TO DO: Make this work with virtualhost along-side xip.io URL
  config.vm.hostname = hostname

  # Create a static IP
  config.vm.network :private_network, ip: server_ip
  config.vm.network :forwarded_port, guest: 80, host: 8000

  # Use NFS for the shared folder
  config.vm.synced_folder ".", "/vagrant",
            id: "core",
            :nfs => true,
            :mount_options => ['nolock,vers=3,udp,noatime']

  # If using VirtualBox
  config.vm.provider :virtualbox do |vb|

    vb.name = "Classroom"

    # Set server cpus
    vb.customize ["modifyvm", :id, "--cpus", server_cpus]

    # Set server memory
    vb.customize ["modifyvm", :id, "--memory", server_memory]

    # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
    # If the clock gets more than 15 minutes out of sync (due to your laptop going
    # to sleep for instance, then some 3rd party services will reject requests.
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

    # Prevent VMs running on Ubuntu to lose internet connection
    # vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

  end

  # If using VMWare Fusion
  config.vm.provider "vmware_fusion" do |vb, override|
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

    # Set server memory
    vb.vmx["memsize"] = server_memory

  end

  # If using Vagrant-Cachier
  # http://fgrehm.viewdocs.io/vagrant-cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # Usage docs: http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box

    config.cache.synced_folder_opts = {
        type: :nfs,
        mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    }
  end

  ####
  # Base Items
  ##########

  # Provision Base Packages
  config.vm.provision "shell", path: "#{github_url}/scripts/base.sh", args: [github_url, server_swap, server_timezone]

  # optimize base box
  config.vm.provision "shell", path: "#{github_url}/scripts/base_box_optimizations.sh", privileged: true

  # Provision Vim
  # config.vm.provision "shell", path: "#{github_url}/scripts/vim.sh", args: github_url

  # Provision Docker
  # config.vm.provision "shell", path: "#{github_url}/scripts/docker.sh", args: "permissions"

  ####
  # Web Servers
  ##########

  # Provision Nginx Base
  config.vm.provision "shell", path: "#{github_url}/scripts/nginx.sh", args: [server_ip, public_folder, hostname, github_url]


  ####
  # Databases
  ##########

  # Provision PostgreSQL
  # config.vm.provision "shell", path: "#{github_url}/scripts/pgsql.sh", args: pgsql_root_password

  ####
  # In-Memory Stores
  ##########

  # Provision Redis (without journaling and persistence)
  # config.vm.provision "shell", path: "#{github_url}/scripts/redis.sh"

  # Provision Redis (with journaling and persistence)
  # config.vm.provision "shell", path: "#{github_url}/scripts/redis.sh", args: "persistent"
  # NOTE: It is safe to run this to add persistence even if originally provisioned without persistence


  ####
  # Utility (queue)
  ##########

  # Install Heroku Toolbelt
  config.vm.provision "shell", path: "https://toolbelt.heroku.com/install-ubuntu.sh"

  # Install Supervisord
  # config.vm.provision "shell", path: "#{github_url}/scripts/supervisord.sh"

  # Install ØMQ
  # config.vm.provision "shell", path: "#{github_url}/scripts/zeromq.sh"

  ####
  # Additional Languages
  ##########

  # Install Nodejs
  # config.vm.provision "shell", path: "#{github_url}/scripts/nodejs.sh", privileged: false, args: nodejs_packages.unshift(nodejs_version, github_url)

  # Install Ruby Version Manager (RVM)
  config.vm.provision "shell", path: "#{github_url}/scripts/rvm.sh", privileged: false, args: ruby_gems.unshift(ruby_version)

  ####
  # Local Scripts
  # Any local scripts you may want to run post-provisioning.
  # Add these to the same directory as the Vagrantfile.
  ##########


  ####
  # Vapro Conf
  #
  # Easily configure databases and other services for your Vaprobash VM.
  ##########

  vaproconf_username     = "rtablada"
  vaproconf_repo         = "Vaproconf"
  vaproconf_branch       = "master"
  vaproconf_url          = "https://raw.githubusercontent.com/#{vaproconf_username}/#{vaproconf_repo}/#{vaproconf_branch}"

  # Postgres Configuration
  pgsql_database_name = "database"
  pgsql_user          = "user"
  pgsql_pass          = "pass"

  # Nginx Override
  nginx_site_file_path   = "/vagrant/_provisioning/vagrant"
  nginx_new_site_name = "vagrant"

  # Configure MySQL
  # config.vm.provision "shell", path: "#{vaproconf_url}/scripts/mysql.sh", args: [mysql_root_password, mysql_database_name, mysql_user, mysql_pass]

  # Configure Postgres
  # config.vm.provision "shell", path: "#{vaproconf_url}/scripts/pgsql.sh", args: [pgsql_database_name, pgsql_user, pgsql_pass]

  # Configure MongoDB
  # config.vm.provision "shell", path: "#{vaproconf_url}/scripts/mongodb.sh", args: [mongodb_database_name, mongodb_user, mongodb_pass]

  # Override Nginx Site Config
  # config.vm.provision "shell", path: "#{vaproconf_url}/scripts/nginx.sh", args: [nginx_site_file_path, nginx_new_site_name]

  config.vm.provision "shell", path: "./script/setup"
end
