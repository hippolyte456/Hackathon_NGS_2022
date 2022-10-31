
# Fastq-Dump

## Description

Fastq-dump is a tool for downloading sequencing reads from <a href="https://www.ncbi.nlm.nih.gov/sra" target="_blank">NCBI</a>’s Sequence Read Archive (SRA). These sequence reads will be downloaded as FASTQ files. How these FASTQ files are formatted depends on the fastq-dump options used.

## Details

1. ```--gzip ```: Compress output using gzip. Gzip archived reads can be read directly by bowtie2.
2. ```--skip-technical```: Dump only biological reads, skip the technical reads.
3. ```--readids``` or ```-I```: Append read ID after spot ID as ‘accession.spot.readid’. With this flag, one sequence gets appended the ID .1 and the other .2. Without this option, pair-ended reads will have identical IDs.
3. ```--read-filter pass```: Only returns reads that pass filtering (without Ns).
4. ```--dumpbase``` or ```-B```: Formats sequence using base space (default for other than SOLiD). Included to avoid colourspace (in which pairs of bases are represented by numbers).
5. ```--split-3``` separates the reads into left and right ends. If there is a left end without a matching right end, or a right end without a matching left end, they will be put in a single file.
6. ```--clip``` or ```-W```: Some of the sequences in the SRA contain tags that need to be removed. This will remove those sequences.
7. ```--outdir``` or ```-O```: (Optional) Output directory, default is current working directory.
8. ```SRR_ID```: This is is the ID of the run from SRA to be downloaded. This ID begins with “SRR” and is followed by around seven digits (e.g. SRA1234567).

Other options that can be used instead of --split-3:

 1. ```--split-files``` splits the FASTQ reads into two files: one file for mate 1s (...1), and another for mate 2s (..._2). This option will not mateless pairs into a third file.
 2. ```--split-spot``` splits the FASTQ reads into two (mate 1s and mate 2s) within one file. -```-split-spot``` gives you an 8-line fastq format where forward precedes reverse (<a href="https://www.biostars.org/p/178586/#258378" target="_blank">see</a>).


## Build the image
```bash
sudo singularity build fastq-dump Singularity.fastq-dump
```

## Execute the image
```bash
singularity shell fastq-dump
```

##  Check the tool is properly installed
```bash
singularity exec fastq-dump fastq-dump --help | wc -l | awk ' {if ($0>100) {print "TESTING FAST DUMP : \033[1;32m yes \033[0;0m"; exit}{print "TESTING FAST DUMP :\033[1;31m no \033[0;0m"}}'
```