#!/bin/bash

#SBATCH --job-name="FtoD"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 3:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/FtoD.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "outputFtoD.%j.err"     #optional, prints our standard error


# Define paths
NCBI_DATA="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVGandSVG_Juicebox/GCF_034640455.1_iyDiaLong2_genomic.fna"
INPUT="LVG_p"


cd ../ragtag_test/$INPUT

if [ ! -d "dot" ]; then
    echo "'dot' directory not found. Creating it..."
    mkdir dot
else
    echo "'dot' directory already exists. Using existing directory."
fi

cd dot

echo /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/ragtag_test/$INPUT/ragtag.scaffold.fasta

# Compare the two files
nucmer -p rt_test /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/ragtag_test/$INPUT/ragtag.scaffold.fasta $NCBI_DATA

echo "Nucmer Complete"

# Convert the comparisons to delta files
python /lustre/isaac24/scratch/nhaulk/software/dot/DotPrep.py --delta rt_test.delta --out rt_test

echo "DotPrep Complete"
