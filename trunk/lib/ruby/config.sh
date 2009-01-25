#!/bin/sh
TOP=${HOME}/android
PRODUCT=dream
HOST=linux-x86
GCCHOST=i686-linux
ARCH=arch-arm
GCCARCH=arm-eabi
GCCVER=4.2.1
RUBYARCH=arm-android-linux
TOOLCHAIN_PATH=${TOP}/prebuilt/${HOST}/toolchain/${GCCARCH}-${GCCVER}
TOOLCHAIN_PREFIX=${TOOLCHAIN_PATH}/bin/${GCCARCH}-
LPATH=${TOP}/out/target/product/${PRODUCT}/obj/lib

export CC=${TOOLCHAIN_PREFIX}gcc
export LD=${TOOLCHAIN_PREFIX}ld
export AR=${TOOLCHAIN_PREFIX}ar
export RANLIB=${TOOLCHAIN_PREFIX}ranlib
export CPPFLAGS="-nostdinc -I${TOP}/external/zlib -I${TOP}/external/openssl/include -I${TOP}/bionic/libc/include -I${TOP}/bionic/libc/${ARCH}/include -I${TOP}/bionic/libc/kernel/common -I${TOP}/bionic/libc/kernel/${ARCH} -I${TOP}/bionic/libc/kernel/common/linux -I${TOP}/bionic/libm/include -I${TOOLCHAIN_PATH}/lib/gcc/${GCCARCH}/${GCCVER}/include -Dptrdiff_t=__ptrdiff_t -include stdio.h -include unistd.h -include fcntl.h -include sys/mman.h -DHAVE_GETCWD"
export LIBS="-nostdlib -L${LPATH} -lstdc++ -lc -lm -ldl -Wl,-dynamic-linker,/system/bin/linker,-rpath,/system/lib"
export MAINLIBS="${LPATH}/crtbegin_dynamic.o ${LPATH}/crtend_android.o"

export ac_cv_func_getpgrp_void=yes
export ac_cv_func_setpgrp_void=yes
export ac_cv_prog_cc_g=no
export ac_cv_prog_cxx_g=no
export ac_cv_func_vsnprintf=yes
export ac_cv_func_isinf=yes
export ac_cv_header_langinfo_h=no

./configure --build=${RUBYARCH} --target=${RUBYARCH} --host=${GCCHOST} --enable-wide-getaddrinfo --prefix=/data/ruby
