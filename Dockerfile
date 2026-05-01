# Reproducible image for the IIEM x youth-health project.
# Base: rocker/verse pins R + tidyverse + Quarto + LaTeX.
# INLA is added via the official R-INLA repository; spatial-stack libraries
# come from rocker/geospatial layer (GDAL, GEOS, PROJ).

FROM rocker/geospatial:4.5.3

LABEL maintainer="Sidney Bissoli <sbissoli76@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/SidneyBissoli/iie-municipal-vs-saude"

# System libraries needed by sf, INLA, and a few CRAN packages with C/Fortran deps.
RUN apt-get update && apt-get install -y --no-install-recommends \
        libnng-dev \
        libudunits2-dev \
        libxt-dev \
        libfontconfig1-dev \
        libharfbuzz-dev \
        libfribidi-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

# renv: project library will be restored at first run via renv::restore().
ENV RENV_PATHS_LIBRARY=renv/library

# Install renv and a small set of bootstrap packages.
RUN R -e "install.packages(c('renv', 'remotes'), repos = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest')"

# INLA from the official repo (binary build matching R version).
RUN R -e "install.packages('INLA', repos = c(getOption('repos'), INLA = 'https://inla.r-inla-download.org/R/stable'), dep = TRUE)"

WORKDIR /work

# Default entrypoint: drop into R after restoring the project library.
COPY .Rprofile renv.lock /work/
COPY renv/activate.R /work/renv/activate.R
COPY renv/settings.json /work/renv/settings.json

CMD ["R", "--no-save"]
