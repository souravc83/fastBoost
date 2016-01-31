#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
int fastboost_rpart_test_(int x, Function call_rpart) {
   int y = as<int>(call_rpart(x));
   return y;
}
