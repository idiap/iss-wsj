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

# We use the CMU dictionary
ISS_DICTS=/idiap/group/speech/iss-dicts
sourceDict=$ISS_DICTS/cmudict/local/cmudict_SPHINX.dct

# Write the two dictionaries
cat <<EOF > $FLAT_DICT
<s>  [] sil
</s> [] sil
EOF
cp $FLAT_DICT $MAIN_DICT

dict-man.rb -a -o $FLAT_DICT ../oov-dict.txt $sourceDict
dict-man.rb -a -o $MAIN_DICT ../oov-dict.txt $sourceDict -s sp -s sil
