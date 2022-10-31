
# Fastqc

## Description

FastQC  reads  a set of sequence files and produces from each one a quality control report consisting of a number of different modules, each one of which will help  to identify a different potential type of problem in your data.

If  no  files  to  process  are specified on the command line then the program will start as an interactive graphical  application.   If  files  are  provided  on  the command  line then the program will run with no user interaction required.  In this mode it is suitable for inclusion into a standardised analysis pipeline.

## Details

```-h --help```

Print this help file and exit

```-v --version```

Print the version of the program and exit

```-o --outdir```

Create all output files in the specified output directory.  Please note  that  this
directory  must exist as the program will not create it.  If this option is not set
then the output file for each sequence file is created in the same directory as the
sequence file which was processed.

```--casava```

Files  come  from raw casava output. Files in the same sample group (differing only
by the group number) will be analysed as a set rather than individually.  Sequences
with  the  filter flag set in the header will be excluded from the analysis.  Files
must have the same names given to them  by  casava  (including  being  gzipped  and
ending with .gz) otherwise they won't be grouped together correctly.

```--extract```

If set then the zipped output file will be uncompressed in the same directory after
it has been created.  By default this option will  be  set  if  fastqc  is  run  in
non-interactive mode.

```-j --java```

Provides  the full path to the java binary you want to use to launch fastqc. If not
supplied then java is assumed to be in your path.

```--noextract```

Do not uncompress the output file after creating it.  You should set this option if
you do not wish to uncompress the output when running in non-interactive mode.

```--nogroup```

Disable  grouping  of  bases  for reads >50bp. All reports will show data for every
base in the read.  WARNING: Using this option will cause fastqc to crash  and  burn
if  you  use  it on really long reads, and your plots may end up a ridiculous size.
You have been warned!

```-f --format```

Bypasses the normal sequence file format detection and forces the  program  to  use
the specified format.  Valid formats are bam,sam,bam_mapped,sam_mapped and fastq

```-t --threads```

Specifies  the  number of files which can be processed simultaneously.  Each thread
will be allocated 250MB of memory so you  shouldn't  run  more  threads  than  your
available memory will cope with, and not more than 6 threads on a 32 bit machine

```-c```

Specifies a non-default file which contains the list of

```--contaminants```

contaminants  to  screen  overrepresented sequences against.  The file must contain
sets of named contaminants in the form name[tab]sequence.  Lines  prefixed  with  a
hash will be ignored.

```-k --kmers```

Specifies the length of Kmer to look for in the Kmer content module. Specified Kmer
length must be between 2 and 10. Default length is 5 if not specified.

```-q --quiet```

Suppress all progress messages on stdout and only report errors.


## Build the image
```bash
sudo singularity build fastqc Singularity.fastqc
```

## Execute the image
```bash
singularity shell fastqc
```

##  Check the tool is properly installed
```bash
singularity exec fastqc fastqc --help | wc -l | awk ' {if ($0==122) {print "TESTING FASTQC : \033[1;32m yes \033[0;0m"; exit}{print "TESTING FASTQC :\033[1;31m no \033[0;0m"}}'
```