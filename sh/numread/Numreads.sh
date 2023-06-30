#!/bin/bash
source ~/.bashrc

module load samtools/1.9

rm -f numreads.txt

while read -r line;
do
   samtools view -c ~/shared_files/Bams/$line.bam >> numreads.txt ;
done < ../list.txt
