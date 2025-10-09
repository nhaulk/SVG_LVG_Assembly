#!/bin/bash

#SBATCH --job-name="bedtools"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 1:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/bedtools.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "output/bedtools.%j.err"     #optional, prints our standard error


# Define paths
PREFIX="$1"

cd /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/${PREFIX}_Clean_Genome

bedtools getfasta -nameOnly -fi ${PREFIX}_trash_remaining.fasta -bed ${PREFIX}_chr_unpl_mt.bed -fo ${PREFIX}_chr_unpl_mt.fasta

echo "=== FINISH ==="
