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
  haps <- construct_haplotypes(seq_aa_dat, 'single', n_header_letters = 5)

  retrieved_seq <- get_all_sequences(haps[[1]])

  expect_that(length(retrieved_seq), equals(length(seq_aa_dat)))
  expect_that(as.character(seq_aa_dat[1]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[10]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[100]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[128]) %in% as.character(retrieved_seq), is_true())

  expect_that(sort(names(seq_aa_dat)), equals(sort(names(retrieved_seq))))
})

test_that('Biostrings::consensusString works as expected', {
  seq_aa_dat <- get_test_AAStringSet()
  haps <- construct_haplotypes(seq_aa_dat, 'unique', n_header_letters = 5)
  
  hap1_uniq <- as.character(unique(get_all_sequences(haps[[1]])))
  names(hap1_uniq) <- NULL
  hap1_consensus <- consensusString(get_all_sequences(haps[[1]]))
  expect_that(length(hap1_uniq), equals(1))
  expect_that(as.character(hap1_uniq), equals(hap1_consensus))
})

test_that('get_unique_sequences method works', {
  seq_aa_dat <- get_test_AAStringSet()
  haps <- construct_haplotypes(seq_aa_dat, 'single', n_header_letters = 5)

  retrieved_seq <- get_unique_sequences(haps[[1]])

  expect_that(length(retrieved_seq), equals(length(unique(seq_aa_dat))))
  expect_that(as.character(seq_aa_dat[1]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[10]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[100]) %in% as.character(retrieved_seq), is_true())
  expect_that(as.character(seq_aa_dat[128]) %in% as.character(retrieved_seq), is_true())
})

test_that('total_number_of_sequences works', {
  seq_aa_dat <- get_test_AAStringSet()
  haps <- construct_haplotypes(seq_aa_dat, 'single', n_header_letters = 5)

  total_seq <- total_number_of_sequences(haps[[1]])
  uniq_seq <- number_of_unique_sequences(haps[[1]])

  expect_that(total_seq, equals(length(seq_aa_dat)))
  expect_that(uniq_seq, equals(length(unique(seq_aa_dat))))
})

test_that('get_unique_sequence_details works', {
  seq_aa_dat <- get_test_AAStringSet()
  haps <- construct_haplotypes(seq_aa_dat, 'single', n_header_letters = 5)
  usd <- get_unique_sequence_details(haps[[1]])

  expect_that(usd, is_a('list'))
  expect_that(sort(names(usd)), equals(sort(c("details", "unique_sequences"))))
  expect_that(usd$details, is_a('data.frame'))
  expect_that(usd$unique_sequences, is_a('BStringSet'))
  expect_that(sort(as.character(usd$details$long_label)), 
              equals(sort(names(usd$unique_sequences))))
})
