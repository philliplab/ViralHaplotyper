# This script will contain all the distance computations that are performed for
# haplotypes.
#
# In all cases:
# If no distance measure is given, use the one included in the haplotype
# definition.
#
# Given a sequence, a haplotype and a distance measure, compute the distances
# between each sequence in the haplotype and the query sequence.
#
# Given a sequence, a haplotype and a distance measure, compute the average (or
# median or min or max or some other metric) of the distances between the query
# sequence and the haplotype sequences. Optionally assign weights based on the
# number of copies of each sequence in the haplotype.
#
# Given a sequence, a haplotype, a distance measure and a threshold, make a
# call about whether or not a sequence belongs to a haplotype.

#' Computes the distances between query sequences and the members of a
#' haplotype
#'
#' @return A matrix of the distances between each query sequence and each
#' sequence in the haplotype.
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
  return(1)
}
  
)

