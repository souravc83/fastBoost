#'adaBoost
#'
#'Implements Freund's Adaboost.M1 algorithm
#'@param formula Formula for models
#'@param data Input dataframe
#'@param nIter no. of classifiers 
#'@examples 
#'fakedata <- data.frame( X=c(rnorm(100,0,1),rnorm(100,1,1)), Y=c(rep(0,100),rep(1,100) ) )
#'fakedata$Y <- factor(fakedata$Y)
#'test.adaboost <- adaBoost(Y~X, data=fakedata,10)


adaBoost <-function(formula, data, nIter,...)
{
  
  formula <- as.formula(formula)
  vardep <- data[, as.character(formula)[[2]] ]
  #elements to store final answers
  num_examples <- nrow(data)
  weights_t <- rep(1/num_examples,num_examples)
  tree_list <- list()
  coeff_vector <- rep(0,nIter)
  rpart_control <- rpart.control(cp=0)
  for(i in 1:nIter)
  {

    temp_wt <<- weights_t
    tree_fit <- rpart(formula, data, weights=temp_wt,  control = rpart_control)
    tree_list[[i]] <- tree_fit
    train_learn <- predict(tree_fit,type="class")
    agreement <- as.numeric(vardep!=train_learn)
    err <- sum(weights_t*agreement)
    #if(i==1)
    #  print(err)
    
    alpha <- 0.5*log( (1-err)/err )
    coeff_vector[i] <- alpha
    
 
    #update the weights
    weights_t <- weights_t*exp(alpha*agreement)
    weights_t <- weights_t/sum(weights_t)
    
  }
  
  adaboost_object <- list(formula = formula, trees=tree_list, weights = coeff_vector)
  class(adaboost_object) <- "adaBoost"
  return(adaboost_object)
}


# #set.seed(1235)
# num_each <- 1000
# fakedata <- data.frame( X=c(rnorm(num_each,0,1),rnorm(num_each,1.5,1)), Y=c(rep(0,num_each),rep(1,num_each) ) )
# fakedata$Y <- factor(fakedata$Y)
# run_my_adaboost <- function(fakedata)
# {
#   A <- adaBoost(Y~X, fakedata, 10)
#   
#   pred <- predict(A,newdata=fakedata)
#   err <- length(which(pred$class!=as.numeric(fakedata$Y)))/nrow(fakedata)
#   #print(err)
# }
# #error with adabag
# run_adabag_adaboost <- function(fakedata)
# {
#   library(adabag)
#   bag_obj <- boosting(Y~., fakedata, boos=F, mfinal=10, coeflearn = "Breiman", 
#                     control = rpart.control(cp=0))
# 
#   bag_pred <- predict(bag_obj, newdata=fakedata)
#   err_bag <- length(which(bag_pred$class!=fakedata$Y))/nrow(fakedata)
#   #print(err_bag)
# }
# 
# library(microbenchmark)
# 
# my_time <- microbenchmark(run_my_adaboost(fakedata), times=25)
# print(my_time)
# bag_time <- microbenchmark(run_adabag_adaboost(fakedata), times=25)
# print(bag_time)
# 
