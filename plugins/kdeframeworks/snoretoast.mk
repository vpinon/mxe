# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := snoretoast
$(PKG)_VERSION  := 0.6.0
$(PKG)_CHECKSUM  := 56b93c1f3aa06a9b170802385492c058fb4834608b1a3c0e773aa1bb5b3ec7ec
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_HOME     := https://download.kde.org/stable/snoretoast/
$(PKG)_URL      := $($(PKG)_HOME)/$($(PKG)_VERSION)/src/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- https://download.kde.org/stable/snoretoast/ | \
    $(SED) -n 's,[^0-9]*\([0-9]\+.[0-9]\+.[0-9]\+\)/.*,\1,p' | \
	tail -1
endef

define $(PKG)_BUILD
    mkdir "$(1)/build"
    cd "$(1)/build" && cmake .. \
        -DCMAKE_TOOLCHAIN_FILE="$(CMAKE_TOOLCHAIN_FILE)" \
        -DCMAKE_BUILD_TYPE=Release
    $(MAKE) -C "$(1)/build" -j $(JOBS) install
endef

