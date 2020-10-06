#!/usr/bin/env bash

if [[ `uname` == 'Linux' ]]; then
    # disable tests
    sed -i 's|tests unit-tests benchmark||g' mono/Makefile.am
fi

./autogen.sh               \
    --prefix=$PREFIX       \
    --disable-silent-rules

make -j${CPU_COUNT}
make install -j${CPU_COUNT}