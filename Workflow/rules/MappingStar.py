__threads_MS = config["MappingSTAR"]["threads"]

rule MappingSTAR :
    input :
        fastq_1 = __input_MS_1,
        fastq_2 = __input_MS_2,
        index = __input_MS_index

    params :
        MS_Repertory = __repertory_MS,
        FQ_Repertory = __repertory_GF,
        IG_Repertory = __repertory_IG,
        ncbi_id =  __params_MS_NCBI_id

    output :
        output_MSTAR_bam = __output_MSTAR_bam

    message :
        "Mapping on {input.fastq_1} {input.fastq_2} with STAR"

    singularity :
        __container_MS  

    threads :
        __threads_MS
 
    shell :
        "STAR --outSAMstrandField intronMotif \
          	--runThreadN 8 \
            --outFilterMismatchNmax 4 \
            --outFilterMultimapNmax 10 \
            --genomeDir {params.IG_Repertory} \
            --readFilesIn {input.fastq_1} {input.fastq_2} \
            --outSAMunmapped None \
            --outSAMtype BAM SortedByCoordinate \
            --outStd BAM_SortedByCoordinate \
		    --genomeLoad NoSharedMemory \
		    --limitBAMsortRAM 3000000000 \
            --outTmpDir {params.MS_Repertory}{params.ncbi_id}/__tmpSTAR \
		    --outFileNamePrefix {params.MS_Repertory}{params.ncbi_id}/ \
            >  {params.MS_Repertory}{params.ncbi_id}.bam"
