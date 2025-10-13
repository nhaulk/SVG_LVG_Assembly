#!/bin/bash

#SBATCH --job-name="RID"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 3:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/RID.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "outputRID.%j.err"     #optional, prints our standard error

WORKDIR="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes"
REF="${WORKDIR}/LVG_p_noec_Clean_Genome/LVG_p_noec_chr_unpl_mt.fasta"
QUERY="${WORKDIR}/SVG_p_noec_Clean_Genome/SVG_p_noec_chr_unpl_mt.fasta"
ALIGN_DIR="${WORKDIR}/LVG_p_noec_Clean_Genome/dot_SVG_v_LVG"
PREFIX="LVG_p_noec_v_SVG_p_noec_chr_unpl_mt"


cd "$ALIGN_DIR"

#Convert chromosome data into fai tables
samtools faidx "$REF"
samtools faidx "$QUERY"

cut -f1,2 "${REF}.fai" | awk '{print $1"\t1\t"$2}' > "${PREFIX}_ref_chr_info.txt"
cut -f1,2 "${QUERY}.fai" | awk '{print $1"\t1\t"$2}' > "${PREFIX}_query_chr_info.txt"

# Reference synteny: handle reversed coordinates
awk 'NR>5 {s=($1<$2?$1:$2); e=($1>$2?$1:$2); print $12"\t"s"\t"e"\tblock"NR"\tblue"}' "${PREFIX}.coords" > "${PREFIX}_ref_synteny.txt"

# Query synteny: handle reversed coordinates
# If query chromosome names are missing, assign a placeholder (e.g., scaffold_1)
awk 'NR>5 {s=($4<$5?$4:$5); e=($4>$5?$4:$5); chr=$13; if(chr=="") chr="scaffold_1"; print chr"\t"s"\t"e"\tblock"NR"\tred"}' "${PREFIX}.coords" > "${PREFIX}_query_synteny.txt"

