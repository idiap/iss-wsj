#!/bin/zsh
#
# Copyright 2011 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, July 2011
#
source Config.sh
chdir.sh wsj5k

export USE_GE=0
export FILE_LIST=/dev/null

# Network inputs
export NET_LM=../local/bcb05cnp-arpa.txt
export NET_WORDS=../local/wlist5c-nvp.txt

# Call the main script
build-net.sh
