# Wall Street Journal with ISS

## Data preparation.  Execute the following scripts in order.

Set up links to the WSJ database, and also your own temp
space (for features):
```sh
CreateLinks.sh
```

This converts the .dot files supplied with WSJ into .mlf label files
in the local directory:
```sh
CreateLabels.sh
```

This will generate the file lists used for training and testing:
```sh
CreateLists.sh
```

This script creates the two dictionaries required for training: flat
(basic) and main (with sil and sp final phones):
```sh
CreateDicts.sh
```


## Now a system can be trained.

Extract features to the feats directory.  You can choose the output
directory; just make sure it remain the same for all training
commands:
```sh
ExtractTrain.sh train-plp-si-84
```

Train an HMM-GMM model using HTS:
```sh
TrainGMM.sh train-plp-si-84
```


## Prepare for testing.

Convert the WSJ LM and word lists to generic formats in `./local`:
```sh
CreateLMs.sh
```

Create a language model suitable for the selected decoder.  Check the
Config.h file for the desired one.  You can choose the output
directory; note that it's acoustic model independent, so something
language model specific is appropriate.
```sh
CreateLM.sh wsj5k
```


## Now the test can be run.

Extract testing data:
```sh
ExtractTest.sh test-plp-h2-p0
```

Run the test:
```sh
TestGMM.sh test-plp-h2-p0
```

Score the test:
```sh
Score.sh test-plp-h2-p0
```
Result should be:
```
SENT: %Correct=36.74 [H=79, S=136, N=215]
WORD: %Corr=91.58, Acc=90.65 [H=3525, D=86, S=238, I=36, N=3849]
```

## Speaker Adaptive Training (SAT)

Estimate CMLLR transforms for the training set:
```sh
AdaptMLLRTrain.sh cmllr-plp-si-84 
```

Train CMLLR speaker normalized acoustic models:
```sh
RetrainGMM.sh train-plp-si-84
```

Estimate CMLLR transforms (supervised) for the test set:
```sh
AdaptMLLRTest.sh cmllr-plp-h2-p0
```

Run the test with speaker adapted models:
```sh
TestSATGMM.sh test-plp-h2-p0-sat
```

Score the test:
```sh
Score.sh test-plp-h2-p0-sat
```
Result should be
```
SENT: %Correct=44.19 [H=95, S=120, N=215]
WORD: %Corr=93.45, Acc=92.70 [H=3597, D=71, S=181, I=29, N=3849]
```

## SAT+MLLR Speaker Adaptation

Estimate MLLR transforms for the test set with the speaker adapted
models:
```sh
AdaptMLLR-sat-test.sh mllr-plp-h2-p0
```

Run the test with speaker adapted models plus MLLR:
```sh
TestSATMLLRGMM.sh test-plp-h2-p0-sat-mllr
```
Score the test:
```sh
Score.sh test-plp-h2-p0-sat-mllr
```
Score should be:
```
SENT: %Correct=54.88 [H=118, S=97, N=215]
WORD: %Corr=95.53, Acc=95.14 [H=3677, D=55, S=117, I=15, N=3849]
```

## Tandem features from MLP phone posteriors

This will generate train, dev and test lists. Train and dev used for MLP
training
```sh
CreateMLPLists.sh
```

This will generate phone alignments for the train, dev and test MLP
lists. The acoustic models to use must be specified within
`CreateMLPLabels.sh`.
```sh
CreateMLPLabels.sh align
```

Shuffle and prepare Quicknet data for MLP training (see MLP
architecture set-up inside the script.)
```sh
InitMLP.sh mlptrain-si-84
```

Train MLP, outputs a mat file with architecture as file name.
```sh
TrainMLP.sh mlptrain-si-84
```

Runs a MLP forward pass on the training data, trains the KLT transform and
applies log and KLT to obtain tandem features.
```sh
ForwardMLPTrain.sh fwdmlp-train-si-84
```

Computes tandem features for the test set (it uses the KLT stats from the
previous step).
```sh
ForwardMLPTest.sh fwdmlp-test-h2-p0
```

The train and test tandem features are stored into
`feats/$featName/$MLP_OUT_HTK_DIR`. `MLP_OUT_HTK_DIR` is defined inside
`ForwardMLP-train.sh` and `ForwardMLP-test.sh` respectively. To use tandem
features to train and test acoustic models change the `trainList` and
`testList` variables in `Config.sh` to:
```sh
trainList=../fwdmlp-train-si-84/file-list-htk.txt
testList=../fwdmlp-test-h2-p0/file-list-htk.txt
```

Trains an HMM-GMM model using tandem features.
```sh
TrainGMM.sh train-tandem-si-84
```

Run the test (You need to change the acoustic models used to
`acousticModel=../train-tandem-si-84`)
```sh
TestGMM.sh test-tandem-h2-p0
```

Score the test.
```sh
Score.sh test-tandem-h2-p0
```
Result should be:
```
SENT: %Correct=32.56 [H=70, S=145, N=215]
WORD: %Corr=91.48, Acc=89.76 [H=3521, D=88, S=240, I=66, N=3849]
```

# Notes

In principle the local directory could be copied to a static site
directory.  This would save running many of the CreateXXX.sh scripts.
However, they are not difficult to run.


[Phil Garner](http://www.idiap.ch/~pgarner), July 2011

Marc Ferras
