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

a. ExtractTrain.sh my-train-dir

Extracts features to the feats directory.

b. Train.sh my-train-dir

Trains an HMM-GMM model using HTS.


3. Prepare for testing.

a. CreateLM.sh

Converts the WSJ LM and word lists to generic formats in ./local


4. Now the test can be run.

a. CreateNetwork.sh my-test-dir

Creates an HTK network suitable for decoding using HVite.

b. ExtractTest.sh my-test-dir

Extracts testing data.

c. TestGMM.sh my-test-dir

Runs the test.

d. Score.sh my-test-dir

Score the test.


Notes
=====

In principle the local directory could be copied to
/idiap/resource/database because it is static.  This would save
running many of the CreateXXX.sh scripts.  However, they are not
difficult to run.

--
Phil Garner, July 2011
