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

# For juicer, we need the deltas too
#export FEAT_NAME=PLP_0_D_A_Z
#export HCOPY_CONFIG_TARGET=1

# Variables for the main script
export FILE_LIST=$testList

extract.sh
