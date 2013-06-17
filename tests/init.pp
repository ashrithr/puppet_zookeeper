#change the hosts and run
class { "zookeeper::server":
  myid   => "0",
  ensemble => ["zk1.cw.com:2888:3888", "zk2.cw.com:2888:3888", "zk3.cw.com:2888:3888"],
}