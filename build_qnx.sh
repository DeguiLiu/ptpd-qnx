#!/bin/bash

make clean
autoreconf -vi
./configure --host=aarch64-unknown-nto-qnx7.1.0  --disable-pcap
./configure --host=aarch64-unknown-nto-qnx7.1.0  --enable-experimental-options --enable-debug-level=all
./configure --host=aarch64-unknown-nto-qnx7.1.0  --enable-experimental-options --with-pcap-config=/home/test/test/ptpd-qnx/pcap-config
make -j10
