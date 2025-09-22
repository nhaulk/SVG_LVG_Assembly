#!/bin/bash

#SBATCH --job-name="ragtag"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 3:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/ragtag.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "output/ragtag.%j.err"     #optional, prints our standard error


REF="$1"
ASSEMBLY="$2"
OUTPUT="$3"


ragtag.py scaffold $REF $ASSEMBLY -o $OUTPUT
