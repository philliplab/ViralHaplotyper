% Generated by roxygen2 (4.0.2): do not edit by hand
\name{construct_haplotypes}
\alias{construct_haplotypes}
\title{Given a set of sequences, extract the haplotypes.}
\usage{
construct_haplotypes(seq_data, cluster_method = "unique",
  cluster_params = list(NULL), n_header_letters = 1)
}
\arguments{
\item{seq_data}{The input data}

\item{cluster_method}{The clustering method to use when constructing the
haplotypes}

\item{cluster_params}{A list of input parameters to the clustering
algorithm.}

\item{n_header_letters}{The number of letters to take from a FASTA header of
one of the sequences and prepend to the haplotype name.}
}
\value{
A list of objects of class \code{\link{Haplotype-class}}
}
\description{
Various different methods can be used to construct the haplotypes. The
following are currently implemented:
\itemize{
  \item{unique - Each unique sequence is a haplotype}
  \item{single - The entire dataset is a single haplotype}
}
}
\details{
The haplotypes are assigned names by taking the first n letters from the name
of a random sequence (the sequence names should all be the same for the
first n letters) and appending _hapx to it. Where is a number the that keeps
track of the haplotype numbers.
}

