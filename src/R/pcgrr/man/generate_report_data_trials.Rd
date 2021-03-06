% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clinicaltrials.R
\name{generate_report_data_trials}
\alias{generate_report_data_trials}
\title{Function that retrieves relevant (interventional based on molecular target)
clinical trials for a given tumor type}
\usage{
generate_report_data_trials(pcgr_data, config, sample_name)
}
\arguments{
\item{pcgr_data}{PCGR data bundle object}

\item{config}{PCGR run configurations}

\item{sample_name}{sample name}
}
\value{
pcg_report_trials data frame with all report elements
}
\description{
Function that retrieves relevant (interventional based on molecular target)
clinical trials for a given tumor type
}
