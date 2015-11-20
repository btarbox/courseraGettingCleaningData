# courseraGettingCleaningData
Project files for the Getting and Cleaning Data course

run_analysis.R is the main script that reads the raw data files and processes them into the required tidy dataset.
The script should be run from the parent directory of datafiles.
It will output its new file in that same directory.

The script runs a series of steps, indicated by comments.

Step 1 reads the data files, sets user friendly column names and binds columns for subject and activity to the main table.
It then adds a column for testing vs. training for each of the testing and training datasets.
Finally it combines the testing and training datasets.

Step 2 selects just the columns we're interested in, "*mean*" and "*std*"

Step 3 turns the activity codes into factors and assigns them labels.

Step 4 of the instructions was accomplished in step 1 of this script.

Step 5 grouped and summarized each of the columns and output the final tidy dataset.
