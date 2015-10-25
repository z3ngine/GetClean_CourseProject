---
title: "Codebook"
author: "Angus Fry"
date: "25th Oct 2015"
---

## GetClean_CourseProject
Course Project for the John Hopkins university Getting and Cleaning Data course.  This project uses data sourced from the "Human Activity Recognition Using Smartphones Dataset" (HAR dataset), containing data recorded by Smartphones, attempting to describe the users' activity.  See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for more information.

Specificallly this project seeks to generate a tidy subset of the HAR dataset, containing only key information along with mean and standard deviation over base measures (from the larger set of 561 features/analyses recorded in the original dataset).

##Study design and data processing

###Collection of the raw data
The raw data was downloaded from the share https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped to the current R working directory.  There is also a function [download.HAR.source()] provided in [run_analysis.R] for downloading the raw data.  For the original data descriptions and raw data, including change notes, see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Notes on the original (raw) data 
The raw data contains 2 data groups: test and training datasets (oriented towards predictive analytics).  Each data group contains 3 data files:
	X_&lt;datagroup&gt;.txt - the 561 features recorded
	Y_&lt;datagroup&gt;.txt - the activity id for each row in X_&lt;datagroup>.txt
	&lt;datagroup&gt;_subject.txt - the test subject (smartphone user) for each row in X_&lt;datagroup&gt;.txt
	
The raw data also contains descriptive files:
	activity_labels.txt - the label associated with each activity id in the Y_&lt;datagroup&gt;.txt file
	features.txt - the descriptive label for each column shown in X_&lt;datagroup&gt;.txt file
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
Of the 561 features recorded in the original HAR dataset, this project extracts 66 features only based on the naming convention of the feature name containing the text "mean()" or "std()".  The code deliberately excludes the following features as non "true" mean or standard deviation measures, or because they are derivative measures of the base mean and standard deviation measures:
 - meanFreq() - represents a weighted average and not a true mean
 - angle() variables such as angle(X,gravityMean) - these are on-processed measures representing an angle between 2 "true" mean variables or a "true" mean and another variable. 

For fast analysis, but also with reference back to the source data, both the activity_id and activity_name are included in the tidy data.  There is no further data available on the subject for each sample so only the subject_id is returned. 
 
