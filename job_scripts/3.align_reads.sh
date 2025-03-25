#!/usr/bin/env bash

#SBATCH -p short-96core-shared
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --mem=50g
#SBATCH --output=star_align.log
#SBATCH -J star_align

module load rna_seq/1.0

READDIR=/gpfs/projects/GenomicsCore/example-rnaseq/output/QC
INDEX=/gpfs/projects/GenomicsCore/example-rnaseq/output/index
OUTDIR=/gpfs/projects/GenomicsCore/example-rnaseq/output/alignments

mkdir -p ${OUTDIR}

for i in `ls ${READDIR}/*_1.fastq.gz`; do
	NAME=`basename $i _trimmed_1.fastq.gz`; 
	echo Mapping reads to reference for sample: ${NAME};
	STAR \
	--runThreadN 20 \
	--genomeDir ${INDEX} \
	--outFileNamePrefix ${OUTDIR}/${NAME} \
	--readFilesIn ${READDIR}/${NAME}_trimmed_1.fastq.gz ${READDIR}/${NAME}_trimmed_2.fastq.gz \
	--quantMode TranscriptomeSAM \
	--twopassMode Basic \
	--outSAMtype BAM Unsorted \
	--readFilesCommand zcat \
	--runRNGseed 0 \
	--outFilterMultimapNmax 20 \
	--alignSJDBoverhangMin 1 \
	--outSAMattributes NH HI AS NM MD \
	--quantTranscriptomeBan Singleend \
	--outSAMstrandField intronMotif;
done


