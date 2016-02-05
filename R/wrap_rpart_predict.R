#'wraps the prediction from a tree for ease of use 
#'with Rcpp
#'@import rpart
#'@param tree_object object of class rpart
#'@param newdata dataframe
#'@return pred_vec integer vector. This contains
#'        the labels of the predicted class 
#'        converted to integers.

wrap_rpart_predict <- function(tree_object, newdata)
{
  pred_fit <- predict(tree_object, newdata, type="class")
  pred_vec <- as.numeric(pred_fit)
  return(pred_vec)
}