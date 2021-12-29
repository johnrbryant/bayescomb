
FROM rocker/verse

COPY Makefile home/rstudio/Makefile

COPY data home/rstudio/data

RUN mkdir home/rstudio/natall
RUN mkdir home/rstudio/natall/out
COPY natall/Makefile home/rstudio/natall/Makefile
COPY natall/src home/rstudio/natall/src

RUN mkdir home/rstudio/natnhes
RUN mkdir home/rstudio/natnhes/out
COPY natnhes/Makefile home/rstudio/natnhes/Makefile
COPY natnhes/src home/rstudio/natnhes/src

RUN mkdir home/rstudio/paper
RUN mkdir home/rstudio/paper/out
COPY paper/Makefile home/rstudio/paper/Makefile
COPY paper/obesity.Rmd home/rstudio/paper/obesity.Rmd
COPY paper/obesitysm.Rmd home/rstudio/paper/obesitysm.Rmd
COPY paper/PLOS-submission.eps home/rstudio/paper/PLOS-submission.eps
COPY paper/plos.csl home/rstudio/paper/plos.csl
COPY paper/references.bib home/rstudio/paper/references.bib
COPY paper/src home/rstudio/paper/src

RUN mkdir home/rstudio/shared
RUN mkdir home/rstudio/shared/out
COPY shared/Makefile home/rstudio/shared/Makefile
COPY shared/src home/rstudio/shared/src

RUN mkdir home/rstudio/submission

RUN mkdir home/rstudio/subnat
RUN mkdir home/rstudio/subnat/out
COPY subnat/Makefile home/rstudio/subnat/Makefile
COPY subnat/src home/rstudio/subnat/src

RUN R -q -e 'install.packages("coda")'
RUN R -q -e 'install.packages("docopt")'
RUN R -q -e 'install.packages("knitr")'
RUN R -q -e 'install.packages("extraDistr")'
RUN R -q -e 'install.packages("magick")'
RUN R -q -e 'install.packages("rticles")'
RUN R -q -e 'devtools::install_github("statisticsnz/dembase")'
RUN R -q -e 'devtools::install_github("statisticsnz/demest")'

RUN tlmgr install standalone
RUN tlmgr install varwidth
RUN tlmgr install pgf
RUN tlmgr install epstopdf-pkg

RUN apt update
RUN apt install -y ghostscript

WORKDIR /home/rstudio

