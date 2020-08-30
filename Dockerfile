FROM bash:5.0.17

WORKDIR /tmp

RUN apk add --no-cache \
  curl \
  git \
  jq \
  openssh \
  build-base \
  perl \
  gzip \
  autoconf \
  automake \
  libtool \
  m4 \
  patch

RUN git clone https://github.com/libressl-portable/portable.git && \
  cd portable && \
  git checkout v2.8.3 && \
  ./autogen.sh && \
  ./configure && \
  make check && \
  make install

ENTRYPOINT bash