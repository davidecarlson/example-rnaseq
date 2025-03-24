#!/usr/bin/env bash

module purge
module load slurm
module load deseq2/1.38.0

Rscript /gpfs/projects/GenomicsCore/example-rnaseq/job_scripts/deseq2.R


