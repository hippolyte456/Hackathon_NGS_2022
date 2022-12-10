import os
import sys

#######################
#   Define Workflow   #
#######################

#--------------------#
#   GetFastq files   #
#--------------------#

# ~~ input
__params_GF_NCBI_id = "{ncbi_id}"

# ~~ parameters depending on inputs
__container_GF = "./" + config["GetFastq"]["container"]
__repertory_GF = config["GetFastq"]["Repertory"]

# ~~ output
__output_GF_1 = config["GetFastq"]["Repertory"] + "{ncbi_id}/{ncbi_id}" + "_1.fastq"
__output_GF_2 = config["GetFastq"]["Repertory"] + "{ncbi_id}/{ncbi_id}" + "_2.fastq"


#---------------#
#   GetGenome   #
#---------------#

# Conversion des fichiers SRA en fichier FATSQ compressé

# ~~ parameters depending on inputs
__params_GG_Chromosom = "{chromosom}"

__container_GG = "./" + config["GetGenome"]["container"]
__repertory_GG = config["GetGenome"]["Repertory"]

# ~~ output
__output_GG_Genome = config["GetGenome"]["Repertory"] +  "{chromosom}" + config["GetGenome"]["Extension"]

#--------------#
#   GetAnnot   #
#--------------#

# ~~ parameters depending on inputs
__genome_ref_GA = config["GetAnnot"]["genome_ref"]
__file_name_GA = config["GetAnnot"]["Filename"]
__container_GA = "./" + config["GetAnnot"]["container"]
__repertory_GA = config["GetAnnot"]["Repertory"]

# ~~ output
__output_GA_Genome = config["GetAnnot"]["Repertory"] + config["GetAnnot"]["Filename"] + ".gtf"

#-----------------#
#   IndexGenome   #
#-----------------#

# Indexation du génome humain à partir du fichier avec les séquences des chromosomes concaténées

# ~~ input
__input_IG_Genome = expand("{repertory}{filename}{extension}",
                            repertory = config["GetGenome"]["Repertory"],
                            filename = config["Chromosom"],
                            extension = config["GetGenome"]["Extension"])


# ~~ parameters depending on inputs
__container_IG = "./" + config["IndexGenome"]["container"]
__repertory_IG = config["IndexGenome"]["Repertory"]
__input_IG_annot = __output_GA_Genome

# ~~ output
__output_CI_ChrL = config["IndexGenome"]["Repertory"] + "chrLength.txt"
__output_CI_ChrNL = config["IndexGenome"]["Repertory"] + "chrNameLength.txt"
__output_CI_ChrN = config["IndexGenome"]["Repertory"] + "chrName.txt"
__output_CI_ChrS = config["IndexGenome"]["Repertory"] + "chrStart.txt"
__output_CI_Genome = config["IndexGenome"]["Repertory"] + "Genome"
__output_CI_GenomeP = config["IndexGenome"]["Repertory"] + "genomeParameters.txt"
__output_CI_SA = config["IndexGenome"]["Repertory"] + "SA"
__output_CI_SAi= config["IndexGenome"]["Repertory"] + "SAindex"

#-----------------#
#   MappingSTAR   #
#-----------------#

# Mapping des fichiers FASTQ compressés avec le génome index (alignement des séquences avec le génôme humain) 


# ~~ input
__input_MS_1 = __output_GF_1
__input_MS_2 = __output_GF_2
__input_MS_index = __output_CI_SAi 
__container_MS = "./" + config["MappingSTAR"]["container"]
__repertory_MS = config["MappingSTAR"]["Repertory"]
__ncbi_id = lambda wildcard : config["NCBI_id"]

# ~~ parameters depending on inputs
__params_MS_NCBI_id = "{ncbi_id}"

# ~~ output
__output_MSTAR_bam = config["MappingSTAR"]["Repertory"] + "{ncbi_id}" + ".bam"

#----------------#
#   CountReads   #
#----------------#

# ~~inputs
__input_CR_counts = expand("{repertory}{filename}{extension}",
                              repertory = config["MappingSTAR"]["Repertory"],
                              filename = config["NCBI_id"],
                              extension = config["MappingSTAR"]["Extension"])
__gtf_CR = __output_GA_Genome
__mapping_CR = __output_MSTAR_bam

# ~~ parameters depending on inputs
__file_name_CR = config["CountReads"]["Filename"]
__container_CR = "./" + config["CountReads"]["container"]
__repertory_CR = config["CountReads"]["Repertory"]

# ~~ output
__output_CR = config["CountReads"]["Repertory"] + config["CountReads"]["Filename"] + ".counts"


#####################
#   Include Rules   #
#####################

include : os.getcwd() + "/rules/GetFastq.py"
include : os.getcwd() + "/rules/GetGenome.py"
include : os.getcwd() + "/rules/IndexGenome.py"
include : os.getcwd() + "/rules/MappingStar.py"
include : os.getcwd() + "/rules/GetAnnot.py"
include : os.getcwd() + "/rules/CountReads.py"

###################
#   Rule Target   #
###################

rule targets :
    input :
        __output_CR
        
    message :
        "All the workflow is done !!"
