IMAGE_NAME = "bento/debian-13"

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
    end

    config.vm.define "debian" do |debian|
        debian.vm.box = IMAGE_NAME
        debian.vm.network "forwarded_port", guest: 22, host: 2206, host_ip: "127.0.0.1"
        debian.vm.hostname = "debian13-fendvit"

        # Instalace a konfigurace Zabbix Agent 2 (8.0 LTS)
        debian.vm.provision "shell", name: "install-zabbix-agent2", path: "install-zabbix-agent2.sh"
        debian.vm.provision "shell", name: "configure-zabbix-agent2", path: "configure-zabbix-agent2.sh"
    end
end
