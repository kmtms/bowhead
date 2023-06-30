#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921
#module load angsd/0.939

data_directory="$HOME/shared_files/Reference"

project_name="bowhead"

angsd -uniqueOnly 1 -GL 2 -remove_bads 1 -minMapQ 20 -minQ 20 -SNP_pval 1e-6 -skipTriallelic 1 -doMaf 2 -doGlf 3 -b ../../list_bam.txt -out $project_name -ref ${data_directory}/Bowhead_scaffolds_w_mito.fasta -rf ${data_directory}/Bowhead_autosomes_100kb.txt -docounts 1 -domajorminor 1 -nthreads 10 -minmaf 0.05 -doIBS 2 -minminor 2 -docov 1 -makematrix 1

# python /projects/mjolnir1/apps/pcangsd/pcangsd/pcangsd.py
