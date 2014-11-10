#' The data structure that holds a haplotype
#' 
#' These are the first thoughts on the design of the data structure:
#'
#' A haplotype will be defined by specifying a number of input sequences
#' (possibly only one), a distance measure (can be complex and based on a
#' 'custom' substitution matrix), and a threshold. The threshold will the the
#' maximum average distance that a sequence can be from all the sequences
#' initally specified and still be consired part of the haplotype.
#'
#' For this data structure the following methods will be implemented:
#' \itemize{
#'   \item is_member_of()
#'   \item distance_from()
#'   \item diversity()
#'   \item ...
#' }
#'
#' By specifying only a single input sequence and a distance of zero, it will
#' be possible to construct haplotypes that consist of only identical
#' sequences.
