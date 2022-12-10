__threads_GG = config["GetGenome"]["threads"]

rule GetGenome :
    params :
        chr = __params_GG_Chromosom,
        GG_Repertory = __repertory_GG

    output :
        genome = __output_GG_Genome

    message :
        "GetGenome with sra toolkit for {params.chr} NCBI_id"

    singularity :
        __container_GG

    threads :
        __threads_GG
 
    shell :
        "wget -O {params.GG_Repertory}{params.chr}.fa.gz https://ftp.ensembl.org/pub/release-108/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.{params.chr}.fa.gz &> /dev/null"
