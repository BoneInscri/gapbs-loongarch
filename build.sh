#!/bin/bash

# Set LoongArch cross-compilation toolchain
# export CROSS_COMPILE="loongarch64-unknown-linux-gnu-"
export CROSS_COMPILE="loongarch64-linux-gnu-"
export CC="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"
export AR="${CROSS_COMPILE}ar"
export RANLIB="${CROSS_COMPILE}ranlib"

# Set architecture-specific flags for LoongArch
export CFLAGS="-march=loongarch64 -mtune=la464 -mabi=lp64d -static -no-pie -fno-PIC"
export CXXFLAGS="${CFLAGS} -static"
export LDFLAGS="-static -no-pie -Wl,--as-needed"

# Additional compilation flags (preserve Makefile's -O3 and -std=c++11)
EXTRA_FLAGS="-O3 -std=c++11 -static"

# Handle OpenMP (same logic as Makefile)
PAR_FLAG="-fopenmp"
if [[ "${CXX}" == *"icpc"* ]]; then
    PAR_FLAG="-openmp"
elif [[ "${CXX}" == *"sunCC"* ]]; then
    EXTRA_FLAGS="-std=c++11 -xO3 -m64 -xtarget=native"
    PAR_FLAG="-xopenmp"
fi

if [[ "${SERIAL}" != "1" ]]; then
    EXTRA_FLAGS+=" ${PAR_FLAG}"
fi

# Export the final flags
export CXX_FLAGS="${EXTRA_FLAGS}"

# Build all targets
echo "Starting cross-compilation for LoongArch..."
echo "Using compiler: ${CXX}"
echo "With flags: ${CXX_FLAGS}"

make clean
make all -j$(($(nproc)+1))

# Verify the build
if [ $? -eq 0 ]; then
    echo "Build successful!"
    echo "Generated binaries:"
    ls -lh bc bfs cc cc_sv pr pr_spmv sssp tc converter 2>/dev/null
else
    echo "Build failed!"
    exit 1
fi

echo "Verifying static linkage..."
for binary in bc bfs cc cc_sv pr pr_spmv sssp tc converter; do
    if [ -f "${binary}" ]; then
        echo -n "${binary}: "
        file "${binary}" | grep -q "statically linked" && echo "STATIC" || echo "DYNAMIC (FAILED)"
    fi
done