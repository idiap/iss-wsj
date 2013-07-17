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
chdir.sh $*

export USE_GE=0
export FILE_LIST=/dev/null

# Call the main script
ht-create-lm.sh
