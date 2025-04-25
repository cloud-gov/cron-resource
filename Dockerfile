ARG base_image

FROM golang:1.24 AS resource
COPY . /resource
WORKDIR /resource
RUN ./build.sh

FROM ${base_image}
COPY --from=resource /resource/tmp/build/* /opt/resource/
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y tzdata && rm -rf /var/lib/apt/lists/*
