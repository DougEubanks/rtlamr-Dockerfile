FROM alpine:latest
MAINTAINER https://github.com/alpinelinux/docker-alpine

RUN apk add --no-cache git make musl-dev go git libusb libusb-dev automake cmake make gcc

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN git clone https://gitea.osmocom.org/sdr/rtl-sdr.git &&\
    cd rtl-sdr/ &&\
    mkdir build &&\
    cd build &&\
    cmake ../ &&\
    make &&\
    make install

RUN git clone https://github.com/merbanan/rtl_433.git &&\
    cd rtl_433 &&\
    mkdir build &&\
    cd build &&\
    cmake ../ &&\
    make &&\
    make install
    
RUN ldconfig /usr/local/lib/

# RUN git clone https://github.com/bemasher/rtlamr.git &&\
RUN go install github.com/bemasher/rtlamr@latest

ENTRYPOINT ["rtl_tcp"]
