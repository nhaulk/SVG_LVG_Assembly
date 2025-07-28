#!/bin/bash

#SBATCH --job-name="Genome_Cleanup"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 1:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/Genome_clean.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "output/Genome_clean.%j.err"     #optional, prints our standard error




# Define paths
ASSEMBLY="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVGandSVG_Juicebox/LVG_juicebox_p/LVG_Male.p_ctg_noec.review_kac_07-11-25.assembly.assembly"
PREFIX="test"
RAWDATA="/lustre/isaac24/scratch/nhaulk/Dlongi_genomes_USDA/LVG_Punaluu_Male"

# Define output directory
OUTPUTDIR="../Clean_Genome"

# Check if output directory exists; if not, create it
if [[ -d "$OUTPUTDIR" ]]; then
  echo "$OUTPUTDIR already exists."

else
  echo "Creating directory $OUTPUTDIR"
  mkdir "$OUTPUTDIR"
fi

# Move to the working directory
cd "$OUTPUTDIR"

# Convert the file from a juicebox assembly to a fasta file
python /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/juicebox_assembly_converter.py \
  -a "$ASSEMBLY" \
  -f "$RAWDATA/HiC_yahs_p/LVG_Male.p_ctg_noec_converted.fasta" \
  -p "$PREFIX" \
  -s

# Run stats on the produced FASTA file
stats.sh -Xmx4g ${PREFIX}.fasta >${PREFIX}.stats

# combine the mitochondiral dNA with the scaffold info
cat ${RAWDATA}/HiC_yahs_p/yahs/LVG_Male.p_ctg_yahsout_noec_scaffolds_final.fa ${RAWDATA}/MT_p_noec/CM067966.1.fasta > Dlongi_UGA_Male_chr_unpl_mt.fasta

#!/bin/bash

sed '/^>CM067966\.1 Diachasmimorpha longicaudata isolate KC_UGA_2023 mitochondrion, complete sequence, whole genome shotgun sequence/ i\
' "Dlongi_UGA_Male_chr_unpl_mt.fasta" > "Dlongi_UGA_Male_chr_unpl_mt2.fasta"

