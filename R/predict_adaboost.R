#'makes predictions for an adaboost object on a new dataset
#'@import rpart
#'@param object an object of class adaboost
#'@param newdata dataframe on which we are looking to predict
#'@return predictor predicted object with prediction probabilities
#'@export
#'@examples
#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'A <- adaboost(Y~X, fakedata, 10)
#'pred <- predict(A,newdata=fakedata)
predict.adaboost <- function(object, newdata)
{
  return( predict_adaboost_internal(object,newdata,"M1") )
}


#'makes predictions for an real_adaboost object on a new dataset
#'@import rpart
#'@param object an object of class real_adaboost
#'@param newdata dataframe on which we are looking to predict
#'@return predictor predicted object with prediction probabilities
#'@export
#'@examples
#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'A <- real_adaboost(Y~X, fakedata, 10)
#'pred <- predict(A,newdata=fakedata)
predict.real_adaboost <- function(object, newdata)
{
  return( predict_adaboost_internal(object,newdata,"SAMME.R") ) 
}





#'internal method which predicts both adaboost_M1 and 
#'real adaboost
#'@param object an object of class adaboost
#'@param newdata dataframe on which we are looking to predict
#'@param method M1 or SAMME.R
predict_adaboost_internal <-function(object, newdata, method)
{
  if(!all(method %in% c("M1","SAMME.R") ))
    stop(paste("method must be M1 or SAMME.R. It is",method), call.=F)
  formula <- object$formula
  tree_list <- object$trees
  coeff_vector <- object$weights
  classnames_map <- object$classnames
  num_examples <- nrow(newdata)
  if(method == "M1")
  {
    cpp_list <- predict_adaboost_(tree_list, coeff_vector, newdata,
                                  num_examples, wrap_rpart_predict,classnames_map)
  }
  else
  {
    cpp_list <- predict_real_adaboost_(tree_list, coeff_vector, newdata,
                                       num_examples, wrap_rpart_predict_real)
  }
  votes <- cpp_list$votes
  predicted_class_int <- cpp_list$class #this is 0 or 1
  predicted_class <- ifelse(predicted_class_int == 0, classnames_map["A"],classnames_map["B"])
  predicted_class <- factor(predicted_class)
  prob_mat = cpp_list$prob
  
  #if data is labeled, calculate prediction error
  test_error <- NA
  depvar_name <- object$dependent_variable 
  if( depvar_name %in% names(newdata))
  {
    vardep = ifelse(newdata[,depvar_name]==classnames_map["A"],0,1)
    test_error <- calculate_test_error_(vardep, predicted_class_int)
  }
    
  
  
  predictor <- list(formula = formula, votes = votes, 
                    class = predicted_class,prob = prob_mat,
                    error = test_error)
  
  
  return(predictor)
}

