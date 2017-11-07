# James Kondilios HWE simulation calculator                          13/3/17

# Working directory
setwd("/Users/studentadmin/desktop/Folders/R scripts")
library("ggplot2")

# Input class genotype simultion data:
# csv must have empty spaces for all cells above the diagonal
Observed_genotype_counts <- read.csv("genotype_sim.csv", header = TRUE)

# ALLELES:
colnames(Observed_genotype_counts) <- c("BLACK", "GREEN", "RED", "WHITE")
rownames(Observed_genotype_counts) <- c("BLACK", "GREEN", "RED", "WHITE")

Observed <- Observed_genotype_counts

# Doubling the diagonal to account for homozygous alleles
for( m in 1:ncol(Observed_genotype_counts)){
  Observed_genotype_counts[m,m] <- Observed_genotype_counts[m,m] * 2
}
rm(m)

# Calculating the allele frequencies:
cols <- as.list(colnames(Observed_genotype_counts))
index <- 1
running_allele_count <- 0
allele_frequencies <- c()
for(i in cols){
  index <- index + 1
  tmp <- c(Observed_genotype_counts[i,]) # rows
  tmp1 <- as.list(Observed_genotype_counts[,i]) # cols
  rows_and_cols <- c((tmp),tmp1) # vector of rows and cols with index c.
  rows_and_cols <- rows_and_cols[!is.na(rows_and_cols)] #removing NA's
  rows_and_cols[index] <- NULL # removing index'th element
  allele_count <- sum(as.numeric(rows_and_cols))
  allele_frequencies <- append(allele_frequencies,allele_count)
  assign(paste0(i,"_allele_Count"), allele_count)
  running_allele_count <- running_allele_count + allele_count
  rm(tmp,tmp1,rows_and_cols,allele_count)
}
rm(i,index)

# Calculate number of samples:
N <- running_allele_count/2

# calculate allele frequencies:
allele_frequencies <- allele_frequencies / running_allele_count

# Expected genotpye frequency table object is created
expected_genotype_frequency_table <- Observed_genotype_counts
for(x in 1:ncol(expected_genotype_frequency_table)){
  for(y in 1:nrow((expected_genotype_frequency_table))){
    #homozygous
    if(x == y & is.na(Observed_genotype_counts[x,y]) == FALSE ){
      expected_genotype_frequency_table[x,y] <- allele_frequencies[x] * allele_frequencies[y] #p^2
    }
    #heterozygous
    if(x != y & is.na(Observed_genotype_counts[x,y]) == FALSE){
      expected_genotype_frequency_table[x,y] <- 2 * allele_frequencies[x] * allele_frequencies[y] # 2pq
    }
  }
}
EGF <- expected_genotype_frequency_table
expected <- expected_genotype_frequency_table * N

# chi-squared values:
x2 <- sum((Observed - expected)^2/expected, na.rm = TRUE)

# degrees of freedom calculation: 
degrees_freedom <- length(cols)*(length(cols) - 1)/2

cat("The chi squared value for this population is:",x2," with",degrees_freedom,"degrees of freedom.")
