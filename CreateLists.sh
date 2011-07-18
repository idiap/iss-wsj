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
chdir.sh local

# Associative array of list names
typeset -A listMap
listMap=(
    si-84    ../dbase/wsj0/doc/indices/train/tr_s_wv1.ndx      #  7,236 utts
    si_et_05 ../dbase/wsj0/doc/indices/test/nvp/si_et_05.ndx   #    330 utts
    si-200   ../dbase/wsj1/doc/indices/wsj1/train/tr_s_wv1.ndx # 30,278 utts
    h2_p0    ../dbase/wsj1/doc/indices/wsj1/eval/h2_p0.ndx     #    215 utts
)

# Convert each list to ISS form
for l in si-84 si-200 si_et_05 h2_p0
do
    echo $l
    cat $listMap[$l] \
        | grep -v "^;" \
        | cut -d":" -f2 \
        | cut -d"." -f1 \
        > $l-list.txt
done

# si-284 is the the sum of the other two
echo si-284
cat si-84-list.txt si-200-list.txt > si-284-list.txt
