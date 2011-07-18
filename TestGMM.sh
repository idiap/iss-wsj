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
export DECODE_LM_SCALE=16.0
export DECODE_WORD_PENALTY=-10.0
export PRUNE="300 300 5000"
export DECODER=HVite
export DECODE_DICT=$MAIN_DICT

# This is the acoutic model to use
export DECODE_MODEL_DIR=../plpz-si-284/hmm-eval

# This is the grammar
export DECODE_NETWORK=../wsj5k/network.txt

# Run the decode
decode.sh
