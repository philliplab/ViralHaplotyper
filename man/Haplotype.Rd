% Generated by roxygen2 (4.0.2): do not edit by hand
\docType{class}
\name{Haplotype-class}
\alias{.Haplotype}
\alias{Haplotype-class}
\title{The data structure that holds a haplotype}
\description{
The data structure that holds a haplotype
}
\details{
A haplotype will be defined by specifying:
\itemize{
  \item a name for the haplotype
  \item a number of unique input sequences (possibly only one)
  \item the copies list (see note about non-uniqueness)
}

The fact that the sequences are not
necessarily unique. If the
number of repeated sequences is large, then very substantial performance
increases can be achieved by working on only the unique sequences when
computing distance matrics and phylogenetic trees. This
performance increase is so large that it is absolutely worthwhile to
implement special features to take advantage of it. (19.5 sec on unqiue
sequences vs > 5 hours on non-unique sequences on sample data from CAPRISA)

To handle the non-uniquess of the sequences, the input sequences specified
will only include unique sequences. The names associated with those
sequences are the names allocated by the uniq method for the data structure
that was used to store the sequence. Usually a BStringSet from the
biostrings package. A further list will be included in the
haplotype data structure that contains for each unique input name, the number of
sequences that are identical to it and a character vector of their names.
}

