FROM rocker/tidyverse:3.5.1

# Set a user and the working directory
RUN mkdir -p /rehhfiles
RUN chown rstudio /rehhfiles
USER rstudio
WORKDIR /rehhfiles

# Set the container to run `Rscript --vanilla ` by default
# ENTRYPOINT ["/usr/local/bin/Rscript", "--save"]

RUN R -e "install.packages('devtools')"
RUN R -e "Sys.setenv(unzip='internal',tar='internal'); \
require(devtools); \
baseContrib <- 'https://cran.r-project.org/src/contrib/'; \
pkgsArchives <- c('Archive/gtools/gtools_3.5.0.tar.gz', 'Archive/gdata/gdata_2.17.0.tar.gz', 'Archive/gplots/gplots_3.0.1.tar.gz','Archive/ggplot2/ggplot2_3.2.0.tar.gz', 'rehh.data_1.0.0.tar.gz','Archive/rehh/rehh_2.0.4.tar.gz', 'BH_1.69.0-1.tar.gz', 'assertthat_0.2.1.tar.gz', 'glue_1.3.1.tar.gz','magrittr_1.5.tar.gz', 'pkgconfig_2.0.2.tar.gz', 'R6_2.4.0.tar.gz','Rcpp_1.0.2.tar.gz', 'rlang_0.4.0.tar.gz', 'tibble_2.1.3.tar.gz','tidyselect_0.2.5.tar.gz', 'Archive/dplyr/dplyr_0.8.1.tar.gz'); \
Names <- c('gtools','gdata' ,'gplots','ggplot2', 'rehh.data', 'rehh', 'BH', 'assethat','glue','magrittr', 'pkgconfig', 'R6', 'Rcpp', 'rlang', 'tibble', 'tidyselect', 'dplyr'); \
for( i in 1:length(Names) ){assign( Names[i] , paste0(baseContrib,pkgsArchives[i] ))}; \
ListOfPkgs <- c(gtools,gdata ,gplots,ggplot2, rehh.data, rehh, BH, assethat,glue,magrittr,pkgconfig, R6, Rcpp, rlang, tibble, tidyselect, dplyr); \
install.packages(ListOfPkgs,repos = NULL, type = 'source');"

COPY ./rehh-runner.R ./rehh-runner.R
RUN Rscript ./rehh-runner.R

