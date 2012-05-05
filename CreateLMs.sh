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

# Array of word lists.
listDir=../dbase/wsj0/lng_modl/vocab
listFiles=(
    wlist5c-nvp
    wlist20o-nvp
)

# Need to remove the 4 comment lines and escape the apostrophes
for lf in $listFiles
do
    l=$listDir/$(echo $lf | sed s/-/./)
    echo $l
    tail -n +4 $l \
        | sed "s/'/\\\'/g" \
        > $lf.txt
done

# Array of language models
arpaDir=../dbase/wsj1/doc/lng_modl/base_lm
arpaFiles=(
    bcb05cnp
    tcb05cnp
    bcb20onp
#    tcb20onp
)

# Uncompress, but *don't* escape apostrophes.  The HTK LM tools break
# with escapes.  The 20k trigram is 188M so uncomment if needed.
for af in $arpaFiles
do
    a=$arpaDir/$af.z
    echo $a
    if [[ $af == tcb20onp ]] # this one isn't compressed
    then
        cat $a
    else
        zcat $a
    fi > $af-arpa.txt
done
