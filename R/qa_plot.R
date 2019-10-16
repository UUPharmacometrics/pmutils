
#' Plot result 
#' 
#' Print result if the provided result does not contain an error. 
#'
#' @param r A result data structure
#'
#' @export
plot_result <- function(r){
  if(has_errors(r)) return(invisible(NULL))
  else print(r$result)
}

#' Prepare VA plot of FREM results
#'
#' @param qa_results QA result data structure
#'
#' @return A result data structure
#' @export
prepare_va_cov_plot <- function(qa_results){
  frem_path <- qa_results$files$frem$path
  derivatives_lst <- qa_results$files$linearize$derivatives_lst
  
  p <- tryCatch({
    input_base <- vaplot::prepare_va_nm(derivatives_lst)
    res_base <- vaplot::compute_va(input_base)
    input_frem <- vaplot::prepare_va_frem(frem_path)
    res_frem <- vaplot::compute_va(input_frem)
    vaplot::plot_va_compare(`without covariates` = res_base, 
                                 `with covariates` = res_frem, 
                                 smooth = TRUE)+
      ggplot2::theme_bw()+
      ggplot2::theme(legend.position = "top")
  },
    error = function(e) return(e)
  ) %>% as_result()
  return(p)
} 
