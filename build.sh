#!/bin/bash

set -exo pipefail

mv configparams /glibc-build/configparams

wget -O- "https://ftp.gnu.org/gnu/glibc/glibc-${GLIBC_VER}.tar.gz" | tar -xz -C /

"/glibc-${GLIBC_VER}/configure" \
    --prefix="$PREFIX_DIR" \
    --libdir="${PREFIX_DIR}/lib" \
    --libexecdir="${PREFIX_DIR}/lib" \
    --enable-multi-arch \
    --enable-stack-protector=strong
make -j$(nproc)
make install

tar --dereference --hard-dereference -zc -f "/glibc-bin-${GLIBC_VER}.tar.gz" "$PREFIX_DIR"