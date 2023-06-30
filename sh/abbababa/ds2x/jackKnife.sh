#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921

module load gcc

module unload R
module load R/4.0.3

data_directory="$HOME/shared_files/Reference"
ancestor_fa="../Fst/DNA550.fa"

# project_name="bowhead"
project_name="bowhead_ds2x_1M_block"

Rscript jackKnife.R file=${project_name}.abbababa indNames=../../list_id_w_pop.txt outfile=${project_name}
#Rscript /maps/projects/mjolnir1/apps/conda/angsd-0.940/angsd/R/jackKnife.R file=${project_name}.abbababa indNames=../list_id_w_pop.txt outfile=${project_name}
