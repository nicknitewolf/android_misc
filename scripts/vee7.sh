#!/bin/bash
repo sync -j32 --force-sync
export KBUILD_BUILD_USER="jenkins"
export KBUILD_BUILD_HOST="neko-server"
export USE_CCACHE="1"
export CCACHE_COMPRESS="1"
export _JAVA_OPTIONS="-Xmx8g"
export CM_BUILDTYPE="UNOFFICIAL"
source ccache.sh
source build/envsetup.sh
source device/lge/vee7/patches/apply.sh
croot
breakfast vee7
time make bacon -j8
