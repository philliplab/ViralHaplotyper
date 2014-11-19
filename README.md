ViralHaplotyper is a tool for investigating the haplotypes present in a
dataset.

Given a dataset, it can construct haplotypes for the dataset using these
techniques:
 * Each unique sequences forms a haplotype
 * All the sequences together forms a single haplotype
 * ... (Use clustering / phylogenetic techniques?)

Furthermore, this package provides tools that one can use to inspect a
haplotype:
 * List all unique sequences
 * Plot a phylogenetic tree of the haplotype
 * Find outliers in the haplotype
 * Find the consensus sequence of the haplotype
 * ...

Lastly, given a list of haplotypes, certain summaries can be reported:
 * Table of haplotypes sorted on different criteria like:
   * Number of unique sequences
   * Total number of sequences
