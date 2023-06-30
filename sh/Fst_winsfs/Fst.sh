#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921
module unload winsfs
module load winsfs/0.7.0

data_directory="$HOME/shared_files/Reference"
# ancestor_fa="DNA550.fa"

project_name="bowhead"

saf_prefix="../Fst/"

pop1="bowhead_BCB"
pop2="bowhead_ECWG"
pop3="bowhead_EGSB"
pop4="bowhead_OKH"

#calculate the 2D SFS
winsfs ${saf_prefix}${pop1}.saf.idx ${saf_prefix}${pop2}.saf.idx -t 10 -v >${pop1}.${pop2}.preml
winsfs ${saf_prefix}${pop1}.saf.idx ${saf_prefix}${pop3}.saf.idx -t 10 -v >${pop1}.${pop3}.preml
winsfs ${saf_prefix}${pop1}.saf.idx ${saf_prefix}${pop4}.saf.idx -t 10 -v >${pop1}.${pop4}.preml
winsfs ${saf_prefix}${pop2}.saf.idx ${saf_prefix}${pop3}.saf.idx -t 10 -v >${pop2}.${pop3}.preml
winsfs ${saf_prefix}${pop2}.saf.idx ${saf_prefix}${pop4}.saf.idx -t 10 -v >${pop2}.${pop4}.preml
winsfs ${saf_prefix}${pop3}.saf.idx ${saf_prefix}${pop4}.saf.idx -t 10 -v >${pop3}.${pop4}.preml

cat ${pop1}.${pop2}.preml | tail -n +2 > ${pop1}.${pop2}.ml
cat ${pop1}.${pop3}.preml | tail -n +2 > ${pop1}.${pop3}.ml
cat ${pop1}.${pop4}.preml | tail -n +2 > ${pop1}.${pop4}.ml
cat ${pop2}.${pop3}.preml | tail -n +2 > ${pop2}.${pop3}.ml
cat ${pop2}.${pop4}.preml | tail -n +2 > ${pop2}.${pop4}.ml
cat ${pop3}.${pop4}.preml | tail -n +2 > ${pop3}.${pop4}.ml

#first will will index the sample so the same sites are analysed for each population
realSFS fst index ${saf_prefix}${pop1}.saf.idx ${saf_prefix}${pop2}.saf.idx -sfs ${pop1}.${pop2}.ml -fstout ${pop1}.${pop2}
realSFS fst index ${saf_prefix}${pop1}.saf.idx ${saf_prefix}${pop3}.saf.idx -sfs ${pop1}.${pop3}.ml -fstout ${pop1}.${pop3}
realSFS fst index ${saf_prefix}${pop1}.saf.idx ${saf_prefix}${pop4}.saf.idx -sfs ${pop1}.${pop4}.ml -fstout ${pop1}.${pop4}
realSFS fst index ${saf_prefix}${pop2}.saf.idx ${saf_prefix}${pop3}.saf.idx -sfs ${pop2}.${pop3}.ml -fstout ${pop2}.${pop3}
realSFS fst index ${saf_prefix}${pop2}.saf.idx ${saf_prefix}${pop4}.saf.idx -sfs ${pop2}.${pop4}.ml -fstout ${pop2}.${pop4}
realSFS fst index ${saf_prefix}${pop3}.saf.idx ${saf_prefix}${pop4}.saf.idx -sfs ${pop3}.${pop4}.ml -fstout ${pop3}.${pop4}

#get the global estimate
realSFS fst stats ${pop1}.${pop2}.fst.idx
realSFS fst stats ${pop1}.${pop3}.fst.idx
realSFS fst stats ${pop1}.${pop4}.fst.idx
realSFS fst stats ${pop2}.${pop3}.fst.idx
realSFS fst stats ${pop2}.${pop4}.fst.idx
realSFS fst stats ${pop3}.${pop4}.fst.idx
