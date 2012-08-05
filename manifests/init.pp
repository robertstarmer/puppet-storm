# Storm Installation
#

class storm {
  
  package {['libzmq-dev','pkg-config','libtool','autoconf','openjdk-6-jdk','build-essential','git','unzip']:
    ensure => latest,
  }
  
  
}