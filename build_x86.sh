#!/bin/bash

make clean
autoreconf -vi
./configure --enable-experimental-options --enable-debug-level=all
make -j10
