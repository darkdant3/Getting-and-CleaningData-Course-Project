#Check if file dont exists then download it extract it
if(! file.exists('dataset.zip')){
  download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',destfile = 'dataset.zip',method='curl')
}
uciDir = 'UCI HAR Dataset/'
if( !file.exists(uciDir) ){
  unzip('dataset.zip')
}

#load test Data
testX = read.table('UCI HAR Dataset/test/X_test.txt')
#load test activities
testY = read.table('UCI HAR Dataset/test/y_test.txt')

#load train Data and activities
trainX = read.table('UCI HAR Dataset/train/X_train.txt')
trainY=read.table('UCI HAR Dataset/train/y_train.txt')

#load subjects
subjTest = read.table('UCI HAR Dataset/test/subject_test.txt')
subjTrain = read.table('UCI HAR Dataset/train/subject_train.txt')


#load features
features = read.table('UCI HAR Dataset/features.txt')

#means
means = features[ grepl('[Mm]ean\\(\\)',features$V2),]
#stds
stds = features[ grepl('[Ss]td\\(\\)',features$V2),]

testX = testX[,c(means$V1,stds$V1)]
names(testX) = c(as.character(means$V2),as.character(stds$V2))

#essential for recode( )
library(car)
trainX = trainX[,c(means$V1,stds$V1)]
names(trainX) = c(as.character(means$V2),as.character(stds$V2))

testX$activity = testY$V1
trainX$activity = trainY$V1

testX$subject = subjTest$V1;
trainX$subject = subjTrain$V1

testX$activity = recode(testX$activity,"1='WALKING';2= 'WALKING_UPSTAIRS';3='WALKING_DOWNSTAIRS';4='SITTING';5='STANDING';6='LAYING'")

trainX$activity = recode(trainX$activity,"1='WALKING';2= 'WALKING_UPSTAIRS';3='WALKING_DOWNSTAIRS';4='SITTING';5='STANDING';6='LAYING'")
#merges data by subject Id
tidyData = merge(testX,trainX,by.x='subject',by.y='subject', all=T)

write.table(tidyData,'tidyData.txt',row.names=F)

