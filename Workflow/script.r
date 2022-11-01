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



#### Installation des librairies nécessaires
```{r, message = FALSE, warning=FALSE }
install.packages("ggplot2")
install.packages("tidyverse") 
install.packages("FactoMineR")
install.packages("factoextra")
install.packages("readxl")
install.packages("dplyr")
install.packages("DESeq2")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("EnhancedVolcano")
```

#### Chargement de la librairie
```{r, message = FALSE, warning=FALSE}
library("ggplot2")
library("tidyverse") # pour renommer les colonnes 
library("FactoMineR") # ACP
library("factoextra") # extraire et visualiser les résultats issus de FactoMineR
library("readxl")
library("dplyr")
library("EnhancedVolcano")
library("DESeq2") 
```

#### Téléchargement des données
```{r téléchargement des données, warning=FALSE }
cts <- read.table("./CountReads/CountReads.counts", header=TRUE, row.names="Geneid", check.names=FALSE)
cts <- read.table("./CountReads/CountReads.counts", header=TRUE)
cts <- cts[ , order(names(cts))]
SRR628582 <- cts[4]
SRR628583 <- cts[5]
SRR628584 <- cts[6]
SRR628585 <- cts[7]
SRR628586 <- cts[8]
SRR628587 <- cts[9]
SRR628588 <- cts[10]
SRR628589 <- cts[11]
SRR636531 <- cts[12]
SRR636532 <- cts[13]
SRR636533 <- cts[14]
```

#### Création du jeu de données avec uniquement les counts à la fin puis renommer les colonnes 
```{r, warning=FALSE}
data <- data.frame(cts$Geneid,
    cts$MappingSTAR.SRR628582.bam,
    cts$MappingSTAR.SRR628583.bam,
    cts$MappingSTAR.SRR628584.bam,
    cts$MappingSTAR.SRR628585.bam,
    cts$MappingSTAR.SRR628586.bam,
    cts$MappingSTAR.SRR628587.bam,
    cts$MappingSTAR.SRR628588.bam,
    cts$MappingSTAR.SRR628589.bam,
    cts$MappingSTAR.SRR636531.bam,
    cts$MappingSTAR.SRR636532.bam,
    cts$MappingSTAR.SRR636533.bam)
colnames(data)[1] <- "Geneid"
colnames(data)[2] <- "SRR628582"
colnames(data)[3] <- "SRR628583"
colnames(data)[4] <- "SRR628584"
colnames(data)[5] <- "SRR628585"
colnames(data)[6] <- "SRR628586"
colnames(data)[7] <- "SRR628587"
colnames(data)[8] <- "SRR628588"
colnames(data)[9] <- "SRR628589"
colnames(data)[10] <- "SRR636531"
colnames(data)[11] <- "SRR636532"
colnames(data)[12] <- "SRR636533"
```

#### Métadonnées: récuperation au format data.frame des labels :
```{r, warning=FALSE}
samples = c("SRR628582", "SRR628583", "SRR628584", "SRR628585", "SRR628586", "SRR628587", "SRR628588", "SRR628589", "SRR636531", "SRR636532", "SRR636533")
Type_M_WT = c("M", "M", "WT", "WT", "WT", "WT", "WT", "M", "WT", "WT", "WT")
MetaData = data.frame(samples, Type_M_WT)
```

#### Enhanced Volcano 
```{r, message = FALSE, warning= FALSE}
dds <- DESeqDataSetFromMatrix(countData=data, colData=MetaData, design=~Type_M_WT, tidy = TRUE)
dds <- DESeq(dds, betaPrior = FALSE) 
res <- results(dds)
dds$Type_M_WT <- relevel(dds$Type_M_WT, ref ="WT")
levels(dds$Type_M_WT)
EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                xlim=c(-10,10),
                y = 'pvalue',
                selectLab = c('ENSG00000164659','ENSG00000234261','ENSG00000153283','ENSG00000214212','ENSG00000142621','ENSG00000186973','ENSG00000286122','ENSG00000103449','ENSG00000007038'),
                title = "EnhancedVolcano plot padj = 0,002 et LFC = 2",
                xlab = bquote(~Log[2]~ 'fold change'),
                pCutoff = .002,
                FCcutoff = 2.0,
                pointSize = 1.0,
                labSize = 3,
                labCol = 'black',
                labFace = 'bold',
                boxedLabels = TRUE,
                colAlpha = 5/5,
                legendPosition = 'top',
                legendLabSize = 14,
                legendIconSize = 4.0,
                drawConnectors = TRUE,
                widthConnectors = 0.1,
                colConnectors = 'black')
```


