#!/bin/bash

#SBATCH --job-name="FtoD"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 3:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "FtoD.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "FtoD.%j.err"     #optional, prints our standard error



#minimap2 -x asm5 -t 8 /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVGandSVG_Juicebox/GCF_034640455.1_iyDiaLong2_genomic.fna \
#/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/Clean_Genome/LVG_p_noec_chr_unpl_mt.fasta \
#> LVG_vs_NCBI.paf

minimap2 -x asm5 -t 8 /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVGandSVG_Juicebox/GCF_034640455.1_iyDiaLong2_genomic.fna /lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/Clean_Genome/test.fasta > LVG_vs_NCBI.paf


