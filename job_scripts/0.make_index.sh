#!/usr/bin/env bash

#SBATCH -p short-96core-shared
#SBATCH -n 1
#SBATCH -c 15
#SBATCH --mem=50g
#SBATCH --output=index.log
#SBATCH -t 01:00:00
#SBATCH -J make_STAR_index

module load rna_seq/1.0

GENOME=/gpfs/projects/GenomicsCore/example-rnaseq/data/reference/GRCm39.genome.fa
GTF=/gpfs/projects/GenomicsCore/example-rnaseq/data/reference/gencode.vM35.annotation.gtf
OUTDIR=/gpfs/projects/GenomicsCore/example-rnaseq/output/index

mkdir -p ${OUTDIR}

rm -r /gpfs/scratch/decarlson/star_tmp

STAR \
--runThreadN 15 \
--runMode genomeGenerate \
--outTmpDir /gpfs/scratch/decarlson/star_tmp \
--genomeDir ${OUTDIR} \
--genomeFastaFiles ${GENOME} \
--sjdbGTFfile ${GTF}



