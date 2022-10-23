## Activate the conda base environment
conda activate base

## Install snakemake (just once per newly activated VM)
mamba create -c conda-forge -c bioconda -n snakemake snakemake

## Activate the conda snakemake environment
conda activate snakemake

## Check help
snakemake --help

## RUN depuis le répertoire snakemake
snakemake -s $PWD/ReproHackathon.wf --configfile $PWD/configuration.yml -j 1 -k --printshellcmds 

--use-singularity


## Other way to download
pip install snakemake


## download
prefetch SRR636531
fasterq-dump   SRR636531