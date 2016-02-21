#'wraps the prediction from a tree for ease of use 
#'with Rcpp
#'@import rpart
#'@param tree_object object of class rpart
#'@param newdata dataframe
#'@return pred_vec integer vector. This contains
#'        the labels of the predicted class 
#'        converted to integers.

wrap_rpart_predict <- function(tree_object, newdata, classnames_map)
{
  test_learn <- predict(tree_object, newdata, type="class")
  integer_class <- ifelse( test_learn == classnames_map["A"],0, 1)
  return(integer_class)
}

wrap_rpart_predict_real <-function(tree_object, newdata)
{
  pred_vec <- predict(tree_object, newdata, type="prob")[,1]
  return(pred_vec)
}