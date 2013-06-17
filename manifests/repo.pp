class zookeeper::repo {
  yumrepo { "cloudera-repo":
    descr => "CDH Repository",
    baseurl => 'http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/4/',
    enabled => 1,
    gpgcheck => 0,
  }
}