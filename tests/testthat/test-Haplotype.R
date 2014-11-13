context('Haplotype class')

test_that('Haplotype constructor works for a single sequence', {

  haplotype_details <- list(
    sequences = BStringSet(structure(c("PIVQNIQGQMVH"), 
                                     .Names = c("A1"))),
    distance = dist,
    threshold = 1,
    copies = list(A1 = list(n_copies = 1,
                            other_sequences = character(0))))

  y <- do.call(.Haplotype, haplotype_details)

  expect_that(y, is_a('Haplotype'))
})

test_that('Haplotype constructor works for a duplicated sequence', {

  haplotype_details <- list(
    sequences = BStringSet(structure(c("PIVQNIQGQMVH", "IIVQNIQGQMVH"), 
                                     .Names = c("A1", "A3"))),
    distance = dist,
    threshold = 1,
    copies = list(A1 = list(n_copies = 2,
                            other_sequences = "A2"),
                  A3 = list(n_copies = 1,
                            other_sequences = character(0))))

  y <- do.call(.Haplotype, haplotype_details)

  expect_that(y, is_a('Haplotype'))
})
