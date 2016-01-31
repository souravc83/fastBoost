// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// fastboost_rpart_test_
int fastboost_rpart_test_(int x, Function call_rpart);
RcppExport SEXP fastBoost_fastboost_rpart_test_(SEXP xSEXP, SEXP call_rpartSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< int >::type x(xSEXP);
    Rcpp::traits::input_parameter< Function >::type call_rpart(call_rpartSEXP);
    __result = Rcpp::wrap(fastboost_rpart_test_(x, call_rpart));
    return __result;
END_RCPP
}
// call_rpart_
NumericVector call_rpart_(Function wrap_rpart, DataFrame newdata, NumericVector weight_vec);
RcppExport SEXP fastBoost_call_rpart_(SEXP wrap_rpartSEXP, SEXP newdataSEXP, SEXP weight_vecSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< Function >::type wrap_rpart(wrap_rpartSEXP);
    Rcpp::traits::input_parameter< DataFrame >::type newdata(newdataSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type weight_vec(weight_vecSEXP);
    __result = Rcpp::wrap(call_rpart_(wrap_rpart, newdata, weight_vec));
    return __result;
END_RCPP
}
