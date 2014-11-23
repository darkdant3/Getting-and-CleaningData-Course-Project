Getting-and-CleaningData-Course-Project
=======================================
The :run_analysis.R first check for the dataset in the working directory and if it doesnt exist it will download the dataset and extract it.

Will read the train and test Xs,Y files describes the subject data the script then runs regular expressions to get appropriate data from mean and standard deviation

Recode the merged activity data with actual :activity name and merges the data by subject  from both test and train data
which results into a some NAs observed in the data.
