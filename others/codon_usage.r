

GFP6 <- "atgagtaaaggagaagaacttttcactggagttgtcccaattcttgttgaattagatggtgatgttaatgggcacaaattttctgtcagtggagagggtgaaggtgatgcaacatacggaaaacttacccttaaatttatttgcactactggaaaactacctgttccatggccaaccctggtcaccaccctgacctacggcgtgcagtgcttctcccgttaccctgatcatatgaagcggcacgacttcttcaagagcgccatgcctgagggatacgtgcaggagaggaccatcttcttcaaggacgacgggaactacaagacacgtgctgaagtcaagtttgagggagacaccctcgtcaacaggatcgagcttaagggaatcgatttcaaggaggacggaaacatcctcggccacaagttggaatacaactacaactcccacaacgtatacatcatggccgacaagcaaaagaacggcatcaaagccaacttcaagacccgccacaacatcgaagacggcggcgtgcaactcgctgatcattatcaacaaaatactccaattggcgatggccctgtccttttaccagacaaccattacctgtccacacaatctgccctttcgaaagatcccaacgaaaagagagaccacatggtccttcttgagtttgtaacagctgctgggattacacatggcatggatgaactatacaaaggcgcg"
eGFP <- "ATGGTGAGCAAGGGCGAGGAGCTGTTCACCGGGGTGGTGCCCATCCTGGTCGAGCTGGACGGCGACGTGAACGGCCACAAGTTCAGCGTGTCCGGCGAGGGCGAGGGCGATGCCACCTACGGCAAGCTGACCCTGAAGTTCATCTGCACCACCGGCAAGCTGCCCGTGCCCTGGCCCACCCTCGTGACCACCTTCACCTACGGCGTGCAGTGCTTCAGCCGCTACCCCGACCACATGAAGCAGCACGACTTCTTCAAGTCCGCCATGCCCGAAGGCTACGTCCAGGAGCGCACCATCTTCTTCAAGGACGACGGCAACTACAAGACCCGCGCCGAGGTGAAGTTCGAGGGCGACACCCTGGTGAACCGCATCGAGCTGAAGGGCATCGACTTCAAGGAGGACGGCAACATCCTGGGGCACAAGCTGGAGTACAACTACAACAGCCACAACGTCTATATCATGGCCGACAAGCAGAAGAACGGCATCAAGGTGAACTTCAAGATCCGCCACAACATCGAGGACGGCAGCGTGCAGCTCGCCGACCACTACCAGCAGAACACCCCCATCGGCGACGGCCCCGTGCTGCTGCCCGACAACCACTACCTGAGCACCCAGTCCGCCCTGAGCAAAGACCCCAACGAGAAGCGCGATCACATGGTCCTGCTGGAGTTCGTGACCGCCGCCGGGATCACTCACGGCATGGACGAGCTGTACAAGTAA"
codon <- vector()
for (nt in 1:nchar(eGFP)) {
  if (nt %% 3 == 0) codon <- c(codon, substr(eGFP, nt-2, nt))
}

length(codon)

count <- list()
for (c in codon) {
  if(!(c %in% names(count))) {
    count[[c]] <- 1
  } else {
    count[[c]] <- count[[c]] + 1
  }
}

df <- as.data.frame(t(as.data.frame(count)))
df$Freq <- round(df[,1] * 1000/240,2)
df <- df[order(row.names(df)), ]
write.table(df, "codeusage.eGFP.txt", sep = "\t", quote = F)
