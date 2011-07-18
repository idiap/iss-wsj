#!/bin/zsh
#
# Copyright 2010 by Idiap Research Institute, http://www.idiap.ch
#
# See the file COPYING for the licence associated with this software.
#
# Author(s):
#   Phil Garner, October 2010
#

#
# Panic - everything is going horribly wrong.  Remove all jobs from
# grid engine
#
source Config.sh
qdel -u $(whoami)
