#!/usr/bin/env bash

module load hts

ALIGNMENTS=/gpfs/projects/GenomicsCore/example-rnaseq/alignments

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
