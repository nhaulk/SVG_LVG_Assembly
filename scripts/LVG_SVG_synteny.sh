#!/bin/bash

#SBATCH --job-name="FtoD"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 24:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/FtoD.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "output/FtoD.%j.err"     #optional, prints our standard error



# Define paths
PREFIX="$1"
PREFIX2="$2"

DIR2="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/${PREFIX2}_Clean_Genome"
cd ../${PREFIX}_Clean_Genome

if [ ! -d "dot_SVG_v_LVG" ]; then
    echo "'dot' directory not found. Creating it..."
    mkdir dot_SVG_v_LVG
else
    echo "'dot' directory already exists. Using existing directory."
fi

cd dot_SVG_v_LVG

# Compare the two files
nucmer -p ${PREFIX}_v_${PREFIX2}_chr_unpl_mt $DIR2/${PREFIX2}_chr_unpl_mt.fasta ../${PREFIX}_chr_unpl_mt.fasta

# convert the comparisons to delta files
python /lustre/isaac24/scratch/nhaulk/software/dot/DotPrep.py --delta ${PREFIX}_v_${PREFIX2}_chr_unpl_mt.delta --out ${PREFIX}_v_${PREFIX2}_chr_unpl_mt
