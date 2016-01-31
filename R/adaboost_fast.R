rpart_wrap <- function(x){return(2*x)}
#'fast implementation of adaboost using Rcpp
#'@export
adaboost_fast<-function()
{

  print(fastboost_rpart_test_(3,rpart_wrap))
  fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
  fakedata$Y <- factor(fakedata$Y)
  x <- call_rpart_(wrap_rpart, fakedata)
  print(x)
}

