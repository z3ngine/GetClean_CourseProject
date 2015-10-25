
#========================================================================================
# download.HAR.source - downloads and extracts the "Human Activity Recognition Using Smartphones
# Dataset" data from archive.ics.uci.edu and stores in working directory
# 
#========================================================================================

download.HAR.source <- function(){
  
  tempZip <- tempfile()
  
  
  #Original source - uncomment this line for recent updates etc.
  #fileURL <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
  fileURL <-  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile=tempZip, mode="wb")
  unzip(tempZip)
  unlink(tempZip)
  
  print("HAR Dataset download and extract complete")
}


#========================================================================================
# prepare.Mean.StdDeviation.HAR - reads the test and training HAR datasets into memory, 
# combines the result, filters to 1 data frame containig only mean and standard deviation
# measures
#
# requires dplyr package installed
#
#========================================================================================

prepare.Mean.StdDeviation.HAR <- function(){
  
  #Check for dplyr installed and stop if not
  if(!("dplyr" %in% row.names(installed.packages()))){
    stop("prepare.Mean.StdDeviation.HAR requires the dplyr package.  Please install dplyr before tyring again.")
  }
  else
    library(dplyr);
  
  #Read the master list of features
  feature <- read.table(file="UCI HAR Dataset/features.txt",sep = ""
                         , col.names = c("feature_id", "feature_name"))
  
  #Rename features with more descriptive labels
  feature <- mutate(feature, feature_clean = gsub("^f","Frequency.",feature$feature_name))
  feature$feature_clean <- gsub("^t","Time.",feature$feature_clean)
  feature$feature_clean <- gsub("Body","Body.",feature$feature_clean)
  feature$feature_clean <- gsub("Gyro","Gyro.",feature$feature_clean)
  feature$feature_clean <- gsub("gravity","Gravity.",feature$feature_clean)
  feature$feature_clean <- gsub("Acc","Acceleration.",feature$feature_clean)
  feature$feature_clean <- gsub("Jerk","Jerk.",feature$feature_clean)
  feature$feature_clean <- gsub("Mag","Magnitude.",feature$feature_clean)
  feature$feature_clean <- gsub("-[Mm]ean\\(\\)","Mean",feature$feature_clean)
  feature$feature_clean <- gsub("-[Ss]td\\(\\)","StdDeviation",feature$feature_clean)
  feature$feature_clean <- gsub("-",".",feature$feature_clean)
  feature$feature_clean <- gsub("\\)|\\(|,","x",feature$feature_clean)
  
  #Read the master list of activities
  activity <- read.table(file="UCI HAR Dataset/activity_labels.txt",sep = ""
                         , col.names = c("activity_id", "activity_name"))
  
  #Test Dataset
  #	read in X	name cols using feature_clean
  		Test.X.Raw <- read.table(file="UCI HAR Dataset/test/X_test.txt",sep = "", 
  		                         col.names = feature$feature_clean)
	#	read in Y
	#		name col "Activity"
  		Test.Activity.Raw <- read.table(file="UCI HAR Dataset/test/y_test.txt",sep = "", 
  		                                col.names = c("activity_id"))
	#	read in subject
	#		name col "Subject"
  		Test.Subject.Raw <- read.table(file="UCI HAR Dataset/test/subject_test.txt",sep = "", 
  		                               col.names = c("subject_id"))
  		
  #	bind the 3 sets by columns
  		Test.Raw <- bind_cols(Test.Subject.Raw, Test.Activity.Raw, Test.X.Raw)
  		
  # deallocate memory for raw sets
  		rm(Test.X.Raw)
  		rm(Test.Activity.Raw)
  		rm(Test.Subject.Raw)

  # join in the activity names
  		Test.Raw.Activity <- inner_join(activity, Test.Raw, by = "activity_id")
  		
  # build a names filter
  		Test.names <- colnames(Test.Raw.Activity)
  		Test.names.filter <- Test.names[
  		    grepl("subject_id|activity_id|activity_name|(\\.Mean|\\.StdDeviation)$|\\.Mean\\.|\\.StdDeviation\\.",
  		          Test.names)]
  		
  #	trim to only Mean and StdDeviation columns
  		Test.Narrow <- subset(Test.Raw.Activity, select=Test.names.filter)
  
  #	deallocate memory for raw sets
  		rm(Test.Raw)
  		rm(Test.Raw.Activity)

  		
  #Training Dataset
  #	read in X	name cols using feature_clean
  		Train.X.Raw <- read.table(file="UCI HAR Dataset/train/X_train.txt",sep = "", 
  		                         col.names = feature$feature_clean)
  #	read in Y
  #		name col "Activity"
  		Train.Activity.Raw <- read.table(file="UCI HAR Dataset/train/y_train.txt",sep = "", 
  		                                col.names = c("activity_id"))
  #	read in subject
  #		name col "Subject"
  		Train.Subject.Raw <- read.table(file="UCI HAR Dataset/train/subject_train.txt",sep = "", 
  		                               col.names = c("subject_id"))
  		
  #	bind the 3 sets by columns
  		Train.Raw <- bind_cols(Train.Subject.Raw, Train.Activity.Raw, Train.X.Raw)
  		
  # deallocate memory for raw sets
  		rm(Train.X.Raw)
  		rm(Train.Activity.Raw)
  		rm(Train.Subject.Raw)
  		
  # join in the activity names
  		Train.Raw.Activity <- inner_join(activity, Train.Raw, by = "activity_id")
  		
  # build a names filter
  		Train.names <- colnames(Train.Raw.Activity)
  		Train.names.filter <- Train.names[
  		  grepl("subject_id|activity_id|activity_name|(\\.Mean|\\.StdDeviation)$|\\.Mean\\.|\\.StdDeviation\\.",
  		        Train.names)]
  		
  #	trim to only Mean and StdDeviation columns
  		Train.Narrow <- subset(Train.Raw.Activity, select=Train.names.filter)
  		
  #	deallocate memory for raw sets
  		rm(Train.Raw)
  		rm(Train.Raw.Activity)

	#	Combine Test and Training Sets
  HAR.Mean.StdDeviation.All <- bind_rows(Test.Narrow, Train.Narrow)
  
  rm(Test.Narrow)
  rm(Train.Narrow)
  
  #return combined clean dataset
  HAR.Mean.StdDeviation.All

}

