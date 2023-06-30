#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload samtools
module load samtools/1.9

data_directory="$HOME/shared_files/Reference"
ancestor_fa="$HOME/shared_files/DNA550.fa"

project_name="bowhead"

samtools faidx DNA550.fa
