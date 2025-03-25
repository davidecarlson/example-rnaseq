#!/usr/bin/env bash

#SBATCH -p short-96core-shared
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=4g
#SBATCH --output=multiqc.log
#SBATCH -J multiqc

module load hts

OUTDIR=/gpfs/projects/GenomicsCore/example-rnaseq/multiqc_report

multiqc \
/gpfs/projects/GenomicsCore/example-rnaseq \
--outdir ${OUTDIR} \
--ignore "*STARpass1*" \
--force
