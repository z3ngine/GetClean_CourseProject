# GetClean_CourseProject
Course Project for the John Hopkins university Getting and Cleaning Data course.

This project uses data sourced from the "Human Activity Recognition Using Smartphones Dataset" (HAR dataset), containing data recorded by Smartphones, attempting to describe the users' activity.  See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for more information.

Specificallly this project seeks to generate a tidy subset of the HAR dataset, containing only key information along with mean and standard deviation over base measures (from the larger set of 561 features/analyses recorded in the original dataset).

## run_analysis.R
To use the functions available in run_analysis.R, download the associated run_analysis.R source code from this repo to the R working directory and load into memory:

> source("run_analysis.R")

run_analysis.R contains 4 functions:

### download.HAR.source()
Downloads and extracts the "Human Activity Recognition Using Smartphones Dataset" data from archive.ics.uci.edu (or equivalent mirror) and stores files in the current working directory.  The function requires no parameters:

> download.HAR.source()

This will source the HAR raw data and extract to a folder "UCI HAR Dataset" in the current working directory.

### prepare.Mean.StdDeviation.HAR()
Reads the test and training HAR datasets from the extracted HAR dataset in the current working directory, combines the result, and generates a tidy data set (data frame) containig only the key measures and the mean and standard deviation measures.

> HAR.Mean.StdDeviation.All <- prepare.Mean.StdDeviation.HAR()

The function will return a tidy dataframe containing 69 columns [click here for a description of the columns and transformations involved](HAR_analysis_CodeBook.md) and 10,299 rows representing the full set of observations.  The function requires the "dplyr" package to be installed.  If "dplyr" is not available you will received a warning message.

### prepare.Mean.Summary.HAR()
Creates a summarised version of the tidy data frame, showing the average of each measure observed.  It takes 1 parameter being the dataframe variable generated from running prepare.Mean.StdDeviation.HAR()

> Mean.of.HAR <- prepare.Mean.Summary.HAR(HAR.Mean.StdDeviation.All)

This dataset will return 180 rows in total representing the means covering 30 subjects across 6 activities.  For each of the measures in the tidy dataset from prepare.Mean.StdDeviation.HAR(), prepare.Mean.Summary.HAR() will append "Mean.of." to the column name to identify it is the mean of all observations.

The function requires the "dplyr" package to be installed.  If "dplyr" is not available you will received a warning message.

### save.HAR(dataframe, filePath)
A quick function for saving the resulting data frame to file/disk.  It accepts 2 parameters:<br/>
 /- <i>dataframe</i> - a data frame variable
 /- <i>filePath</i> - the full or referntial path to the file to be saved to<br/>
 example usage: save.HAR(Mean.of.HAR, "HAR_Mean_of_Mean_StdDeviation_All.txt")
