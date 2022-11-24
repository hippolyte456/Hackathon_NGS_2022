library(DESeq2)

#Ouverture des données
#CountReads <- read.delim("~/INGE 3A/AMI2B_Hackathon/CountReads.counts", comment.char="#")
CountReads <- read.delim("~/Hackathon_NGS_2022/Workflow/CountReads/CountReads.counts", comment.char="#")
#colData <- read.delim("~/INGE 3A/AMI2B_Hackathon/TryR.txt", comment.char="#")
colData <- read.delim("~/Hackathon_NGS_2022/Workflow/TryR.txt", comment.char="#")
View(CountReads)
View(colData)

# dimension du jeu de données
dim(CountReads)
dim(colData)

#Pre-traitement du jeu de donnees et verifications necessaires
countData <- CountReads[,7:14]
rownames(countData) <- CountReads[,1]
all(colnames(countData) %in% rownames(colData)) #meme colonnes ?
all(colnames(countData) == rownames(colData)) #meme ordre ?

#Construct a DESeqDataSet Object
dds <- DESeqDataSetFromMatrix(countData = countData, 
                       colData = colData,
                       design = ~ Type)

dds

###PAS OBLIGATOIRE###
#pre-filtering: removing rows with low gene counts
#keeping rows that have at least 10 reads total
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

dds
###

#Set a factor level
dds$Type <- relevel(dds$Type, ref = "WT") #Set "WT" as a reference level

#Run DESeq
dds <- DESeq(dds)
res <- results(dds)

#Explore Results
summary(res)

res0.01 <- results(dds, alpha = 0.01) #pour ajuster la p-value
summary(res0.01)

resultsNames(dds)

#Plots
plotMA(res)
