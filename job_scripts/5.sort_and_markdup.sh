#!/usr/bin/env bash

#SBATCH -p short-96core-shared
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --mem=30g
#SBATCH --output=sort_markdup.log
#SBATCH -J sort_markdup

module load hts

ALIGNMENTS=/gpfs/projects/GenomicsCore/example-rnaseq/output/alignments

for i in `ls ${ALIGNMENTS}/*Aligned.out.bam`; do
	NAME=`basename $i Aligned.out.bam`; 
	echo Sorting bam by genomic coordinate for sample: ${NAME};
	samtools \
	sort \
	-@ 8 \
	-o ${ALIGNMENTS}/${NAME}.Aligned.out.sorted.bam \
	${i};
done

for i in `ls ${ALIGNMENTS}/*.Aligned.out.sorted.bam`; do
	NAME=`basename $i Aligned.out.sorted.bam`;
	picard \
	MarkDuplicates \
	I=${i} \
	O=${ALIGNMENTS}/${NAME}.Aligned.out.sorted.markdup.bam \
	M=${ALIGNMENTS}/${NAME}.marked_dup_metrics.txt;
done

for i in `ls ${ALIGNMENTS}/*.Aligned.out.sorted.markdup.bam`; do
    samtools index ${i};
done
