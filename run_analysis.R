# mvonderl
# class3 project
library(dplyr)
library(tidyr)

# for speed in testing only, assume that if X_both exists, then this section has already
# been run.
if (!exists("X_both"))
{
    print ("loading labels and features...")
    activity_labels = read.table("./data/UCI HAR Dataset/activity_labels.txt")
    features = read.table("./data/UCI HAR Dataset/features.txt")
    
    print ("loading test data...")
    X_test = read.table("./data/UCI HAR Dataset/test/X_test.txt")
    y_test = read.table("./data/UCI HAR Dataset/test/y_test.txt")
    subject_test = read.table("./data/UCI HAR Dataset/test/subject_test.txt")
    
    print ("loading training data...")
    X_train = read.table("./data/UCI HAR Dataset/train/X_train.txt")
    y_train = read.table("./data/UCI HAR Dataset/train/y_train.txt")
    subject_train = read.table("./data/UCI HAR Dataset/train/subject_train.txt")
    
    print ("combining data sets..")
    y_both = rbind(y_test,y_train)
    X_both = rbind(X_test,X_train)
    subject_both = rbind(subject_test,subject_train)
    rm(X_test,X_train,y_test,y_train,subject_test,subject_train)
}

print ("extracting mean and std column info...")
m_f = features[grepl("mean\\(",features$V2),]
s_f = features[grepl("std\\(",features$V2),]
mean_std_features = rbind(m_f,s_f)
#rm(m_f,s_f)

print ("extracting activity info...")
# for each row in y_both, take the first column value, say 2, and get the activity_labels[2,2] value, eg. SITTING
activity_row_labels = data.frame(activity_labels[y_both[,1],2])

print ("building tidy data...")
mydf = select(X_both,mean_std_features[,1])
colnames(mydf) = mean_std_features[,2]
X_tidy <-tbl_df(mydf)

print ("building tidy activity and subject data...")
X_tidy_activity_subject = X_tidy %>%
    mutate(activity=activity_row_labels[,1]) %>%
    mutate(subject=subject_both[,1])

print ("building average data...")
X_tidy_mean <- X_tidy_activity_subject %>%
    arrange(subject,activity) %>%
    group_by(subject,activity) %>%
    summarise_each(funs(mean))

print ("writing average data...")
write.table(X_tidy_mean,"X_tidy_mean.txt",row.names=FALSE)

print ("done.")
#end
