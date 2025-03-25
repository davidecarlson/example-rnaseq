# Example RNA-seq

Repository to house code demonstrating a typical RNA-Seq analysis

Note: fastq, fasta, gtf and bam files have been excluded due to size.

The scripts in the repository will do the following:

1. Download fastq files from NCBI's SRA and reference genome files from Gencode
2. Build a STAR index using the reference data
3. Subsample 1 million paired-end reads from each sample
4. Run fastp QC on the reads
5. Align the reads to the reference genome with STAR
6. Quantify transcript expression using Salmon in alignment mode
7. Sort, mark duplicates, and index the BAM files produced by STAR using samtools and Picard
8. Conduct a basic differential expression analysis using DESeq2
9. Generate a MultiQC report

*Note: the code in this repository is intended for educational purposes only.  For an actual RNA-seq analysis, a standardized pipeline like [nf-core/rnaseq](https://nf-co.re/rnaseq/latest) is strongly recommended.*
