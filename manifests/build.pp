#mkdir /usr/local/storm;
#cd /usr/local/storm
#wget https://github.com/downloads/nathanmarz/storm/storm-0.8.0-SNAPSHOT.zip
#unzip storm-0.8.0-SNAPSHOT.zip
#cd storm-0.8.0-SNAPSHOT

class storm::build (
  snapshot = 'storm-0.8.0.zip',
  snapshot_dir = 'storm-0.8.0'
  ){
  
  file {'/usr/local/storm':
    ensure => directory,
  }

  exec {"wget https://github.com/downloads/nathanmarz/storm/${snapshot}":
    cwd => '/usr/local/storm',
    path => ['/usr','/usr/bin'],
    unless => "test -f /usr/local/storm/${snapshot}"
  }
  
  exec {"unzip /usr/local/storm/${snapshot}":
    cwd => '/usr/local/storm',
    path => ['/usr','/usr/bin'],
    unless => "test -f /usr/local/storm/${snapshot_dir}"    
  }
  
  file {'/mnt/storm':
    ensure => directory
  }
  
  file {"/usr/local/storm/${snapshot_dir}/conf/storm.yaml":
    ensure => present,
    content =>"
storm.zookeeper.server:
  - '127.0.0.1'
nimbus.host: '127.0.0.1'
storm.local.dir: '/mnt/storm'
    "}

}