#!/bin/bash

set -ex

git submodule update --init
cp files/sftp-server-main.c openssh-portable/


(
cd openssh-portable

export CC="musl-gcc -static -pipe -nostdinc -D_GNU_SOURCE -D_BSD_SOURCE -DHAVE_GETLINE -DHAVE_BROKEN_CHACHA20"

autoreconf \
  && ./configure \
    --without-openssl \
    --without-zlib \
    --without-pam \
    --without-xauth \
  && make sftp-server \
  && cp sftp-server ..
)
