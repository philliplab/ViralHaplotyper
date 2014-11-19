#' Given a set of sequences, extract the haplotypes using the 'unique' approach
#'
#' Each unique sequence will be made a haplotype. The names of all the
#' identical sequences will be added to the haplotype as well as the number of
#' copies of this sequence.
#'
#' @return A list of objects of class \code{\link{Haplotype-class}}
#' @inheritParams construct_haplotypes
#' @export

construct_haplotypes_unique <- function(seq_data, cluster_params, n_header_letters){
  haplotypes <- list()
  seq_uniq <- unique(seq_data)
  seq_tab <- BiocGenerics::table(seq_data)
  if (n_header_letters == 0){
    hap_name_pref <- ""
  } else {
    hap_name_pref <- substr(names(seq_data)[1], 1, n_header_letters)
  }
  for (i in seq_along(seq_uniq)){
    hap_name <- paste0(hap_name_pref, sprintf("%05d", i))
    curr_seq <- seq_uniq[i]
    curr_seq_name <- names(seq_uniq)[i]
    copies_list <- list()
    n_copies <- seq_tab[names(seq_tab) == curr_seq]
    names(n_copies) <- NULL
    other_sequences <- names(seq_data)[seq_uniq[i] == seq_data]
    other_sequences <- other_sequences[other_sequences != names(seq_uniq)[i]]
    copies_list[[names(seq_uniq)[i]]] <- list(n_copies = n_copies,
                                              other_sequences = other_sequences)
    haplotypes[[i]] <- .Haplotype(name = hap_name,
                                  sequences = BStringSet(seq_uniq[i]),
                                  copies = copies_list)
  }
  return(haplotypes)
}

#' Given a set of sequences, extract the haplotypes using the 'single' approach
#'
#' A single haplotype will be constructed from the entire dataset. Unique
#' sequences will be extracted and their copies will be found and the haplotype
#' will be constructed using this information.
#'
#' @return A list of objects of class \code{\link{Haplotype-class}}
#' @inheritParams construct_haplotypes
#' @export

construct_haplotypes_single <- function(seq_data, cluster_params, n_header_letters){
  haplotypes <- list()
  if (n_header_letters == 0){
    hap_name_pref <- ""
  } else {
    hap_name_pref <- substr(names(seq_data)[1], 1, n_header_letters)
  }
  hap_name <- paste0(hap_name_pref, "00001")
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
  haplotypes[[1]] <- .Haplotype(name = hap_name,
                                sequences = BStringSet(seq_uniq),
                                copies = copies_list)
  return(haplotypes)
}

#' Given a set of sequences, extract the haplotypes.
#'
#' Various different methods can be used to construct the haplotypes. The
#' following are currently implemented:
#' \itemize{
#'   \item{unique - Each unique sequence is a haplotype}
#'   \item{single - The entire dataset is a single haplotype}
#' }
#'
#' The haplotypes are assigned names by taking the first n letters from the name
#' of a random sequence (the sequence names should all be the same for the
#' first n letters) and appending _hapx to it. Where is a number the that keeps
#' track of the haplotype numbers.
#'
#' @return A list of objects of class \code{\link{Haplotype-class}}
#'
#' @param seq_data The input data
#' @param cluster_method The clustering method to use when constructing the
#' haplotypes
#' @param cluster_params A list of input parameters to the clustering
#' algorithm.
#' @param n_header_letters The number of letters to take from a FASTA header of
#' one of the sequences and prepend to the haplotype name.
#' @export

construct_haplotypes <- function(seq_data, cluster_method = 'unique', 
                                 cluster_params = list(NULL),
                                 n_header_letters = 1){
  haplotypes <- list()
  if (cluster_method == 'unique'){
    haplotypes <- construct_haplotypes_unique(seq_data, cluster_params, n_header_letters)
  }
  if (cluster_method == 'single'){
    haplotypes <- construct_haplotypes_single(seq_data, cluster_params, n_header_letters)
  }
  return(haplotypes)
}