#ACP 
## Préparation des données 
```{r, warning= FALSE}
n <- data[1:60612,1] # on sauvegarde à part le nom des geneid
t_data <- as.data.frame(t(data[1:60612,2:9])) # on fait la transposé des colonnes avec des int (pas avec colonne des geneid sinon pb on a des chr sur toute la transposé)
colnames(t_data) <- n # on renome les colonnes avec le geneid 
t_data$Samples <- factor(row.names(t_data)) # on rajoute la colonne avec les samples SRR...
t_data$Type_M_WT <- c("M", "M", "WT", "WT", "WT", "WT", "WT", "M") # on rajoute une colonne avec le type pour pouvoir colorier
t_data <- t_data[, colSums(t_data != 0) > 0] # on enlève les colonnes nulles sinon df2 ne se lancera pas 
resPCA <- PCA(t_data[1:28906], scale.unit = TRUE, ncp =8,graph = FALSE)
fviz_pca_ind (resPCA, col.ind = "cos2",
              gradient.cols = c("#00AFBB", "#FC4E07"),
              repel = TRUE # Évite le chevauchement de texte
)
```

#############
#   TEST2   #
#############
cts <- read.table("./CountReads/CountReads.counts", header=TRUE, row.names="Geneid")
cts2 <- cts[6:16]
cts2 <- cts2[ , order(names(cts2))]

data <- data.frame(cts2$MappingSTAR.SRR628582.bam,
    cts2$MappingSTAR.SRR628583.bam,
    cts2$MappingSTAR.SRR628584.bam,
    cts2$MappingSTAR.SRR628585.bam,
    cts2$MappingSTAR.SRR628586.bam,
    cts2$MappingSTAR.SRR628587.bam,
    cts2$MappingSTAR.SRR628588.bam,
    cts2$MappingSTAR.SRR628589.bam,
    cts2$MappingSTAR.SRR636531.bam,
    cts2$MappingSTAR.SRR636532.bam,
    cts2$MappingSTAR.SRR636533.bam)

colnames(data)[1] <- "SRR628582"
colnames(data)[2] <- "SRR628583"
colnames(data)[3] <- "SRR628584"
colnames(data)[4] <- "SRR628585"
colnames(data)[5] <- "SRR628586"
colnames(data)[6] <- "SRR628587"
colnames(data)[7] <- "SRR628588"
colnames(data)[8] <- "SRR628589"
colnames(data)[9] <- "SRR636531"
colnames(data)[10] <- "SRR636532"
colnames(data)[11] <- "SRR636533"

coldata <- read.table("./samples.tsv", header=TRUE, row.names="sample_name", check.names=FALSE)
coldata <- coldata[order(row.names(coldata)), , drop=F]

dds = DESeqDataSetFromMatrix(countData = cts2, colData = coldata, design = ~ condition)  # Object construction
dds = DESeq(dds)     # performs differential expression analysis
res = results(dds)   # differential expression analysis
res_mat = as.matrix(res)

write.table(res_mat, "DESeq_results.txt", sep="\t")  # output file (table format txt) resulting of the differential expression analysis

pdf("plot_counts.pdf")
plotCounts(dds, gene=which.min(res$padj), intgroup="condition")  # output file (pdf) showing the most variable gene bewteen the 2 groups (wild and mutated)
dev.off()


DEgenes = which(res$padj<0.05)      # row numbers whose genes are significantly differentially expressed
significative_DEgenes = res[DEgenes,]   # matrix containing names, log2FC and adjusted p-value of significantly differentially expressed genes
significative_DEgenes = significative_DEgenes[, c(2,6)]
write.table(significative_DEgenes, "Significative_DEgenes.txt", sep="\t")   # output file (matrix format txt) of previous matrix 


summary.df = as.data.frame(matrix("", ncol= 3, nrow = 3))  # DataFrame whose summarise previous matrix
rownames(summary.df) = c("significantly differentially expressed ", "overexpressed genes in mutants", "overexpressed genes in wild types")
colnames(summary.df) = c("Amount", "Ratio (significantly differentially expressed)", "Ratio (all expressed genes)")

summary.df[1,1] = dim(significative_DEgenes)[1]
summary.df[2,1] = length(which(significative_DEgenes$log2FoldChange < -1))
summary.df[3,1] = length(which(significative_DEgenes$log2FoldChange > 1))

summary.df[1,2] = round(as.numeric(summary.df[1,1]) / as.numeric(summary.df[1,1]), digits = 2)
summary.df[2,2] = round(as.numeric(summary.df[2,1]) / as.numeric(summary.df[1,1]), digits = 2)
summary.df[3,2] = round(as.numeric(summary.df[3,1]) / as.numeric(summary.df[1,1]), digits = 2)

summary.df[1,3] = round(as.numeric(summary.df[1,1]) / dim(counts)[1], digits = 2)
summary.df[2,3] = round(as.numeric(summary.df[2,1]) / dim(counts)[1], digits = 2)
summary.df[3,3] = round(as.numeric(summary.df[3,1]) / dim(counts)[1], digits = 2)