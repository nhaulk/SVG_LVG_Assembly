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
INPUT="LVG_p"
SVG_FILE=/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/ragtag_test/SVG_p/ragtag.scaffold.fasta

cd ../ragtag_test/$INPUT

if [ ! -d "dot_LVGvSVG" ]; then
    echo "'dot_LVGvSVG' directory not found. Creating it..."
    mkdir dot_LVGvSVG
else
    echo "'dot_LVGvSVG' directory already exists. Using existing directory."
fi

cd dot_LVGvSVG

echo /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/ragtag_test/$INPUT/ragtag.scaffold.fasta

# Compare the two files
nucmer -p rt_test /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/ragtag_test/$INPUT/ragtag.scaffold.fasta $SVG_FILE

echo "Nucmer Complete"

# Convert the comparisons to delta files
python /lustre/isaac24/scratch/nhaulk/software/dot/DotPrep.py --delta rt_test.delta --out rt_test

echo "DotPrep Complete"
