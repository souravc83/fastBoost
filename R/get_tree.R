#'returns an individual tree from the adaboost object
#'@param object object of class fastBoost
#'@param tree_num integer describing the tree to get
#'@return tree object of class rpart
#'@export
#'@examples 
#'#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'A <- adaBoost(Y~X, fakedata, 10)
#'tree <- get_tree(A,5)

get_tree <-function(object, tree_num)
{
  if(class(object)[1]!="adaboost")
    stop("object is not of class adaboost",call.=F)
  tree_list <- object$trees
  if(tree_num> length(tree_list))
  {
    stop(paste("requested tree number",tree_num,
               "is greater than no. of adaboost iterations:",length(tree_list)), call.=F)
  }
  return(tree_list[tree_num])
}