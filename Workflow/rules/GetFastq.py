__threads_GF = config["GetFastq"]["threads"]

rule getFastq :
    params :
       id =  __params_GF_NCBI_id,
       GF_Repertory = __repertory_GF

    output :
        output_GF_1 = __output_GF_1,
        output_GF_2 = __output_GF_2

    message :
        "GetFastq with sra toolkit for {params.id} SRAID"

    singularity :
        __container_GF  
 
    threads :
        __threads_GF

    shell :
        "vdb-config --restore-defaults ;\
        prefetch -f yes {params.id} -O {params.GF_Repertory};\
        fasterq-dump --split-files {params.GF_Repertory}{params.id}/{params.id}.sra -O {params.GF_Repertory}{params.id}"
