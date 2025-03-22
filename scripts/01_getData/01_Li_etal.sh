#!/bin/bash
#SBATCH --job-name=Li_etal
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 2
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

OUTDIR=../../data/Li_etal_2022/
mkdir -p ${OUTDIR}
cd ${OUTDIR}

# download data from figshare
    # Li, Q., Wang, M., Zhang, P. et al. A single-cell transcriptomic atlas tracking the neural basis of division of labour in an ant superorganism. Nat Ecol Evol 6, 1191–1204 (2022). https://doi.org/10.1038/s41559-022-01784-1
    # https://figshare.com/articles/dataset/Supporting_data_for_A_single-cell_transcriptomic_atlas_tracking_the_neural_basis_of_division_of_labor_in_an_ant_superorganism_/16616353

wget https://figshare.com/ndownloader/articles/16616353/versions/2

# make sure you get this file Mpha.umi.geneMatrix.gz and name it this. 
wget https://figshare.com/ndownloader/files/35070388

# the zip file is just named '2'
unzip 2

# remove zipfile
# rm ${OUTDIR}/2

# decompress genomic resources
for file in ${OUTDIR}/M.pharaonis*gz; do gunzip $file; done