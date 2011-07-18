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

# Variables
temp=/idiap/temp/$(whoami)/dbase/WSJ

# Flatten the two WSJ dbs into a single structure
echo WSJ dbase links
for d in dbase audio/wv1 audio/wv2
do
    mkdir -p $d
    ln -sf $wsj0/$d/wsj0 $d/wsj0
    ln -sf $wsj1/$d/wsj1 $d/wsj1
done

# Some auxiliary things
ln -sf $wsj0/dbase/csrnov92.doc dbase/csrnov92.doc
ln -sf $wsj1/dbase/csrnov93.doc dbase/csrnov93.doc
ln -sf $wsj1/dbase/tranfilt dbase/tranfilt
#ln -sf $wsj1/dbase/score    dbase/score

# Link in the temp dir
feats=$temp/feats
echo Write features to $feats
mkdir -p $feats
ln -sf $feats feats
