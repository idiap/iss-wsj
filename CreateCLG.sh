#!/bin/zsh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, August 2011
#
source Config.sh
chdir.sh $*

# Where to find things
export WFST_LG_DIR=../wsj5k/wfst-lg

# Where to put things (inside the current output directory)
export WFST_CLG_DIR=wfst-clg-wsj5k

# Call the main script
export USE_GE=0
compose-clg.sh
