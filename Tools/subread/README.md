# Subread

## Description

Subread package: high-performance read alignment, quantification and mutation discovery

The Subread package comprises a suite of software programs for processing next-gen sequencing read data.

## Details

* <a href="https://pubmed.ncbi.nlm.nih.gov/23558742/" target="_blank">Subread</a>: a general-purpose read aligner which can align both genomic DNA-seq and RNA-seq reads. It can also be used to discover genomic mutations including short indels and structural variants.
* <a href="https://pubmed.ncbi.nlm.nih.gov/23558742/" target="_blank">Subjunc</a>: a read aligner developed for aligning RNA-seq reads and for the detection of exon-exon junctions. Gene fusion events can be detected as well.
* <a href="https://pubmed.ncbi.nlm.nih.gov/24227677/" target="_blank">featureCounts</a>: a software program developed for counting reads to genomic features such as genes, exons, promoters and genomic bins.
* Sublong: a long-read aligner that is designed based on seed-and-vote.
* exactSNP: a SNP caller that discovers SNPs by testing signals against local background noises.


## Build the image
```bash
sudo singularity build subread Singularity.subread
```

## Execute the image
```bash
singularity shell subread
```

##  Check the tool is properly installed
```bash
singularity exec subread which subread-align | wc -c | awk ' {if ($0==37) {print "TESTING Subread : \033[1;32m yes \033[0;0m"; exit}{print "TESTING Subread :\033[1;31m no \033[0;0m"}}'
```