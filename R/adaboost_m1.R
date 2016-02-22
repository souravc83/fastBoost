#'Implements Freund's Adaboost.M1 algorithm
#'@import rpart
#'@param formula Formula for models
#'@param data Input dataframe
#'@param nIter no. of classifiers 
#'@param ... other optional arguments, not implemented now
#'@export 
#'@examples 
#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'test.adaboost <- adaboost(Y~X, data=fakedata,10)


adaboost <-function(formula, data, nIter,...)
{
  theCall <- match.call()
  adaboost_object <- adaboost_fast(formula,data,nIter, method="M1")
  adaboost_object$call <- theCall
  return(adaboost_object)
}

# 
# library(microbenchmark)
# 
# my_time <- microbenchmark(run_my_adaboost(fakedata), times=25)
# print(my_time)
# bag_time <- microbenchmark(run_adabag_adaboost(fakedata), times=25)
# print(bag_time)
# 
