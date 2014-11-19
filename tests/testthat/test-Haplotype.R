context('Haplotype class')

test_that('Haplotype constructor works for a single sequence', {

  haplotype_details <- list(name = 'hap',
    sequences = BStringSet(structure(c("PIVQNIQGQMVH"), 
                                     .Names = c("A1"))),
    copies = list(A1 = list(n_copies = 1,
                            other_sequences = character(0))))

  y <- do.call(.Haplotype, haplotype_details)

  expect_that(y, is_a('Haplotype'))
})

test_that('Haplotype constructor works for a duplicated sequence', {

  haplotype_details <- list(name = 'hap',
    sequences = BStringSet(structure(c("PIVQNIQGQMVH", "IIVQNIQGQMVH"), 
                                     .Names = c("A1", "A3"))),
    copies = list(A1 = list(n_copies = 2,
                            other_sequences = "A2"),
                  A3 = list(n_copies = 1,
                            other_sequences = character(0))))

  y <- do.call(.Haplotype, haplotype_details)

  expect_that(y, is_a('Haplotype'))
})

test_that('get_all_sequences method works', {
  seq_aa_dat <- get_test_AAStringSet()
  haps <- construct_haplotypes_single(seq_aa_dat, n_header_letters = 5)

  retrieved_seq <- get_all_sequences(haps[[1]])

  expect_that(length(retrieved_seq), equals(length(seq_aa_dat)))
  expect_that(as.character(seq_aa_dat[1]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[10]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[100]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[128]) %in% as.character(retrieved_seq), is_true())

  expect_that(sort(names(seq_aa_dat)), equals(sort(names(retrieved_seq))))
})
