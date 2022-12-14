rule CountReads :
    input :
        gtf = __gtf_CR,
        bam = __input_CR_counts,
        fastqc = __fastqc_CR

    params :
       CR_Repertory = __repertory_CR,
       filename = __file_name_CR

    output :
        output_CR = __output_CR

    message :
        "Get counts from {input.bam} with subreaf"

    singularity :
        __container_CR  
 
    shell :
        "CPU=$(grep -c ^processor /proc/cpuinfo) ;\
        featureCounts -T $CPU -t gene -g gene_id -s 0 -a {input.gtf} -o {params.CR_Repertory}{params.filename}.counts {input.bam}"