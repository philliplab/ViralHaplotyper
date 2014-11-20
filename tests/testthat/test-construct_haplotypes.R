context('Construct Haplotypes')

test_that('unqiue haplotype construction approach is working', {
  seq_aa_dat <- get_test_AAStringSet()
  haps <- construct_haplotypes_unique(seq_aa_dat, n_header_letters = 5)
  expect_that(haps, is_a('list'))
  expect_that(haps[[1]], is_a('Haplotype'))
  expect_that(length(haps), equals(length(unique(seq_aa_dat))))
  expect_that(haps[[1]]@name, equals("evolv_01"))
  expect_that(haps[[11]]@name, equals("evolv_11"))
})

test_that('single haplotype construction approach is working', {
  seq_aa_dat <- get_test_AAStringSet()
  haps <- construct_haplotypes_single(seq_aa_dat, n_header_letters = 5)
  expect_that(haps, is_a('list'))
  expect_that(haps[[1]], is_a('Haplotype'))
  expect_that(length(haps), equals(1))
  expect_that(haps[[1]]@name, equals("evolv_1"))
})
