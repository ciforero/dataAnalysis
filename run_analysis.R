run_analysis <- function() {
  ## Read the feature names and assign them to a vector
  myFeatures<-read.table("features.txt")
  myFeatureNames<-as.character(myFeatures$V2)
  
  ## Read test data
  myTestData<-read.table("./test/X_test.txt")
  myTestDataY<-read.table("./test/y_test.txt")
  myTestSubject<-read.table("./test/subject_test.txt")
  ## Assign feature names
  names(myTestData)<-myFeatureNames
  ## Add activity column
  names(myTestDataY)<-c("ActivityId")
  myTestData$ActivityId<-myTestDataY$ActivityId
  ## Add subject column
  names(myTestSubject)<-c("Subject")
  myTestData$Subject<-myTestSubject$Subject

  ## Read training data
  myTrainData<-read.table("./train/X_train.txt")
  myTrainDataY<-read.table("./train/y_train.txt")
  myTrainSubject<-read.table("./train/subject_train.txt")
  ## Assign feature names
  names(myTrainData)<-myFeatureNames
  ## Add activity column
  names(myTrainDataY)<-c("ActivityId")
  myTrainData$ActivityId<-myTrainDataY$ActivityId
  ## Add subject column
  names(myTrainSubject)<-c("Subject")
  myTrainData$Subject<-myTrainSubject$Subject

  ## Join test and training data sets
  myData_1<-rbind(myTestData,myTrainData)
  ## Include only columns related to mean, standard deviation, activity or subject
  myNames<-names(myData_1)
  myData_2<-myData_1[,grep("mean()|std()|ActivityId|Subject",myNames)]

  ## Add column with activity labels
  myActivityLabels<-read.table("./activity_labels.txt")
  names(myActivityLabels)<-c("ActivityId","Activity")
  myData_3a<-merge(myData_2,myActivityLabels,by.x="ActivityId",by.y="ActivityId")
  ## Remove ActivityId column
  myNames<-names(myData_3a)
  z<-!(myNames=="ActivityId")
  myData_3<-myData_3a[,z]
  
  ## Load library dplyr
  library(dplyr)
  
  ## Generate tidy data set containing the average for all the features
  ## per Activity and Subject
  myData_4<-group_by(myData_3,Activity,Subject) %>% summarise_each(c("mean"))
  myNames<-names(myData_4)
  myNames<-sub("()","",myNames,fixed=TRUE)
  names(myData_4)<-myNames
  
  ## Return tidy data set
  myData_4
}
