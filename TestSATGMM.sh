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
export FILE_LIST=$testList

# Specify the two models to use
acousticModel=../train-plp-si-84
languageModel=../wsj5k
export DECODE_ACOUSTIC_MODEL_DIR=$acousticModel/hmm-eval-sat
export DECODE_LANGUAGE_MODEL_DIR=$languageModel/htk-lm

# SAT-specific variables
export SAT_TRANS_DIR=../cmllr-plp-h2-p0/adapt-base
export SAT_TRANS_EXT=cmllr
export DECODE_PATTERN='*/%%%?????.htk'

# The other things depend on which decoder is used
case $DECODER in
'HVite')
    export DECODE_LM_SCALE=16.0
    export DECODE_WORD_PENALTY=-10.0
    export PRUNE="300 300 5000"
    ;;
'HDecode')
    # HDecode should be a 32 bit version, so override it.
    export HDECODE=/idiap/resource/software/HTK/HTK_V3.4.1/bin/HDecode
    export DECODE_LM_SCALE=16.0
    export DECODE_WORD_PENALTY=-10.0
    export PRUNE="250.0 250.0"
    export DECODE_BLOCK_SIZE=1
    ;;
'Juicer')
    export FEAT_NAME=PLP_0_D_A_Z
    export WFST_LG_DIR=../wsj5k/wfst-lg
    export WFST_CLG_DIR=$acousticModel/wfst-clg-wsj5k
    export Tracter_Verbose=1
    ;;
esac

# Run the decode
decode-sat.sh
