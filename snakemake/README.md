## Activate the conda base environment
conda activate base

## Install snakemake (just once per newly activated VM)
mamba create -c conda-forge -c bioconda -n snakemake snakemake

## Activate the conda snakemake environment
conda activate snakemake

## Check help
snakemake --help

## RUN depuis le répertoire snakemake
snakemake --use-singularity -s $PWD/ReproHackathon.wf --configfile $PWD/configuration.yml -j 1 -k --printshellcmds 

## Other way to download snakemake 
pip install snakemake