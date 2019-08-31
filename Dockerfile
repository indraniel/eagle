FROM debian:stretch-slim
label maintainer "Indraniel Das <idas@wustl.edu>"

# Volumes
VOLUME /build

# bootstrap build dependencies
RUN apt-get update -qq \
    && apt-get -y install apt-transport-https \
    && echo "deb [trusted=yes] https://gitlab.com/indraniel/hall-lab-debian-repo-1/raw/master stretch main" | tee -a /etc/apt/sources.list \
    && apt-get update -qq \
    && apt-get -y install \
       build-essential \
       libcurl4-openssl-dev \
       ca-certificates \
       curl \
       zlib1g \
       zlib1g-dev \
       libnss-sss \
       libgomp1 \
       libopenblas-dev \
       libstdc++-6-dev \
       libboost-random-dev \
       libboost-iostreams-dev \
       libboost-program-options-dev \
       hall-lab-htslib-1.9 \
       hall-lab-bcftools-1.9 \
       --no-install-recommends

RUN apt-get clean all
