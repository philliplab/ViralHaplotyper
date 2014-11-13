ViralHaplotyper is a tool for investigating the haplotypes present in a
dataset.

Distance based measures is used to group the sequences into haplotypes.

Information about the diversity of the sequences in the dataset, the diversity
within each haplotype and between the haplotypes can also be explored.

The package is build around the 'haplotype' class and implements various
methods for it.

Haplotypes are constructed by:
 - Computing a distance matrix on a multiple sequence alignment
 - Running a clustring algorithm on the distnace matrix
 - Assigning haplotypes using some threshold applied to the clustering output

### Design notes

#### Testing

Due to the how complicated the haplotype objects are to construct, I'm going to
need to do some testing and I'm going to need quite a few helper functions for
the testing.

Should the testing be done with unit tests or in a knitr report that reports
all the interesting things? Well, both probably. Most of the testing will not
be interesting, so it will be better to just put the intersting tests into a
separate document.

What should be tested?
 - Constructor of the haplotype object
 - The format of the output of the distance computations
 - The formats of the output of the accessor functions
