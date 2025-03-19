#!/bin/bash
#SBATCH --job-name=counts
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --mem=25G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load STAR/2.7.11b

INDIR=../../data/fastq
OUTDIR=../../results/02_counts
mkdir -p ${OUTDIR}

GENOME=../../data/Li_etal_2022/genomeIndex
FQREAD=${INDIR}/SRR19020406_2.fastq.gz
FQBARCODE=${INDIR}/SRR19020406_1.fastq.gz

# read file needs to be first, barcode file second (reverse from our data)
     # usually you want a barcode whitelist, but we don't have one. 
     # --soloCBmatchWLtype 0 means treat every barcode sequence as unique. Will have to obvious failures later. 
STAR --runThreadN 16 \
     --genomeDir ${GENOME} \
     --readFilesIn ${FQREAD} ${FQBARCODE} \
     --readFilesCommand zcat \
     --soloType CB_UMI_Simple \
     --soloCBstart 1 17 \
     --soloCBlen 10 10 \
     --soloUMIstart 32 \
     --soloUMIlen 10 \
     --soloCBmatchWLtype 0 \
     --outFileNamePrefix ${OUTDIR}