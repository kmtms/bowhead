#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921

data_directory="$HOME/shared_files/Reference"
# ancestor_fa="DNA550.fa"

project_name="bowhead"

pop1="bowhead_BCB"
pop2="bowhead_ECWG"
pop3="bowhead_EGSB"
pop4="bowhead_OKH"

# see how the Fst and PBS varies between different regions of the genome my using a sliding windows approach (windows site of 50kb)
# winsize="50000"
# stepsize="10000"
winsize="1000000"
stepsize="1000000"

popa="${pop1}"
popb="${pop2}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ${popa}.saf.idx ${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow_win1M

popa="${pop1}"
popb="${pop3}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ${popa}.saf.idx ${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow_win1M

popa="${pop1}"
popb="${pop4}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ${popa}.saf.idx ${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow_win1M

popa="${pop2}"
popb="${pop3}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ${popa}.saf.idx ${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow_win1M

popa="${pop2}"
popb="${pop4}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ${popa}.saf.idx ${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow_win1M

popa="${pop3}"
popb="${pop4}"
sfs="${popa}.${popb}.ml"
project_name="${popa}.${popb}"
realSFS fst index ${popa}.saf.idx ${popb}.saf.idx -sfs ${sfs} -fstout ${project_name}
realSFS fst stats2 ${project_name}.fst.idx -win ${winsize} -step ${stepsize} >${project_name}_slidingwindow_win1M