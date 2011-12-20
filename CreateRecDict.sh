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
chdir.sh wsj20k

export USE_GE=0
export FILE_LIST=/dev/null

lm=../local/bcb20cnp-arpa.txt
words=../local/wlist20o-nvp.txt
wordsSorted=wlist20c-nvp-sorted.txt
dict=rec-dict.txt
inputDict=../local/flat-dict.txt
inputDictSorted=flat-dict-sorted.txt
dictTmp=$dict.tmp

sed -e "s/^'/\\'/g" $inputDict | sort -k1,1 > $inputDictSorted
sed -e "s/^'/\\'/g" $words | sort -k1,1 > $wordsSorted

join -1 1 -2 1 $wordsSorted $inputDictSorted > $dictTmp

# remove any word with sil pronunciation
grep -v "sil" $dictTmp > $dict

cat <<EOF > $dictTmp
<s>  [] sil
</s> [] sil
EOF
cat $dict >> $dictTmp
rm -f $dict
cp $dictTmp $dict

# add oov words
#oovDict=../oov-dict-hdecode.txt
#dict-man.rb -a -o $dict $oovDict $dictTmp
##sed -i -e "s/\\\'/'/g" $dict
##sed -i -e "s/^'/\\\'/g" $dict
rm -f $dictTmp
