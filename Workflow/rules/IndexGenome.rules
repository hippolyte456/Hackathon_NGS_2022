__threads_IG = config["IndexGenome"]["threads"]

rule IndexGenome :
    input :
        genome = __input_IG_Genome,
        gtf = __input_IG_annot

    params :
        IG_Repertory = __repertory_IG,
        GG_Repertory = __repertory_GG

    output :
        ChrL =__output_CI_ChrL,
        ChrNL = __output_CI_ChrNL,
        ChrN = __output_CI_ChrN,
        ChrS = __output_CI_ChrS,
        Genome = __output_CI_Genome,
        GenomeP = __output_CI_GenomeP,
        SA = __output_CI_SA,
        SAi = __output_CI_SAi

    message :
        "Creating index from {input.genome}"

    singularity :
        __container_IG

    threads :
        __threads_IG
 
    shell :
        "gunzip -c {params.GG_Repertory}*.fa.gz > {params.GG_Repertory}ref.fa ;\
        STAR --runThreadN 8 \
             --runMode genomeGenerate \
             --genomeDir {params.IG_Repertory}    \
             --genomeFastaFiles  {params.GG_Repertory}ref.fa \
             --sjdbGTFfile {input.gtf} \
             --sjdbOverhang 100 \
             --genomeSAindexNbases 11"
