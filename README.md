puppet module for zookeeper
---------------------------

This module will install and manages zookeeper instances

###Sample Usage

zookeeper server:

```
class { "zookeeper::server":
  myid   => "0",
  ensemble => ["zk1.cw.com:2888:3888", "zk2.cw.com:2888:3888", "zk3.cw.com:2888:3888"],
  java_home => '/opt/java/jdk1.6.0_31',
}
```

zookeeper client:

```
include zookeeper::client
```

Using with puppet apply (given module lives in /root/modules):

```
$cd ~ && mkdir modules
$cd ~/modules && git clone https://github.com/ashrithr/puppet_zookeeper.git zookeeper
#for sevrer (modify hosts list in zookeeper/tests/init.pp) and run:
  $puppet apply --modulepath=/root/modules/ zookeeper/tests/init.pp
#for client:
  $puppet apply --modulepath=/root/modules/ -e "include zookeeper::client"
```