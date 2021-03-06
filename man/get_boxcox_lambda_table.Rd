% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qa_get_boxcox_lambda_table.R
\name{get_boxcox_lambda_table}
\alias{get_boxcox_lambda_table}
\title{A dataframe of the estimated shape parameters (Lambda) as well as expected improvement in OFV
when estimating a Box-Cox transformation for each subject-level random effect.}
\usage{
get_boxcox_lambda_table(directory, dofv_boxcox)
}
\arguments{
\item{directory}{A path of the qa run directory. Will search for the boxcox.ext file in the modelfit_run folder
and derivatives.ext file in the linearize_run/scm_dir1 folder.}

\item{dofv_boxcox}{A dofv value of the boxcox model.}
}
\value{
A list of two elements:
boxcox_lambdas_orig - A data frame with lambda and sd values from the boxcox and derivatives models.
boxcox_lambdas_table - A data frame with rounded lambda and sd values from the boxcox and derivatives models values, and added boxcox dofv value.
}
\description{
A dataframe of the estimated shape parameters (Lambda) as well as expected improvement in OFV
when estimating a Box-Cox transformation for each subject-level random effect.
}
