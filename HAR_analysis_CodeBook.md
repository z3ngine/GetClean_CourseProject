---
title: "Codebook"
author: "Angus Fry"
date: "25th Oct 2015"
output:
  html_document:
    keep_md: yes
---

## GetClean_CourseProject
Course Project for the John Hopkins university Getting and Cleaning Data course.  This project uses data sourced from the "Human Activity Recognition Using Smartphones Dataset" (HAR dataset), containing data recorded by Smartphones, attempting to describe the users' activity.  See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for more information.

Specificallly this project seeks to generate a tidy subset of the HAR dataset, containing only key information along with mean and standard deviation over base measures (from the larger set of 561 features/analyses recorded in the original dataset).

##Study design and data processing

###Collection of the raw data
The raw data was downloaded from the share https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped to the current R working directory.  There is also a function [download.HAR.source()] provided in [run_analysis.R] for downloading the raw data.  For the original data descriptions and raw data, including change notes, see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Notes on the original (raw) data 
The raw data contains 2 data groups: test and training datasets (oriented towards predictive analytics).  Each data group contains 3 data files:
	X_<datagroup>.txt - the 561 features recorded
	Y_<datagroup>.txt - the activity id for each row in X_<datagroup>.txt
	<datagroup>_subject.txt - the test subject (smartphone user) for each row in X_<datagroup>.txt
	
The raw data also contains descriptive files:
	activity_labels.txt - the label associated with each activity id in the Y_<datagroup>.txt file
	features.txt - the descriptive label for each column shown in X_<datagroup>.txt file
	features_info.txt - more explanatory notes about each feature
	README.txt - background information on the study and contents of the HAR data

For the purposes of this project, all of the above 2 datasets were merged to give the complete sample set recorded.  The raw data also contains raw "Interial Signals" not used in this project.

##Creating the tidy datafile

###Guide to create the tidy data file
Download the associated run_analysis.R source code to the R working directory and load into memory

> source("run_analysis.R")

The user can either download from the URL above and unzip the raw data to the current R working directory; or use the function provided:

> download.HAR.source()

This will source the HAR raw data and extract to a folder "UCI HAR Dataset" in the current working directory.  To create the initial tidy data set, containing only key information and the mean & standard deviation measures assign a new dataframe variable to the prepare.Mean.SStdDeviation.HAR() function:

> HAR.Mean.StdDeviation.All <- prepare.Mean.StdDeviation.HAR()

###Cleaning of the data
The HAR 

Of the 561 features recorded in the original HAR dataset, this project extracts 66 features only

 [link to the readme document that describes the code in greater detail](README.md)

##Description of the variables in the tiny_data.txt file
General description of the file including:
 - Dimensions of the dataset
 - Summary of the data
 - Variables present in the dataset

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

###Variable 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including:
 - Class of the variable
 - Unique values/levels of the variable
 - Unit of measurement (if no unit of measurement list this as well)
 - In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels). 

(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

####Notes on variable 1:
If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

##Sources
Sources you used if any, otherise leave out.

##Other

To create a summarised version of the tidy data frame, showing the average of each measure observed, feed the dataframe variable generated from prepare.Mean.StdDeviation.HAR() back into the prepare.Mean.Summary.HAR() function, and assign to a new dataframe variable:

> Mean.of.HAR <- prepare.Mean.Summary.HAR(HAR.Mean.StdDeviation.All)

