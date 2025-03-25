#!/usr/bin/env bash

#SBATCH -p short-96core-shared
#SBATCH -n 1
#SBATCH -c 12
#SBATCH --mem=50g
#SBATCH --output=salmon_quant.log
#SBATCH -J salmon_quant

module load deseq2

GTF=/gpfs/projects/GenomicsCore/example-rnaseq/data/reference/gencode.vM35.annotation.gtf
TRANSCRIPTOME=/gpfs/projects/GenomicsCore/example-rnaseq/data/reference/gencode.vM35.transcripts.fa
OUTDIR=/gpfs/projects/GenomicsCore/example-rnaseq/output/quant
ALIGNMENTS=/gpfs/projects/GenomicsCore/example-rnaseq/output/alignments

mkdir -p ${OUTDIR}

for i in `ls ${ALIGNMENTS}/*toTranscriptome.out.bam`; do
	NAME=`basename $i Aligned.toTranscriptome.out.bam`; 
	echo Quantifying transcripts and genes for sample: ${NAME};
	salmon \
	quant \
	--geneMap ${GTF} \
	--threads 12 \
	--libType A \
	--seqBias \
	--gcBias \
	-t ${TRANSCRIPTOME} \
	-a ${i} \
	-o ${OUTDIR}/${NAME};
done
