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

SETSHELL srilm

# 20k vocab for now; just need to remove the 4 comment lines
sourceWords=$wsj0/dbase/wsj0/lng_modl/vocab/wlist20o.nvp
targetWords=wlist20o-nvp.txt
echo $targetWords
tail -n +4 $sourceWords > $targetWords
sed -i -e "s/'/\\\'/g" $targetWords

# 20k language model; just uncompress it
#sourceARPA=$wsj0/dbase/wsj0/lng_modl/base_lm/bcb20cnp.z
#targetARPA=bcb20cnp-arpa.txt
#targetARPAtmp=bcb20cnp-arpa.tmp
#cp $sourceARPA $targetARPA.z
#uncompress $targetARPA.z

sourceARPA=$wsj1/dbase/wsj1/doc/lng_modl/base_lm/tcb20onp.z
targetARPA=tcb20onp-arpa.txt
targetARPAtmp=tcb20onp-arpa.tmp
echo $targetARPA
sed -e "s/'/\\\'/g" $sourceARPA > $targetARPA
#cp $targetARPA $targetARPAtmp
ngram -unk -limit-vocab -lm $targetARPA -order 3 -write-lm $targetARPAtmp -vocab $targetWords
rm -f $targetARPA
cp $targetARPAtmp $targetARPA
chmod 644 $targetARPA
rm -f $targetARPAtmp
