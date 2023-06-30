#!/bin/bash
source ~/.bashrc

paste list.txt numread/numreads.txt coverage/coverages.txt -d "," > summary.csv

sed -i '1i Sample ID,Number of reads,Coverage' summary.csv
