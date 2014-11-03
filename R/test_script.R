#' A test script
#' @param msg A messge
#' @export

helloViralHaplotyper <- function(msg){
  print(msg)
}

#' Reads in the sequence data
#'
#' This function currently just calls readAAStringSet in the Biostrings
#' package. See that function for more details.
#'
#' Must be a valid FASTA file with protein sequence data.
#'
#' @param file_name Name of the fasta file
#' @export

read_seq_data <- function(file_name){
  x <- readAAStringSet(file_name)
  return(x)
}


