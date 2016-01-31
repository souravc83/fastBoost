#'wraps the rpart call for ease of use with Rcpp
#'@import rpart
#'@param newdata dataframe with requisite columns
#'@export

wrap_rpart <- function(formula_char,newdata, weight_vec)
{
  formula <- as.formula(formula_char)
  tmp_wt <<- weight_vec
  rpart_control <- rpart::rpart.control(cp=0)
  tree_fit <- rpart::rpart(formula,newdata,weights = tmp_wt, control = rpart_control)
  train_learn <- predict(tree_fit,type="class")
  num_class <- as.numeric(levels(train_learn))[train_learn]
  return(num_class)
  #num_examples = nrow(newdata)
  #return(num_examples)
}