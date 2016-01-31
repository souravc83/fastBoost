#'wraps the rpart call for ease of use with Rcpp
#'@import rpart
#'@param newdata dataframe with requisite columns
#'@export

wrap_rpart <- function(newdata)
{
  #first ignore formula char and the weights
  tree_fit <- rpart::rpart(Y~X,newdata)
  train_learn <- predict(tree_fit,type="class")
  num_class <- as.numeric(levels(train_learn))[train_learn]
  return(num_class)
  #num_examples = nrow(newdata)
  #return(num_examples)
}