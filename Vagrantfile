# ref: https://app.vagrantup.com/puppetlabs
nodes = [
  { :hostname => 'centos66',     :ip => '192.168.1.2',  :box => 'puppetlabs/centos-6.6-64-puppet' },
  { :hostname => 'centos70',     :ip => '192.168.1.3',  :box => 'puppetlabs/centos-7.2-64-puppet' },
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "50",
          "--memory", memory.to_s,
        ]
      end
    end
  end

  config.vm.provision :shell do |shell|
    script = "mkdir -p /etc/puppetlabs/code/environments/production/modules/psacct;" +
    "cp -r /vagrant/* /etc/puppetlabs/code/environments/production/modules/psacct/;" +
    "puppet module --modulepath=/etc/puppetlabs/code/environments/production/modules/ install puppetlabs/stdlib;" +
    'export PATH=$PATH:/opt/puppetlabs/puppet/bin;' +
    'export MODULEPATH=/etc/puppetlabs/code/environments/production/modules/;' +
    "if [ `hostname` == centos66.box ] ; then echo \"This is centos66\"; sudo yum -y remove puppet-agent; sudo rpm -ivh https://yum.puppetlabs.com/puppet5-release-el-6.noarch.rpm; sudo yum -y install puppet-agent; fi;" +
    "if [ `hostname` == centos70.box ] ; then echo \"This is centos70\"; sudo yum -y remove puppet-agent; sudo rpm -ivh https://yum.puppetlabs.com/puppet5-release-el-7.noarch.rpm; sudo yum -y install puppet-agent; fi;" +
    "puppet apply --pluginsync --modulepath=$MODULEPATH \"$MODULEPATH\"psacct/examples/init.pp;"
    shell.inline = script
  end
end
