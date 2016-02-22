#'S3 method to print an adaboost object
#'@param x object of class adaboost
#'@param ... arguments passed to print.default
#'@return None
#'@export
#'@examples
#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'A <- adaboost(Y~X, fakedata, 10)
#'print(A)
#'

print.adaboost <-function(x,...)
{
  object <- x
  print(object$call)
  print(object$formula)
  cat("Dependent Variable: ", object$dependent_variable,"\n",sep="")
  cat("No of trees:",length(object$trees),"\n",sep="")
  cat("The weights of the trees are:",object$weights,"\n",sep="")

}

#'S3 method to print an real_adaboost object
#'@param x object of class real_adaboost
#'@param ... arguments passed to print.default
#'@return None
#'@export
#'@examples
#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'A <- real_adaboost(Y~X, fakedata, 10)
#'print(A)
#'

print.real_adaboost <-function(x,...)
{
  object <- x
  print(object$call)
  print(object$formula)
  cat("Dependent Variable: ", object$dependent_variable,"\n",sep="")
  cat("No of trees:",length(object$trees),"\n",sep="")
}