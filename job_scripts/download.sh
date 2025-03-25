#!/usr/bin/env bash

# download all the fastq data associated with 6 SRA accessions

module load hts/1.0

ACCESSIONS="SRR5448113 SRR5448114 SRR5448115 SRR5448116 SRR5448117 SRR5448118"

for id in `echo $ACCESSIONS`; do
	echo Downloading fastq data for $id;
	fasterq-dump $id --progress --split-files -O ../data/reads/;
done

module load pigz

pigz -p 25 ../data/reads/*.fastq

# download annotation data and unzip it

wget -P ../data/reference/ https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M35/gencode.vM35.annotation.gtf.gz
wget -P ../data/reference/ https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M35/gencode.vM35.transcripts.fa.gz
wget -P ../data/reference/ https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M35/GRCm39.genome.fa.gz
gunzip ../data/reference/*


