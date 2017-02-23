node 'base'{
#include classes
}



node 'kali','kali2' {
 # if tagged('test1') {

notify{"this is $::operatingsystem version $::operatingsystemrelease,on $::architecture architecture,kernel version $::kernelversion":}

#$message=generate('jiaoben')
#notify{$message}


   file {'/tmp/hello':
     content=>"Hello a Big World\n",

     }

   append_if_no_such_line{'test':
          file=>'/tmp/hello',
      line=>'Hello World',
    }
  #}
 #if tagged('test2'){
 #       notify {'this is my testright':}
 # file {'/tmp/test':
 #   content=>"the right\n",
   # }


     include user::virtual
    include user::sysadmins
    include user::developers   

    include puppet

#从第三方仓库安装软件的例子
#  include admin::percona_repo
#  package {'percona-server-server-5.5':
#    ensure=>installed,
#    require=>Class['admin::percona_repo'],
#  }
#例子结束
#从源码安装软件的例子
#exec{ 'install-keepalived':
#  cwd=>'/root',
#  command=>'/usr/bin/wget http:// .gz && /bin/tar xvzf .gz && cd && ./configure && make all && make install',
#  creates=>'usr/local/bin/ ',
#  timeout=>0,
#}
# 例子结束
# versioncmp()
#非上班时间执行一次
schedule {'outside-offline-hours':
  period=>daily,
  range =>['17:00-23:59','00:00-09:00'],
  repeat=>1,
  }
exec { '/bin/echo it is xiaban time':
  schedule=>'outside-offline-hours',
  }

host {'ovirt_node1':
  ensure=>present,
  ip=>'192.168.1.178',
  target=>'/etc/hosts',
 # noop=>true,
  }
#文件源例子
#file {'/etc/stuff.cfg':
#  source=>["puppet:///modules/admin/${::hostname}.cfg",
#    'puppet:///admin/generic.fg'],
#}
#file {'/tmp/tree':
# source=>'',  #其下的子目录也会一同创建，不推荐，还是压缩包好
# recurse=>true,
#}
#清理一年前的日志
  tidy {'/var/lib/puppet/reports':
    age=>'365d',
    recurse=>true,
    }
#审计密码文件
file { '/etc/passwd':
  audit=>all,
  }
  firewall::role{'webserver':}
  #}
 }

