# train and test are pre-loaded

# Code of previous exercise
set.seed(1)
tree <- rpart(income ~ ., train, method = "class")
probs <- predict(tree, test, type = "prob")[,2]

# Load the ROCR library
library(ROCR)

# Make a prediction object: pred
pred <- prediction(probs,test$income)

# Make a performance object: perf
pref<- performance(pred,"tpr","fpr")

# Plot this curve
plot(pref)

Area Under the Curve
# Make a performance object: perf
perf <- performance(pred,"auc")

# Print out the AUC
perf@y.values[[1]]


# kang_nose is pre-loaded in your workspace

# Build model and make plot
lm_kang <- lm(nose_length ~ nose_width, data=kang_nose)
plot(kang_nose, xlab = "nose width", ylab = "nose length")
abline(lm_kang$coefficients, col = "red")

# Apply predict() to lm_kang: nose_length_est
nose_length_est <- predict(lm_kang)

# Calculate difference between the predicted and the true values: res
res <- nose_length_est - kang_nose$nose_length

# Calculate RMSE, assign it to rmse and print it
rmse <- sqrt(mean((res) ^ 2))
rmse


##################################################

# world_bank_train and world_bank_test are pre-loaded
# lm_wb and lm_wb_log have been trained on world_bank_train
# The my_knn() function is available

# Define ranks to order the predictor variables in the test set
ranks <- order(world_bank_test$cgdp)

# Scatter plot of test set
plot(world_bank_test,
     xlab = "GDP per Capita", ylab = "Percentage Urban Population")

# Predict with simple linear model and add line
test_output_lm <- predict(lm_wb, data.frame(cgdp = world_bank_test$cgdp))
lines(world_bank_test$cgdp[ranks], test_output_lm[ranks], lwd = 2, col = "blue")

# Predict with log-linear model and add line
test_output_lm_log <- predict(lm_wb_log, data.frame(cgdp = world_bank_test$cgdp))
lines(world_bank_test$cgdp[ranks],test_output_lm_log[ranks], lwd = 2, col = "red")

# Predict with k-NN and add line
test_output_knn <- my_knn(world_bank_train,world_bank_test$cgdp world_bank_test$urb_pop,30)
lines(world_bank_test$cgdp[ranks],test_output_lm_log[ranks], lwd = 2, col = "green")



# Calculate RMSE on the test set for simple linear model
sqrt(mean( (test_output_lm - world_bank_test$urb_pop) ^ 2))

# Calculate RMSE on the test set for log-linear model


# Calculate RMSE on the test set for k-NN technique


#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

###
# You don't have to change this!
# The algorithm is already coded for you;
# inspect it and try to understand how it works!
my_knn <- function(x_pred, x, y, k){
  m <- length(x_pred)
  predict_knn <- rep(0, m)
  for (i in 1:m) {

    # Calculate the absolute distance between x_pred[i] and x
    dist <- abs(x_pred[i] - x)

    # Apply order() to dist, sort_index will contain
    # the indices of elements in the dist vector, in
    # ascending order. This means sort_index[1:k] will
    # return the indices of the k-nearest neighbors.
    sort_index <- order(dist)

    # Apply mean() to the responses of the k-nearest neighbors
    predict_knn[i] <- mean(y[sort_index[1:k]])

  }
  return(predict_knn)
}
###

# world_bank_train and world_bank_test are pre-loaded

# Apply your algorithm on the test set: test_output
test_output <- my_knn(world_bank_test$cgdp,world_bank_train$cgdp,world_bank_train$urb_pop,30)

# Have a look at the plot of the output
plot(world_bank_train,
     xlab = "GDP per Capita",
     ylab = "Percentage Urban Population")
points(world_bank_test$cgdp, test_output, col = "green")

################################################################

# The dataset school_result is pre-loaded

# Set random seed. Don't remove this line.
set.seed(100)

# Explore the structure of your data
str(school_result)

# Initialise ratio_ss 
ratio_ss <- rep(0,7)

# Finish the for-loop. 
for (k in 1:7) {
  
  # Apply k-means to school_result: school_km
  school_km <- kmeans(school_result, nstart=20, k)
  
  # Save the ratio between of WSS to TSS in kth element of ratio_ss
  ratio_ss[k] <- (school_km$tot.withinss/school_km$tot.totss)
  
}

# Make a scree plot with type "b" and xlab "k"
plot(ratio_ss, type="b",xlab="k")


##################################################################

# The dataset run_record has been loaded in your workspace

# Set random seed. Don't remove this line.
set.seed(1)

# Explore your data with str() and summary()
str(run_record)
summary(run_record)
# Cluster run_record using k-means: run_km. 5 clusters, repeat 20 times
run_km <- kmeans(run_record,5,nstart=20)

# Plot the 100m as function of the marathon. Color using clusters
plot(x=run_record$marathon,y=run_record$X100m,col=run_km$cluster,xlab="Marathon",ylab="x100m")

# Calculate Dunn's index: dunn_km. Print it.
dunn_km <- dunn(clusters = run_km$cluster, Data=run_record)
dunn_km

#######################################################################


# The dataset run_record_sc has been loaded in your workspace

# Apply dist() to run_record_sc: run_dist
run_dist <- dist(run_record_sc)

# Apply hclust() to run_dist: run_single
run_single <- hclust(run_dist,"single")

# Apply cutree() to run_single: memb_single
memb_single <- cutree(run_single,5)

# Apply plot() on run_single to draw the dendrogram
plot(run_single)

# Apply rect.hclust() on run_single to draw the boxes
rect.hclust(run_single, 5 ,border=2:6)

---------------------------------------------------------------------
# run_record_sc is pre-loaded

# Code for single-linkage
run_dist <- dist(run_record_sc, method = "euclidean")
run_single <- hclust(run_dist, method = "single")
memb_single <- cutree(run_single, 5)
plot(run_single)
rect.hclust(run_single, k = 5, border = 2:6)

# Apply hclust() to run_dist: run_complete
run_complete <- hclust(run_dist, method = "complete")

# Apply cutree() to run_complete: memb_complete
memb_complete <- cutree(run_complete, 5)

# Apply plot() on run_complete to draw the dendrogram
plot(run_complete)

# Apply rect.hclust() on run_complete to draw the boxes
rect.hclust(run_complete,5,border=2:6)

# table() the clusters memb_single and memb_complete. Put memb_single in the rows
table(memb_single,memb_complete)

#------------------------------------------
#Clustering US states based on criminal activity
#------------------------------------------

# Set random seed. Don't remove this line.
set.seed(1)

# Scale the dataset: crime_data_sc
crime_data_sc <- scale(crime_data)

# Perform k-means clustering: crime_km
crime_km <- kmeans(crime_data_sc,4,nstart=20)

# Perform single-linkage hierarchical clustering
## Calculate the distance matrix: dist_matrix
dist_matrix <- dist(crime_data_sc)

## Calculate the clusters using hclust(): crime_single
crime_single <- hclust(dist_matrix,"single")

## Cut the clusters using cutree: memb_single
memb_single <- cutree(crime_single,4)

# Calculate the Dunn's index for both clusterings: dunn_km, dunn_single
dunn_km <- dunn(clusters=crime_km$cluster,Data=crime_data_sc)
dunn_single <- dunn(clusters=memb_single,Data=crime_data_sc)

# Print out the results
dunn_km
dunn_single


