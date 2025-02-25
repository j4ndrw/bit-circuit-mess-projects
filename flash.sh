#!/bin/bash

cd vendor/Bit-Firmware/build
esptool \
  --chip esp32s3 merge_bin \
  -o custom.bin \
  --flash_mode dio \
  --flash_freq 80m \
  --flash_size 8MB \
    0x0 bootloader.bin \
    0x10000 partition-table.bin \
    0x20000 Bit-Firmware.bin \
    0x17e000 storage.bin \
    0x410000 ../../micropython.bin
esptool -b 921600 -p <PORT> write_flash -e 0 custom.bin
cd ..
