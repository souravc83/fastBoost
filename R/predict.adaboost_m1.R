#'makes predictions for an adaboost object on a new dataset
#'@import rpart
#'@param object an object of class adaboost
#'@param newdata dataframe on which we are looking to predict
#'@return predictor predicted object with prediction probabilities
#'@export
#'@examples
#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'A <- adaBoost(Y~X, fakedata, 10)
#'pred <- predict(A,newdata=fakedata)


predict.adaboost <- function(object, newdata)
{
  
  
  formula <- object$formula
  tree_list <- object$trees
  coeff_vector <- object$weights
  classnames_map <- object$classnames
  num_examples <- nrow(newdata)
  cpp_list <- predict_adaboost_(tree_list, coeff_vector, newdata,
                                num_examples, wrap_rpart_predict,classnames_map)
  votes <- cpp_list$votes
  predicted_class_int <- cpp_list$class #this is 0 or 1
  predicted_class <- ifelse(predicted_class_int == 0, classnames_map["A"],classnames_map["B"])
  predicted_class <- factor(predicted_class)
  prob_mat = cpp_list$prob
  
  predictor <- list(formula = formula, votes = votes, 
                    class = predicted_class,prob = prob_mat)
  
  
#   nIter <- length(object$trees)
#   num_examples <- nrow(newdata)
#   pred_mat <- array(0,c(num_examples, nIter))
#   
#   
#   #get the prediction from each tree
#   for(i in 1:nIter)
#   {
#     this_tree <- object$trees[[i]]
#     pred_mat[,i] <- predict(this_tree, newdata, type="class")
#   }
#   final_class <- matrix(0,num_examples, 2)
#   final_class[,1] <- (matrix(as.numeric(pred_mat==1), nrow= num_examples))%*%object$weights
#   final_class[,2] <- (matrix(as.numeric(pred_mat==2), nrow= num_examples))%*%object$weights
#   
#   predicted_class <- rep(0,num_examples)
#   for(i in 1:num_examples)
#     predicted_class[i] <- which(final_class[i,] == max(final_class[i,]))
#   prob_mat <- final_class/apply(final_class,1,sum)
#   
#   predictor <- list( formula= formula, votes= final_class, class = predicted_class, prob = prob_mat)
  
  return(predictor)
}

