#include <Rcpp.h>
using namespace Rcpp;

// Below is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar)

// For more on using Rcpp click the Help button on the editor toolbar

// [[Rcpp::export]]
List real_adaboost_main_(std::string formula_char, DataFrame data_df, 
                          IntegerVector vardep, int nIter, Function wrap_rpart)
{
  int num_examples = vardep.size();
  List tree_list = List::create();
  //create initial weight vector
  double init_weight_val = 1./num_examples;
  std::vector<double> weight_vec(num_examples,init_weight_val);
  NumericVector weight_numvec(weight_vec.begin(), weight_vec.end() );
  
  List adaboost_list;
  return adaboost_list;
}
