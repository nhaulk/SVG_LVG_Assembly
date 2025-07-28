#!/bin/bash

#SBATCH --job-name="align"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 24:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=BEGIN,END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "align.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "align.%j.err"     #optional, prints our standard error


nucmer -p test2 /lustre/isaac24/proj/UTK0312/nathaniel.haulk/Dlongi_genomes/converted_scaffold/test.fasta /lustre/isaac24/proj/UTK0312/nathaniel.haulk/Dlongi_genomes/converted_scaffold/GCF_034640455.1_iyDiaLong2_genomic.fna

