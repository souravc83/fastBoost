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

//utility functions 
double calculate_error(IntegerVector dep_variable, IntegerVector tree_prediction, 
                       NumericVector weight_vec )
{
  int dep_size = dep_variable.size();
  int pred_size = tree_prediction.size();
  int weight_size = weight_vec.size();
  if(dep_size!=pred_size || pred_size!=weight_size)
    stop("three vector sizes should be the same");
  
  double error = 0.;
  for(int i=0;i<dep_size;i++)
  {
    if(dep_variable[i]!=tree_prediction[i])
      error+=weight_vec[i];
  }
  return error;
  
}

NumericVector update_weights(IntegerVector dep_variable, IntegerVector tree_prediction, 
                             NumericVector weight_vec, double alpha)
{
  int dep_size = dep_variable.size();
  int pred_size = tree_prediction.size();
  int weight_size = weight_vec.size();
  if(dep_size!=pred_size || pred_size!=weight_size)
    stop("three vector sizes should be the same");
  
  NumericVector updated_wt = weight_vec;
  
  for(int i=0;i<dep_size;i++)
  {
    if(dep_variable[i]!=tree_prediction[i])
      updated_wt[i] = weight_vec[i]*exp(alpha);
  }
  double element_sum = 0.;
  for(int i=0;i<dep_size;i++)
    element_sum +=updated_wt[i];
  Rcout<<element_sum<<std::endl;
  if (element_sum!=0)
  {
    for(int i=0;i<dep_size;i++)
      updated_wt[i] = updated_wt[i]/element_sum;
  }
  return updated_wt;
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
  
  //initialize to avoid initialize in every loop
  IntegerVector tree_prediction;
  double err;
  double alpha;
  NumericVector weight_numvec_dummy;
  
  for(int i=0;i<nIter;i++)
  {
    List rcpp_result = call_rpart_(wrap_rpart, data_df, weight_numvec);
    //because rcpp will not accept integers as list names
    std::string list_name = std::to_string(i);
    tree_list[list_name] = rcpp_result["tree"];
    tree_prediction = as<IntegerVector>(rcpp_result["pred"]);
    err = calculate_error(vardep, tree_prediction, weight_numvec);
    Rcout<< err<<std::endl;
    alpha = 0.5*log((1.-err)/err);
    coeff_vector[i] = alpha;
    weight_numvec_dummy =  update_weights(vardep, tree_prediction, weight_numvec, alpha); 
  }
  
  List adaboost_list;
  adaboost_list["trees"] = tree_list;
  adaboost_list["weights"] = coeff_vector;
  
  return adaboost_list;
}

