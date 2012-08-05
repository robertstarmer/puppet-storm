class storm::zoo {
  
  package {['zookeeper','zookeeper-bin','zookeeperd']:
    ensure => latest,
  }
  
}