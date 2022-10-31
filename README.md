# Project Repro-Hackathon

Project of the Master of Bioinformatics (AMI2B) of the University Paris-Saclay realized by : <br>
* <a href="https://github.com/JudithCo" target="_blank">Judith Coutrot </a> <br>
* <a href="https://github.com/J-ally" target="_blank">Joseph Allyndrée </a> <br>
* <a href="https://github.com/hippolyte456" target="_blank">Hippolyte Dreyfus </a> <br>
* <a href="https://github.com/Aaramis" target="_blank">Auguste Gardette </a> <br>

## Presentation

The goal is to reproduce parts of the analysis described in these papers (to read): <br>
* https://pubmed.ncbi.nlm.nih.gov/23313955/ <br>
* https://pubmed.ncbi.nlm.nih.gov/23861464/ <br>

They performed <a href="https://en.wikipedia.org/wiki/RNA-Seq" target="_blank">RNA-Seq</a> in samples from patients with uveal melanoma. Some samples are mutated in SF3B1 .
We want to analyze this data in order to find <a href="https://en.wikipedia.org/wiki/RNA-Seq#Differential_expression" target="_blank">differentially expressed genes</a>, i.e. genes that are more (or less) expressed in one condition (SF3B1 mutated samples) compared to another (SF3B1 non mutated samples).

To do this, we have designed and implemented a reproductible workflow.<br>
1. This workflow uses containers that can be generated from this git directory (see ["Tools"](Tools/README.md))<br>
2. The workflow is set up with the Snakemake tool (see  ["Workflow"](snakemake/README.md))<br>