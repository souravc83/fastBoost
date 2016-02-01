#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
List call_rpart_(Function wrap_rpart, DataFrame newdata, NumericVector weight_vec) {
   std::string formula_char = "Y~X";
   SEXP return_list = wrap_rpart(formula_char, newdata, weight_vec);
   List rcpp_return_list = as<List>(return_list);
   
   NumericVector rpart_class = as<NumericVector>(rcpp_return_list["pred"]);
   //Rcout<<rpart_class<<std::endl;
   return rcpp_return_list;
}

// [[Rcpp::export]]
List adaboost_main_loop_(std::string formula_char, DataFrame data_df, int nIter, Function wrap_rpart)
{
  //Dataframe should be doubles, checked at R upstream
  char vardep_col = formula_char[0];
  Rcout<<vardep_col<<std::endl;
  IntegerVector vardep = data_df["Y"];
  int num_examples = vardep.size();
  List tree_list = List::create();
  std::vector<double> coeff_vector(nIter,0.0);
  // initialize weight vector
  double init_weight_val = 1./num_examples;
  std::vector<double> weight_vec(num_examples,init_weight_val);
  NumericVector weight_numvec(weight_vec.begin(), weight_vec.end() );
  
  for(int i=0;i<nIter;i++)
  {
    List rcpp_result = call_rpart_(wrap_rpart, data_df, weight_numvec);
    //because rcpp will not accept integers as list names
    std::string list_name = std::to_string(i);
    tree_list[list_name] = rcpp_result["tree"];
    weight_numvec = as<NumericVector>(rcpp_result["pred"]);
  }
  
  return tree_list;
}

