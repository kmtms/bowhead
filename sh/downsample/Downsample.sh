#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload samtools
module load samtools/1.9

data_directory="$HOME/shared_files/Bams"

bam_suffix="ds2x"

python GenerateSvalbardDownsample.py

paste svalbard_list.txt downsample_factor.txt > svblist_w_factor.txt

while read name factor;
do
	#echo "${col1} is ${col2}";
	case `grep -Fx "${name}" ../list.txt >/dev/null; echo $?` in
  		0)
    			# code if found
    			filename="${name}_${bam_suffix}.bam" ;
			#echo ${filename};
                	samtools view -@ 10 -s ${factor} -o ${filename} "${data_directory}/${name}.bam" ;
                	samtools index ${filename} ;
			;;
  		1)
    			# code if not found
			;;
  		*)
    			# code if an error occurred
			;;
	esac
done < svblist_w_factor.txt
