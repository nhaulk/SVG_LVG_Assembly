#!/bin/bash

#SBATCH --job-name="LvSJtoD"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=campus
#SBATCH --qos=campus
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 24:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "LvSJtoD.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "LvSJtoD.%j.err"     #optional, prints our standard error



# Define paths
ASSEMBLY="$1"
FASTA="$2"
PREFIX="$3"
NCBI_DATA="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/Dlongi_genomes/dot_converted_scaffold/SVG.p_noec.vs_NCBI.fasta"

# Define output directory
OUTPUTDIR="../dot_converted_scaffold"

# Check if output directory exists; if not, create it
if [[ -d "$OUTPUTDIR" ]]; then
  echo "$OUTPUTDIR already exists."
else
  echo "Creating directory $OUTPUTDIR"
  mkdir "$OUTPUTDIR"
fi

# Run the converter
python /lustre/isaac24/proj/UTK0312/nathaniel.haulk/Dlongi_genomes/juicebox_assembly_converter.py \
  -a "$ASSEMBLY" \
  -f "$FASTA" \
  -p "$PREFIX" \
  -s


# Compare the two files
nucmer -p ${PREFIX} ${PREFIX}.fasta $NCBI_DATA

# convert the comparisons to delta files
python /lustre/isaac24/scratch/nhaulk/software/dot/DotPrep.py --delta ${PREFIX}.delta --out ${PREFIX}

# Move output files that start with the prefix into the output directory
mv ${PREFIX}* "$OUTPUTDIR/"

