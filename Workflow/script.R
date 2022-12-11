library(DESeq2)
library(ggplot2)

#Import data 
CountReads <- read.delim("./CountReads/CountReads.counts", comment.char="#") 
colData <- data.frame(Type = c("WT", "WT", "WT", "WT", "WT", "Mutant SF3B1", "Mutant SF3B1", "Mutant SF3B1")) 
rownames(colData) <- c("MappingSTAR.SRR628589.bam", 
                  "MappingSTAR.SRR628588.bam", 
                  "MappingSTAR.SRR628587.bam",
                  "MappingSTAR.SRR628586.bam",
                  "MappingSTAR.SRR628585.bam",
                  "MappingSTAR.SRR628584.bam",
                  "MappingSTAR.SRR628583.bam",
                  "MappingSTAR.SRR628582.bam")

# Pre-processing of the dataset and necessary verifications
countData <- CountReads[,7:14]
rownames(countData) <- CountReads[,1]

# Create DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = countData, 
                              colData = colData,
                              design = ~ Type)

# Deseq Pre-filtering
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

# Set a factor level
dds$Type <- relevel(dds$Type, ref = "WT") #Set "WT" as a reference level

# Deseq2
dds <- DESeq(dds)

resultsNames(dds)
trans <- DESeqTransform(dds)

png("Deseq/pca.png")
plotPCA(object = trans, intgroup = "Type")
dev.off()

#P.value
ALPHA = 0.01
res <- results(dds, alpha = ALPHA)

# List of genes mentioned in the article
Article = data.frame("ENSG00000148848" = "ADAM12",
                     "ENSG00000088256" = "GNA11",
                     "ENSG00000101019" = "UQCC1",
                     "ENSG00000114770" = "ABCC5",
                     "ENSG00000115524" = "SF3B1",
                     "ENSG00000156052" = "GNAQ",
                     "ENSG00000163930" = "BAP1",
                     "ENSG00000245694" = "CRNDE",
                     "ENSG00000228315" = "GUSBP11",
                     "ENSG00000131503" = "ANKHD1",
                     "ENSG00000185010" = "F8",
                     "ENSG00000141013" = "GAS8",
                     "ENSG00000089057" = "SLC23A2",
                     "ENSG00000114861" = "FOXP1")

keep <- which(rownames(res) %in% colnames(Article))
res_Article <- res[keep,]
write.table(res_Article, file="Deseq/res_Article.txt", row.names=TRUE)
a_genes <- rownames(res_Article)

#Order the names of the genes
OrdArticle <- data.frame(a_genes, a_genes)
colnames(OrdArticle) <- c("a_gene_code", "a_gene_name")
for (i in 1:length(a_genes)){
  gene <- a_genes[i]
  OrdArticle$a_gene_name[i] <- Article[gene][1,1]
}

# List of differentially expressed genes (padj lower than ALPHA) 
diff_genes <- subset(res, padj < ALPHA)
write.table(diff_genes, file="Deseq/diff_genes.txt", row.names=TRUE)

d_genes <- rownames(diff_genes)
any(a_genes %in% d_genes) # Genes article and diff

# Plotcounts for the genes mentioned in the article
par(mfrow=c(2,3))
for (i in 1:length(a_genes)) {
  g <- a_genes[i]
  png(paste("Deseq/Plotcounts_", OrdArticle$a_gene_name[i], ".png", sep=""))
  plotCounts(dds, gene=g, intgroup="Type", main = OrdArticle$a_gene_name[i])
  dev.off()
}

# Heatmap for the genes mentioned in the article
png("Deseq/heatmap_res_Article.png")
heatmap(as.matrix(res_Article[, -1]), labRow=OrdArticle$a_gene_name)
dev.off()

# VolcanoPlot for the genes mentioned in the article
alpha <- ALPHA # Threshold on the adjusted p-value
cols <- densCols(res_Article$log2FoldChange, -log10(res_Article$pvalue))

png("Deseq/VolcanoPlot_res_Article.png")
plot(res_Article$log2FoldChange, -log10(res_Article$padj), col=cols, panel.first=grid(), main="Volcano plot", xlab="Effect size: log2(fold-change)", ylab="-log10(adjusted p-value)", ylim = c(0,-log10(alpha) + 0.1))
abline(v=0)
abline(v=c(-1,1), col="brown")
abline(h=-log10(alpha), col="brown")
text(res_Article$log2FoldChange,
     -log10(res_Article$padj),
     lab=OrdArticle$a_gene_name, cex=1)
dev.off()

# 4a. Plotcounts for differentially expressed genes
d_genes <- rownames(diff_genes)
for (g in d_genes) {
  png(paste("Deseq/Plotcounts_", g, ".png", sep=""))
  plotCounts(dds, gene=g, intgroup="Type")
  dev.off()
}

# 4b. PlotMA for differentially expressed genes
png("Deseq/plotMA_res.png")
plotMA(res) 
with(res_Article, {
  points(baseMean, log2FoldChange, cex = 1, lwd = 2)
  text(baseMean, log2FoldChange, OrdArticle$a_gene_name, cex = 0.8, pos = 1)
})
dev.off()

# 4c. Heatmap for differentially expressed genes
png("Deseq/heatmap_res.png")
heatmap(as.matrix(diff_genes[, -1]))
dev.off()

# 4d. VolcanoPlot for differential gene expression
cols <- densCols(res$log2FoldChange, -log10(res$pvalue))
png("Deseq/VolcanoPlot_res.png")
plot(res$log2FoldChange, -log10(res$padj), col=cols, panel.first=grid(),
     main="Volcano plot", xlab="Effect size: log2(fold-change)", ylab="-log10(adjusted p-value)",
     pch=20, cex=0.6, xlim = c(-11, 11))
abline(v=0)
abline(v=c(-1,1), col="brown")
abline(h=-log10(alpha), col="brown")
gn.selected <- abs(res$log2FoldChange) > 2.5 & res$padj < alpha 
text(res$log2FoldChange[gn.selected],
     -log10(res$padj)[gn.selected],
     lab=rownames(res)[gn.selected ], cex=1)
dev.off()