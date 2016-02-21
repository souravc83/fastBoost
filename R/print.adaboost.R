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

print.adaboost <-function(object)
{
  print(object$call)
  print(object$formula)
  cat("No of trees:",length(object$trees),"\n",sep="")
  cat("The weights of the trees are:",object$weights,"\n",sep="")


}