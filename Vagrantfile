Vagrant.configure("2") do |config|

  config.vm.define "wordpress" do |wordpress|
    wordpress.vm.box = "ubuntu/bionic64" 
    wordpress.vm.hostname = "wordpress"
    wordpress.vm.network "private_network", ip: "192.168.33.11", nic_type: "virtio", virtualbox__intnet: "keepcoding"
    wordpress.vm.network "forwarded_port", guest: 80, host: 8081
    wordpress.vm.synced_folder ".", "/vagrant"    
    wordpress.vm.provision "shell", path: "wordpress.sh"        
    wordpress.vm.provider "virtualbox" do |vb|
        vb.memory= 512
        vb.cpus = 2
        vb.default_nic_type = "virtio"
    end
  end

  config.vm.define "elastik" do |elastik|
      elastik.vm.box = "ubuntu/bionic64" 
      elastik.vm.hostname = "elastik"
      elastik.vm.network "private_network", ip: "192.168.33.12", nic_type: "virtio", virtualbox__intnet: "keepcoding" 
      elastik.vm.network "forwarded_port", guest: 5601, host: 5601
      elastik.vm.network "forwarded_port", guest: 9200, host: 9200
      elastik.vm.synced_folder ".", "/vagrant"
      elastik.vm.provision "shell", path: "elastik.sh" 
      elastik.vm.provider "virtualbox" do |vb|
          vb.memory= 4096
          vb.cpus = 2
          vb.default_nic_type = "virtio"
      end
  end
  
end