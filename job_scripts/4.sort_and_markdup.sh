#!/usr/bin/env bash

module load hts

for i in `ls alignments/*Aligned.out.bam`; do
	NAME=`basename $i Aligned.out.bam`; 
	echo Sorting bam by genomic coordinate for sample: ${NAME};
	samtools \
	sort \
	-@ 8 \
	-o alignments/${NAME}.Aligned.out.sorted.bam \
	${i};
done

for i in `ls alignments/*.Aligned.out.sorted.bam`; do
	NAME=`basename $i Aligned.out.sorted.bam`;
	picard \
	MarkDuplicates \
	I=${i} \
	O=alignments/${NAME}.Aligned.out.sorted.markdup.bam \
	M=alignments/${NAME}.marked_dup_metrics.txt;
done
