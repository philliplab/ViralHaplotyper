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
#' @param distance A function that can compute a distance between a genetic
#' string and a set of genetic strings. More details in 
#' \code{\link{Haplotype-class}}
#' @param threshold The threshold the distance function must be under in order
#' for a new sequence to be considered part of the haplotype
#' @export

construct_haplotypes <- function(seq_data, cluster_method = 'unique', 
                                 cluster_params = list(NULL),
                                 distance = function(){return(1)},
                                 threshold = 0){
  haplotypes <- list()
  if (cluster_method == 'unique'){
    seq_uniq <- unique(seq_data)
    seq_tab <- BiocGenerics::table(seq_data)
    for (i in seq_along(seq_uniq)){
      curr_seq <- seq_uniq[i]
      curr_seq_name <- names(seq_uniq)[i]
      copies_list <- list()
      n_copies <- seq_tab[names(seq_tab) == curr_seq]
      names(n_copies) <- NULL
      other_sequences <- names(seq_data)[seq_uniq[i] == seq_data]
      other_sequences <- other_sequences[other_sequences != names(seq_uniq)[i]]
      copies_list[[names(seq_uniq)[i]]] <- list(n_copies = n_copies,
                                                other_sequences = other_sequences)
      haplotypes[[i]] <- .Haplotype(sequences = BStringSet(seq_uniq[i]),
                              distance = distance,
                              threshold = threshold,
                              copies = copies_list)
    }
  }
  return(haplotypes)
}
