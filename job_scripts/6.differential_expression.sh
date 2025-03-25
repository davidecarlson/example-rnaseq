#!/usr/bin/env bash

#SBATCH -p short-96core-shared
#SBATCH -n 1
#SBATCH -c 1
#SBATCH --mem=4g
#SBATCH --output=differential_expression.log
#SBATCH -J differential_expression

module purge
module load slurm
module load deseq2/1.38.0

Rscript /gpfs/projects/GenomicsCore/example-rnaseq/job_scripts/deseq2.R


