# Hackathon_NGS_2022

Projet Master2 AMI2B test de reproductibilité 

# Compte rendu scéance 07/10/22

pb ?
- problème de compréhension du fonctionnement de snakemake. En initialisant l'image pour l'outil FastQC, nous ne comprenions pas pourquoi nous n'avions aucune donnée. L'image fonctionnait en fait correctement, et il était nécessaire d'ouvrir l'image pour accéder à l'outil FastQC par la commande \$ singularity shell FastQC

Travail fait ?
- installation sur les machines virtuelles d'Anaconda, de Mamba, de Singularity
- debuggage de l'image pour l'outil FastQC
- répartition des tâches (réalisation des différentes images) pour la semaine prochaine
- création du Github commun pour la parallélisation du workload

# Outil

## Gestion d'image
Utilisation de Singularity

## Gestion de Workflow
Utilisation de Snakemake
