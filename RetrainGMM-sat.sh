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
export SAT_TRANS_DIR=../adaptcmllr-mfccez-si-284/adapt-base
export SAT_TRANS_EXT=cmllr
export DECODE_PATTERN='*/%%%?????.htk'

export RETRAIN_OUT_SUFFIX=sat
retrain-lt.sh

export EVAL_SOURCE_DIR=hmm-tied-${RETRAIN_OUT_SUFFIX}
export EVAL_MODEL_DIR=hmm-eval-${RETRAIN_OUT_SUFFIX}
synth-full.sh
