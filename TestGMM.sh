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
export DECODE_DICT=$MAIN_DICT

# This is the acoustic model to use
acousticModel=../test-dir
export DECODE_MODEL_DIR=$acousticModel/hmm-eval

# The other things depend on which decoder is used
export DECODER=HVite
case $DECODER in
'HVite')
    # This is the grammar
    export DECODE_NETWORK=../wsj5k/network.txt
    export DECODE_LM_SCALE=16.0
    export DECODE_WORD_PENALTY=-10.0
    export PRUNE="300 300 5000"
    ;;
'HDecode')
    # HDecode should be a 32 bit version, so override it.
    export HDECODE=/idiap/resource/software/HTK/HTK_V3.4.1/bin/HDecode
    # This is the grammar
    #export DECODE_GRAMMAR=../local/bcb20cnp-arpa.txt
    export DECODE_GRAMMAR=../local/tcb20onp-arpa.txt
    export DECODE_DICT=../wsj20k/rec-dict.txt
    export NET_WORDS=../local/wlist20c-nvp.txt
    export DECODE_LM_SCALE=16.0
    export DECODE_WORD_PENALTY=-10.0
    export PRUNE="250.0 250.0"
    export DECODE_BLOCK_SIZE=5
    ;;
'Juicer')
    export FEAT_NAME=PLP_0_D_A_Z
    export WFST_LG_DIR=../wsj5k/wfst-lg
    export WFST_CLG_DIR=$acousticModel/wfst-clg-wsj5k
    export Tracter_Verbose=1
    ;;
esac

# Run the decode
decode.sh
