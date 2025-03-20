#!/bin/bash
#SBATCH --job-name=indexSTAR
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

INDIR=../../data/Li_etal_2022/
OUTDIR=../../data/Li_etal_2022/genomeIndex
mkdir -p ${OUTDIR}

GENOME=../../data/Li_etal_2022/M.pharaonis.genome.fasta
GTF=../../data/Li_etal_2022/M.pharaonis.genome.gtf

STAR --runThreadN 16 \
     --runMode genomeGenerate \
     --genomeDir ${OUTDIR} \
     --genomeFastaFiles ${GENOME} \
     --sjdbGTFfile ${GTF} \
     --sjdbOverhang 99 