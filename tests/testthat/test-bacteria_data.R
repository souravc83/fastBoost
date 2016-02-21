  library(fastBoost)
  library(MASS)
  
  test_that("Bacteria dataset works",{
    attach(bacteria)
    boost_obj <- adaboost(y~.,bacteria , 10)
    pred <- predict(boost_obj,bacteria)
    
  })
#  
 test_that("bacteria dataset works with a selection of variables",{
    attach(bacteria)
    boost_obj <- adaboost(y~ap+hilo+week,bacteria , 10)
    pred <- predict(boost_obj, bacteria)
  })