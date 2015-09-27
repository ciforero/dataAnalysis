# run_analysis()

This script generates a tidy data set for the Samsung smartphone data available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

It assumes that the .zip file was unzipped in the current working directory, such that the files "activity_labels.txt", "features.txt", "features_info.txt" and "README.txt" are in the current directory, as well as the two folders "test" and "train".

As a prerequisite to running this script, the package dplyr must be already installed.

These are the steps executed by the script:
* Read the feature names and assign them to a vector (file "features.txt")
* Read the test data (located in the subfolder "test").  The resulting data set will contain all the test data, including activity id, subject and the columns will be named according to the features previously read
* Read the training data (located in the subfolder "train").  The resulting data set will contain all the training data, including activity id, subject and the columns will be named according to the features previously read
* Merge into a single data set the test and training data.  Only columns related to means, standard deviation, activity and subject will be included in the new data set
* Replace the activity id with the activity name to add some clarity to the output data
* Load library dplyr
* Generate tidy data set containing the average for all the features (related to mean and standard) per activity and subject
* Return the tidy data set
  
