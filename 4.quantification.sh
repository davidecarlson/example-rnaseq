#!/usr/bin/env bash

module load deseq2

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
	--threads 25 \
	--libType A \
	--seqBias \
	--gcBias \
	-t ${TRANSCRIPTOME} \
	-a ${i} \
	-o ${OUTDIR}/${NAME};
done


