#!/bin/bash

make clean
autoreconf -vi
./configure --host=aarch64-unknown-nto-qnx7.1.0 --enable-debug-level=all --enable-experimental-options --with-pcap-config=./pcap-config
make -j10
