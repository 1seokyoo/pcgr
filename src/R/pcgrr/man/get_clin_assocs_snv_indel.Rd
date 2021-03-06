% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/biomarkers.R
\name{get_clin_assocs_snv_indel}
\alias{get_clin_assocs_snv_indel}
\title{Function that matches clinical evidence items (CIVIC, CBMDB)
against somatic cancer variants detected in tumor}
\usage{
get_clin_assocs_snv_indel(sample_calls, annotation_tags = NULL, eitems = NULL)
}
\arguments{
\item{sample_calls}{data frame with sample variants}

\item{annotation_tags}{list with annotation tags for display in report}

\item{eitems}{data frame with clinical evidence items}
}
\value{
list
}
\description{
Function that matches clinical evidence items (CIVIC, CBMDB)
against somatic cancer variants detected in tumor
}
