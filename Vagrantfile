Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  NODE_CPUS = 2
  NODE_MEMORY = 2048

  nodes = {
    "control-plane" => { ip: "192.168.56.10", script: "control-plane.sh" },
    "worker1"       => { ip: "192.168.56.11", script: "worker.sh" },
    "worker2"       => { ip: "192.168.56.12", script: "worker.sh" }
  }

  nodes.each do |name, data|
    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network "private_network", ip: data[:ip]

      node.vm.provider "virtualbox" do |vb|
        vb.name = name
        vb.memory = NODE_MEMORY
        vb.cpus = NODE_CPUS
      end

      # Common setup
      node.vm.provision "shell", path: "scripts/common.sh"

      # Role-specific setup
      node.vm.provision "shell", path: "scripts/#{data[:script]}"
    end
  end
end
