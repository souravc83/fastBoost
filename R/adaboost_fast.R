#'fast implementation of adaboost using Rcpp
#'@import rpart
#'@import mlbench
#'@param formula Formula for models
#'@param data Input dataframe
#'@param nIter no. of classifiers 
#'@return adaboost_object An object of class adaboost containing each tree, and its corresponding weight
#'@export

# TODO before CRAN release:
# boosting.cv: cross validation
#from here:
#http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.AdaBoostClassifier.html#sklearn.ensemble.AdaBoostClassifier
# score(or error)
# staged_error
#handle NA
#getTree(adaboost_obj, k) -done
#print
#summary
#real adaboost
adaboost_fast<-function(formula, data, nIter, ...)
{
  #all precondition checks
  
  #formula_char <- as.character(formula)
  formula_char <-"Y~X"
  #num_each <- 100
  #fakedata <- data.frame( X=c(rnorm(num_each,0,1),rnorm(num_each,1.5,1)), Y=c(rep(0,num_each),rep(1,num_each) ) )
  #fakedata$Y <- factor(fakedata$Y)
  
  rcpp_ada_obj <- adaboost_main_loop_(formula_char, data, nIter, wrap_rpart)
  trees_list <- rcpp_ada_obj$trees
  coeff_vector<- rcpp_ada_obj$weights
  
  
  ceoff_vector <- rcpp_ada_obj$coeff_vector
  adaboost_object <- list(formula = formula, trees=trees_list, weights = coeff_vector)
  class(adaboost_object) <- "adaBoost"
  return(adaboost_object)
  
}

