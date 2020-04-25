
#Reading the  Data
Train <- read.table('X_train.txt')
subject_train <- read.table('subject_train.txt')
x_Train <- read.table('y_train.txt')


Test <- read.table('X_test.txt')
subject_test <- read.table('subject_test.txt')
y_Train <- read.table('y_test.txt')

activityLabels = read.table('activity_labels.txt')

activity_test = merge(y_Train,activityLabels,by.x = 'V1',by.y = 'V1')
activity_train = merge(x_Train,activityLabels,by.x = 'V1',by.y = 'V1')




#Renaming Column Names
names <- read.table('features.txt')
names(Train) <- names$V2
names(Test) <- names$V2

Test$Subject_Name = subject_test$V1
Train$Subject_Name = subject_train$V1

#Merged Data
Train$Activity = activity_train$V2
Test$Activity = activity_test$V2
merged_data = rbind(Train,Test)


#Mean and STD only
column_Index = grep("mean|std|Subject_Name|Activity",names(merged_data))
new_data <- merged_data[,column_Index]

group_data = group_by(new_data,Activity,Subject_Name) 

output = aggregate(new_data[,-c(80,81)], list(new_data$Subject_Name,new_data$Activity), mean)
names(output)[1:2] = c('Subject','Activity')

          
          