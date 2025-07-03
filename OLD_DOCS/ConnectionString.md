19887  cat Luminal.ini 
19888  fd 'StandaloneCommon.ini'
19889  egrep -e 'Connectionstring'  opensim-0.9.1.1/bin/config-include/StandaloneCommon.ini
19890  egrep -e 'ConnectionString' opensim-0.9.1.1/bin/config-include/StandaloneCommon.ini
19891  fd '*.ini'
19892  fd --glob '*.ini'
19893  fd --help
19894  fd --glob '*.ini' -X ack2
19895  ack2
19896  ack2 'ConnectionString'
19897  ack2 'ConnectionString' ./*.ini
19898  ack2 'ConnectionString' *.ini
19899  ack2 'ConnectionString' /
19900  ack2 'ConnectionString' .
19901  ack2 'ConnectionString =' .
19902  clear
19903  ack2 'ConnectionString =' .
19904  fd --glob '*.db'
19905  history | tail -n 20
19906  history | tail -n 20  > ../ConnectionString.md
