#!/bin/bash
cd ./bootable/recovery
for f in ../../device/askey/adt3/patches/*.patch
do
  patch -p1 < $f
done
cd ../..
