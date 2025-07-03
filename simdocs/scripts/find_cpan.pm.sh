#!/bin/tcsh
find `perl -le '$,="\n"; print @INC'` -name CPAN.pm 
