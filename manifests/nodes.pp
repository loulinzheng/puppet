node 'kali','kali2' {
 file {'/tmp/hello':
   content=>"Hello World\n",
   }
 include puppet
 }

