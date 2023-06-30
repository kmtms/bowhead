#!/bin/bash
source ~/.bashrc

## $1 - input prefix

module unload pcangsd
module load pcangsd/0.98.2 

# data_directory="$HOME/shared_files/Reference"

project_name="bowhead"

pcangsd -beagle ../2relatedness_forPCA/bowhead.beagle.gz -admix -threads 10 -o $project_name

# python /projects/mjolnir1/apps/pcangsd/pcangsd/pcangsd.py
