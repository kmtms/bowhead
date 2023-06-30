#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921

data_directory="$HOME/shared_files/Reference"
ancestor_fa="../Fst/DNA550.fa"

project_name="bowhead_1M_block"

angsd -uniqueOnly 1 -remove_bads 1 -minMapQ 20 -minQ 20 -b ../list_bam_path.txt -out $project_name -ref $data_directory/Bowhead_scaffolds_w_mito.fasta -rf $data_directory/Bowhead_autosomes_1Mb.txt -docounts 1 -nthreads 10 -doAbbababa 1 -blockSize 1000000 -anc ${ancestor_fa}
