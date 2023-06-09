#!/bin/bash
# This script is sets environment variables requires to use this version of QNX Software Development Platform 7.0
# from the command line. To use the script, you have to "source" it into your shell,
# source qnxsdp-env.sh
# if source command is not available use "." (dot) command instead
#
test "$BASH_SOURCE" = "" && echo "This script only can be run from bash" && return
SCRIPT_SOURCE=$BASH_SOURCE
echo SCRIPT_SOURCE $SCRIPT_SOURCE
test "$SCRIPT_SOURCE" = "$0" && echo "Script is being run, should be sourced" && exit 1

HOST_OS=$(uname -s)
echo HOST_OS $HOST_OS
if [ -z "$QNX_BASE" ]; then
  QNX_BASE=/root/qnx710
fi

echo QNX_BASE $QNX_BASE
case "$HOST_OS" in
	Linux)
    QNX_HOST=$QNX_BASE/host/linux/x86_64
		;;
	Darwin)
    QNX_HOST=$QNX_BASE/host/darwin/x86_64
		;;
	*)
    QNX_HOST=$QNX_BASE/host/win64/x86_64
		;;
esac

QNX_TARGET=$QNX_BASE/target/qnx7
QNX_CONFIGURATION=$HOME/.qnx
MAKEFLAGS=-I$QNX_BASE/target/qnx7/usr/include
PATH=$QNX_HOST/usr/bin:$QNX_CONFIGURATION/bin:$QNX_BASE/jre/bin:$PATH

export QNX_BASE QNX_TARGET QNX_HOST QNX_CONFIGURATION MAKEFLAGS PATH
unset PYTHONPATH

export QNX_TOOLCHAIN_TRIPLE="aarch64-unknown-nto-qnx7.1.0"
export QNX_TOOLCHAIN_PREFIX="${QNX_HOST}/usr/bin/${QNX_TOOLCHAIN_TRIPLE}-"
export QNX_TOOLCHAIN_FILE=${QNX_BASE}/cmake/Toolchain-QNX.cmake

export CC=${QNX_TOOLCHAIN_PREFIX}gcc
export CXX=${QNX_TOOLCHAIN_PREFIX}g++
export STRIP=${QNX_TOOLCHAIN_PREFIX}strip
export AR=${QNX_TOOLCHAIN_PREFIX}ar
export OBJCOPY=${QNX_TOOLCHAIN_PREFIX}objcopy
export RANLIB=${QNX_TOOLCHAIN_PREFIX}ranlib
export READELF=${QNX_TOOLCHAIN_PREFIX}readelf
export CFLAGS="-O2 -g2 -D_QNX_SOURCE -D_QNX_ -D__QNXNTO__ -I${QNX_TARGET}/usr/include -L${QNX_TARGET}/aarch64le/usr/lib -L${QNX_TARGET}/aarch64le/lib"
export CPPFLAGS="-O2 -g2 -D_QNX_SOURCE -D_QNX_ -D__QNXNTO__ -I${QNX_TARGET}/usr/include -L${QNX_TARGET}/aarch64le/usr/lib -L${QNX_TARGET}/aarch64le/lib"
export LDFLAGS="-pthread -lsocket -static"
export DYNA_LINKFLAGS="-pthread -lsocket"
export CPLUS_INCLUDE_PATH=${QNX_TARGET}/usr/include:$CPLUS_INCLUDE_PATH
export C_INCLUDE_PATH=${QNX_TARGET}/usr/include:$C_INCLUDE_PATH
export LD_LIBRARY_PATH=${QNX_TARGET}/aarch64le/usr/lib:${QNX_TARGET}/aarch64le/lib
export LT_SYS_LIBRARY_PATH=${LD_LIBRARY_PATH}

export CMAKE_TOOLCHAIN_FILE=${QNX_TOOLCHAIN_FILE}
export ARCH=QNX
