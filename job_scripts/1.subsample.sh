#!/usr/bin/env bash

#SBATCH -p short-96core-shared
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=4g
#SBATCH --output=subsample.log
#SBATCH -J subsample_reads

#subsample reads to keep only 1 million PE reads per sample

READDIR=/gpfs/projects/GenomicsCore/example-rnaseq/data/reads
OUTDIR=/gpfs/projects/GenomicsCore/example-rnaseq/output/subsample

mkdir -p ${OUTDIR}

module load hts/1.0

for i in `ls ${READDIR}/*_1.fastq.gz`; do
	NAME=`basename $i _1.fastq.gz`;
	seqtk sample -s100 ${READDIR}/${NAME}_1.fastq.gz 1000000 | gzip > ${OUTDIR}/${NAME}_subsample_1.fastq.gz;
	seqtk sample -s100 ${READDIR}/${NAME}_2.fastq.gz 1000000 | gzip > ${OUTDIR}/${NAME}_subsample_2.fastq.gz;
done


