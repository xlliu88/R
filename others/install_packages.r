#It is a demo for install & import R packages

install.packages("reshape2")
install.packages("dplyr")
install.packages("ggplot2", dependencies = TRUE)
install.packages("ggrepel")
install.packages("ggthemes")
install.packages("plyr")
install.packages("MASS")
install.packages("downloader")
install.packages("rafalib")
install.packages("installr")
install.packages("agricolae") # statistical tests
#install.packages("UsingR")
install.packages("devtools")
install.packages("contrast")
install.packages("swirl")
install.packages("pracma") #Practical Numerical Math Routines
#install.packages("networkD3") #javascript ploting; sankeys
#install.packages("curl")
install.packages("stringr")
install.packages("RColorBrewer")
install.packages("pheatmap")
install.packages("VennDiagram")
#install.packages("geneplotter") #multiecdf plotChr
#install.packages("genefilter")
install.packages("fdrtool")
install.packages("LSD")

#install.packages(c("plyr", "LSD", "fdrtool"))

if (!requireNamespace("BiocManager"))
  install.packages("BiocManager")
BiocManager::install()
BiocManager::install("tximport")
BiocManager::available("DESeq2")
BiocManager::install(c("DESeq2", "Rbowtie2", "sigPathway"))
BiocManager::install("ballgown")
BiocManager::install("geneplotter")
BiocManager::install(c("ballgown","geneplotter","BiocStyle", "topGO","genefilter", "biomaRt", "EDASeq", "gplots"))
BiocManager::install("AnnotationDbi")
BiocManager::install("org.Mm.eg.db")
BiocManager::install("org.At.tair.db", version = "3.8")
BiocManager::install("topGO")
BiocManager::install("gage")
BiocManager::install("KEGGREST")
BiocManager::install(c("affy","limma", "simpleaffy", "GEOquery"))

