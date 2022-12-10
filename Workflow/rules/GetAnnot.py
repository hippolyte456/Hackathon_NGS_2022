__threads_GA = config["GetAnnot"]["threads"]

rule GetAnnot : 
    params :
        genome_ref = __genome_ref_GA,
        repertory_GA = __repertory_GA,
        filename = __file_name_GA

    output :
        genome_annot = __output_GA_Genome

    message :
        "GetGenome Annotation for reference genome {params.genome_ref}"
    
    singularity :
        __container_GA

    threads :
        __threads_GA

    shell :
        "wget -O {params.filename}.gtf.gz https://ftp.ensembl.org/pub/release-108/gtf/homo_sapiens/Homo_sapiens.{params.genome_ref}.108.chr.gtf.gz; \
        mv {params.filename}.gtf.gz {params.repertory_GA}{params.filename}.gtf.gz; \
        gunzip -k -f GenomeAnnot/genome_annot.gtf.gz "   
