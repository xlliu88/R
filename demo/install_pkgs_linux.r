#It is a demo for install & import R packages
packages <- c("BiocManager", "UsingR","devtools","curl", "doParallel", "downloader","installr","stringr","swirl","pracma", 
			  "reshape2", "dplyr", "plyr", "MASS","contrast","fmsb", "fdrtool","rafalib","agricolae", 
			  "RColorBrewer", "ggplot2","ggthemes", "ggrepel","pheatmap", "VennDiagram","eulerr","LSD","networkD3")
			  
for (pkg in packages) {
	install.packages(pkg)
}
	
biopkgs <- c("seqinr", "GenomicRanges", "GenomicFeatures", 
			 "biomaRt", "AnnotationDbi", "org.Mm.eg.db", "org.At.tair.db",   		## annotation
			 "TxDb.Athaliana.BioMart.plantsmart22",
			 "affy", "limma", "simpleaffy", "affyPLM",        						## affy
			 "topGO", "sigPathway", "KEGGREST", "gage", "pathview", 					## pathway enrichment
             "geneplotter", "BiocStyle", "genefilter", "gplots",
			 "EDASeq", "tximport"， "DESeq2", "EDASeq", "ballgown")
					   
for (pkg in biopkgs) {
	BioManager::install(pkg)
}

# BiocManager::install("org.At.tair.db") #, version = "3.8")

# install.packages("reshape2")
# install.packages("dplyr")
# install.packages("ggplot2", dependencies = TRUE)
# install.packages("ggthemes")
# install.packages("plyr")
# install.packages("MASS")
# install.packages("downloader")
# install.packages("rafalib")
# install.packages("installr")
# install.packages("agricolae") # statistical tests
# install.packages("UsingR")
# install.packages("devtools")
# install.packages("contrast")
# install.packages("swirl")
# install.packages("pracma") #Practical Numerical Math Routines
# install.packages("networkD3") #javascript ploting; sankeys
# install.packages("curl")
# install.packages("stringr")
# install.packages("RColorBrewer")
# install.packages("ggrepel")
# install.packages("pheatmap")
# install.packages("VennDiagram")
# install.packages(c("plyr", "LSD", "fdrtool"))

# #import
# #library("dplyr")
# #library(Downloder)
# #download(url, filename) # file will be saved using file name in current folder


# if (!requireNamespace("BiocManager"))
  # install.packages("BiocManager")
# BiocManager::install()
# BiocManager::install("tximport")
# BiocManager::available("DEseq2")
# BiocManager::install(c("DESeq2", "Rbowtie2", "sigPathway"))
# BiocManager::install("ballgown")
# BiocManager::install("geneplotter")
# BiocManager::install(c("ballgown","geneplotter","BiocStyle", "topGO","genefilter", "biomaRt", "EDASeq", "gplots"))
# BiocManager::install("AnnotationDbi")
# BiocManager::install("org.Mm.eg.db")
# BiocManager::install("org.At.tair.db", version = "3.8")
# BiocManager::install("topGO")
# BiocManager::install("gage")
# BiocManager::install("KEGGREST")
# BiocManager::install(c("affy","limma", "simpleaffy", "GEOquery"))
