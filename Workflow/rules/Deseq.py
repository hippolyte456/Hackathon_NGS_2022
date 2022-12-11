__threads_DES = config["Deseq"]["threads"]

rule Deseq :
    input :
        input_DES_count = __input_DES_count

    params :
        DES_Repertory = __repertory_DES

    output :
        DES_output = __output_fake

    message :
        "Deseq2 analysis of {input.input_DES_count}"

    singularity :
        __container_DES

    threads :
        __threads_DES
 
    shell :
        "touch {input.DES_Repertory}fake.R"
