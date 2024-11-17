#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/askey/adt3
# A/B
AB_OTA_PARTITIONS += recovery
AB_OTA_UPDATER := true
ENABLE_VIRTUAL_AB := true
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true


PRODUCT_PACKAGES += \
    bootctrl.diana

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    shell_and_utilities_vendor_ramdisk \

PRODUCT_PACKAGES += adbd.recovery

PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    tune2fs.vendor_ramdisk \

PRODUCT_PACKAGES += adbd.vendor_ramdisk

PRODUCT_PACKAGES += \
    linker.recovery \
    shell_and_utilities_recovery \
    adbd.recovery