Further information relating to the transform functions can be found [in the project's README file](README.md)

##Description of the variables returned by prepare.Mean.StdDeviation.HAR()
The tidy data is dimensioned by the keys:<br/>
 [1] "activity_id" - the raw activity_id from the HAR data (ranges from 1 - 6)  <br/>                                               
 [2] "activity_name" - the lookup value for the specific activity (eg. WALKING, STANDING...) <br/>                                          
 [3] "subject_id" - an id identifying the subject/user (ranges from 1 - 30)<br/>
<br/>
The measures from the HAR dataset have had their identifying names cleansed to fit a naming convention:<br/>
	Time. -  measures were recorded<br/>
	Frequency. <br/>
	<br/>
Measures are represented by 2 units of measure against the convention in the naming.  For measure names containing the text:<br/>
	"Acceleration." - measured in standard gravity units "g"<br/>
	"Gyro." - angular velocity measured in radians/second "rad/s"<br/>
<br/>
###Variables - detailed
                                              <br/>   
 [4] "Time.Body.Acceleration.Mean.X"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
 <br/>
 [5] "Time.Body.Acceleration.Mean.Y"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
 <br/>
 [6] "Time.Body.Acceleration.Mean.Z"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>                      
 [7] "Time.Body.Acceleration.StdDeviation.X"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>                
 [8] "Time.Body.Acceleration.StdDeviation.Y"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>               
 [9] "Time.Body.Acceleration.StdDeviation.Z"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>                
[10] "Time.Gravity.Acceleration.Mean.X"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>                      
[11] "Time.Gravity.Acceleration.Mean.Y"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>                     
[12] "Time.Gravity.Acceleration.Mean.Z"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>                    
[13] "Time.Gravity.Acceleration.StdDeviation.X"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>              
[14] "Time.Gravity.Acceleration.StdDeviation.Y"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>             
[15] "Time.Gravity.Acceleration.StdDeviation.Z"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>             
[16] "Time.Body.Acceleration.Jerk.Mean.X"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                              <br/>                 
[17] "Time.Body.Acceleration.Jerk.Mean.Y"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                        <br/>
[18] "Time.Body.Acceleration.Jerk.Mean.Z"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
    <br/>
[19] "Time.Body.Acceleration.Jerk.StdDeviation.X"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
 <br/>
[20] "Time.Body.Acceleration.Jerk.StdDeviation.Y"<br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
 <br/>
[21] "Time.Body.Acceleration.Jerk.StdDeviation.Z" <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
 <br/>
[22] "Time.Body.Gyro.Mean.X"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
 <br/>
[23] "Time.Body.Gyro.Mean.Y"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                  <br/>      
[24] "Time.Body.Gyro.Mean.Z"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                  <br/>      
[25] "Time.Body.Gyro.StdDeviation.X"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                <br/>
[26] "Time.Body.Gyro.StdDeviation.Y"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                <br/>
[27] "Time.Body.Gyro.StdDeviation.Z" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                               <br/>
[28] "Time.Body.Gyro.Jerk.Mean.X"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                  <br/> 
[29] "Time.Body.Gyro.Jerk.Mean.Y"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                  <br/> 
[30] "Time.Body.Gyro.Jerk.Mean.Z"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                  <br/> 
[31] "Time.Body.Gyro.Jerk.StdDeviation.X"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                           <br/>
[32] "Time.Body.Gyro.Jerk.StdDeviation.Y"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                           <br/>
[33] "Time.Body.Gyro.Jerk.StdDeviation.Z" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                          <br/>
[34] "Time.Body.Acceleration.Magnitude.Mean"      <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                   <br/>
[35] "Time.Body.Acceleration.Magnitude.StdDeviation"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
               <br/>
[36] "Time.Gravity.Acceleration.Magnitude.Mean"   <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                    <br/>
[37] "Time.Gravity.Acceleration.Magnitude.StdDeviation"    <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
           <br/>
[38] "Time.Body.Acceleration.Jerk.Magnitude.Mean"   <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                 <br/>
[39] "Time.Body.Acceleration.Jerk.Magnitude.StdDeviation"   <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
         <br/>
[40] "Time.Body.Gyro.Magnitude.Mean" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                               <br/>
[41] "Time.Body.Gyro.Magnitude.StdDeviation"  <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                      <br/>
[42] "Time.Body.Gyro.Jerk.Magnitude.Mean" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                          <br/>
[43] "Time.Body.Gyro.Jerk.Magnitude.StdDeviation"         <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
          <br/>
[44] "Frequency.Body.Acceleration.Mean.X" <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                           <br/>
[45] "Frequency.Body.Acceleration.Mean.Y"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                          <br/>
[46] "Frequency.Body.Acceleration.Mean.Z"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                          <br/>
[47] "Frequency.Body.Acceleration.StdDeviation.X"   <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                 <br/>
[48] "Frequency.Body.Acceleration.StdDeviation.Y"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                 <br/>
[49] "Frequency.Body.Acceleration.StdDeviation.Z"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                  <br/>
[50] "Frequency.Body.Acceleration.Jerk.Mean.X"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                     <br/>
[51] "Frequency.Body.Acceleration.Jerk.Mean.Y"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                     <br/>
[52] "Frequency.Body.Acceleration.Jerk.Mean.Z"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                     <br/>
[53] "Frequency.Body.Acceleration.Jerk.StdDeviation.X"   <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
            <br/>
[54] "Frequency.Body.Acceleration.Jerk.StdDeviation.Y" <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
              <br/>
[55] "Frequency.Body.Acceleration.Jerk.StdDeviation.Z"  <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
             <br/>
[56] "Frequency.Body.Gyro.Mean.X"    <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                               <br/>
[57] "Frequency.Body.Gyro.Mean.Y" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                  <br/>
[58] "Frequency.Body.Gyro.Mean.Z" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                                  <br/>
[59] "Frequency.Body.Gyro.StdDeviation.X"  <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                         <br/>
[60] "Frequency.Body.Gyro.StdDeviation.Y"  <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                         <br/>
[61] "Frequency.Body.Gyro.StdDeviation.Z" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                          <br/>
[62] "Frequency.Body.Acceleration.Magnitude.Mean"    <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
                <br/>
[63] "Frequency.Body.Acceleration.Magnitude.StdDeviation"   <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
         <br/>
[64] "Frequency.Body.Body.Acceleration.Jerk.Magnitude.Mean"   <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
       <br/>
[65] "Frequency.Body.Body.Acceleration.Jerk.Magnitude.StdDeviation" <br/>
	class: Numeric<br/>
	unit of measure: "g" <br/>
 <br/>
[66] "Frequency.Body.Body.Gyro.Magnitude.Mean"  <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                    <br/>
[67] "Frequency.Body.Body.Gyro.Magnitude.StdDeviation" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
             <br/>
[68] "Frequency.Body.Body.Gyro.Jerk.Magnitude.Mean" <br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
                <br/>
[69] "Frequency.Body.Body.Gyro.Jerk.Magnitude.StdDeviation"<br/>
	class: Numeric<br/>
	unit of measure: "rad/s" <br/>
<br/>
##Other

To create a summarised version of the tidy data frame, showing the average of each measure observed, feed the dataframe variable generated from prepare.Mean.StdDeviation.HAR() back into the prepare.Mean.Summary.HAR() function, and assign to a new dataframe variable:

> Mean.of.HAR <- prepare.Mean.Summary.HAR(HAR.Mean.StdDeviation.All)

This dataset will return 180 rows in total representing the means covering 30 subjects across 6 activities.  For each of the measures in the tidy dataset from prepare.Mean.StdDeviation.HAR(), prepare.Mean.Summary.HAR() will append "Mean.of." to the column name to identify it is the mean of all observations.