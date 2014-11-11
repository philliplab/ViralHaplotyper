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
