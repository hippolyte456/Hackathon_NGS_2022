library( "DESeq2")
# if need to install.packages("reshape2")
# library(reshape2)


# colData and countData must have the same sample order, but this is ensured
# by the way we create the count matrix
cts <- read.table("./CountReads/CountReads.counts", header=TRUE, row.names="Geneid", check.names=FALSE)
cts <- cts[ , order(names(cts))]

coldata <- read.table("./samples.tsv", header=TRUE, row.names="sample_name", check.names=FALSE)
coldata <- coldata[order(row.names(coldata)), , drop=F]

dds <- DESeqDataSetFromMatrix(countData=cts[4:14],
                              colData=coldata,
                              design=as.formula(~condition))


# remove uninformative columns
dds <- dds[ rowSums(counts(dds)) > 1, ]
# normalization and preprocessing
dds <- DESeq(dds)
# possibility to include parallisation to speed up fitting model

# Write dds object as RDS
#saveRDS(dds, file="test.rds")
# Write normalized counts
norm_counts = counts(dds, normalized=T)
#write.table(data.frame("gene"=rownames(norm_counts), norm_counts), file="normcounts.tsv", sep='\t', row.names=F)

# report("pca.svg", "pca.rst")

counts <- rlog(dds, blind=FALSE)
plotPCA(counts, intgroup="condition")
dev.off()


## new test
library( "DESeq2")
counts <- read.table("./CountReads/CountReads.counts", header=TRUE, row.names="Geneid", check.names=FALSE)
colnames(counts)=c("cond","sraid","exon","count")