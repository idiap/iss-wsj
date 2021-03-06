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
export TRN_MLF=../align/align-tri-trn.mlf
export TRN_LIST=../local/si-84-list-trn.txt
export DEV_MLF=../align/align-tri-dev.mlf
export DEV_LIST=../local/si-84-list-dev.txt
export TST_MLF=../align/align-tri-tst.mlf
export TST_LIST=../local/h2_p0-list-tst.txt

export USE_GE=0
export N_JOBS=1

# Either 3 or 5 layers so far
# For 3 layers, follow David Imseng's scripts
# For 5 layers, a bottleneck architecture is assumed with
# layer sizes I-H1-H2-H3-O with constraints
#   - H1=H3
#   - H2=$MLP_BN_SIZE (specified in this script)
export MLP_NLAYERS=3
#export MLP_BN_SIZE=50

init-mlp.sh
