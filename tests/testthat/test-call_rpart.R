library("fastBoost")
test_that("rpart call from Rcpp works",{
  num_each <- 100
  fakedata <- data.frame( X=c(rnorm(num_each,0,1),rnorm(num_each,1.5,1)), Y=c(rep(0,num_each),rep(1,num_each) ) )
  fakedata$Y <- factor(fakedata$Y)
  num_examples <- nrow(fakedata)
  weights <- rep(1./num_examples, num_examples)
  x <- call_rpart_(wrap_rpart, fakedata, weights)
  
  tree <- x$tree
  predictions <- predict(tree, newdata=fakedata, type="class")
  #print(predictions)
  
})