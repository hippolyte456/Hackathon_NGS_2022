__threads_QC = config["Fastqc"]["threads"]

rule Fastqc :
    input :
        fastq_1 = __input_MS_1,
        fastq_2 = __input_MS_2

    params :
        QC_Repertory = __repertory_QC,
        FQ_Repertory = __repertory_GF,
        ncbi_id =  __params_QC_NCBI_id

    output :
        QC_output = __output_QC

    message :
        "NGS quality check of {input.fastq_1} {input.fastq_2}"

    singularity :
        __container_QC

    threads :
        __threads_QC
 
    shell :
        "fastqc --outdir {params.QC_Repertory} \
                {input.fastq_1} {input.fastq_2} &> /dev/null"
