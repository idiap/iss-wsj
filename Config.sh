#!/bin/sh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, July 2011
#   Marc Ferras
#

# Allow setshell
software=/idiap/resource/software
source $software/initfiles/shrc $software

# SETSHELLs
SETSHELL hts
SETSHELL icsi-speech-tools
SETSHELL quicknet
SETSHELL grid

# Check for ISS; add it to the path
if [ "$ISSROOT" = "" ]
then
    echo "Please \"SETSHELL iss\" or point \$ISSROOT to an ISS installation"
    exit 1
fi
path=( $ISSROOT/bin $path )
fpath=( $ISSROOT/lib/zsh $fpath )

# Functions that ISS provides
autoload chdir.sh

# Shell variables
wsj0=/idiap/resource/database/WSJ0
wsj1=/idiap/resource/database/WSJ1

# Environment variables to pass to working scripts
export DBASE_ROOT=..
export AUDIO_NAME=wv1
export PHONESET=CMUbet
export FLAT_DICT=../local/flat-dict.txt
export MAIN_DICT=../local/main-dict.txt
export MIX_ORDER=16

# Basic grid operation
nCPUs=$(cat /proc/cpuinfo | fgrep processor | wc -l)
if false
then
    export USE_GE=1
    export N_JOBS=15
else
    export USE_GE=0
    export N_JOBS=$nCPUs
fi

# Front-end
# $FEAT_NAME is the directory to which features are written
export EXTRACT=hcopy
feats=plp
case $feats in
user)
    export FEAT_NAME=USER
    export TARGET_KIND=USER_D_A
    ;;
mfcc)
    export FEAT_NAME=MFCC_E
    export HCOPY_CONFIG=$ISSROOT/lib/config/MFCC_E.cfg
    export TARGET_KIND=MFCC_E_D_A_Z
    ;;
plp)
    export FEAT_NAME=PLP_0
    export HCOPY_CONFIG=$ISSROOT/lib/config/PLP_0.cfg
    export TARGET_KIND=PLP_0_D_A_Z
    ;;
esac

# Train and test lists
# Choose si-84 or si-284 for training
# It's best to leave the default at si-84 as it's quicker
train=si-84
case $train in
si-84)
    trainList=../local/si-84-list.txt
    ;;
si-284)
    trainList=../local/si-284-list.txt
    ;;
esac

# Various sets for decoding
# Default is the 5k system as it's quicker
export DECODER=HDecode
gram=b
task=h2-p0
case $task in
h2-p0)
    export LM_ARPA_FILE=../local/${gram}cb05cnp-arpa.txt
    export LM_WORD_LIST=../local/wlist5c-nvp.txt
    export SCORE_REFERENCE=../local/h2_p0.mlf
    testList=../local/h2_p0-list.txt
    ;;
20k)
    export LM_ARPA_FILE=../local/${gram}cb20onp-arpa.txt
    export LM_WORD_LIST=../local/wlist20o-nvp.txt
    export SCORE_REFERENCE=../local/si_et_20.mlf
    testList=../local/si_et_20-list.txt
    ;;
esac

# This should get overridden
export FILE_LIST=/dev/null

# For Tandem training; set to true
if false
then
    echo Config.sh: TANDEM MODE
    trainList=../fwdmlp-train-si-84/file-list-htk.txt
    testList=../fwdmlp-test-h2-p0/file-list-htk.txt
    export TARGET_KIND=USER
    export FEAT_DIM=32
fi
