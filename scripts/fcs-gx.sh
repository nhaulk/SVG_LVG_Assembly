#!/bin/bash

#SBATCH --job-name="Chr_order"
#SBATCH --account=ISAAC-UTK0312
#SBATCH --partition=short
#SBATCH --qos=short
#SBATCH -N 1                #number of nodes in this job
#SBATCH -n 48                 #number of cores/tasks in this job, you get all 2$
#SBATCH -t 1:00:00            #time to run
#SBATCH --mail-user=nhaulk@utk.edu  #enter your email address to receive emails
#SBATCH --mail-type=END,FAIL #will receive an email when job starts, ends$
#SBATCH -o "output/Chr_order.%j.out"     # standard output, %j adds job number to output fil$
#SBATCH -e "output/Chr_order.%j.err"     #optional, prints our standard error


# Define paths
ASSEMBLY="/lustre/isaac24/proj/UTK0312/nathaniel.haulk/projects/Dlongi_genomes/LVGandSVG_Juicebox/LVG_juicebox_p/LVG_Male.p_ctg_noec.review_kac_07-11-25.assembly.assembly"
PREFIX="LVG_p_noec"
RAWDATA="/lustre/isaac24/scratch/nhaulk/Dlongi_genomes_USDA/LVG_Punaluu_Male"
SOFTWARE="/lustre/isaac24/scratch/nhaulk/software"

# Define output directory
OUTPUTDIR="../Clean_Genome"


python3 /reference/containers/fcs-genome/2022-08-03/run_fcsgx.py
\ --container-engine=singularity
\ --image=/reference/containers/fcs-genome/2022-08-03/fcs-gx.0.2.2.sif
\ --gx-db-disk /reference/data/NCBI/FCS/2022-07-14
\ --fasta ${assembly}.fasta
\ --out-basename ${assembly}
\ --gx-db /reference/data/NCBI/FCS/2022-07-14/all
\ --split-fasta --tax-id 58733
cat ${assembly}.fcs_gx_report.txt | grep "EXCLUDE" | awk -v OFS='\t' '{print $1}' >${assembly}.fcs_exclude.txt





