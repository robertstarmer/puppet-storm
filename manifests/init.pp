# Storm Installation
#

class storm (
  role = 'zoo' #zoo or worker (assumed)
  ){
  
  Exec{
    path=>["/bin","/usr/bin","/usr/local/${snapshot_dir}/bin"]
  }
  
  $snapshot = 'storm-0.8.0.zip'
  $snapshot_dir = 'storm-0.8.0'

  package {['libzmq-dev','pkg-config','libtool','autoconf','openjdk-6-jdk','build-essential','git','unzip']:
    ensure => latest,
  }

  class {"storm::zoo": }
  class {"storm::jzmq": }

  class {"storm::build":
    snapshot => $snapshot,
    snapshot_dir => $snapshot_dir
  }
  
  if $role == 'zoo'{
     
     exec {"storm nimbus":
       cwd => "/usr/local/${snapshot_dir}",
       unless => "ps -ef | grep zookeeper",
       before => Exec['storm supervisor']
     }
     
     exec {"storm supervisor":
       cwd => "/usr/local/${snapshot_dir}",
       unless => "ps -ef | grep java",
       require => Exec['storm nimbus']
     }
     
     exec {"storm ui":
       cwd => "/usr/local/${snapshot_dir}",
       unless => "ps -ef | grep storm.ui",
     }
  } else {
    
    ??
    
  }
  

}