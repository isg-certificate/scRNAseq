#!/bin/bash
#SBATCH --job-name=sra
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

#################################################################
# Download fastq files from SRA 
#################################################################

# load software
module load parallel/20180122
module load sratoolkit/3.0.1

# The data are from this study:

OUTDIR=../../data/fastq
    mkdir -p ${OUTDIR}
METADATA=../../metadata/SraRunTable.txt

ACCLIST=../../metadata/subset.txt

# use parallel to download 2 accessions at a time. 
cat $ACCLIST | head -n 3 | parallel -j 3 "fasterq-dump -O ${OUTDIR} {}"

# compress the files 
ls ${OUTDIR}/*fastq | parallel -j 3 gzip