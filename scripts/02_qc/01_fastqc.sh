#!/bin/bash 
#SBATCH --job-name=fastqc
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=15G
#SBATCH --qos=general
#SBATCH --partition=general
#SBATCH --mail-user=
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load fastqc/0.11.7
module load parallel/20180122

INDIR=../../data/fastq/
OUTDIR=../../results/02_qc/fastqc
mkdir -p ${OUTDIR}

find ${INDIR} -name "SRR*fastq.gz" | parallel -j 6 \
    fastqc -t 2 -o ${OUTDIR} ${INDIR}/{}