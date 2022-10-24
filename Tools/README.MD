## Proposed organization

* One subdirectory per tool containing a script and a README
* A subdirectory for images (absent by default)
* A subdirectory doc with the documentation on each tools (To do)
* A Singularity.tools script generating an image with all the tools directly (To be deleted)
* A script images.sh generating all the images in image's folder
* A README file

## Useful links

### Tools
* [FASTQ Dump](https://github.com/ncbi/sra-tools/)
* [STAR](https://github.com/alexdobin/STAR)
* [FASTQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
* [Subread](https://subread.sourceforge.net/)
* [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html)
* [Samtools](http://www.htslib.org/)

### Articles
* [Recurrent mutations at codon 625 of the splicing factor SF3B1 in uveal melanoma](https://pubmed.ncbi.nlm.nih.gov/23313955/)
* [SF3B1 mutations are associated with alternative splicing in uveal melanoma](https://pubmed.ncbi.nlm.nih.gov/23861464/)

## Useful commands

### Generate images
```bash
./images.sh
```
Please do not commit images on the git repository.

### Downloading FASTQ files
```bash
for sraid in MM089T SRR628583 SRR628584 SRR628585 SRR628586 SRR628587 SRR628588 SRR628589
do
wget  -O ${SRAID}.sra https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-5/${SRAID}/${SRAID}.1
fastq-dump --gzip --split-files ./${SRAID}.sra
done
```

### Dowloading Chromosomes Sequences

### Creating Genome Index

### Getting genome annotations (GFF)

### Mapping FastQ files

### Counting reads

### Statistical analysis (differential gene expression)