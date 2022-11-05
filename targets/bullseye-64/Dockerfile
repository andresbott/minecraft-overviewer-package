FROM debian:bullseye

RUN apt-get update && apt-get -y install \
jq git curl wget devscripts \
python3 python3-all-dev python3-numpy python3-pil python3-pip \
build-essential libssl-dev libffi-dev dh-python

# install nfpm
RUN echo 'deb [trusted=yes] https://repo.goreleaser.com/apt/ /' | tee /etc/apt/sources.list.d/goreleaser.list && \
   apt-get update && apt-get install -y nfpm

COPY . /app
