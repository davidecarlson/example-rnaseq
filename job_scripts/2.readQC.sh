#!/usr/bin/env bash

#subsample reads to keep only 10% per sample

READDIR=/gpfs/projects/GenomicsCore/BGE510/subsample
OUTDIR=QC

mkdir -p ${OUTDIR}

module load hts/1.0

for i in `ls ${READDIR}/*_subsample_1.fastq.gz`; do
	NAME=`basename $i _subsample_1.fastq.gz`;
	echo doing QC for sample: $NAME;
	fastp \
	--cut_right \
	--thread 5 \
	-i ${READDIR}/${NAME}_subsample_1.fastq.gz \
	-I ${READDIR}/${NAME}_subsample_2.fastq.gz \
	-o ${OUTDIR}/${NAME}_trimmed_1.fastq.gz \
	-O ${OUTDIR}/${NAME}_trimmed_2.fastq.gz \
	--json ${OUTDIR}/${NAME}_report.json \
	--html ${OUTDIR}/${NAME}_report.html;
done


