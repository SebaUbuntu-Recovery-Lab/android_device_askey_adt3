#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/askey/adt3

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    product \
    vendor_dlkm \
    system_dlkm \
    vendor \
    system
BOARD_USES_RECOVERY_AS_BOOT := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := generic

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := exdroid
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 240

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_CMDLINE := loop.max_part=4 mmcblk.perdev_minors=16 firmware_class.path=/vendor/etc/firmware bootconfig
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x03388000
BOARD_KERNEL_TAGS_OFFSET := 0xfff88100
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_PAGE_SIZE)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)



BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_CONFIG := adt3_defconfig
TARGET_KERNEL_SOURCE := kernel/askey/adt3

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := 
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
#BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := askey_dynamic_partitions
BOARD_ASKEY_DYNAMIC_PARTITIONS_PARTITION_LIST := system system system_dlkm vendor vendor_dlkm product
BOARD_ASKEY_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# Platform
TARGET_BOARD_PLATFORM := diana

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := ARGB_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2021-08-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# TWRP Configuration
# Add EXT4 support
TARGET_USERIMAGES_USE_EXT4 := true

# Disable/enable SELinux. Only suggested when you want to enable SELinux support
TWHAVE_SELINUX := true

# Remove MTP support
TW_EXCLUDE_MTP := true

# No screen timeout
TW_NO_SCREEN_TIMEOUT := true

# disables things like sdcard partitioning and may save you some space if TWRP isn't fitting in your recovery patition
BOARD_HAS_NO_REAL_SDCARD := true

# this enables proper handling of /data/media on devices that have this folder for storage (most Honeycomb and devices that originally shipped with ICS like Galaxy Nexus
RECOVERY_SDCARD_ON_DATA := true

# If your device has recovery as a second ramdisk of boot.img
TW_HAS_NO_RECOVERY_PARTITION := true

# To prevent /boot partition not found error
TW_HAS_NO_BOOT_PARTITION := true

# Removes the 'Reboot bootloader' button
TW_NO_REBOOT_BOOTLOADER := true

# Removes the 'Reboot recovery' button
TW_NO_REBOOT_RECOVERY := true

# Same as above, for CPU Temperature
TW_NO_CPU_TEMP := true


# Always use rm -rf to wipe
TW_ALWAYS_RMRF := true

# Prevent TWRP from unmounting /system
TW_NEVER_UNMOUNT_SYSTEM := true

# Automatically implies these:
BOARD_HAS_NO_REAL_SDCARD := true
TW_USE_TOOLBOX := true
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_MTP := true
TW_OEM_BUILD := true

# For older devices. See here :https://github.com/omnirom/android_b...ndroid.mk#l383
TW_NO_EXFAT_FUSE := true

# Decryption support for /data
TW_INCLUDE_CRYPTO := true


# CPU temp sysfs path, if it is zero all the time.
TW_CUSTOM_CPU_TEMP_PATH := true

# Remove the ability to encrypt backups with a password
TW_EXCLUDE_ENCRYPTED_BACKUPS := true

# Supply a custom init.rc for the recovery
TARGET_RECOVERY_INITRC := device/askey/adt3/recovery/init.recovery.rc

# Set the default language, if not english
TW_DEFAULT_LANGUAGE := en-US

# For people who would want to have ToyBox rather than Busybox
TW_USE_TOOLBOX := true

# Remove exFAT formatting binaries
TW_NO_EXFAT := true

# Remove SuperSU and stop TWRP prompts to install it
TW_EXCLUDE_SUPERSU := true

# An awesome way to take screenshots. Back-end improvement, no noticeable user side changes. Screenshots work without it too
TW_INCLUDE_FB2PNG := true

# include Logcat daemon for help in debugging
TWRP_INCLUDE_LOGCAT := true

# See here : https://github.com/omnirom/android_b...ndroid.mk#L435
TARGET_RECOVERY_DEVICE_MODULES := true


# Log touch input
TWRP_EVENT_LOGGING := true

# Smartwatch optimisation
TW_ROUND_SCREEN := true

# Remove TrueType fonts
TW_DISABLE_TTF:= true

# building of an OEM friendly TWRP. excludes SuperSu, uses Toolbox instead busybox, disables themeing. MORE INFOS TO BE ADDED
TW_OEM_BUILD := true

# exclude mtp from twrp (disable if you are not able to fix it device/kernel side, safes some space)
TW_EXCLUDE_MTP := true

# screen will stay awake
TW_NO_SCREEN_TIMEOUT := true

# needed on devices without a recovery partition (some devices have recovery included im boot.img)
TW_HAS_NO_RECOVERY_PARTITION := true

# removes the reboot option to boot into boooader, needed e.g. on samsung devices which use Download mode instead
TW_NO_REBOOT_BOOTLOADER := true

# add an option in reboot menu to reboot into Download Mode
TW_HAS_DOWNLOAD_MODE := true

# some devices don't have a temp sensor, disable in such case to stop spamming recovery.log
TW_NO_CPU_TEMP := true

# recursive delete by default instead fotmatting (available optional inside recovery settings too)
TW_ALWAYS_RMRF := true

# system won't be unmounted,
TW_NEVER_UNMOUNT_SYSTEM := true

# don't blank screen (available optional inside recovery settings too)
TW_NO_SCREEN_BLANK := true

# deprecated, use TW_INCLUDE_CRYPTO instead
TW_INCLUDE_JB_CRYPTO := true

# add support for encryption
TW_INCLUDE_CRYPTO := true


# ToyBox (disables busybox?)
TW_USE_TOOLBOX := true

# exclude SuperSu e.g. to save some space or for different other reasons (supersu still included bx default?)
TW_EXCLUDE_SUPERSU := true

# F2FS filesystem support (make sure your kernel supports f2fs!)
TARGET_USERIMAGES_USE_F2FS := true

# device resolution - deprecated, use TW_THEME instead
DEVICE_RESOLUTION := X96Q
TW_THEME := portrait_hdpi
TARGET_RECOVERY_DEVICE_DIRS += device/askey/adt3

