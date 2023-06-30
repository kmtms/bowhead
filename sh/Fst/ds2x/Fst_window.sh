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

# see how the Fst and PBS varies between different regions of the genome my using a sliding windows approach (windows site of 50kb)
# realSFS fst index ../${pop1}.saf.idx ../${pop2}.saf.idx ${pop3}.saf.idx ../${pop4}.saf.idx -sfs ../${pop1}.${pop2}.ml -sfs ${pop1}.${pop3}.ml -sfs ../${pop1}.${pop4}.ml -sfs ${pop2}.${pop3}.ml -sfs ../${pop2}.${pop4}.ml -sfs ${pop3}.${pop4}.ml -fstout ${project_name}
# realSFS fst stats2 ${project_name}.fst.idx -win 50000 -step 10000 >${project_name}_slidingwindow
# winsize="50000"
# stepsize="10000"
winsize="100000"
stepsize="100000"

popa="${pop1}"
popb="${pop3}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ../${popa}.saf.idx ${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow

popa="${pop2}"
popb="${pop3}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ../${popa}.saf.idx ${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow

popa="${pop3}"
popb="${pop4}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ${popa}.saf.idx ../${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow