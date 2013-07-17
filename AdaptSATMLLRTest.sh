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
export WORD_MLF=$SCORE_REFERENCE
export FILE_LIST=$testList
export ADAPT_MODEL_DIR=../train-plp-si-84/hmm-eval-sat
export ADAPT_KIND=tree
export ADAPT_TRANS_KIND=MLLRMEAN
export ADAPT_TRANS_EXT=mllr
export ADAPT_PATTERN='*/%%%?????.htk'
export SAT_TRANS_DIR=../cmllr-plp-h2-p0/adapt-base
export SAT_TRANS_EXT=cmllr

init-adapt.sh
adapt-mllr.sh
