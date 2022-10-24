# Environment setup

## Singularity 
* [Singularity](https://singularity-tutorial.github.io/01-installation/)

## Snakemake

### Using Anaconda (didn' work for me)
```bash
conda activate base
mamba create -c conda-forge -c bioconda -n snakemake snakemake
conda activate snakemake
```
### Using Python (Worked for me)
```bash
pip install snakemake
```

### Check Installation
```bash
singularity --version
snakemake -v  
```
## Prepare Images
from the source of the git directory run
```bash
cd Tools
./images.sh
cp Tools/images/star snakemake/images/star
```

# Execution
Once the 'environment setup' is done :
```bash
snakemake --use-singularity -s $PWD/ReproHackathon.wf --configfile $PWD/configuration.yml -j 1 -k --printshellcmds
```

## Install snakemake (just once per newly activated VM)
mamba create -c conda-forge -c bioconda -n snakemake snakemake

## Activate the conda snakemake environment
conda activate snakemake

## Check help
snakemake --help

## RUN depuis le répertoire snakemake
snakemake --use-singularity -s $PWD/ReproHackathon.wf --configfile $PWD/configuration.yml -j 1 -k --printshellcmds 

# Work Status

## Rules (Need to add a description but not now as it will still change maybe)
 * GetFastq.rules : Recover DNA Seq from article (only SRR628586 for the moment as it is the lightest one)
 * GetGenome.rules : Recover human Chromosome.fa.gz (only the last 4 because they are the lightest)
 * CreateIndex.rules : Index chr.fa.gz files (do not work for the moment with heavy chr such as 1 and 2)
 * GetAnnot : Recover genome annotations for Homo sapiens
 * MappingSTAR : Map the DNA seq with index result (doesn't seem to work yet, i mean the workflow is good but the result of the counting show 0 aligment ...)

## Next work
 * Scaling-up GetFastq.rules to accept multiple Seq list (as GetGenome)
 * Fix issue with CreateIndex and too heavy files
 * Fix issue with Mapping Result
 * Remove plointless code (cleaning code)
 * Improve README files
 * Once everything is good we will be able to move on DESeq2 script