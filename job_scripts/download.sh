#!/usr/bin/env bash

# download all the fastq data associated with 6 SRA accessions

module load hts/1.0

ACCESSIONS="SRR5448113 SRR5448114 SRR5448115 SRR5448116 SRR5448117 SRR5448118"

for id in `echo $ACCESSIONS`; do
	echo Downloading fastq data for $id;
	fasterq-dump $id --progress --split-files -O ../reads/;
done

module load pigz

pigz -p 25 reads/*.fastq
