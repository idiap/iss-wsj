#!/usr/bin/zsh
#
# MLP training
#
# Marc Ferras, November 2011
#
echo Script: $0
source Config.sh
chdir.sh $*

# Variables for the main script
export FEAT_NAME=MFCC_E
export USE_GE=1
export N_JOBS=1

if [[ $USE_GE != 0 ]] ; then
  # choose queue on SGE
  export USE_QUEUE=q_1week_mth
  #export USE_QUEUE=q_1month
  case $USE_QUEUE in
    "q_1week_mth")
      export THREADS=4
      export MEM_FREE=3G
      ;;
    "q_1month")
      export THREADS=8
      export MEM_FREE=3G
      ;;
  esac
  export GE_OPTIONS="-l $USE_QUEUE -l mem_free=$MEM_FREE -pe pe_mth $THREADS"
fi

# Either 3 or 5 layers so far
# For 3 layers, follow David Imseng's scripts
# For 5 layers, a bottleneck arquitecture is assumed with layer sizes I-H1-H2-H3-O with constraints
#   - H1=H3
#   - H2=$MLP_BN_SIZE (specified in this script)
#export MLP_NLAYERS=5
#export MLP_BN_SIZE=50
export MLP_NLAYERS=3
trainMLP.sh
