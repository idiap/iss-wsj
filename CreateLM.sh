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
chdir.sh local

# 5k vocab for now; just need to remove the 4 comment lines
sourceWords=$wsj0/dbase/wsj0/lng_modl/vocab/wlist5c.nvp
targetWords=wlist5c-nvp.txt
echo $targetWords
tail -n +4 $sourceWords > $targetWords

# 5k language model; just uncompress it
sourceARPA=$wsj0/dbase/wsj0/lng_modl/base_lm/bcb05cnp.z
targetARPA=bcb05cnp-arpa.txt
echo $targetARPA
cp $sourceARPA $targetARPA.z
uncompress $targetARPA.z
chmod 644 $targetARPA
