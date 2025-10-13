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

WORK_DIR="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVG_p_noec_Clean_Genome/dot_SVG_v_LVG"
REF_FASTA="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVG_p_noec_Clean_Genome/LVG_p_noec_chr_unpl_mt.fasta"
QRY_FASTA="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/SVG_p_noec_Clean_Genome/SVG_p_noec_chr_unpl_mt.fasta"
COORDS="${WORK_DIR}/LVG_p_noec_v_SVG_p_noec_chr_unpl_mt.coords"
OUTPUT_PREFIX="LVG_SVG_synteny"

cd ${WORK_DIR}

# Extract reference karyotype
echo "Extracting LVG karyotype..."
awk '/^>/ {if (seqlen) print seqname"\t"seqlen; seqname=$1; gsub(/^>/, "", seqname); seqlen=0; next} {seqlen += length($0)} END {print seqname"\t"seqlen}' ${REF_FASTA} > LVG_chr_length.txt

# Extract query karyotype
echo "Extracting SVG karyotype..."
awk '/^>/ {if (seqlen) print seqname"\t"seqlen; seqname=$1; gsub(/^>/, "", seqname); seqlen=0; next} {seqlen += length($0)} END {print seqname"\t"seqlen}' ${QRY_FASTA} > SVG_chr_length.txt

# Create RIdeogram karyotype format (Chr, Start, End)
awk '{print $1"\t1\t"$2}' LVG_chr_length.txt > LVG_karyotype.txt
awk '{print $1"\t1\t"$2}' SVG_chr_length.txt > SVG_karyotype.txt


# Parse coords file to extract synteny blocks
# Coords file format: [S1] [E1] [S2] [E2] [LEN 1] [LEN 2] [% IDY] [TAGS]
# RIdeogram needs: Species_1 Chr Start End Species_2 Chr Start End fill

awk 'NR > 5 {
    # Skip header lines and empty lines
    if (NF >= 9) {
        ref_start = $1
        ref_end = $2
        qry_start = $3
        qry_end = $4
        ref_chr = $12
        qry_chr = $13
        
        # Calculate a color based on identity (column 7)
        identity = $7
        if (identity >= 95) fill = "fd8d3c"
        else if (identity >= 90) fill = "fecc5c"
        else if (identity >= 85) fill = "ffffb2"
        else fill = "e0e0e0"
        
        print "LVG\t"ref_chr"\t"ref_start"\t"ref_end"\tSVG\t"qry_chr"\t"qry_start"\t"qry_end"\t"fill
    }
}' ${COORDS} > synteny_data.txt
