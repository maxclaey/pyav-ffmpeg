#!/bin/sh

# This build script is based on .github/workflows/build-ffmpeg.yml
# and can be used to build outside of CI (Linux only)

# Check if cibuildwheel is installed
if [ -z `which cibuildwheel` ]; then
    echo "[ERROR] Could not find cibuildwheel. Please install it via 'pip install cibuildwheel'"
    exit 1
fi

# Set some environment variables from build-ffmpeg.yml, needed for Linux builds
export CIBW_BEFORE_BUILD="scripts/build-ffmpeg /tmp/vendor"
export CIBW_ENVIRONMENT_LINUX="LD_LIBRARY_PATH=/tmp/vendor/lib:/usr/local/lib:$LD_LIBRARY_PATH"
export CIBW_BUILD="cp38-*"
export CIBW_TEST_COMMAND="python -c 'import dummy'"

# Build with cibuildwheel
cibuildwheel --output-dir output --platform linux
rm -f output/*.whl