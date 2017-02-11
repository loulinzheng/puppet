node 'kali' {
 file {'/tmp/hello':
   content=>"Hello World\n",
   }
 }

