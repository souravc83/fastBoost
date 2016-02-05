library("fastBoost")
test_that("predicting adaboost works",{
  #create data
  num_each <- 1000
  fakedata <- data.frame( X=c(rnorm(num_each,0,1),rnorm(num_each,1.5,1)), Y=c(rep(0,num_each),rep(1,num_each) ) )
  fakedata$Y <- factor(fakedata$Y)
  #run adaboost
  A <- adaBoost(Y~X, fakedata, 10)  
  pred <- predict(A,newdata=fakedata)
  err <- length(which(pred$class!=as.numeric(fakedata$Y)))/nrow(fakedata)
  print(paste("Adaboost Error:",err))
  expect_true(err<1.)
})