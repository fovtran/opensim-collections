#!/bin/tcsh
export mirror_json http://www.cpan.org/indices/mirrors.json
/usr/local/bin/rsync -av --delete cpan-rsync.perl.org::CPAN /opt/project/CPAN/
