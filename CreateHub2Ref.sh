#!/bin/zsh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, July 2011
#
source Config.sh

if [ ! -e tranfilt ]
then
    cp -rL dbase/tranfilt .
    (
        # A few hacks to build the tranfilt tools
        chmod 755 tranfilt
        cd tranfilt
        chmod 644 *
        mv nov93flt nov93flt.
        mv ut_rfilt ut_rfilt.
        make
        cc -m32 -o rfilter1 rfilter1.c
        mv ut_rfilt.pl ut_rfilt.tmp
        echo '#!/usr/bin/perl' > ut_rfilt.pl
        cat ut_rfilt.tmp >> ut_rfilt.pl
        chmod +x ut_rfilt.pl
        make test
    )
fi

chdir.sh hub2ref
cp ../dbase/wsj1/doc/nov93_h2/cu_htk2.hyp .
cp ../dbase/wsj1/doc/nov93_h2/cu_htk2.scr .
../tranfilt/nov93flt.sh < cu_htk2.hyp > cu_htk2.filt.hyp
dot-to-lab.rb -e rec cu_htk2.hyp > decode.hyp
dot-to-lab.rb -e rec cu_htk2.filt.hyp > decode.filt.hyp
ln -s decode.filt.hyp decode.mlf
