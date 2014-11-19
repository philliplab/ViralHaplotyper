context('Construct Haplotypes')

test_that('unqiue haplotype construction approach is working', {
  x <- get_test_AAStringSet()
  y <- construct_haplotypes(x)
  expect_that(y, is_a('list'))
  expect_that(y[[1]], is_a('Haplotype'))
})
