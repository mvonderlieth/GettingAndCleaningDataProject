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
# should be a function but for now...
l = nrow(features)
c1 = numeric(l)
c2 = character(l)
for (r in 1:l)
{
    if (grepl("mean\\(",features[r,2]) || grepl("std\\(",features[r,2]))
    {
        c1[r] = features[r,1]
        c2[r] = as.character(features[r,2])
    }
    else
    {
        c1[r] = NA
        c2[r] = NA
    }
}
mean_std_features = data.frame(c1,c2,stringsAsFactors=FALSE)
rownames(mean_std_features) <- NULL
mean_std_features = mean_std_features[complete.cases(mean_std_features),]

print ("extracting activity info...")
# should be a function but for now...
l = nrow(y_both)
# row name
rn = character(l)
for (r in 1:l)
{
    rn[r] = as.character(activity_labels[y_both[r,1],2])
}
activity_row_labels = data.frame(rn,stringsAsFactors=FALSE)

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


