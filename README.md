# Wall Street Journal with ISS

1. Data preparation.  Execute the following scripts in order.

a. CreateLinks.sh

This will set up links to the WSJ database, and also your own temp
space (for features).

b. CreateLabels.sh

This converts the .dot files supplied with WSJ into .mlf label files
in the local directory.

c. CreateLists.sh

This will generate the file lists used for training and testing.

d. CreateDicts.sh

This script creates the two dictionaries required for training: flat
(basic) and main (with sil and sp final phones).


2. Now a system can be trained.

a. ExtractTrain.sh train-mfccez-si-284

Extracts features to the feats directory.

b. Train.sh train-mfccez-si-284

Trains an HMM-GMM model using HTS.


3. Prepare for testing.

a. CreateLMs.sh

Converts the WSJ LM and word lists to generic formats in ./local

c. CreateLM.sh wsj20k

Creates a language model suitable for the selected decoder


4. Now the test can be run.

a. ExtractTest.sh test-mfccez-si_et_20

Extracts testing data.

b. TestGMM.sh test-mfccez-si_et_20

Runs the test.

c. Score.sh test-mfccez-si_et_20

Score the test.


5. Speaker Adaptive Training (SAT)

a. AdaptCMLLR-train.sh adaptcmllr-mfccez-si-284 

Estimate CMLLR transforms for the training set

b. RetrainGMM-sat.sh train-mfccez-si-284

Train CMLLR speaker normalized acoustic models

c. AdaptCMLLR-test.sh adaptcmllr-mfccez-si_et_20

Estimate CMLLR transforms (supervised) for the test set

d. TestGMM-sat.sh test-mfccez-si_et_20-sat

Run the test with speaker adapted models

e. Score.sh test-mfccez-si_et_20-sat

Score the test.


6. SAT+MLLR Speaker Adaptation

a. AdaptMLLR-sat-test.sh adaptmllr-mfccez-si_et_20

Estimate MLLR transforms for the test set with the speaker adapted models

b. TestGMM-sat-mllr.sh test-mfccez-si_et_20-sat-mllr

Run the test with speaker adapted models plus MLLR

c. Score.sh test-mfccez-si_et_20-sat-mllr

Score the test.


7. Tandem features from MLP phone posteriors

a. CreateMLPLists.sh

This will generate train, dev and test lists. Train and dev used for MLP
training

b. CreateMLPLabels.sh align

This will generate phone alignments for the train, dev and test MLP
lists. The acoustic models to use must be specified within
CreateMLPLabels.sh.

c. PrepareMLP.sh mlptrain-si-284

Shuffle and prepare Quicknet data for MLP training (see MLP
architecture set-up inside the script.)

c. TrainMLP.sh mlptrain-si-284

Train MLP, outputs a mat file with architecture as file name.

d. ForwardMLP-train.sh fwdmlp-train-si-284

Runs a MLP forward pass on the training data, trains the KLT transform and
applies log and KLT to obtain tandem features.

e. ForwardMLP-test.sh fwdmlp-test-si_et_20

Computes tandem features for the test set (it uses the KLT stats from the
previous step).

The train and test tandem features are stored into
feats/$featName/$MLP_OUT_HTK_DIR . MLP_OUT_HTK_DIR is defined inside
ForwardMLP-train.sh and ForwardMLP-test.sh respectively. To use tandem
features to train and test acoustic models change the trainList and
testList variables in Config.sh to:

  trainList=../fwdmlp-train-si-284/file-list-htk.txt
  testList=../fwdmlp-test-si_et_20/file-list-htk.txt

f. Train.sh train-tandem-si-284

Trains an HMM-GMM model using tandem features.

g. TestGMM.sh test-tandem-si_et_20

Runs the test (You need to change the acoustic models used to
acousticModel=../train-tandem-si-284)

h. Score.sh test-tandem-si_et_20

Score the test.



# Notes

In principle the local directory could be copied to
/idiap/resource/database because it is static.  This would save
#acousticModel=../train-351x4423x100x4423x40-tandem-si-284
running many of the CreateXXX.sh scripts.  However, they are not
difficult to run.

--
[Phil Garner](http://www.idiap.ch/~pgarner), July 2011
Marc Ferras
