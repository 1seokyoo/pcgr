% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kataegis.R
\name{generate_report_data_kataegis}
\alias{generate_report_data_kataegis}
\title{Function that generates data frame with potential kataegis events}
\usage{
generate_report_data_kataegis(
  variant_set,
  sample_name = "SampleX",
  build = "grch37"
)
}
\arguments{
\item{variant_set}{data frame with SNVs/InDels (must contain 'CHROM',
'POS','REF','ALT')}

\item{sample_name}{name of tumor sample}

\item{build}{genome assembly (grch37/grch38)}
}
\description{
Function that generates data frame with potential kataegis events
}
