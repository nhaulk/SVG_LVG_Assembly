#!/bin/bash

#SBATCH --job-name="ragtag"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 24:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "ragtag.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "ragtag.%j.err"     #optional, prints our standard error



REF="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVGandSVG_Juicebox/GCF_034640455.1_iyDiaLong2_genomic.fna"
ASSEMBLY="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVG_p_noec_Clean_Genome/LVG_p_noec.fasta"
OUTPUT="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/ragtag_test"

# Create the output directory if it doesn’t exist
mkdir -p "$OUTPUT"


ragtag.py scaffold $REF $ASSEMBLY -o $OUTPUT

