### GettingAndCleaningDataProject
=============================

### Course Project
Contains code to read data based on the following study:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
and the following data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The code expects the study data to be in a folder as unziped, that is "./data/UCI HAR Dataset/".
The output is a summarized data of several of the mean and standard deviation columns for all subject grouped by subject (person studied) and their activties (Walking, Standing, etc.).

## Code book
The mean and standard devation summaries are described in the study above.
The append columns are:
1. subject - The number of the subject as taken from the study data.
2. activty - The text label of the activty performed, e.g. WALKING, etc, see the study site for a complete list.
3-n. <mean values for columns> - The mean of the particular activity performed by the particular subject number.

#Author
Mark von der Lieth
Oct. 2014