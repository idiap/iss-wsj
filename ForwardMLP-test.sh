#!/usr/bin/zsh
#
# Prepare MLP training
#
# David Imseng, November 2010
#
echo Script: $0
source Config.sh
chdir.sh $*

# Variables for the main script
export FEAT_NAME=MFCC_E
export FILE_LIST=../local/si_et_20-list.txt
export MLP_WEIGHT_FILE=../mlptrain-si-284/351x6691x40.mat

export MLP_TANDEM_TEST=1
export MLP_TANDEM_STATS=../fwdmlp-train-si-284/mlp-tandem-stats

export MLP_OUT_HTK_DIR=si_et_20-351x6691x40-tandem

forwardMLP.sh
