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

# TB 5800 => 2178 states
# TB 4000 => 2829 states
# TB 3750 => 2953 states
# TB 3650 => 2997 states
# TB 3645 => 3001 states
# TB 3640 => 3004 states
# TB 3625 => 3010 states
# TB 3600 => 3025 states
# TB 3500 => 3090 states

export TIED_MIN_CLUSTER=300
#export TIE_MAX_LLK_INC=3645
export TIE_FORCE_NSTATES=3000

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
		maxMixOrder=$MIX_ORDER
    for i in 1 2 4 8 $maxMixOrder
    do
        export MIX_ORDER=$i
        mix-up.sh
    done
    synth-full.sh
    ;;
esac
