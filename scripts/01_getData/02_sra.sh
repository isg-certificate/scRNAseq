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

# The data are from this study, NCBI BioProject: PRJNA833256
# Li, Q., Wang, M., Zhang, P. et al. A single-cell transcriptomic atlas tracking the neural basis of division of labour in an ant superorganism. Nat Ecol Evol 6, 1191–1204 (2022). https://doi.org/10.1038/s41559-022-01784-1

OUTDIR=../../data/fastq
    mkdir -p ${OUTDIR}

ACCLIST=../../metadata/subset.txt

# use parallel to download 2 accessions at a time. 
cat $ACCLIST | head -n 3 | parallel -j 3 "fasterq-dump -O ${OUTDIR} {}"

# compress the files 
ls ${OUTDIR}/*fastq | parallel -j 6 gzip