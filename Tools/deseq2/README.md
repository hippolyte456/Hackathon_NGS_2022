# DESeq2 

## Description

The DESeq2 package is designed for normalization, visualization, and differential analysis of high-dimensional count data.  It makes use of empirical Bayes techniques to estimate priors for log foldchange and dispersion, and to calculate posterior estimates for these quantities.

## Details

The main functions are: <br>
*   DESeqDataSet - build the dataset, see tximeta & tximport packages for preparing input <br>
*   DESeq - perform differential analysis <br>
*   results - build a results table <br>
*   lfcShrink - estimate shrunken LFC (posterior estimates) using apeglm & ashr pakges•vst- apply variance stabilizing transformation, e.g. for PCA or sample clustering <br>
*  Plots, e.g. : plotPCA, plotMA, plotCounts <br>

## Build the image
```bash
sudo singularity build deseq2 Singularity.deseq2
```

## Execute the image
```bash
singularity shell deseq2 
```

##  Check the tool is properly installed
```bash
singularity exec deseq2 R --vanilla  -e 'library( "DESeq2")' &>/dev/null | wc -l | awk ' {if ($0==20) {print "TESTING DESeq2 : \033[1;32m yes \033[0;0m"; exit}{print "TESTING DESeq2 :\033[1;31m no \033[0;0m"}}'
```
