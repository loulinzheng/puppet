$ssh_service=$::operatingsystem?{
/Ubuntu|Debian/=>'ssh',
default        =>'sshd',
}




class puppet {
  file { '/usr/local/bin/papply':
    source =>'puppet:///modules/puppet/papply.sh',
    mode   =>'0755',
  }
  file { '/usr/local/bin/pull-updates':
    source =>'puppet:///modules/puppet/pull-updates.sh',
    mode   =>'0755',
  }
#  file { '/root/.ssh/id_rsa':
#    source =>'puppet:///modules/puppet/root.priv',
#    owner  =>'root',
#    mode   =>'0600',
#  }
#service {$ssh_service:
#ensure=>running,
#}

  cron { 'run-puppet':
    ensure  =>present,
    user    =>'root',
    command =>'/usr/local/bin/pull-updates',
    minute  =>'*/30',
    hour    =>'*',
  }
  cron { 'run-puppet-for-hardtime':
    ensure  =>present,
    user    =>'root',
    command =>'/usr/local/bin/pull-updates',
    minute  =>'00',
    hour    =>inline_template('<%=@hostname.sum%24%>'),
  }
}


