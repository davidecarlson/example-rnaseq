#!/usr/bin/env bash

module load rna_seq/1.0

BAM=alignments
GTF=/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m29/gencode.vM29.annotation.gtf
TRANSCRIPTOME=/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m29/genome.transcripts.fa
OUTDIR=quant

mkdir -p ${OUTDIR}

for i in `ls alignments/*toTranscriptome.out.bam`; do
	NAME=`basename $i Aligned.toTranscriptome.out.bam`; 
	echo Quantifying transcripts and genes for sample: ${NAME};
	salmon \
	quant \
	--geneMap ${GTF} \
	--threads 12 \
	--libType A \
	-t ${TRANSCRIPTOME} \
	-a ${i} \
	-o ${OUTDIR}/${NAME};
done


