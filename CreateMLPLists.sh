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

trainMLF=si_tr_s.mlf
testMLF=$SCORE_REFERENCE
PERCENT_TRAIN=90
#MAX_SPEAKERS=50
MAX_SPEAKERS=-1

# do train/dev splitting
SPK_LIST=`echo $trainList | sed -e 's/\.txt/-spk\.txt/g'`
(( PERCENT_DEV = 100 - PERCENT_TRAIN ))
SPK_LIST_TRN=`echo $trainList | sed -e 's/\.txt/-spk-trn\.txt/g'`
FILE_LIST_TRN=`echo $trainList | sed -e 's/\.txt/-trn\.txt/g'`
SPK_LIST_DEV=`echo $trainList | sed -e 's/\.txt/-spk-dev\.txt/g'`
FILE_LIST_DEV=`echo $trainList | sed -e 's/\.txt/-dev\.txt/g'`

# create speaker list
cat $trainList | awk '{ fname=system("basename " $1) }' | cut -c1-3 | sort -u > $SPK_LIST 

# keep either all speakers or just MAX_SPEAKERS
nAllSpk=`cat $SPK_LIST | wc -l`
if [[ $MAX_SPEAKERS > 0 ]] ; then
  echo "Limiting the number of speakers to $MAX_SPEAKERS"
  shuf $SPK_LIST | head -$MAX_SPEAKERS > ${SPK_LIST}.tmp
  mv ${SPK_LIST}.tmp $SPK_LIST
  nAllSpk=`cat $SPK_LIST | wc -l`
fi

# split data sets
((nTrainSpk = nAllSpk * PERCENT_TRAIN / 100))
(( nDevSpk = nAllSpk - nTrainSpk))
echo "Splitting $SPK_LIST (100%, $nAllSpk spks.) into train ($PERCENT_TRAIN%, $nTrainSpk spks.) and dev ($PERCENT_DEV%, $nDevSpk spks.) sets"

shuf $SPK_LIST > /dev/shm/${SPK_LIST}_shuf
cat /dev/shm/${SPK_LIST}_shuf | head -$nTrainSpk > $SPK_LIST_TRN
cat /dev/shm/${SPK_LIST}_shuf | tail -$nDevSpk > $SPK_LIST_DEV
rm -f /dev/shm/${SPK_LIST}_shuf

# generate file lists for train and dev
cat /dev/null > $FILE_LIST_TRN
for spk in $(cat $SPK_LIST_TRN)
do
  grep "\/$spk\/" $trainList >> $FILE_LIST_TRN
done

cat /dev/null > $FILE_LIST_DEV
for spk in $(cat $SPK_LIST_DEV)
do
  grep "\/$spk\/" $trainList >> $FILE_LIST_DEV
done

nAll=`cat $trainList | wc -l`
nTrain=`cat $FILE_LIST_TRN | wc -l`
nDev=`cat $FILE_LIST_DEV | wc -l`
echo "$nTrain utts. for training set, $nDev utts. for development set"

# generate train and dev transcriptions
echo "Generating transcripts for train and dev sets"
MLF=`echo $FILE_LIST_TRN | sed -e 's/\.txt/\.mlf/g'`
mlfmatch.sh $trainMLF $FILE_LIST_TRN > $MLF
MLF=`echo $FILE_LIST_DEV | sed -e 's/\.txt/\.mlf/g'`
mlfmatch.sh $trainMLF $FILE_LIST_DEV > $MLF



# do test list
FILE_LIST_TEST=`echo $testList | sed -e 's/\.txt/-tst\.txt/g'`
SPK_LIST=`echo $testList | sed -e 's/\.txt/-spk\.txt/g'`
cat $testList | awk '{ fname=system("basename " $1) }' | cut -c1-3 | sort -u > $SPK_LIST
nTestSpk=`cat $SPK_LIST | wc -l`
cp $testList $FILE_LIST_TEST
nTest=`cat $FILE_LIST_TEST | wc -l`
echo "$nTest utts. for test ($nTestSpk spks.)"
# generate MLF for test data
echo "Generating transcripts for test set"
MLF=`echo $FILE_LIST_TEST | sed -e 's/\.txt/\.mlf/g'`
cp $testMLF $MLF
