Wall Street Journal with ISS
============================

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

a. CreateLM20k.sh (or CreateLM5k.sh)

Converts the WSJ LM and word lists to generic formats in ./local


4. Now the test can be run.

a. CreateRecDict.sh (or CreateNetwork.sh if HVite is used for decoding)

Creates the recognition dictionary for use with HDecode.

b. ExtractTest.sh test-mfccez-si_et_20

Extracts testing data.

c. TestGMM.sh test-mfccez-si_et_20 (Use DECODER=HVite for HVite based decoding)

Runs the test.

d. Score.sh test-mfccez-si_et_20

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



Notes
=====

In principle the local directory could be copied to
/idiap/resource/database because it is static.  This would save
running many of the CreateXXX.sh scripts.  However, they are not
difficult to run.

--
Phil Garner, July 2011
