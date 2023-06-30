#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921

data_directory="$HOME/shared_files/Reference"
# ancestor_fa="$HOME/shared_files/DNA550.fa"
ancestor_fa="../Fst/DNA550.fa"

project_name="bowhead"

pops=( "BCB" "ECWG" "EGSB" "OKH" )
nInd2s=( "3" "9" "9" "6" )

for i in "${!pops[@]}"
do
    pop="${pops[i]}"
    # nInd=`cat ../pop${pop}_bam_path.txt | wc -l`
    nInd2="${nInd2s[i]}"

    final_name="${project_name}_${pop}_075Ind"

    angsd -uniqueOnly 1 -GL 2 -remove_bads 1 -minMapQ 20 -minQ 20 -skipTriallelic 1 -doMaf 2 -b ../pop${pop}_bam_path.txt -out ${project_name}_${pop} -ref ${data_directory}/Bowhead_scaffolds_w_mito.fasta -rf ${data_directory}/Bowhead_autosomes_100kb.txt -docounts 1 -domajorminor 1 -nthreads 10 -minInd ${nInd2} -doSaf 1 -anc ${ancestor_fa}
	# echo "$i"
done
