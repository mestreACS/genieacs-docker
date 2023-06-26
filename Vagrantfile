# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box_download_options = {"ssl-no-revoke" => true}

  config.vm.box_check_update = true

  config.vm.box = "debian/bookworm64" #Debian 12
  #config.vm.box_version = "12.20230602.1"

  config.vm.network "public_network"  
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 7547, host: 7547
  config.vm.network "forwarded_port", guest: 7557 , host: 7557
  config.vm.network "forwarded_port", guest: 7567, host: 7567
  config.vm.network "forwarded_port", guest: 22, host: 2222

  config.vm.synced_folder "genieacs-docker/", "/home/vagrant/genieacs-docker/", create:true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "curso_acs_tr069"
    vb.check_guest_additions = false
    vb.gui = false
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Atualizando linux..."
    apt-get update
    apt-get upgrade -y
    echo "Instalando docker and docker-compose..."
    apt-get install -y docker docker-compose
    systemctl start docker
    systemctl enable docker
    usermod -a -G docker vagrant
    echo "Baixando arquivos de configuração..."
    wget -q https://raw.githubusercontent.com/mestreACS/genieacs-docker/main/docker-compose.yml -O /home/vagrant/genieacs-docker/docker-compose.yml
    wget -q https://raw.githubusercontent.com/mestreACS/genieacs-docker/main/.env.example -O /home/vagrant/genieacs-docker/.env
    echo "Baixando imagens do docker..."
    docker-compose -f /home/vagrant/genieacs-docker/docker-compose.yml pull
    echo "Criando e iniciando containers..."
    docker-compose -f /home/vagrant/genieacs-docker/docker-compose.yml up -d
    echo "Script finalizado..."
  SHELL
    
end
