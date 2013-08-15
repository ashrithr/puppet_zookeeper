# == Class: zookeeper
#			zookeeper::client
#			zookeeper::server
#
# This module installs and manages zookeeper, which is a centralized service for
# maintaining configuration information, naming, providing distributed synchronization,
# and providing group services for hadoop/hbase/kafka/storm and other distributed systems.
#
# === Parameters
#
# [*server::myid*]
#	  zookeeper id for specified host
#
# [*server::ensemble*]
#	  zookeeper ensemble, array of zookeeper hosts with port numbers
#
# [*server::java_home*]
#   override default java home path for zookeeper
#
# === Variables
#
# Nothing.
#
# === Requires
#
# Java to be installed
#
# === Examples
#
#	include zookeeper::client
#
#	class { "zookeeper::server":
#		myid 	 => "0",
#		ensemble => ["zk1.cw.com:2888:3888", "zk2.cw.com:2888:3888", "zk3.cw.com:2888:3888"],
#   java_home => '/opt/java/jdk1.6.0_31'
#	}
#

class zookeeper {

  class client {
    require zookeeper::repo
    package { "zookeeper":
      ensure => installed,
      require => Yumrepo["cloudera-repo"],
    }
  }

  class server(
      $myid,
      $ensemble = ['localhost:2888:3888'],
      $java_home = undef,
    ) {
    require zookeeper::repo
    include java::params
    package { "zookeeper-server":
      ensure => installed,
      require => Yumrepo["cloudera-repo"],
    }

    service { "zookeeper-server":
      enable => true,
      ensure => running,
      hasrestart => true,
      hasstatus => true,
      require => [ Package["zookeeper-server"], Exec["zookeeper-server-init"] ],
      subscribe => [ File[  "zookeeper-conf",
                            "zookeeper-myid",
                            "zookeeper-setjavapath"
                          ]
                    ],
    }

    file { "/etc/zookeeper/conf/zoo.cfg":
      alias => "zookeeper-conf",
      content => template("zookeeper/zoo.cfg.erb"),
      require => Package["zookeeper-server"],
    }

    file { "/var/lib/zookeeper/myid":
      alias => "zookeeper-myid",
      content => inline_template("<%= @myid %>"),
      require => Package["zookeeper-server"],
    }

    file { "/etc/default/bigtop-utils":
      alias => "zookeeper-setjavapath",
      content => template("zookeeper/bigtop-utils.erb"),
      require => Package["zookeeper-server"],
    }

    exec { "zookeeper-server-init":
      command => "/usr/bin/zookeeper-server-initialize",
      user => "zookeeper",
      creates => "/var/lib/zookeeper/version-2",
      require => Package["zookeeper-server"],
    }
  }
}
