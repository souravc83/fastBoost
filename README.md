---
output:
  md_document:
    variant: markdown_github
---

<!-- README.md is generated from README.Rmd. Please edit that file -->

# fastBoost
fastBoost is a fast implementation of adaboost for R. It uses C++ code in the backend to provide
a much faster adaboost implementation than currently available libraries in R. This is especially
useful if your data size is large.

## Install
It is currently in very alpha stages of development. So I would urge you to wait for a couple of 
weeks until I get it to shape.

It is not submitted to CRAN yet.
If you must install it:

```r
devtools::install_github("souravc83/fastBoost")
```

## Load the package

```r
library("fastBoost")
```

