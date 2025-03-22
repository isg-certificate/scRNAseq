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
module load bioawk

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
     --readFilesIn <(zcat ${FQREAD}) <(bioawk -c fastx '{S = substr($seq,1,10) substr($seq,17,10) substr($seq,32,10); Q = substr($qual,1,10) substr($qual,17,10) substr($qual,32,10); print "@"$name"\n"S"\n+\n"Q}' ${FQBARCODE}) \
     --soloType CB_UMI_Simple \
     --soloBarcodeReadLength 30 \
     --soloCBstart 1 \
     --soloCBlen 20 \
     --soloUMIstart 21 \
     --soloUMIlen 10 \
     --soloCBwhitelist None \
     --soloCBmatchWLtype Exact \
     --outFileNamePrefix ${OUTDIR}/SRR19020406