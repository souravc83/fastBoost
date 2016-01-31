#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
int call_rpart_(Function wrap_rpart, DataFrame newdata) {
   std::string formula_char = "Y~X";
   SEXP num_class = wrap_rpart(newdata);
   NumericVector rpart_class = as<NumericVector>(num_class);
   Rcout<<rpart_class<<std::endl;
   return 1;
}
