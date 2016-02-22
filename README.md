---
output:
  md_document:
    variant: markdown_github
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# fastAdaboost
fastAdaboost is a blazingly fast implementation of adaboost for R. It uses C++ code in the backend to provide an implementation of adaboost that is about 100 times faster than native R based libraries currently available. This is especially useful if your data size is large. fastAdaboost works only 
for binary classification tasks presently. It implements Freund and Schapire's Adaboost.M1 and 
Zhu et. al's SAMME.R (real adaboost) algorithms.

## Install
It is not submitted to CRAN yet.

```r
devtools::install_github("souravc83/fastBoost")
```

## Quick Demo

```r
library("fastBoost")

num_each <- 1000
fakedata <- data.frame( X=c(rnorm(num_each,0,1),rnorm(num_each,1.5,1)), Y=c(rep(0,num_each),rep(1,num_each) ) )
fakedata$Y <- factor(fakedata$Y)
#run adaboost
A <- adaboost(Y~X, fakedata, 10)
#print(A)
pred <- predict(A,newdata=fakedata)
print(paste("Adaboost Error on fakedata:",pred$error))

B <- real_adaboost(Y~X, fakedata, 10)
pred_real <- predict(B,fakedata)
print(paste("Real Adaboost Error on fakedata:", pred_real$error))
```



