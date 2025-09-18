#!/bin/bash

#SBATCH --job-name="SPlot"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 1:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/SPlot.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "output/SPlot.%j.err"     #optional, prints our standard error

blobtools add --genome /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/Clean_Genome/test.fasta --out myblob