#========================================================================================
# prepare.Mean.Summary.HAR - accepts the HAR dataset generated by prepare.Mean.StdDeviation.HAR
# and returns a summarised data frame containing the mean of each measure, grouped by
# subject and activity.
#
# requires dplyr package installed
#
#========================================================================================

prepare.Mean.Summary.HAR <- function(HAR.Mean.StdDeviation.All){
  
  #Check for dplyr installed and stop if not
  if(!("dplyr" %in% row.names(installed.packages()))){
    stop("prepare.Mean.Summary.HAR requires the dplyr package.  Please install dplyr before tyring again.")
  }
  else
    library(dplyr);
  
  #build even smaller set with average by activity, subject
  #	using dplyr::summarise_each
  # and dplyr::group_by
  HAR.Mean.of.Mean.StdDeviation.All <- (HAR.Mean.StdDeviation.All 
        %>% group_by(activity_id, activity_name, subject_id) 
        %>% summarise_each(funs(mean)))
  
  #rename measure  columns to indicate different context (Mean.of....)
  for(i in 4:length(names(HAR.Mean.of.Mean.StdDeviation.All))){
    colnames(HAR.Mean.of.Mean.StdDeviation.All)[i] <- paste("Mean.of.", 
        colnames(HAR.Mean.of.Mean.StdDeviation.All)[i], sep="");
  }
  
  HAR.Mean.of.Mean.StdDeviation.All
  
}

#========================================================================================
# save.HAR - quick function for saving data frame to file/disk
#
#========================================================================================

save.HAR <- function(HAR.Dataset, filepath){
  
  write.table(HAR.Dataset, file = filepath, row.names = FALSE)
  
}

