#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921

data_directory="$HOME/shared_files/Reference"
ds_suffix="ds2x"
# ancestor_fa="DNA550.fa"

project_name="bowhead_${ds_suffix}"

pop1="bowhead_BCB"
pop2="bowhead_ECWG"
pop3="bowhead_${ds_suffix}_EGSB"
pop4="bowhead_OKH"

#calculate the 2D SFS
#realSFS ../${pop1}.saf.idx ../${pop2}.saf.idx -P 10 >${pop1}.${pop2}.ml
realSFS ../${pop1}.saf.idx ${pop3}.saf.idx -P 10 >${pop1}.${pop3}.ml
#realSFS ../${pop1}.saf.idx ../${pop4}.saf.idx -P 10 >${pop1}.${pop4}.ml
realSFS ../${pop2}.saf.idx ${pop3}.saf.idx -P 10 >${pop2}.${pop3}.ml
#realSFS ../${pop2}.saf.idx ../${pop4}.saf.idx -P 10 >${pop2}.${pop4}.ml
realSFS ${pop3}.saf.idx ../${pop4}.saf.idx -P 10 >${pop3}.${pop4}.ml

#first we will index the sample so the same sites are analysed for each population
#realSFS fst index ${pop1}.saf.idx ${pop2}.saf.idx -sfs ${pop1}.${pop2}.ml -fstout ${pop1}.${pop2}
realSFS fst index ../${pop1}.saf.idx ${pop3}.saf.idx -sfs ${pop1}.${pop3}.ml -fstout ${pop1}.${pop3}
#realSFS fst index ${pop1}.saf.idx ${pop4}.saf.idx -sfs ${pop1}.${pop4}.ml -fstout ${pop1}.${pop4}
realSFS fst index ../${pop2}.saf.idx ${pop3}.saf.idx -sfs ${pop2}.${pop3}.ml -fstout ${pop2}.${pop3}
#realSFS fst index ${pop2}.saf.idx ${pop4}.saf.idx -sfs ${pop2}.${pop4}.ml -fstout ${pop2}.${pop4}
realSFS fst index ${pop3}.saf.idx ../${pop4}.saf.idx -sfs ${pop3}.${pop4}.ml -fstout ${pop3}.${pop4}

#get the global estimate
#realSFS fst stats ${pop1}.${pop2}.fst.idx
realSFS fst stats ${pop1}.${pop3}.fst.idx
#realSFS fst stats ${pop1}.${pop4}.fst.idx
realSFS fst stats ${pop2}.${pop3}.fst.idx
#realSFS fst stats ${pop2}.${pop4}.fst.idx
realSFS fst stats ${pop3}.${pop4}.fst.idx