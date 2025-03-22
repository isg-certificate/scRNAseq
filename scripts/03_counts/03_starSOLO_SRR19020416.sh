#!/bin/bash
#SBATCH --job-name=counts_SRR19020416
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
OUTDIR=../../results/03_counts
mkdir -p ${OUTDIR}

GENOME=../../data/Li_etal_2022/genomeIndex
FQREAD=${INDIR}/SRR19020416_2.fastq.gz
FQBARCODE=${INDIR}/SRR19020416_1.fastq.gz

# read file needs to be first, barcode file second (reverse from our data)
     # usually you want a barcode whitelist, but we don't have one. 
     # --soloCBmatchWLtype 0 means treat every barcode sequence as unique. Will have to obvious failures later. 
STAR \
    --runThreadN 16 \
    --genomeDir ${GENOME} \
    --readFilesIn ${FQREAD} ${FQBARCODE} \
    --readFilesCommand zcat \
    --soloType CB_UMI_Simple \
    --soloBarcodeReadLength 30 \
    --soloCBstart 1 \
    --soloCBlen 20 \
    --soloUMIstart 21 \
    --soloUMIlen 10 \
    --soloCBwhitelist None \
    --soloCBmatchWLtype Exact \
    --outFileNamePrefix ${OUTDIR}/SRR19020416


