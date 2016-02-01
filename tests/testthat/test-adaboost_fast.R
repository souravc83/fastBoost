library("fastBoost")
test_that("fast adaboost works",{
  num_each <- 100
  fakedata <- data.frame( X=c(rnorm(num_each,0,1),rnorm(num_each,1.5,1)), Y=c(rep(0,num_each),rep(1,num_each) ) )
  fakedata$Y <- factor(fakedata$Y)
  adaboost_fast(Y~X,fakedata,10)
})