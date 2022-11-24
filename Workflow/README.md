# Workflow

## Organization

* A subdirectory for each output of each rule (absent by default)
* A subdirectory "images" containing all the images of the tools (absent by default, you will have to copy it from "[Tools](../Tools/)")
* A subdirectory "[rules](./rules/)" with all the rules used in the workflow (one file per rule).
* A file "[configuration.yml](./configuration.yml)" containing all the necessary configurations for Reprochackthon.wf.
* A Snakefile "[ReproHackathon.wf](./ReproHackathon.wf)" with the workflow.
* A [README](./README.md) file

## Setup

## Singularity 

You can check the read-me from [Tools](../Tools/) about [Singularity](../Tools/README.md/#install-singularity) installation.

## Snakemake

### Using Anaconda (didn't work for me)
```bash
conda activate base
mamba create -c conda-forge -c bioconda -n snakemake snakemake
conda activate snakemake
```
### Using Python (Worked for me)
```bash
pip install snakemake
```

### Using Bash (worked for me ...)
```bash
sudo apt install snakemake
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
cp -r Tools/images Worflow/images
```

# Execution
Once the 'environment setup' is done :
From the Workflow directory :
```bash
snakemake --use-singularity -s $PWD/ReproHackathon.wf --configfile $PWD/configuration.yml -j 1 -k --printshellcmds
```
# Work Status

## Rules (Need to add a description but not now as it will still change maybe)
 * GetFastq.rules : Recover DNA Seq from article (only SRR628586 for the moment as it is the lightest one)
 * GetGenome.rules : Recover human Chromosome.fa.gz (only the last 4 because they are the lightest)
 * CreateIndex.rules : Index chr.fa.gz files (do not work for the moment with heavy chr such as 1 and 2)
 * GetAnnot : Recover genome annotations for Homo sapiens
 * MappingSTAR : Map the DNA seq with index result (doesn't seem to work yet, i mean the workflow is good but the result of the counting show 0 aligment ...)

## Next work
 * Scaling-up GetFastq.rules to accept multiple Seq list (as GetGenome) (Done)
 * Fix issue with CreateIndex and too heavy files  (Done)
 * Fix issue with Mapping Result (Done)
 * Remove plointless code (cleaning code)
 * Improve README files (Work in progress)
 * Once everything is good we will be able to move on DESeq2 script
 * Try with lower VM capacity
 * See what's up with R when generating the images (seems like downloading way too much packages) ...
 * Implement FastQC (beginning of the workflow = multithreading ?)