#' Given a set of sequences, extract the haplotypes.
#'
#' The clustering approach to use is described using the list cluster_params.
#'
#' The simplest haplotype construction approach is to see each unique sequence
#' as a haplotype. This is achieved by specifying inputs of cluter_method =
#' 'unique' and cluster_params = list(NULL).
#'
#' Dealing with non-unique sequences leads to several complications. 
#' See the documentation of \code{\link{Haplotype-class}} for more details on
#' the storing the non-unique data.
#'
#' I am currently unsure about the best approach to follow for clustering with
#' the non-unique data. Just clustering with the unique data will probably
#' produce different results from clustering when the non-unique data is
#' included. This is a big problem to deal with in the future.
#'
#' @return A list of objects of class \code{\link{Haplotype-class}}
#'
#' @param seq_data The input data
#' @param cluster_method The clustering method to use when constructing the
#' haplotypes
#' @param cluster_params A list of input parameters to the clustering
#' algorithm.
#' @export

construct_haplotypes <- function(seq_data, cluster_method = 'unqiue', 
                                 cluster_params = list(NULL)){
  return(0)
}
