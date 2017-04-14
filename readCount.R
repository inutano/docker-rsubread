# Rscript to cout reads of mapped bam using gtf annotation file
# Example:
#   $ Rscript --vanilla ./readCount.R /path/to/Aligned.toTranscriptome.out.bam /path/to/genes.gtf
#

# Load library, install if missing
if( require("Rsubread") ) {} else {
  source("http://bioconductor.org/biocLite.R")
  biocLite("Rsubread")
}

if( require("optparse") ) {} else {
  install.packages("optparse", repos='http://cran.r-project.org')
  require("optparse")
}

# Parse arguments
option_list = list(
  make_option(
    c("--bam"),
    type="character",
    default=NULL,
    help="input bam file path",
    metavar="character"
  ),
  make_option(
    c("--gtf"),
    type="character",
    default=NULL,
    help="input gtf annotation file",
    metavar="character"
  )
)
opt = parse_args(OptionParser(option_list=option_list))

# get file path
inputFile <- opt$bam
gtf <- opt$gtf

# Set output file
outputFile <- file.path(getwd(), basename(sub(".bam$", "_rc.txt", inputFile)))

# Count reads
feature <- featureCounts(
  files = inputFile,
  annot.ext = gtf,
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_name",
  isPairedEnd = FALSE,
  nthreads = 12
)

# Write output
write.table(feature$counts, outputFile, quote=F, sep="\t")
