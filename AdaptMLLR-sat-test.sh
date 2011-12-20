#!/bin/zsh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, September 2011
#
echo Script: $0
source Config.sh
chdir.sh $*

# Variables for the main script
export WORD_MLF=../local/si_et_20.mlf
export FILE_LIST=$testList
export MIX_ORDER=16
export ADAPT_MODEL_DIR=../train-mfccez-si-284/hmm-eval-sat
export ADAPT_KIND=tree
export ADAPT_TRANS_KIND=MLLRMEAN
export ADAPT_TRANS_EXT=mllr
export ADAPT_PATTERN='*/%%%?????.htk'
export SAT_TRANS_DIR=../adaptcmllr-mfccez-si_et_20/adapt-base
export SAT_TRANS_EXT=cmllr

init-adapt.sh
adapt-mllr.sh
