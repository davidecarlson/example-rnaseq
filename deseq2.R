library(tximport)
library(DESeq2)
library(readr)
library(GenomicFeatures)
library(EnhancedVolcano)

# read input files into memory
samples <- read.table('/gpfs/projects/GenomicsCore/BGE510/samples.csv', header=TRUE, sep=",")
gtf <- '/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m29/gencode.vM29.annotation.gtf'
files <- file.path('/gpfs/projects/GenomicsCore/BGE510/quant', samples$Sample, "quant.sf")

names(files) <- samples$Sample

# get mapping of transcript IDs to Gene IDs
txdb <- makeTxDbFromGFF(gtf, "gtf", 'GENCODE')
k <- keys(txdb, keytype = "TXNAME")
tx2gene <- select(txdb, k, "GENEID", "TXNAME")

# import the transcript level abundances and convert to gene abundances
txi <- tximport(files, type = "salmon", tx2gene = tx2gene)

# Construct the DESeq object using the sample table and the gene counts
ddsTxi <- DESeqDataSetFromTximport(txi,
                                   colData = samples,
                                   design = ~ Condition)

# remove genes without at least 10 reads in at least 3 samples
smallestGroupSize <- 3
keep <- rowSums(counts(ddsTxi) >= 10) >= smallestGroupSize
ddsTxi <- ddsTxi[keep,]

# run the differential expression analysis
ddsTxi <- DESeq(ddsTxi)

# get the results and specify the contrast of interest
res <- results(ddsTxi, contrast=c("Condition","KO","WT"))

# shrink the LFC estimates
resLFC <- lfcShrink(ddsTxi, coef="Condition_WT_vs_KO", type="apeglm")

#sort the results by p-value
resOrdered <- resLFC[order(resLFC$pvalue),]

# add gene names & symbols to the results
print("Loading mouse gene ID DB")
library(org.Mm.eg.db)
spp_db = org.Mm.eg.db
ens.str <- substr(rownames(resOrdered), 1, 18)
resOrdered$geneName <- mapIds(spp_db,
                       keys=ens.str,
                       column="GENENAME",
                       keytype="ENSEMBL",
                       multiVals="first")
resOrdered$symbol <- mapIds(spp_db,
                     keys=ens.str,
                     column="SYMBOL",
                     keytype="ENSEMBL",
                     multiVals="first")
print(summary(resOrdered))

#write the results to a csv file
write.csv(as.data.frame(resOrdered), 
          file="/gpfs/projects/GenomicsCore/BGE510/DGE_results/WT_vs_KO_results.csv")

#make volcano plot
volc<-EnhancedVolcano(resOrdered,
                lab = resOrdered$symbol,
                x = 'log2FoldChange',
                y = 'pvalue')

# save volcano plot to a pdf

ggsave('WT_vs_KO_volcanoplot.pdf', 
       plot = volc, 
       device = 'pdf', 
       path = '/gpfs/projects/GenomicsCore/BGE510/DGE_results/')

