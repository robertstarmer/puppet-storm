#git clone https://github.com/zeromq/jzmq.git
#cd jzmq; ./autogen.sh; export JAVA_HOME=/usr/lib/jvm/default-java; ./configure; make; make install

class storm::jzmq {
  
  Exec {
    environment => 'JAVA_HOME=/usr/lib/jvm/default-java',
  }

  exec {'git clone https://github.com/zeromq/jzmq.git':
    cwd => '/tmp',
    path => ['/usr','/usr/bin'],
    unless => 'test -d /tmp/jzmq'
  }
  
  exec {'/tmp/jzmq/autogen.sh':
    cwd => '/tmp/jzmq',
    path => ['/usr','/usr/bin','/tmp/jzmq'],
    unless => 'test -f /tmp/jzmq/config/compile'
  }  

  exec {'/tmp/jzmq/configure':
    cwd => '/tmp/jzmq',
    path => ['/usr','/usr/bin','/tmp/jzmq'],
    unless => 'test -f /tmp/jzmq/config.status'
  }  

  exec {'make install':
    cwd => '/tmp/jzmq',
    path => ['/usr','/usr/bin','/tmp/jzmq'],
    unless => 'test -f /usr/local/share/java/zmq.jar'
  }
  
}

