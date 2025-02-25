#!/bin/bash

# Create vendor dir where all 3rd party stuff lives
mkdir -p vendor
cd vendor

# Install esp-idf
git clone -b v5.1.1 --recursive https://github.com/espressif/esp-idf.git --depth 1
cd esp-idf
./install.sh esp32s3

# Run prepare command
cd ../
./prepare.sh

# Install custom MicroPython build
cd vendor
git clone --recursive -b ota https://github.com/ge0rdi/micropython.git --depth 1
cd micropython
make -C mpy-cross
cd ports/esp32
make BOARD=CM_-CombinedS3 USER_C_MODULES=../../../usermod/micropython.cmake
cp build-CM_-CombinedS3/micropython.bin ../../vendor
cd ../../../

# Install custom Bit firmware
cd vendor
git clone --recursive -b micropython https://github.com/ge0rdi/Bit-Firmware.git
cd Bit-Firmware
idf.py build
cd ../
