VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|  
  config.vm.provider :virtualbox do |vb|
    #memory
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.hostname = "nginx-devenv-host.dev"
  config.vm.box = "ubuntu/trusty64"

  # jetty ports
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  # nginx ports
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  # graphite ports
  config.vm.network "forwarded_port", guest: 8180, host: 8180
  config.vm.network "forwarded_port", guest: 2003, host: 2003
  # dropwizard services example ports
  config.vm.network "forwarded_port", guest: 8181, host: 8181

  config.vm.provision :shell, inline: <<-SCRIPT
    sudo apt-get update
    sudo apt-get upgrade
    # Set correct source list
    echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
    echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe" >> /etc/apt/sources.list

    # add the python properties so we can add repos afterwards and also the utility to auto-accept licens es, some dev tools too
    apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common debconf-utils net-tools vim-tiny sudo iputils-ping less curl

    # auto-acept oracles jdk license
    /bin/echo -e oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

    # add JDK8 repository
    add-apt-repository -y ppa:webupd8team/java

    # install Oracle JDK 8
    apt-get update && apt-get upgrade -y --force-yes && apt-get install -y --force-yes oracle-java8-installer  

    # set java environment variables
    sudo apt-get install oracle-java8-set-default
  SCRIPT

  config.vm.provision "docker",
    images: ["library/nginx:1.9.6", "sitespeedio/graphite", "crosbymichael/skydock", "crosbymichael/skydns", "library/jetty"]

  # Build docker images for our example
  config.vm.provision :shell, run:"always", inline: <<-SCRIPT
    cd /vagrant/dropwizard-example/docker
    docker build -t dropwizard-example .
  SCRIPT

  # default provisioning of the nginx instance
  config.vm.provision :shell, run: "always", path: "devenv-startup.sh"
  
end
