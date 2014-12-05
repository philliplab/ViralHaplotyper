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

#' Returns the count of the unique sequences in the haplotype
#'
#' @param the_haplotype The haplotype whose sequences must be counted.
#' @rdname number_of_unique_sequences-methods
#' @export number_of_unique_sequences

setGeneric("number_of_unique_sequences",
           function(the_haplotype){
             standardGeneric("number_of_unique_sequences")
           }
)

#' @rdname number_of_unique_sequences-methods
#' @aliases number_of_unique_sequences
setMethod("number_of_unique_sequences", 
          c('Haplotype'),
function(the_haplotype){
  return(length(the_haplotype@sequences))
}
)

#' Returns detailed information about the unique sequences in a haplotype
#'
#' It return a list with two elements. The first is a data.frame with all the
#' stats and the second is a BStringSet with complicated labels that contain
#' all the information from the first element.
#'
#' @param the_haplotype The haplotype from which the details must be
#' extracted
#' @rdname get_unique_sequence_details-methods
#' @export get_unique_sequence_details

setGeneric("get_unique_sequence_details",
           function(the_haplotype){
             standardGeneric("get_unique_sequence_details")
           }
)

#' @rdname get_unique_sequence_details-methods
#' @aliases get_unique_sequence_details
setMethod("get_unique_sequence_details", 
          c('Haplotype'),

function(the_haplotype){
  unique_sequences <- BStringSet()
  uniq_seq_details <- data.frame(seq_name = character(0),
                                 count = numeric(0),
                                 total_sequences = numeric(0),
                                 long_label = character(0))
  total_sequences <- total_number_of_sequences(the_haplotype)
  copies <- the_haplotype@copies
  for (i in seq_along(copies)){
    seq_name <- names(copies)[i]
    count <- copies[[i]]$n_copies
    the_seq <- the_haplotype@sequences[seq_name]
    hap_freq <- sprintf("%05.1f", 100*count/total_sequences)
    padded_count <- str_pad(count, width=5, pad="0")
    padded_i <- str_pad(i, width=3, pad = "0")
    long_label <- paste(the_haplotype@name, padded_i, padded_count, hap_freq, sep = "_")
    names(the_seq) <- long_label
    unique_sequences <- c(unique_sequences, the_seq)
    usd_row <- data.frame(seq_name = seq_name,
                          count = count,
                          total_sequences = total_sequences,
                          long_label = long_label)
    uniq_seq_details <- rbind(uniq_seq_details, usd_row)
  }
  row.names(uniq_seq_details) <- NULL
  return(list(details = uniq_seq_details,
              unique_sequences = unique_sequences))
}
)

