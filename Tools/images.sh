#!/bin/bash

##############
### Colors ###
##############
BLACK="\033[1;30m"
RED="\033[1;31m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
PURPLE="\033[1;35m"
WHITE="\033[1;37m"
EOC="\033[0;0m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

function exists_in_list() {
    LIST=$1
    DELIMITER=$2
    VALUE=$3
    [[ "$LIST" =~ ($DELIMITER|^)$VALUE($DELIMITER|$) ]]
}

tools_name=$(ls -l | grep drw | awk 'NF>1 {print $NF}');
if ! ls -la | grep .logscript  &>/dev/null 
then
    mkdir .logscript
fi

if ! ls -l | grep drw | grep images &>/dev/null 
then 
    mkdir images
fi



for name in $tools_name
do 
    if ls ./.logscript/ | grep ${name} &>/dev/null || ls ./images/ | grep ${name} &>/dev/null # Si image et historique checker si diff puis build ou non
    then
        var=$(diff ./${name}/Singularity.${name} ./.logscript/Singularity.${name} | wc -l)
        if [ $var -gt 0 ]
        then
            echo -e "${BLACK}Creation of tool :${CYAN} ${name} ${EOF}"
            sudo singularity build ./images/${name} ./${name}/Singularity.${name}
            rm ./.logscript/Singularity.${name}
            cp ./${name}/Singularity.${name} ./.logscript/Singularity.${name}
        fi
    else
        var=$(ls ./${name} | grep singularity | wc -l)
        if [ $var -gt 0 ]
        then
            echo -e "${BLACK}Creation of tool :${CYAN} ${name} ${EOF}"
            sudo singularity build ./images/${name} ./${name}/Singularity.${name}
            rm ./.logscript/Singularity.${name}
            cp ./${name}/Singularity.${name} ./.logscript/Singularity.${name}
        fi
    fi
done


######################
### Testing Images ###
######################

echo """#####################################\n
###         TESTING TOOLS         ###\n
#####################################\n\n"""

tools_built=$(ls -l ./images/ | grep rwx | awk 'NF>1 {print $NF}')
if exists_in_list "$tools_built" "" star;
then
    singularity exec ./images/star STAR --help | wc -l | awk ' {if ($0==918) {print "TESTING STAR : \033[1;32m yes \033[0;0m"; exit}{print "TESTING STAR :\033[1;31m no \033[0;0m"}}'
else
    echo -e "${RED}star not build${EOC}"
fi
if exists_in_list "$tools_built" "" fastq_dump;
then
    singularity exec ./images/fastq_dump fastq-dump --help | wc -l | awk ' {if ($0==120) {print "TESTING FAST DUMP : \033[1;32m yes \033[0;0m"; exit}{print "TESTING FAST DUMP :\033[1;31m no \033[0;0m"}}'
else
    echo -e "${RED}fastq_dump not build${EOC}"
fi
if exists_in_list "$tools_built" "" fastqc;
then
    singularity exec ./images/fastqc fastqc --help | wc -l | awk ' {if ($0==122) {print "TESTING FASTQC : \033[1;32m yes \033[0;0m"; exit}{print "TESTING FASTQC :\033[1;31m no \033[0;0m"}}'
else
    echo -e "${RED}fastqc not build${EOC}"
fi
if exists_in_list "$tools_built" "" subread;
then
    singularity exec ./images/subread which subread-align | wc -c | awk ' {if ($0==37) {print "TESTING Subread : \033[1;32m yes \033[0;0m"; exit}{print "TESTING Subread :\033[1;31m no \033[0;0m"}}'
else
    echo -e "${RED}subread not build${EOC}"
fi
if exists_in_list "$tools_built" "" deseq2;
then
    singularity exec ./images/deseq2 R --vanilla  -e 'library( "DESeq2")' &>/dev/null | wc -l | awk ' {if ($0==20) {print "TESTING DESeq2 : \033[1;32m yes \033[0;0m"; exit}{print "TESTING DESeq2 :\033[1;31m no \033[0;0m"}}'
else
    echo -e "${RED}deseq2 not build${EOC}"
fi