# Docker container for Rsubread and Rscript to calculate readcount
# reference: genomicpariscentre/rsubread
# Version: 0.1.0

FROM ubuntu:14.04
MAINTAINER Tazro Inutano Ohta, inutano@gmail.com
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN apt-get update -y && apt-get install -y libxml2-dev \
   r-base \
   r-base-core \
   r-base-dev \
   r-base-html \
   r-doc-html \
   r-recommended \
   r-cran-boot \
   r-cran-class \
   r-cran-cluster \
   r-cran-codetools \
   r-cran-foreign \
   r-cran-kernsmooth \
   r-cran-lattice \
   r-cran-mass \
   r-cran-matrix \
   r-cran-mgcv \
   r-cran-nlme \
   r-cran-nnet \
   r-cran-rpart \
   r-cran-spatial \
   r-cran-survival
RUN apt-get clean
RUN echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile
RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("Rsubread")'
RUN R -e 'install.packages("optparse")'
ADD readCount.R /
CMD ["R", "--no-save"]
