#!/bin/zsh
#
# Copyright 2010 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#

#
# Align train/dev/test transcriptions to data
#
# Marc Ferras, November 2011
#
echo Script: $0
source Config.sh
chdir.sh $*

# Variables for the main script
export HMM_TRAIN_DIR=../train-mfccez-si-284
export ALIGN_MODEL_DIR=$HMM_TRAIN_DIR/hmm-eval
export HTS_CONFIG=$HMM_TRAIN_DIR/main.cnf
export MODEL_NAME=mmf.txt
export DECODER=HVite
export ALIGN_CD=1

export WORD_MLF=../local/si-284-list-trn.mlf
export FILE_LIST=../local/si-284-list-trn.txt
export ALIGN_MLF=align-tri-trn.mlf
if [[ ! -f $ALIGN_MLF ]] ; then
  align.sh
fi

export WORD_MLF=../local/si-284-list-dev.mlf
export FILE_LIST=../local/si-284-list-dev.txt
export ALIGN_MLF=align-tri-dev.mlf
if [[ ! -f $ALIGN_MLF ]] ; then
  align.sh
fi

export WORD_MLF=../local/si_et_20-list-tst.mlf
export FILE_LIST=../local/si_et_20-list-tst.txt
export ALIGN_MLF=align-tri-tst.mlf
if [[ ! -f $ALIGN_MLF ]] ; then
  align.sh
fi

