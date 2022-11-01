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


#--------------#
#   0.-Setup   #
#--------------#

# 0.1 Get the OS distribution
OS=$(cat /etc/os-release | awk 'NR==1{print $1}' |  cut -d'"' -f 2)
if [ $OS != "Ubuntu" ] ;
then
    echo -e "$RED Please use a Ubuntu distribution $EOC"
    exit 1
fi

# 0.2 Update & upgrade & autoremove & autoclean
echo -e -n "\n$CYAN Updating ... $EOC" | sort
sudo apt update -y &> /dev/null && sudo apt full-upgrade -y &> /dev/null && sudo apt autoremove -y &> /dev/null && sudo apt autoclean -y &> /dev/null
echo -e "$GREEN  Done $EOC"

#---------------------------------#
#   1. Singularity Installation   #
#---------------------------------#

echo -e -n "\n$CYAN 1. Singularity $EOC" | sort
SING_PATH=$(which singularitry)
LOCA=$(pwd)
if which singularity &>/dev/null ;
then
    echo -e -n "$GREEN Singularity already downloaded. $EOC" | sort
else
    echo -e -n "$PURPLE Singularity not here, downloading ... $EOC" | sort
    sudo apt-get install -y build-essential libssl-dev uuid-dev libgpgme11-dev squashfs-tools libseccomp-dev wget pkg-config git cryptsetup &>/dev/null
    wget https://dl.google.com/go/go1.13.linux-amd64.tar.gz &>/dev/null
    sudo tar --directory=/usr/local -xzvf go1.13.linux-amd64.tar.gz &>/dev/null
    export PATH=/usr/local/go/bin:$PATH                
    wget https://github.com/singularityware/singularity/releases/download/v3.5.3/singularity-3.5.3.tar.gz &>/dev/null
    tar -xzvf singularity-3.5.3.tar.gz &>/dev/null
    cd singularity &>/dev/null
    ./mconfig &>/dev/null
    cd builddir &>/dev/null
    make &>/dev/null
    sudo make install  &>/dev/null
    cd $LOCA
    rm -rf singularity-3.5.3.tar.gz go1.13.linux-amd64.tar.gz singularity
    sudo mv singularity /usr/local/bin/ &>/dev/null
    if which singularity &>/dev/null ;
    then
        echo -e "$GREEN Singularity has been successfully downloaded. $EOC"
    else
        echo -e "$RED ERROR : Singularity has not been downloaded. $EOC"
        exit 1
    fi
fi

#-------------------------------#
#   2. Snakemake Installation   #
#-------------------------------#

# 2.1 Download Snakemake using pip
echo -e -n "\n$CYAN 2. Snakemake $EOC" | sort
if which snakemake &>/dev/null ;
then
    echo -e -n "$GREEN Snakemake already downloaded. $EOC" | sort
else
    echo -e -n "$PURPLE Snakemake not here, downloading ... $EOC" | sort
    pip install snakemake &>/dev/null
    # 2.2 Find path to snakemake (find / snakemake | grep bin/snakemake)
    SNAK_PATH=$(sudo find / snakemake 2>/dev/null | grep bin/snakemake | awk 'NR==1{print $1}' | awk -F 'bin/' '{print $1 FS}')
    # 2.3 Export Path
    export PATH=$PATH:$SNAK_PATH
    if which snakemake &>/dev/null ;
    then
        echo -e "$GREEN Snakemake has been successfully downloaded. $EOC"

    else 
        echo -e "$RED ERROR : Snakemake has not been downloaded. $EOC"
        exit 1
    fi
fi

# Error need to check if snakemake work. in file snakemake/deployment/singularity.py comparaison between int and str. Need to change the file line 70 and add str()
# sudo find / snakemake | grep snakemake/deployment/singularity.py
#if not LooseVersion(v)) >= LooseVersion("2.4.1"):

#if not str(LooseVersion(v)) >= str(LooseVersion("2.4.1")):

# sed -i 's/old-text/new-text/g' input.txt
# sed -i 's/if not LooseVersion(v)) >= LooseVersion("2.4.1"):/if not str(LooseVersion(v)) >= str(LooseVersion("2.4.1")):/g' /home/ubuntu/.local/lib/python3.8/site-packages/snakemake/deployment/singularity.py
# sed -i 's/if not str(LooseVersion(v)) >= str(LooseVersion("2.4.1")):/if not LooseVersion(v)) >= LooseVersion("2.4.1"):/g' /home/ubuntu/.local/lib/python3.8/site-packages/snakemake/deployment/singularity.py

# Fixing error in snakemake deployement, comparaison between int and str :
SNAK_DEPLOY_PATH=$(sudo find / snakemake | grep snakemake/deployment/singularity.py)
for file in $SNAK_DEPLOY_PATH;
do
    sed -i 's/if not LooseVersion(v)) >= LooseVersion("2.4.1"):/if not str(LooseVersion(v)) >= str(LooseVersion("2.4.1")):/g' $file
done



#------------------------#
#   3. Generate images   #
#------------------------#

# 3.1 Execute script ./Tools/images.sh
echo -e -n "\n$CYAN 3. Generating Containers $EOC"  | sort
cd ./Tools
./images.sh
# 3.2 Export ./Tools/Images to ./Workflow/images or change config file (less memory need)
cd ..
cp -r ./Tools/images ./Workflow/images
if ls Workflow/images &>/dev/null  ;
then
    echo -e -n "$GREEN Images generation has been successfully executed"  | sort
else
    echo -e -n "$RED Error Images generation has not been executed"  | sort
    exit 1
fi 

#-------------------------#
#   4. Execute Workflow   #
#-------------------------#

# 4.1 Run snakemake command
echo -e -n "\n$CYAN 4. Executing Workflow $EOC" | sort
if which snakemake &>/dev/null ;
then
    cd ./Workflow
    snakemake --use-singularity -s $PWD/ReproHackathon.wf --configfile $PWD/configuration.yml -j 1 -k --printshellcmds
else
    echo -e -n "$RED Error Snakemake not find" | sort
    exit 1
fi

#--------------#
#   5. Bonus   #
#--------------#

# 5.1 Set firewall between steps
# 5.2 Generate log and err folders for the workflow to track the steps
# 5.3 Create a script (python) to have a visual interface of the workflow status
