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
PREFIX="$1"



# Define output directory
OUTPUTDIR="../${PREFIX}_Clean_Genome"


cat $OUTPUTDIR/${PREFIX}_chr.lengths | sort -k2,2 -nr | awk -v OFS='\t' 'BEGIN{sum=0}{sum+=1}{print $1, "0", $2, "Chromosome"sum" [organism = Diachasmimorpha longicaudata][isolate = LVG_USDA_2025][location = chromosome][chromosome = " sum "]"}' >$OUTPUTDIR/${PREFIX}_chr.bed

cat $OUTPUTDIR/${PREFIX}_unpl.lengths | sort -k2,2 -nr | awk -v OFS='\t' 'BEGIN{sum=0}{sum+=1}{print $1, "0", $2, $1 " [organism = Diachasmimorpha longicaudata][isolate = LVG_USDA_2025]"}' >$OUTPUTDIR/${PREFIX}_unpl.bed

cat $OUTPUTDIR/${PREFIX}_mt.length | awk -v OFS='\t' 'BEGIN{sum=0}{sum+=1}{print $1, "0", $2, "Mitochondria [organism = Diachasmimorpha longicaudata][isolate = LVG_USDA_2025][location = mitochondrion][topology = circular][completeness = complete]"}' >$OUTPUTDIR/${PREFIX}_mt.bed

cat $OUTPUTDIR/${PREFIX}_chr.bed $OUTPUTDIR/${PREFIX}_unpl.bed $OUTPUTDIR/${PREFIX}_mt.bed > $OUTPUTDIR/${PREFIX}_chr_unpl_mt.bed
