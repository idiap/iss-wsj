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

# Associative array of dot directories
typeset -A dirMap
dirMap=(
    si-101   ../dbase/wsj0/transcrp/dots/si_tr_s # 101 speakers
    si_et_05 ../dbase/wsj0/si_et_05              #   8 speakers
    si-200   ../dbase/wsj1/trans/wsj1/si_tr_s    # 200 speakers
    h2_p0    ../dbase/wsj1/si_et_h2/wsj5k        #  10 speakers
)

# Extension of the reference files
typeset -A refMap
refMap=(
    si-101   dot
    si_et_05 dot
    si-200   dot
    h2_p0    lsn
)

# Find files and convert to MLF
for d in si-101 si-200 si_et_05 h2_p0
do
    if [ ! -e $d-refs.txt ]
    then
        echo Searching $dirMap[$d] for $d $refMap[$d] files
        find -L $dirMap[$d] -name \*.$refMap[$d] > $d-refs.txt
    fi
done

# For training, write out the word list too for OOV discovery
dot-to-lab.rb -w si_tr_s-words.txt $(cat si-101-refs.txt si-200-refs.txt) \
    > si_tr_s.mlf

# In the testing data we delete the noises
# ...actually the lsn format should have done that for h2_p0
dot-to-lab.rb -d $(cat si_et_05-refs.txt) > si_et_05.mlf
dot-to-lab.rb -d $(cat h2_p0-refs.txt) > h2_p0.mlf
