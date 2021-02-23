FROM rocker/shiny-verse

COPY app.R /srv/shiny-server/app.R

COPY shiny-customized.config /etc/shiny-server/shiny-server.conf

# install dependencies
WORKDIR /srv/shiny-server/
RUN Rscript -e "install.packages('renv')"
RUN Rscript -e "install.packages(setdiff(renv::dependencies(quiet = TRUE)[, 'Package'], .packages(all.available = TRUE)))"

EXPOSE 8080

USER shiny

# avoid s6 initialization
# see https://github.com/rocker-org/shiny/issues/79
CMD ["/usr/bin/shiny-server"]
