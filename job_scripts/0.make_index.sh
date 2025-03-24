#!/usr/bin/env bash

module load rna_seq/1.0

GENOME=/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m35/GRCm39.primary_assembly.genome.fa
GTF=/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m35/gencode.vM35.primary_assembly.annotation.gtf
OUTDIR=index

mkdir -p ${OUTDIR}

STAR \
--runThreadN 10 \
--runMode genomeGenerate \
--genomeDir ${OUTDIR} \
--genomeFastaFiles ${GENOME} \
--sjdbGTFfile ${GTF}



