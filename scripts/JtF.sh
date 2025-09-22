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
#SBATCH -o "JtF.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "JtF.%j.err"     #optional, prints our standard error

conda activate genome_assembly

# Define paths
ASSEMBLY="$1"
FASTA="$2"
PREFIX="$3"

# Define output directory
OUTPUTDIR="../JtoF_fasta"

# Check if output directory exists; if not, create it
if [[ -d "$OUTPUTDIR" ]]; then
  echo "$OUTPUTDIR already exists."
else
  echo "Creating directory $OUTPUTDIR"
  mkdir "$OUTPUTDIR"
fi

# Run the converter
python /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/software/juicebox_assembly_converter.py \
  -a "$ASSEMBLY" \
  -f "$FASTA" \
  -p "$PREFIX" \
  -s

# Move output files that start with the prefix into the output directory
mv ${PREFIX}* "$OUTPUTDIR/"
