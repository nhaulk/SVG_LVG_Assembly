#!/bin/bash

#SBATCH --job-name="Chr_order"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 1:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/Chr_order.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "output/Chr_order.%j.err"     #optional, prints our standard error


# Define paths
infastaprefix="$1"
bedprefix="$2"
outfastaprefix="$3"

cd /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/Clean_Genome

bedtools getfasta -nameOnly -fi ${infastaprefix}.fasta -bed ${bedprefix}.bed -fo ${outfastaprefix}.fasta

echo "=== FINISH ==="
