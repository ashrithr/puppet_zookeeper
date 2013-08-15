puppet module for zookeeper
---------------------------

This module will install and manages zookeeper instances

###Sample Usage

zookeeper server:

```puppet
class { "zookeeper::server":
  myid   => "0",
  ensemble => ["zk1.cw.com:2888:3888", "zk2.cw.com:2888:3888", "zk3.cw.com:2888:3888"],
  java_home => '/opt/java/jdk1.6.0_31',
}
```

zookeeper client:

```puppet
include zookeeper::client
```

Using with puppet apply (given module lives in /root/modules):

```bash
cd ~ && mkdir modules
cd ~/modules && git clone https://github.com/ashrithr/puppet_zookeeper.git zookeeper
#for sevrer (modify hosts list in zookeeper/tests/init.pp) and run:
  puppet apply --modulepath=/root/modules/ zookeeper/tests/init.pp
#for client:
  puppet apply --modulepath=/root/modules/ -e "include zookeeper::client"
```

To install standalone puppet agent:

```bash
wget -qO - https://raw.github.com/ashrithr/scripts/master/install_puppet_standalone.sh | bash
```

**NOTE**: This module depends on java, which can be installed by following
instructions at https://github.com/ashrithr/puppet_java
