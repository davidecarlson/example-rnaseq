#!/usr/bin/env bash

module load hts

OUTDIR=/gpfs/projects/GenomicsCore/example-rnaseq/multiqc_report

multiqc \
/gpfs/projects/GenomicsCore/example-rnaseq \
--outdir ${OUTDIR} \
--ignore "*STARpass1*" \
--force
