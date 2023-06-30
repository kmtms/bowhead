#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload samtools
module load samtools/1.9

rm -f coverages.txt

ls ./Bams/*bam | sed 's:.*/::' > svalbard_2x_bam_list.txt

while read -r line;
do
	samtools depth -a ./Bams/${line} | awk '{sum+=$3;cnt++}END{print " Coverage=" sum/cnt " Total mapped bp=" sum}' >> coverages.txt;
done < svalbard_2x_bam_list.txt

egrep -o "[0-9]+[.][0-9]+" coverages.txt > coverages_only.txt
