#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload angsd
module load angsd/0.921

data_directory="$HOME/shared_files/Reference"
ancestor_fa="../Fst/DNA550.fa"

project_name="bowhead"

pops=( "BCB" "ECWG" "EGSB" "OKH" )
nInd2s=( "3" "9" "9" "6" )

for i in "${!pops[@]}"
do
    pop="${pops[i]}"
    nInd=`cat ../pop${pop}_bam_path.txt | wc -l`
    nInd2="${nInd2s[i]}"

    final_name="${project_name}_${pop}_allInd"

    # winsize="10000000"
    # stepsize="10000000"
    winsize="100000"
    stepsize="100000"

    # angsd -uniqueOnly 1 -GL 2 -remove_bads 1 -minMapQ 20 -minQ 20 -skipTriallelic 1 -doMaf 2 -b ../pop${pop}_bam_path.txt -out ${project_name}_${pop} -ref ${data_directory}/Bowhead_scaffolds_w_mito.fasta -rf ${data_directory}/Bowhead_autosomes_100kb.txt -docounts 1 -domajorminor 1 -nthreads 10 -minInd ${nInd} -doSaf 1 -anc ${ancestor_fa}
	
    # angsd -b ../pop${pop}_bam_path.txt -anc ${ancestor_fa} -docounts 1 -ref ${data_directory}/Bowhead_scaffolds_w_mito.fasta -dosaf 1 -uniqueOnly 1 -remove_bads 1 -minMapQ 20 -minQ 20 -doMajorMinor 1 -doMaf 2 -skipTriallelic 1 -GL 2 -minInd ${nInd} -out ${final_name} -rf ${data_directory}/Bowhead_autosomes_100kb.txt -nthreads 10

    # realSFS ${final_name}.saf.idx > ${final_name}.sfs

    # tail -n +2 ${final_name}.sfs > ${final_name}_nohead.sfs

    # realSFS saf2theta ${final_name}.saf.idx -outname ${final_name} -sfs ${final_name}.sfs -P 10

    thetaStat do_stat ${final_name}.thetas.idx -win ${winsize} -step ${stepsize} -outnames ${final_name}.thetasWindow.gz

    ##########

    final_name="${project_name}_${pop}_075Ind"
	
    # angsd -b ../pop${pop}_bam_path.txt -anc ${ancestor_fa} -docounts 1 -ref ${data_directory}/Bowhead_scaffolds_w_mito.fasta -dosaf 1 -uniqueOnly 1 -remove_bads 1 -minMapQ 20 -minQ 20 -doMajorMinor 1 -doMaf 2 -skipTriallelic 1 -GL 2 -minInd ${nInd2} -out ${final_name} -rf ${data_directory}/Bowhead_autosomes_100kb.txt -nthreads 10

    # realSFS ${final_name}.saf.idx > ${final_name}.sfs

    # tail -n +2 ${final_name}.sfs > ${final_name}_nohead.sfs

    # realSFS saf2theta ${final_name}.saf.idx -outname ${final_name} -sfs ${final_name}.sfs -P 10

    thetaStat do_stat ${final_name}.thetas.idx -win ${winsize} -step ${stepsize} -outnames ${final_name}.thetasWindow.gz

done








