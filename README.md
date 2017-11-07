# Chi sq test for Hardy-Weinberg equillibrium

This script can be used to test for HW equillibruim in any number of alleles for any given locus.
Data corresponding to genotypes must be input in the following way: <br />
 , , ,  <br />
12, , , <br />
8, 3, , <br />
20, 13, 12, <br />
5, 0, 4, 1 <br />
<br />
With each column and row representing an one of any amount of alleles (in this case 4). <br />
<br />
#allele1, #allele2, #allele3, #allele4 <br />
, , ,                        # empty row <br />
12, , ,                       # allele1 <br />
8, 3, ,                       # allele2 <br />
20, 13, 12,                   # allele3 <br />
5, 0, 4, 1                    # allele4 <br />
<br />
i,j in this matrix represents the genotype count of genotypes possessing allele i and allele j. 
