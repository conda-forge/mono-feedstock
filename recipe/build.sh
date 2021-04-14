#!/usr/bin/env bash

if [[ $target_platform =~ linux.* ]]; then
    # disable tests
    sed -i 's|tests unit-tests benchmark||g' mono/Makefile.am
fi

cp $BUILD_PREFIX/share/gnuconfig/config.guess config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.sub config.sub

./autogen.sh               \
    --prefix=$PREFIX

make -j${CPU_COUNT}
make install -j${CPU_COUNT}
