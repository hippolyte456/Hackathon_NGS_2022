samples = ['A', 'B']
    
rule all:
    input:
        expand("stats/{sample}.txt", sample=samples)

rule count:
    input: "{sample}.fastq"
    output: "stats/{sample}.txt"
    run:
        count = 0
        with open(input[0], 'r') as fin:
            for line in fin.readlines():
                count += 1
        with open(output[0], "w") as fout:
            N = int(count / 4)
            fout.write("{}".format(N))