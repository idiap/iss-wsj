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
export ADAPT_MODEL_DIR=../train-plp-si-84/hmm-eval
export ADAPT_KIND=base
export ADAPT_TRANS_KIND=CMLLR
export ADAPT_TRANS_EXT=cmllr
export ADAPT_PATTERN='*/%%%?????.htk'

init-adapt.sh
adapt-mllr.sh
