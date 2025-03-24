#!/usr/bin/env bash

module load rna_seq/1.0

GENOME=/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m29/GRCm39.primary_assembly.genome.fa
GTF=/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m29/gencode.vM29.annotation.gtf
OUTDIR=index

mkdir -p ${OUTDIR}

STAR \
--runThreadN 10 \
--runMode genomeGenerate \
--genomeDir ${OUTDIR} \
--genomeFastaFiles ${GENOME} \
--sjdbGTFfile ${GTF}



