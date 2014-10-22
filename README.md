### GettingAndCleaningDataProject
=============================

### Course Project
Contains code to read data based on the following study:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

and the following data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The code expects the study data to be in a folder as unziped, that is "./data/UCI HAR Dataset/".

The output is a summarized data of several of the mean and standard deviation columns for all subject grouped by subject (person studied) and their activties (Walking, Standing, etc.).

## Logic
This program uses the dplyr and tidyr packages.

The program reads all of the activity data, and all of the subject, test and training X and Y data from the sub-folders and combines them into a single data frame containg all the observations.

It then greps the column names for having 'mean' or 'std' in them and saves them into a data frame.

Then it gathers the activity labels into a data frame.

Then it builds a core tidy data table, X_tidy, consisting of the activity data with just those columns from the column names data frame, along with adding those column names to X_tidy.

Using X_tidy it creates a new table, X_tidy_activity_subject, combined with the subject and activity labels for each row.

X_tidy_activity_subject is then arranged and grouped by subject and activity to be summarised on each columns mean into X_tidy_mean which is then written to the output text file 'X_tidy_mean.txt'. 


## Code book
The mean and standard devation summaries are described in the study above.  All data values are from 0 to 1.0 based on the study sensor output.

The append columns are:

1.  'subject' - The number of the subject as taken from the study data.
2.  'activty' - The text label of the activty performed, e.g. WALKING, etc, see the study site for a complete list.
3.  ..n 'mean values' - The mean of the particular activity performed by the particular subject number.

#Author
Mark von der Lieth
Oct. 2014