#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module load samtools/1.9

rm -f coverages.txt

while read -r line;
do
   samtools depth -a ~/shared_files/Bams/$line.bam | awk '{sum+=$3;cnt++}END{print " Coverage=" sum/cnt " Total mapped bp=" sum}' >> coverages.txt ;
done < ../list.txt

egrep -o "[0-9]+[.][0-9]+" coverages.txt > coverages_only.txt
