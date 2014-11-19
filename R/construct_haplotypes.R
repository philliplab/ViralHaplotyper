#' Given a set of sequences, extract the haplotypes.
#'
#' Various different methods can be used to construct the haplotypes. The
#' following are currently implemented:
#' \itemize{
#'   \item{unique - Each unique sequence is a haplotype}
#'   \item{single - The entire dataset is a single haplotype}
#' }
#'
#' @return A list of objects of class \code{\link{Haplotype-class}}
#'
#' @param seq_data The input data
#' @param cluster_method The clustering method to use when constructing the
#' haplotypes
#' @param cluster_params A list of input parameters to the clustering
#' algorithm.
#' @export

construct_haplotypes <- function(seq_data, cluster_method = 'unique', 
                                 cluster_params = list(NULL)){
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
      haplotypes[[i]] <- .Haplotype(name = 'hap',
                                    sequences = BStringSet(seq_uniq[i]),
                                    copies = copies_list)
    }
  }
  if (cluster_method == 'single'){
    seq_uniq <- unique(seq_data)
    seq_tab <- BiocGenerics::table(seq_data)
    copies_list <- list()
    for (i in seq_along(seq_uniq)){
      curr_seq <- seq_uniq[i]
      curr_seq_name <- names(seq_uniq)[i]
      n_copies <- seq_tab[names(seq_tab) == curr_seq]
      names(n_copies) <- NULL
      other_sequences <- names(seq_data)[seq_uniq[i] == seq_data]
      other_sequences <- other_sequences[other_sequences != names(seq_uniq)[i]]
      copies_list[[names(seq_uniq)[i]]] <- list(n_copies = n_copies,
                                                other_sequences = other_sequences)
    }
    haplotypes[[1]] <- .Haplotype(name = 'hap',
                                  sequences = BStringSet(seq_uniq),
                                  copies = copies_list)
  }
  return(haplotypes)
}
