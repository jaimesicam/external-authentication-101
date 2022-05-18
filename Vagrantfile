Vagrant.configure("2") do |config|
  config.vm.define "ansible-controller" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "ansible-controller.example.com"
    end
    server.vm.hostname = "ansible-controller.example.com"
    server.vm.network :private_network, ip: "192.168.56.50"
    server.vm.provision :shell, path: "scripts/deploy_ansible-controller"
  end

  config.vm.define "samba" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "samba.percona.local"
      vb.cpus = 2
      vb.memory = 1024
    end
    server.vm.hostname = "samba.percona.local"
    server.vm.network :private_network, ip: "192.168.56.51"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end
  
  config.vm.define "ldap" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "ldap.percona.local"
    end
    server.vm.hostname = "ldap.percona.local"
    server.vm.network :private_network, ip: "192.168.56.52"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "mysql1" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "mysql1.percona.local"
    end
    server.vm.hostname = "mysql1.percona.local"
    server.vm.network :private_network, ip: "192.168.56.53"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "mysql2" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "mysql2.percona.local"
    end
    server.vm.hostname = "mysql2.percona.local"
    server.vm.network :private_network, ip: "192.168.56.54"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "mysql3" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "mysql3.percona.local"
    end
    server.vm.hostname = "mysql3.percona.local"
    server.vm.network :private_network, ip: "192.168.56.55"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "mongodb1" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "mongodb1.percona.local"
    end
    server.vm.hostname = "mongodb1.percona.local"
    server.vm.network :private_network, ip: "192.168.56.56"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "mongodb2" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "mongodb2.percona.local"
    end
    server.vm.hostname = "mongodb2.percona.local"
    server.vm.network :private_network, ip: "192.168.56.57"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "mongodb3" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "mongodb3.percona.local"
    end
    server.vm.hostname = "mongodb3.percona.local"
    server.vm.network :private_network, ip: "192.168.56.58"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "postgres1" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "postgres1.percona.local"
    end
    server.vm.hostname = "postgres1.percona.local"
    server.vm.network :private_network, ip: "192.168.56.59"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "postgres2" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "postgres2.percona.local"
    end
    server.vm.hostname = "postgres2.percona.local"
    server.vm.network :private_network, ip: "192.168.56.60"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "postgres3" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "postgres3.percona.local"
    end
    server.vm.hostname = "postgres3.percona.local"
    server.vm.network :private_network, ip: "192.168.56.61"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "pmm1" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "pmm1.percona.local"
      vb.memory = 2048
      vb.cpus = 2
    end
    server.vm.hostname = "pmm1.percona.local"
    server.vm.network :private_network, ip: "192.168.56.62"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end

  config.vm.define "multifactor" do |server|
    server.vm.box = "centos/stream8"
    server.vm.provider "virtualbox" do |vb|
      vb.name = "multifactor.percona.local"
    end
    server.vm.hostname = "multifactor.percona.local"
    server.vm.network :private_network, ip: "192.168.56.63"
    server.vm.provision :shell, path: "scripts/deploy_ansible-target"
  end
end
