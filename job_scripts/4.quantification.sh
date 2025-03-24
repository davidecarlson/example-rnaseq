#!/usr/bin/env bash

module load deseq2

GTF=/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m35/gencode.vM35.primary_assembly.annotation.gtf
TRANSCRIPTOME=/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m35/gencode.vM35.transcripts.fa
OUTDIR=/gpfs/projects/GenomicsCore/example-rnaseq/quant
ALIGNMENTS=/gpfs/projects/GenomicsCore/example-rnaseq/alignments

mkdir -p ${OUTDIR}

for i in `ls ${ALIGNMENTS}/*toTranscriptome.out.bam`; do
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


