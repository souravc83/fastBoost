library("fastBoost")
test_that("test if rpart test works",{
  rpart_wrap <- function(x){return(2*x)}
  print(fastboost_rpart_test_(3,rpart_wrap))
})