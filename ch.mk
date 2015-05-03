# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

################OPTIMIZATIONS###################
#Use Optimizations?
USE_OPTIMIZATIONS := true

ifneq ($(strip $(USE_OPTIMIZATIONS)),false)
#HACKIFY CONFIGURATION 

##Define ROM toolchain
TARGET_GCC_AND := 4.9-sm

##Define NDK toolchain
TARGET_NDK_VERSION := 4.9

##Define Kernel toolchain
TARGET_GCC_ARM := 4.9-sm

##Enable Pthread (only on newer devices)
ENABLE_PTHREAD := true

##Enable O3 Optimizations
O3_OPTIMIZATIONS:= true

##Use Kernel Optimizations?
USE_KERNEL_OPTIMIZATIONS := true

##Use Extra Optimizations?
USE_EXTRA_OPTIMIZATIONS := true

##How many threads does the device have?
PRODUCT_THREADS := 4

ifeq ($(strip $(USE_EXTRA_OPTIMIZATIONS)),true)
# Extra SaberMod GCC C flags for the ROM and Kernel
export EXTRA_SABERMOD_GCC_CFLAGS := \
         -ftree-loop-distribution \
         -ftree-loop-if-convert \
         -ftree-loop-im \
         -ftree-loop-ivcanon \
         -fprefetch-loop-arrays \
         -ftree-vectorize \
         -mvectorize-with-neon-quad \
         -pipe

# Extra SaberMod CLANG C flags
EXTRA_SABERMOD_CLANG_CFLAGS := \
  -fprefetch-loop-arrays \
  -ftree-vectorize \
  -pipe

OPT4 := -extra

GRAPHITE_KERNEL_FLAGS := \
  -floop-parallelize-all \
  -ftree-parallelize-loops=$(PRODUCT_THREADS) \
  -fopenmp

endif

endif
#################################################

##If you´re running an old device, set this to true
USE_LEGACY_GCC := false

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from bacon device
$(call inherit-product, device/oneplus/bacon/bacon.mk)

# Inherit some common CH stuff.
$(call inherit-product, vendor/ch/config/common_full_phone.mk)

PRODUCT_NAME := ch_bacon
PRODUCT_DEVICE := bacon
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_MODEL := A0001

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BRAND := oneplus
TARGET_VENDOR := oneplus
TARGET_VENDOR_PRODUCT_NAME := bacon
TARGET_VENDOR_DEVICE_NAME := A0001
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=A0001 PRODUCT_NAME=bacon

## Use the latest approved GMS identifiers unless running a signed build
ifneq ($(SIGN_BUILD),true)
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=oneplus/bacon/A0001:5.0.2/LRX22G/YNG1TAS0YL:user/release-keys PRIVATE_BUILD_DESC="bacon-user 5.0.2 LRX22G YNG1TAS0YL release-keys"
endif
