% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/qa_get_structural_overview_table.R
\name{get_structural_overview_table}
\alias{get_structural_overview_table}
\title{Get structural data frame with expected improvement in OFV as well as number of additional parameters used for each idv.}
\usage{
get_structural_overview_table(directory, idv, dvid_name, skip = NULL)
}
\arguments{
\item{directory}{A path to the qa run directory.}

\item{idv}{A string vector of all possible idv names for the specific qa run.}

\item{dvid_name}{A string of the DVID column name.}

\item{skip}{A character vector with names of the skipped parts in the qa run. Will check if "resmod" is one of the vector elements.
By default skip=NULL.}
}
\value{
A data frame.
}
\description{
Get structural data frame with expected improvement in OFV as well as number of additional parameters used for each idv.
}
