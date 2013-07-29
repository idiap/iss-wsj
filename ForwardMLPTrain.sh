#!/bin/zsh
#
# Copyright 2010 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   David Imseng, November 2010
#   Phil Garner, July 2013
#

echo Script: $0
source Config.sh
chdir.sh $*

# Variables for the main script
export FILE_LIST=../local/si-84-list.txt
export MLP_WEIGHT_FILE=../mlptrain-si-84/351x1257x40.mat
export MLP_TANDEM_STATS=mlp-tandem-stats
export MLP_OUT_HTK_DIR=si-84-351x1257x40-tandem

forward-mlp.sh
train-klt.sh
forward-klt.sh
