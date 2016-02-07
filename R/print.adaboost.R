#'S3 method to print an adaboost object
#'@param object object of class adaboost
#'@return None
#'@export
#'@examples
#'#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'A <- adaBoost(Y~X, fakedata, 10)
#'print(A)
#'

print.adaBoost <-function(object)
{
  #cat("No of trees:",length(object$trees_list),"\n",sep="")
  #print training error

}