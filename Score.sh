#!/bin/zsh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, July 2011
#
echo Script: $0
source Config.sh
chdir.sh $*

# Variables for the main script
export USE_GE=0
export FILE_LIST=$testList
#export SCORE_REFERENCE=../local/si_et_05.mlf
#export SCORE_REFERENCE=../local/h1_p0.mlf

# Call the main script
score.sh
