# This script will contain all the distance computations that are performed for
# haplotypes.
#
# In all cases:
# If no distance measure is given, use the one included in the haplotype
# definition.
#
# Given a set of sequences, a haplotype and a distance measure, compute the distances
# between each sequence in the haplotype and each query sequence.
#
# Given a set of sequences, a haplotype and a distance measure, compute the average (or
# median or min or max or some other metric) of the distances between each query
# sequence and the haplotype sequences. Optionally assign weights based on the
# number of copies of each sequence in the haplotype.
#
# Given a sequence, a haplotype, a distance measure and a threshold, make a
# call about whether or not a sequence belongs to a haplotype.
#
# The distance function must have some special properties:
#  - It must not compute a distance matrix, it must compute a vector of
#  distances between each given element and the query element. Think the
#  difference between pairwiseAlignment() and dist()
#
# Let's add the further convention that the first argument to the distance
# function must be the vector of targets and the second argument the query
# sequence.

#' Computes the distances between set of target sequences and a single query
#' sequence
#'
#' @return A vector of the distances between each target sequence and the
#' query sequence.
#' @param target_sequences A BStringSet of target sequences
#' @param query_sequence The sequence whose distance from the target sequences
#' must be computed
#' @export
dist_pwa <- function(target_sequences, query_sequence, substitutionMatrix = NULL){
  return(score(pairwiseAlignment(gsub('-', '', target_sequences), 
                                 gsub('-', '', query_sequence),
                                 substitutionMatrix = substitutionMatrix)))
}

#' Computes the distances between query sequences and the members of a
#' haplotype
#'
#' @return A matrix of the distances between each query sequence and each
#' sequence in the haplotype. The haplotype sequences correspond to the rows
#' and the query sequences correspond to the columns.
#'
#' @param haplotype The haplotype the sequence must be compared to.
#' @param query_sequences The sequences to be compared to the haplotype.
#' @rdname seq_hap_distances-methods
#' @export seq_hap_distances

setGeneric("seq_hap_distances",
           function(haplotype, query_sequences){
             standardGeneric("seq_hap_distances")
           }
)

#' @rdname seq_hap_distances-methods
#' @aliases seq_hap_distances
setMethod("seq_hap_distances", 
          c('Haplotype', 'BStringSet'),

function(haplotype, query_sequences){
  hap_sequences <- haplotype@sequences
  all_dists <- matrix(-1, nrow = length(hap_sequences),
                      ncol = length(query_sequences))
  for (query_sequence_id in seq_along(query_sequences)){
    query_sequence <- query_sequences[query_sequence_id]
    all_dists[, query_sequence_id] <- dist_pwa(hap_sequences, query_sequence)
  }
  return(all_dists)
}
)
