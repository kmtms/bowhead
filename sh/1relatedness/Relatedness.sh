#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921

data_directory="~/shared_files/Reference"

project_name="bowhead"

angsd -uniqueOnly 1 -GL 2 -remove_bads 1 -minMapQ 20 -minQ 20 -SNP_pval 1e-6 -skipTriallelic 1 -doMaf 2 -doGlf 3 -b ../list_bam.txt -out $project_name -ref ~/shared_files/Reference/Bowhead_scaffolds_w_mito.fasta -rf ~/shared_files/Reference/Bowhead_autosomes_100kb.txt -docounts 1 -domajorminor 1 -nthreads 10 -minmaf 0.05

# allele freq
zcat $project_name.mafs.gz | tail -n +2 | cut -f 6 > $project_name.freq

~/apps/ngsRelate/ngsRelate -g $project_name.glf.gz -n 41 -p 10 -f $project_name.freq -O $project_name.relatedness -z ../name_list.txt
