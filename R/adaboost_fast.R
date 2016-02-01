#'fast implementation of adaboost using Rcpp
#'@import rpart
#'@param formula Formula for models
#'@param data Input dataframe
#'@param nIter no. of classifiers 
#'@export
#'
adaboost_fast<-function(formula, data, nIter, ...)
{
  #all precondition checks
  
  #formula_char <- as.character(formula)
  formula_char <-"Y~X"
  #num_each <- 100
  #fakedata <- data.frame( X=c(rnorm(num_each,0,1),rnorm(num_each,1.5,1)), Y=c(rep(0,num_each),rep(1,num_each) ) )
  #fakedata$Y <- factor(fakedata$Y)
  
  rcpp_ada_obj <- adaboost_main_loop_(formula_char, data, 10, wrap_rpart)
  trees_list <- rcpp_ada_obj$trees
  coeff_vector<- rcpp_ada_obj$weights
  
  
  ceoff_vector <- rcpp_ada_obj$coeff_vector
  adaboost_object <- list(formula = formula, trees=trees_list, weights = coeff_vector)
  class(adaboost_object) <- "adaBoost"
  return(adaboost_object)
  
}

