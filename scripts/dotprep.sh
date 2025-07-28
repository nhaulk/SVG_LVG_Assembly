#!/bin/bash

#SBATCH --job-name="Juicebox to Fasta"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 1:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=BEGIN,END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "dot.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "dot.%j.err"     #optional, prints our standard error



python /lustre/isaac24/scratch/nhaulk/software/dot/DotPrep.py --delta test2.delta
