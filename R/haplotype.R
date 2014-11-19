#' @title The data structure that holds a haplotype
#' 
#' @details A haplotype will be defined by specifying:
#' \itemize{
#'   \item a name for the haplotype
#'   \item a number of unique input sequences (possibly only one)
#'   \item the copies list (see note about non-uniqueness)
#' }
#'
#' The fact that the sequences are not
#' necessarily unique. If the
#' number of repeated sequences is large, then very substantial performance
#' increases can be achieved by working on only the unique sequences when
#' computing distance matrics and phylogenetic trees. This
#' performance increase is so large that it is absolutely worthwhile to
#' implement special features to take advantage of it. (19.5 sec on unqiue
#' sequences vs > 5 hours on non-unique sequences on sample data from CAPRISA)
#'
#' To handle the non-uniquess of the sequences, the input sequences specified
#' will only include unique sequences. The names associated with those
#' sequences are the names allocated by the uniq method for the data structure
#' that was used to store the sequence. Usually a BStringSet from the
#' biostrings package. A further list will be included in the
#' haplotype data structure that contains for each unique input name, the number of
#' sequences that are identical to it and a character vector of their names.
#'
#' @rdname Haplotype
#' @aliases Haplotype-class
#' @exportClass Haplotype
#' @export .Haplotype

.Haplotype <- setClass(
  Class = 'Haplotype',
  representation = representation(
    name = 'character',
    sequences = 'BStringSet',
    copies = 'list'),
  validity = function(object){
    for (seq_name in names(object@copies)){
      stopifnot(seq_name %in% names(object@sequences))
      stopifnot(!(seq_name %in% object@copies[[seq_name]]$other_sequences))
    }
  }
)

#' Returns all the sequences of a haplotype
#'
#' @param the_haplotype The haplotype from which the sequences must be
#' extracted
#' @rdname get_all_sequences-methods
#' @export get_all_sequences

setGeneric("get_all_sequences",
           function(the_haplotype){
             standardGeneric("get_all_sequences")
           }
)

#' @rdname get_all_sequences-methods
#' @aliases get_all_sequences
setMethod("get_all_sequences", 
          c('Haplotype'),

function(the_haplotype){
  all_seq <- BStringSet()
  copies <- the_haplotype@copies
  for (i in seq_along(copies)){
    the_copy <- copies[[i]]
    seq_name <- names(copies)[i]
    copy_seq <- the_haplotype@sequences[seq_name]
    seq_names <- c(seq_name, the_copy$other_sequences)
    rep_seq <- rep(copy_seq, the_copy$n_copies)
    names(rep_seq) <- seq_names
    all_seq <- c(all_seq, rep_seq)
  }
  return(all_seq)
}
  
)

#' Returns the unique sequences of a haplotype
#'
#' @param the_haplotype The haplotype from which the unique sequences must be
#' extracted
#' @rdname get_unique_sequences-methods
#' @export get_unique_sequences

setGeneric("get_unique_sequences",
           function(the_haplotype){
             standardGeneric("get_unique_sequences")
           }
)

#' @rdname get_unique_sequences-methods
#' @aliases get_unique_sequences
setMethod("get_unique_sequences", 
          c('Haplotype'),

function(the_haplotype){
  return(the_haplotype@sequences)
}
  
)

#' Returns the count of all sequences in the haplotype
#'
#' @param the_haplotype The haplotype whose sequences must be counted.
#' @rdname total_number_of_sequences-methods
#' @export total_number_of_sequences

setGeneric("total_number_of_sequences",
           function(the_haplotype){
             standardGeneric("total_number_of_sequences")
           }
)

#' @rdname total_number_of_sequences-methods
#' @aliases total_number_of_sequences
setMethod("total_number_of_sequences", 
          c('Haplotype'),

function(the_haplotype){
  total_seq <- 0
  copies <- the_haplotype@copies
  for (i in seq_along(copies)){
    total_seq <- total_seq + copies[[i]]$n_copies
  }
  return(total_seq)
}
  
)

