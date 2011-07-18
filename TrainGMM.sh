#!/bin/zsh
#
# Copyright 2010 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, October 2010
#

#
# Train script
#
echo Script: $0
source Config.sh
chdir.sh $*

# Variables for the main script
export WORD_MLF=../local/si_tr_s.mlf
export FILE_LIST=$trainList

# The main recipe.  You can jump in at various points.
start=${START:-init}
case $start in
init)
    init-train.sh
    flat-start.sh
    fix-silence.sh
    align.sh
    reestimate-mono.sh
    init-tri.sh
    reestimate-tri.sh
    tie.sh
    ;&
mix-up)
    for i in 1 2 4 8 16
    do
        export MIX_ORDER=$i
        mix-up.sh
    done
    synth-full.sh
    ;;
esac
