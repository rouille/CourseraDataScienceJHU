## Introduction
This repository encloses the Getting and Cleaning Data Course Project. The purpose of this project is to collect, work with, and clean a dataset.

Data from the accelerometers from the Samsung Galaxy S smartphone are used in this project. A full description of these data is available at the following url:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones;

and the dataset itself can be downloaded through this link: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Assignment
In accordance with the assignment, the R script, `run_analysis.R`, does the following:
* Downloads the dataset if not present in the working directory.
* Loads the list of activities performed by the subjects as well as the list of features selected for this dataset.
* Loads the test and training datasets, keeping only the columns associated to the mean and standard deviation of each variable.
* Loads the activities and subjects associated to each data set and column-binds them to the corresponding dataset.
* Merges the two datasets.
* Appropriately labels the dataset with descriptive variable names.
* Creates a second tidy dataset enclosing the average value of eache variable for each subject and activity pair.
* Store the second tidy dataset in `tidy_dataset.txt`.

## Code Book
A code book that describes the data fields in `tidy_dataset.txt` can be be found in `CodeBook.md`.
