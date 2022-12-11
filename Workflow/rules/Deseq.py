__threads_DES = config["Deseq"]["threads"]
__script = "./script.R"

rule Deseq :
    input :
        input_DES_count = __input_DES_count

    params :
        DES_Repertory = __repertory_DES,
        script = __script

    output :
        pca = __output_PCA,
        plotMA_res = __output_PlotMA

    message :
        "Deseq2 analysis of {input.input_DES_count}"

    singularity :
        __container_DES

    threads :
        __threads_DES
 
    shell:
        "Rscript {params.script} &> /dev/null"