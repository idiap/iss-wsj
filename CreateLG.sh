#!/bin/zsh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, August 2011
#
source Config.sh
chdir.sh wsj5k

export WFST_LM=../local/bcb05cnp-arpa.txt
export WFST_WORDS=../local/wlist5c-nvp.txt
export WFST_NORM_LM=1

# This is just for the monophone list
export WFST_MODEL_DIR=../plpz-si-284/hmm-eval

# -log10(0.5)
export WFST_LM_SCALE=16.0
export WFST_WORD_PENALTY=-10.0
#export WFST_WORD_PENALTY=-14.8165

# Call the main script
export USE_GE=0
compose-lg.sh
