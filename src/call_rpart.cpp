#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
NumericVector call_rpart_(Function wrap_rpart, DataFrame newdata, NumericVector weight_vec) {
   std::string formula_char = "Y~X";
   SEXP num_class = wrap_rpart(formula_char, newdata, weight_vec);
   NumericVector rpart_class = as<NumericVector>(num_class);
   Rcout<<rpart_class<<std::endl;
   return rpart_class;
}
