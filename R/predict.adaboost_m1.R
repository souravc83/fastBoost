#'makes predictions for an adaboost object on a new dataset
#'@import rpart
#'@param object an object of class adaboost
#'@param newdata dataframe on which we are looking to predict
#'@return predictor predcted object with prediction probabilities
#'@export
#'@examples
#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'A <- adaBoost(Y~X, fakedata, 10)
#'pred <- predict(A,newdata=fakedata)


predict.adaBoost <- function(object, newdata)
{
  formula <- object$formula
  nIter <- length(object$trees)
  num_examples <- nrow(newdata)
  pred_mat <- array(0,c(num_examples, nIter))
  
  
  #get the prediction from each tree
  for(i in 1:nIter)
  {
    this_tree <- object$trees[[i]]
    pred_mat[,i] <- predict(this_tree, newdata, type="class")
  }
  final_class <- matrix(0,num_examples, 2)
  final_class[,1] <- (matrix(as.numeric(pred_mat==1), nrow= num_examples))%*%object$weights
  final_class[,2] <- (matrix(as.numeric(pred_mat==2), nrow= num_examples))%*%object$weights
  
  predicted_class <- rep(0,num_examples)
  for(i in 1:num_examples)
    predicted_class[i] <- which(final_class[i,] == max(final_class[i,]))
  prob_mat <- final_class/apply(final_class,1,sum)
  
  predictor <- list( formula= formula, votes= final_class, class = predicted_class, prob = prob_mat)
  
  return(predictor)
}

