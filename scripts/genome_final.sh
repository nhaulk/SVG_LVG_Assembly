#!/bin/bash

#SBATCH --job-name="Genome_Cleanup"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 1:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=BEGIN,END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/Genome_clean.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "output/Genome_clean.%j.err"     #optional, prints our standard error



python /lustre/isaac24/proj/UTK0312/nathaniel.haulk/Dlongi_genomes/juicebox_assembly_converter.py -a /lustre/isaac24/proj/UTK0312/nathaniel.haulk/Dlongi_genomes/LVGandSVG_Juicebox/LVG_juicebox_p/LVG_Male.p_ctg_noec.review_kac_07-11-25.assembly.assembly /
-f /lustre/isaac24/scratch/nhaulk/Dlongi_genomes/LVG_Punaluu_Male/HiC_yahs_p/LVG_Male.p_ctg_noec_converted.fasta /
-p test -s


# Define paths
ASSEMBLY="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/Dlongi_genomes/LVGandSVG_Juicebox/LVG_juicebox_p/LVG_Male.p_ctg_noec.review_kac_07-11-25.assembly.assembly"
FASTA="/lustre/isaac24/scratch/nhaulk/Dlongi_genomes/LVG_Punaluu_Male/HiC_yahs_p/LVG_Male.p_ctg_noec_converted.fasta"
PREFIX="test"

# Define output directory
OUTPUTDIR="../converted_scaffold"

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

# Run stats on the produced FASTA file
stats.sh -Xmx4g ${PREFIX}.fasta >${PREFIX}.stats




# Move output files that start with the prefix into the output directory
mv ${PREFIX}* "$OUTPUTDIR/"
